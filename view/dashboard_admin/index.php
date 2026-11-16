<?php
// Interface preview only: no database, account or API integration.
require_once __DIR__ . '/../../controller/security/bootstrap.php';
$icons = [
    'overview' => '<rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/>',
    'orders' => '<path d="M8 4H5v17h14V4h-3M9 3h6v4H9zM8 12h8M8 16h5"/>',
    'messages' => '<path d="M21 11a8 8 0 0 1-8 8H8l-5 3V11a9 9 0 0 1 18 0Z"/><path d="M7 10h10M7 14h6"/>',
    'users' => '<circle cx="9" cy="8" r="3"/><path d="M3 21v-3a6 6 0 0 1 12 0v3M17 5a3 3 0 0 1 0 6M18 15a5 5 0 0 1 3 4v2"/>',
    'coffee' => '<path d="M4 8h13v8a4 4 0 0 1-4 4H8a4 4 0 0 1-4-4ZM17 9h2a3 3 0 0 1 0 6h-2M7 3v2M11 2v3M15 3v2"/>',
    'arrow' => '<path d="M5 12h14M13 6l6 6-6 6"/>',
    'search' => '<circle cx="10" cy="10" r="6"/><path d="m15 15 6 6"/>',
];
function dashboardIcon(string $name): string {
    global $icons;
    return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' . ($icons[$name] ?? '') . '</svg>';
}
?>
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex,nofollow">
  <title>Dashboard · Coffee</title>
  <link rel="stylesheet" href="promoflow-sidebar.css?v=<?= filemtime(__DIR__ . '/promoflow-sidebar.css') ?>">
  <link rel="stylesheet" href="dashboard.css?v=<?= filemtime(__DIR__ . '/dashboard.css') ?>">
  <script src="dashboard.js?v=<?= filemtime(__DIR__ . '/dashboard.js') ?>" defer></script>
</head>
<body>
<a href="#main" class="skip-link">Saltar al contenido</a>
<div class="dashboard-shell">
  <aside class="section-sidebar-navigation side-open" id="dashboard-sidebar" aria-label="Administración de Coffee">
    <a href="#overview" class="sidebar-header">
      <span class="coffee-mark"><?= dashboardIcon('coffee') ?></span>
      <span class="sidebar-title"><strong>Coffee</strong><small>ADMINISTRACIÓN</small></span>
    </a>
    <p class="sidebar-label">ESPACIO DE TRABAJO</p>
    <nav class="sidebar-left-menu" aria-label="Secciones del dashboard">
      <?php foreach (['overview' => 'Resumen', 'orders' => 'Pedidos', 'messages' => 'Mensajes', 'users' => 'Usuarios'] as $key => $label): ?>
      <a class="sidebar-left-menu-item<?= $key === 'overview' ? ' is-active' : '' ?>" href="#<?= $key ?>" data-section="<?= $key ?>"<?= $key === 'overview' ? ' aria-current="page"' : '' ?>>
        <span class="sidebar-item-icon"><?= dashboardIcon($key) ?></span><span><?= $label ?></span>
      </a>
      <?php endforeach; ?>
    </nav>
    <div class="sidebar-bottom">
      <div class="sidebar-note"><span class="small-dot"></span>Tu operación, en un solo lugar.<small>El espacio de Promoflow, dentro de Coffee.</small></div>
      <a class="back-store" href="../product/index.php">Volver a la tienda <?= dashboardIcon('arrow') ?></a>
    </div>
  </aside>

  <main id="main" tabindex="-1">
    <header class="topbar"><span>Coffee <span class="separator">/</span> Dashboard <span class="separator">/</span> <strong id="breadcrumb">Resumen</strong></span><span class="preview-pill"><span class="small-dot"></span> Vista previa</span></header>
    <div class="preview-notice"><strong>Interfaz de demostración.</strong> Los datos son de ejemplo. Los cambios solo duran mientras esta página está abierta; no se envían mensajes ni se modifica la base de datos.</div>
    <header class="page-heading"><div><p class="eyebrow">COFFEE · OPERACIONES</p><h1 id="page-title">Un buen día empieza aquí.</h1><p id="page-description">Una mirada a tus pedidos, conversaciones y equipo.</p></div><span class="heading-stamp" aria-hidden="true"><?= dashboardIcon('coffee') ?></span></header>

    <section id="section-overview" class="dashboard-section" aria-label="Resumen">
      <div class="stats-grid" id="stats-grid"></div>
      <div class="overview-grid">
        <article class="panel"><div class="panel-heading"><div><p class="eyebrow">EN TU RADAR</p><h2>Aprobaciones pendientes</h2></div><span class="badge warm">2 de ejemplo</span></div>
          <div class="table-scroll"><table><thead><tr><th>Producto</th><th>Proveedor</th><th>Solicitud</th><th>Acción</th></tr></thead><tbody id="approvals-body"></tbody></table></div>
          <p class="panel-footnote">Aquí podrás revisar las solicitudes de publicación de Coffee.</p>
        </article>
        <article class="panel activity-panel"><div class="panel-heading"><div><p class="eyebrow">LO MÁS RECIENTE</p><h2>Actividad</h2></div></div><ol class="activity-list"><li><span class="activity-dot"></span><div><strong>Nuevo pedido recibido</strong><p>Café de origen · Pedido #CF-1048</p><small>Hoy, 10:30 · Ejemplo</small></div></li><li><span class="activity-dot caramel"></span><div><strong>Una conversación por revisar</strong><p>Tostadores del Valle · Entrega semanal</p><small>Hoy, 09:15 · Ejemplo</small></div></li><li><span class="activity-dot pale"></span><div><strong>Producto pendiente de aprobación</strong><p>Blend de la casa · Nueva publicación</p><small>Ayer, 16:45 · Ejemplo</small></div></li></ol></article>
      </div>
      <article class="panel"><div class="panel-heading"><div><p class="eyebrow">DE LA TIENDA A LA MESA</p><h2>Últimos pedidos</h2></div><a class="text-link" href="#orders">Ver todos <?= dashboardIcon('arrow') ?></a></div><div class="table-scroll"><table><thead><tr><th>Pedido</th><th>Cliente</th><th>Fecha</th><th>Estado</th><th>Total de ejemplo</th><th></th></tr></thead><tbody id="recent-orders"></tbody></table></div></article>
    </section>

    <section id="section-orders" class="dashboard-section" aria-label="Pedidos" hidden>
      <article class="panel"><div class="toolbar"><label class="search-field"><?= dashboardIcon('search') ?><input id="orders-search" type="search" placeholder="Buscar pedido o cliente" aria-label="Buscar pedido o cliente"></label><label class="filter-label">Estado<select id="orders-filter"><option value="">Todos</option><option>Por preparar</option><option>En preparación</option><option>Enviado</option><option>Entregado</option></select></label></div><div class="table-scroll"><table><thead><tr><th>Pedido</th><th>Cliente</th><th>Fecha</th><th>Estado</th><th>Total de ejemplo</th><th></th></tr></thead><tbody id="orders-body"></tbody></table></div><p class="panel-footnote" id="orders-count"></p></article>
    </section>

    <section id="section-messages" class="dashboard-section" aria-label="Mensajes" hidden>
      <div class="messages-layout panel"><aside class="conversations"><div class="conversation-heading"><h2>Conversaciones</h2><button class="icon-button" id="new-conversation" aria-label="Crear conversación de ejemplo">+</button></div><label class="search-field"><?= dashboardIcon('search') ?><input type="search" id="conversation-search" placeholder="Buscar conversación" aria-label="Buscar conversación"></label><div id="conversation-list"></div></aside><div class="conversation-content"><header class="conversation-header"><span class="avatar" aria-hidden="true">TV</span><div><h2 id="conversation-title"></h2><p id="conversation-subtitle"></p></div></header><div id="message-list" role="log" aria-label="Mensajes de ejemplo" aria-live="polite"></div><form id="message-form"><label class="sr-only" for="message-input">Mensaje de borrador</label><textarea id="message-input" required maxlength="2000" rows="2" placeholder="Escribe un borrador de ejemplo…"></textarea><button class="button primary" type="submit">Añadir borrador <?= dashboardIcon('arrow') ?></button><small>Solo vista previa. Este mensaje no se envía.</small></form></div></div>
    </section>

    <section id="section-users" class="dashboard-section" aria-label="Usuarios" hidden>
      <article class="panel"><div class="toolbar"><label class="search-field"><?= dashboardIcon('search') ?><input id="users-search" type="search" placeholder="Buscar por nombre o correo" aria-label="Buscar usuarios"></label><button class="button primary" id="new-user">+ Añadir usuario de ejemplo</button></div><div class="table-scroll"><table><thead><tr><th>Usuario</th><th>Correo</th><th>Rol</th><th>Estado</th><th>Acciones</th></tr></thead><tbody id="users-body"></tbody></table></div><p class="panel-footnote">Diseño de la gestión de usuarios. No crea cuentas ni concede permisos reales.</p></article>
    </section>
    <footer class="dashboard-footer"><span>Coffee · Hecho para tu día a día.</span><span>Interfaz basada en Promoflow_v1</span></footer>
  </main>
</div>
<dialog id="detail-dialog" aria-labelledby="detail-title"><div class="dialog-heading"><h2 id="detail-title">Detalle</h2><button type="button" class="icon-button" data-close aria-label="Cerrar detalle">×</button></div><div id="detail-content"></div><form method="dialog" class="dialog-actions"><button class="button">Cerrar</button></form></dialog>
<dialog id="user-dialog" aria-labelledby="user-dialog-title"><form id="user-form"><div class="dialog-heading"><h2 id="user-dialog-title">Usuario de ejemplo</h2><button type="button" class="icon-button" data-close aria-label="Cerrar formulario">×</button></div><input type="hidden" name="id"><label>Nombre<input name="name" required maxlength="80" autocomplete="off"></label><label>Correo<input type="email" name="email" required maxlength="150" autocomplete="off"></label><div class="form-grid"><label>Rol<select name="role"><option>Administrador</option><option>Operaciones</option><option>Atención al cliente</option></select></label><label>Estado<select name="status"><option>Activo</option><option>Inactivo</option></select></label></div><p class="dialog-note">Se añade únicamente a esta vista previa. No se crea un acceso.</p><div class="dialog-actions"><button class="button" type="button" data-close>Cancelar</button><button class="button primary" type="submit">Guardar en la vista previa</button></div></form></dialog>
<dialog id="conversation-dialog" aria-labelledby="conversation-dialog-title"><form id="conversation-form"><div class="dialog-heading"><h2 id="conversation-dialog-title">Conversación de ejemplo</h2><button type="button" class="icon-button" data-close aria-label="Cerrar formulario">×</button></div><label>Asunto<input name="subject" required maxlength="100"></label><label>Proveedor de ejemplo<select name="supplier"><option>Tostadores del Valle</option><option>Finca La Esperanza</option><option>Café del Bosque</option></select></label><p class="dialog-note">Esta conversación no contacta con ningún proveedor.</p><div class="dialog-actions"><button class="button" type="button" data-close>Cancelar</button><button class="button primary">Crear vista previa</button></div></form></dialog>
<div id="toast" role="status" aria-live="polite" hidden></div>
<noscript><p class="preview-notice">Activa JavaScript para explorar las secciones de esta interfaz.</p></noscript>
</body>
</html>
