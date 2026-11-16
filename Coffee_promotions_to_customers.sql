-- Ejecutar en la base seleccionada en phpMyAdmin, si ya existe el esquema anterior.
-- Elimina los vinculos anteriores entre variaciones y promociones.
-- Conserva las tablas promotions, variations y customers y sus datos.
-- Las asignaciones a clientes deben crearse por separado.

CREATE TABLE `customer_promotions` (
  `customer_id` int(11) NOT NULL,
  `promotion_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`, `promotion_id`),
  KEY `IXFK_customer_promotions_promotions` (`promotion_id`),
  KEY `IXFK_customer_promotions_customers` (`customer_id`),
  CONSTRAINT `FK_customer_promotions_customers`
    FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_customer_promotions_promotions`
    FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `variation_promotions`;
