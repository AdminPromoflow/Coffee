'use strict';
(() => {
  // Deliberately in-memory only: this interface never calls an API or persists data.
  const $ = selector => document.querySelector(selector);
  const escape = value => String(value).replace(/[&<>"']/g, char => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[char]));
  const money = value => new Intl.NumberFormat('es-CO', {style:'currency',currency:'COP',maximumFractionDigits:0}).format(value);
  const orders = [
    {id:'CF-1048',customer:'María Torres',email:'maria@example.com',date:'16 nov 2026',status:'Por preparar',total:96000,items:[['Café de origen · 500 g',2,48000]]},
    {id:'CF-1047',customer:'Daniel Rojas',email:'daniel@example.com',date:'16 nov 2026',status:'En preparación',total:78000,items:[['Blend de la casa · 250 g',3,26000]]},
    {id:'CF-1046',customer:'Laura Méndez',email:'laura@example.com',date:'15 nov 2026',status:'Enviado',total:128000,items:[['Kit de degustación',2,64000]]},
    {id:'CF-1045',customer:'Andrés López',email:'andres@example.com',date:'15 nov 2026',status:'Entregado',total:48000,items:[['Café de origen · 500 g',1,48000]]}
  ];
  const approvals = [
    {id:1,name:'Blend de la casa',sku:'CF-BLEND-250',supplier:'Tostadores del Valle',request:'Publicación',description:'Mezcla de café tostado, presentación de 250 g. Solicitud de ejemplo para revisar el diseño del panel.'},
    {id:2,name:'Café de origen',sku:'CF-ORIGEN-500',supplier:'Finca La Esperanza',request:'Actualización',description:'Café de origen, presentación de 500 g. Solicitud de ejemplo; todavía no está conectada al catálogo.'}
  ];
  let users = [
    {id:1,name:'Ana Martínez',email:'ana@example.com',role:'Administrador',status:'Activo'},
    {id:2,name:'Carlos Rivera',email:'carlos@example.com',role:'Operaciones',status:'Activo'},
    {id:3,name:'Sofía Castro',email:'sofia@example.com',role:'Atención al cliente',status:'Inactivo'}
  ];
  const conversations = [
    {id:1,supplier:'Tostadores del Valle',subject:'Entrega semanal',messages:[{own:false,text:'Hola, estamos preparando la entrega de esta semana. ¿Podemos confirmar la cantidad de café de origen?',time:'09:15 · Ejemplo'},{own:true,text:'¡Hola! Revisaremos las cantidades para coordinar la entrega.',time:'09:22 · Ejemplo'}]},
    {id:2,supplier:'Finca La Esperanza',subject:'Nueva cosecha',messages:[{own:false,text:'Ya está disponible la información de nuestra nueva cosecha.',time:'Ayer · Ejemplo'}]},
    {id:3,supplier:'Café del Bosque',subject:'Presentaciones disponibles',messages:[{own:false,text:'Podemos ofrecer presentaciones de 250 g y 500 g.',time:'Ayer · Ejemplo'}]}
  ];
  let selectedConversation = 1;
  let toastTimer;
  const initials = name => name.split(/\s+/).slice(0,2).map(word=>word[0] || '').join('').toUpperCase();
  const badgeClass = status => ({'Por preparar':'pending','En preparación':'progress','Enviado':'warm','Entregado':'done','Activo':'done','Inactivo':'muted'}[status] || 'warm');
  const badge = status => `<span class="badge ${badgeClass(status)}">${escape(status)}</span>`;
  function toast(text) { $('#toast').textContent=text; $('#toast').hidden=false; clearTimeout(toastTimer); toastTimer=setTimeout(()=>$('#toast').hidden=true,4500); }
  function detail(title,html) { $('#detail-title').textContent=title; $('#detail-content').innerHTML=html; $('#detail-dialog').showModal(); }
  function renderStats() {
    const data=[['Pedidos de ejemplo',orders.length,'Estados de la operación','orders'],['Por revisar',approvals.length,'Solicitudes de productos','overview'],['Conversaciones',conversations.length,'Casos con proveedores','messages'],['Usuarios de ejemplo',users.length,'Personas del equipo','users']];
    $('#stats-grid').innerHTML=data.map(([label,value,note,section])=>`<a class="stat" href="#${section}"><span class="stat-label">${label}</span><span class="stat-icon" aria-hidden="true">↗</span><p class="stat-value">${value}</p><p class="stat-note">${note}</p></a>`).join('');
  }
  function orderRow(order) {
    return `<tr><td><strong>#${order.id}</strong></td><td>${escape(order.customer)}</td><td>${order.date}</td><td>${badge(order.status)}</td><td><strong>${money(order.total)}</strong><small>COP</small></td><td><button class="text-link" data-order="${order.id}" aria-label="Ver pedido ${order.id}">Ver detalle →</button></td></tr>`;
  }
  function renderOrders() {
    const term=$('#orders-search').value.toLocaleLowerCase(); const status=$('#orders-filter').value;
    const results=orders.filter(o=>(!status || o.status===status) && `${o.id} ${o.customer}`.toLocaleLowerCase().includes(term));
    $('#orders-body').innerHTML=results.map(orderRow).join('') || '<tr><td colspan="6" class="table-empty">No hay pedidos que coincidan con tu búsqueda.</td></tr>';
    $('#orders-count').textContent=`${results.length} de ${orders.length} pedidos de ejemplo · Importes ilustrativos en COP`;
    $('#recent-orders').innerHTML=orders.slice(0,3).map(orderRow).join('');
  }
  function renderApprovals() {
    $('#approvals-body').innerHTML=approvals.map(p=>`<tr><td><strong>${escape(p.name)}</strong><small>${p.sku}</small></td><td>${escape(p.supplier)}</td><td>${badge(p.request)}</td><td><button class="text-link" data-approval="${p.id}">Revisar →</button></td></tr>`).join('');
  }
  function showOrder(id) {
    const order=orders.find(o=>o.id===id); if(!order)return;
    detail(`Pedido #${order.id}`,`<dl class="detail-grid"><div><dt>Cliente</dt><dd>${escape(order.customer)}</dd></div><div><dt>Estado de ejemplo</dt><dd>${badge(order.status)}</dd></div><div><dt>Correo de ejemplo</dt><dd>${escape(order.email)}</dd></div><div><dt>Fecha</dt><dd>${order.date}</dd></div></dl>${order.items.map(([name,quantity,price])=>`<div class="detail-line"><span>${escape(name)} × ${quantity}</span><strong>${money(price*quantity)}</strong></div>`).join('')}<div class="detail-line"><strong>Total de ejemplo (COP)</strong><strong>${money(order.total)}</strong></div><p class="dialog-note">Vista de detalle. No representa un pedido ni un pago real.</p>`);
  }
  function renderUsers() {
    const term=$('#users-search').value.toLocaleLowerCase();
    const list=users.filter(u=>`${u.name} ${u.email}`.toLocaleLowerCase().includes(term));
    $('#users-body').innerHTML=list.map(u=>`<tr><td><div class="user-cell"><span class="avatar">${escape(initials(u.name))}</span><strong>${escape(u.name)}</strong></div></td><td>${escape(u.email)}</td><td>${escape(u.role)}</td><td>${badge(u.status)}</td><td><button class="text-link" data-edit-user="${u.id}" aria-label="Editar ${escape(u.name)}">Editar</button> <button class="text-link" data-delete-user="${u.id}" aria-label="Quitar ${escape(u.name)} de la vista previa">Quitar</button></td></tr>`).join('') || '<tr><td colspan="5" class="table-empty">No hay usuarios que coincidan con tu búsqueda.</td></tr>';
    renderStats();
  }
  function editUser(id) {
    const form=$('#user-form');form.reset();form.elements.email.setCustomValidity('');
    const user=users.find(u=>u.id===id);
    form.elements.id.value=user?.id || '';
    if(user)for(const field of ['name','email','role','status'])form.elements[field].value=user[field];
    $('#user-dialog-title').textContent=user?'Editar usuario de ejemplo':'Añadir usuario de ejemplo';
    $('#user-dialog').showModal();
  }
  function renderConversations() {
    const term=$('#conversation-search').value.toLocaleLowerCase();
    $('#conversation-list').innerHTML=conversations.filter(c=>`${c.subject} ${c.supplier}`.toLocaleLowerCase().includes(term)).map(c=>`<button class="conversation-button${c.id===selectedConversation?' active':''}" data-conversation="${c.id}" aria-pressed="${c.id===selectedConversation}"><strong>${escape(c.supplier)}</strong><small>${escape(c.subject)}</small></button>`).join('') || '<p class="table-empty">Sin coincidencias.</p>';
  }
  function renderMessages() {
    const conversation=conversations.find(c=>c.id===selectedConversation);
    $('#conversation-title').textContent=conversation.subject;
    $('#conversation-subtitle').textContent=conversation.supplier+' · Conversación de ejemplo';
    $('.conversation-header .avatar').textContent=initials(conversation.supplier);
    $('#message-list').innerHTML=conversation.messages.map(m=>`<div class="message-bubble${m.own?' own':''}">${escape(m.text)}<small>${escape(m.time)}</small></div>`).join('') || '<p class="table-empty">Añade un borrador para previsualizar esta conversación.</p>';
    $('#message-list').scrollTop=$('#message-list').scrollHeight;
    renderConversations();
  }
  const pages={overview:['Resumen','Un buen día empieza aquí.','Una mirada a tus pedidos, conversaciones y equipo.'],orders:['Pedidos','Cada pedido, en su punto.','Revisa el estado y los detalles de la operación.'],messages:['Mensajes','Las buenas conexiones importan.','Un espacio para conversar con tus proveedores.'],users:['Usuarios','El equipo detrás de Coffee.','Organiza las personas que hacen posible cada entrega.']};
  function navigate() {
    const key=location.hash.slice(1);const section=pages[key]?key:'overview';
    document.querySelectorAll('.dashboard-section').forEach(el=>el.hidden=el.id!==`section-${section}`);
    document.querySelectorAll('[data-section]').forEach(el=>{const active=el.dataset.section===section;el.classList.toggle('is-active',active);if(active)el.setAttribute('aria-current','page');else el.removeAttribute('aria-current');});
    const [label,title,description]=pages[section];$('#breadcrumb').textContent=label;$('#page-title').textContent=title;$('#page-description').textContent=description;document.title=label+' · Coffee Dashboard';
  }
  document.addEventListener('click',event=>{
    const target=event.target.closest('button');if(!target)return;
    if(target.hasAttribute('data-close'))target.closest('dialog').close();
    if(target.dataset.order)showOrder(target.dataset.order);
    if(target.dataset.approval){const p=approvals.find(p=>p.id===Number(target.dataset.approval));detail('Revisión de producto',`<p class="eyebrow">SOLICITUD DE EJEMPLO</p><h3>${escape(p.name)}</h3><p class="dialog-note">${escape(p.description)}</p><dl class="detail-grid"><div><dt>Proveedor</dt><dd>${escape(p.supplier)}</dd></div><div><dt>Solicitud</dt><dd>${escape(p.request)}</dd></div></dl><p class="dialog-note">La aprobación se conectará al catálogo cuando se defina la integración con la base de datos.</p>`);}
    if(target.dataset.editUser)editUser(Number(target.dataset.editUser));
    if(target.dataset.deleteUser){const id=Number(target.dataset.deleteUser);if(confirm('¿Quitar este usuario de ejemplo de la vista previa?')){users=users.filter(u=>u.id!==id);renderUsers();toast('Usuario quitado de la vista previa.');}}
    if(target.dataset.conversation){selectedConversation=Number(target.dataset.conversation);$('#message-form').reset();renderMessages();}
  });
  $('#new-user').addEventListener('click',()=>editUser(null));
  $('#user-form').addEventListener('input',()=>$('#user-form').elements.email.setCustomValidity(''));
  $('#user-form').addEventListener('submit',event=>{
    event.preventDefault();const form=event.currentTarget;const data=Object.fromEntries(new FormData(form));const id=Number(data.id);
    data.name=data.name.trim();data.email=data.email.trim().toLowerCase();
    if(!data.name){form.elements.name.focus();return;}
    if(users.some(u=>u.id!==id && u.email.toLowerCase()===data.email)){form.elements.email.setCustomValidity('Este correo ya está en la vista previa.');form.elements.email.reportValidity();return;}
    if(id)users=users.map(u=>u.id===id?{...data,id}:u);else users.push({...data,id:Math.max(0,...users.map(u=>u.id))+1});
    $('#user-dialog').close();renderUsers();toast('Cambios guardados solo en esta vista previa.');
  });
  $('#new-conversation').addEventListener('click',()=>{$('#conversation-form').reset();$('#conversation-dialog').showModal();});
  $('#conversation-form').addEventListener('submit',event=>{event.preventDefault();const data=Object.fromEntries(new FormData(event.currentTarget));if(!data.subject.trim())return;selectedConversation=Math.max(...conversations.map(c=>c.id))+1;conversations.unshift({id:selectedConversation,supplier:data.supplier,subject:data.subject.trim(),messages:[]});$('#conversation-search').value='';$('#conversation-dialog').close();renderMessages();renderStats();toast('Conversación de ejemplo creada.');});
  $('#message-form').addEventListener('submit',event=>{event.preventDefault();const text=$('#message-input').value.trim();if(!text)return;conversations.find(c=>c.id===selectedConversation).messages.push({own:true,text,time:'Borrador local · No enviado'});$('#message-input').value='';renderMessages();toast('Borrador añadido. No se envió ningún mensaje.');});
  $('#orders-search').addEventListener('input',renderOrders);$('#orders-filter').addEventListener('change',renderOrders);$('#users-search').addEventListener('input',renderUsers);$('#conversation-search').addEventListener('input',renderConversations);
  window.addEventListener('hashchange',navigate);
  renderOrders();renderApprovals();renderUsers();renderMessages();navigate();
})();
