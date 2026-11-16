-- Esquema de Coffee, sin datos.
-- Origen: u273173398_dot63-5.sql (MariaDB).
-- Esquema adaptado: promociones vinculadas a customers, no a variations.
-- Los contadores AUTO_INCREMENT comienzan en 1 para las tablas nuevas.

CREATE DATABASE IF NOT EXISTS `Coffee`
  DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `Coffee`;

SET NAMES utf8mb4;

-- Tablas

CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company_name` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `street_address_1` varchar(50) DEFAULT NULL,
  `street_address_2` varchar(50) DEFAULT NULL,
  `town_city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `postcode` varchar(50) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password_hash` text DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  `group` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT 0,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `images` (
  `image_id` int(11) NOT NULL,
  `link` text DEFAULT NULL,
  `updated` int(11) DEFAULT NULL,
  `variation_id` int(11) DEFAULT NULL,
  `show_on_product_main` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `variation_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jobs` (
  `job_id` int(11) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price_per_unit` float(10,2) DEFAULT NULL,
  `discount_percentage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `subtotal` float(10,2) DEFAULT NULL,
  `pdf_artwork_link` text DEFAULT NULL,
  `id_order` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `job_details` (
  `job_id` int(11) NOT NULL,
  `variation_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `quantity` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` varchar(50) DEFAULT NULL,
  `currency` varchar(50) DEFAULT NULL,
  `subtotal` varchar(50) DEFAULT NULL,
  `shipping_total` varchar(50) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `shipping_address_json` text DEFAULT NULL,
  `promotion_code` varchar(50) DEFAULT NULL,
  `discount_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cart_fingerprint` char(64) DEFAULT NULL,
  `stripe_payment_intent_id` varchar(255) DEFAULT NULL,
  `stripe_payment_status` varchar(50) DEFAULT NULL,
  `stripe_idempotency_key` varchar(255) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `password_reset_requests` (
  `bucket_hash` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `attempts` int(10) UNSIGNED NOT NULL,
  `window_started` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

CREATE TABLE `password_reset_tokens` (
  `account_type` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `account_id` int(11) NOT NULL,
  `token_hash` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `password_fingerprint` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `expires_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

CREATE TABLE `prices` (
  `price_id` int(11) NOT NULL,
  `min_quantity` int(11) DEFAULT NULL,
  `max_quantity` int(11) DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  `variation_id` int(11) DEFAULT NULL,
  `delivery_price` decimal(12,2) UNSIGNED DEFAULT NULL,
  `delivery_price_type` enum('percentage','amount') DEFAULT NULL,
  `delivery_time_days` smallint(5) UNSIGNED DEFAULT NULL,
  `delivery_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`delivery_options`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `SKU` varchar(50) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `descriptive_tagline` text DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `date_status` time DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT 0,
  `supplier_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `pending_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `status_request_version` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status_requested_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `promotions` (
  `promotion_id` int(11) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `discount_type` varchar(50) DEFAULT NULL,
  `discount_value` float(10,2) DEFAULT NULL,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `stripe_webhook_events` (
  `event_id` varchar(255) NOT NULL,
  `event_type` varchar(100) NOT NULL,
  `payment_intent_id` varchar(255) DEFAULT NULL,
  `processed_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `contact_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `company_name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `address_line1` varchar(50) DEFAULT NULL,
  `address_line2` varchar(50) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `password` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `supplier_categories` (
  `supplier_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `type_variations` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(100) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `variations` (
  `variation_id` int(11) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `SKU` varchar(100) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `pdf_artwork` text DEFAULT NULL,
  `name_pdf_artwork` text DEFAULT NULL,
  `price_display_mode` varchar(50) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `delivery_price` decimal(12,2) UNSIGNED DEFAULT NULL,
  `delivery_price_type` enum('percentage','amount') DEFAULT NULL,
  `delivery_time_days` smallint(5) UNSIGNED DEFAULT NULL,
  `delivery_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`delivery_options`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='a';

CREATE TABLE `customer_promotions` (
  `customer_id` int(11) NOT NULL,
  `promotion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Claves primarias, indices, AUTO_INCREMENT y claves foraneas

ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `IXFK_addresses_customers` (`customer_id`);

ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `IXFK_groups_categories` (`category_id`);

ALTER TABLE `images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `IXFK_images_variations` (`variation_id`);

ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `IXFK_items_variations` (`variation_id`);

ALTER TABLE `jobs`
  ADD PRIMARY KEY (`job_id`),
  ADD KEY `IXFK_jobs_orders` (`order_id`),
  ADD KEY `IXFK_jobs_orders_02` (`order_id`);

ALTER TABLE `job_details`
  ADD PRIMARY KEY (`job_id`,`variation_id`),
  ADD KEY `IXFK_job_details_jobs` (`job_id`),
  ADD KEY `IXFK_job_details_variations` (`variation_id`);

ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `UX_orders_stripe_payment_intent` (`stripe_payment_intent_id`),
  ADD KEY `IXFK_orders_customers` (`customer_id`),
  ADD KEY `IX_orders_address` (`address_id`),
  ADD KEY `IX_orders_payment_status` (`status`,`stripe_payment_status`);

ALTER TABLE `password_reset_requests`
  ADD PRIMARY KEY (`bucket_hash`),
  ADD KEY `password_reset_request_window` (`window_started`);

ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`account_type`,`account_id`),
  ADD UNIQUE KEY `password_reset_token_hash` (`token_hash`),
  ADD KEY `password_reset_expiry` (`expires_at`);

ALTER TABLE `prices`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `IXFK_prices_variations` (`variation_id`);

ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `IXFK_products_groups` (`group_id`),
  ADD KEY `IXFK_products_suppliers` (`supplier_id`);

ALTER TABLE `promotions`
  ADD PRIMARY KEY (`promotion_id`);

ALTER TABLE `stripe_webhook_events`
  ADD PRIMARY KEY (`event_id`);

ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

ALTER TABLE `supplier_categories`
  ADD PRIMARY KEY (`supplier_id`,`category_id`),
  ADD KEY `IXFK_supplier_categories_categories` (`category_id`),
  ADD KEY `IXFK_supplier_categories_suppliers` (`supplier_id`);

ALTER TABLE `type_variations`
  ADD PRIMARY KEY (`type_id`),
  ADD KEY `IXFK_type_variations_categories` (`category_id`);

ALTER TABLE `variations`
  ADD PRIMARY KEY (`variation_id`),
  ADD KEY `IXFK_variations_products` (`product_id`),
  ADD KEY `IXFK_variations_type_variations` (`type_id`),
  ADD KEY `IXFK_variations_variations` (`parent_id`),
  ADD KEY `wdbi_sku_product_id_0e99683c22aa` (`SKU`,`product_id`);

ALTER TABLE `customer_promotions`
  ADD PRIMARY KEY (`customer_id`,`promotion_id`),
  ADD KEY `IXFK_customer_promotions_promotions` (`promotion_id`),
  ADD KEY `IXFK_customer_promotions_customers` (`customer_id`);

ALTER TABLE `addresses`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `groups`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `jobs`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `prices`
  MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `promotions`
  MODIFY `promotion_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `type_variations`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `variations`
  MODIFY `variation_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `addresses`
  ADD CONSTRAINT `FK_addresses_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `groups`
  ADD CONSTRAINT `FK_groups_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `images`
  ADD CONSTRAINT `FK_images_variations` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`variation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `items`
  ADD CONSTRAINT `FK_items_variations` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`variation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `jobs`
  ADD CONSTRAINT `FK_jobs_orders_02` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `job_details`
  ADD CONSTRAINT `FK_job_details_jobs` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_job_details_variations` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`variation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `orders`
  ADD CONSTRAINT `FK_orders_addresses` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `prices`
  ADD CONSTRAINT `FK_prices_variations` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`variation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `products`
  ADD CONSTRAINT `FK_products_groups` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_products_suppliers` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `supplier_categories`
  ADD CONSTRAINT `FK_supplier_categories_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_supplier_categories_suppliers` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `type_variations`
  ADD CONSTRAINT `FK_type_variations_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `variations`
  ADD CONSTRAINT `FK_variations_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_variations_type_variations` FOREIGN KEY (`type_id`) REFERENCES `type_variations` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_variations_variations` FOREIGN KEY (`parent_id`) REFERENCES `variations` (`variation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `customer_promotions`
  ADD CONSTRAINT `FK_customer_promotions_promotions` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_customer_promotions_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
