
CREATE TABLE "user" (
  id_user            	SERIAL PRIMARY KEY,
  name               VARCHAR(100)        NOT NULL,
  identification       VARCHAR(20)         NOT NULL,
  adress            VARCHAR(255),
  email               VARCHAR(255)        NOT NULL,
  phone             VARCHAR(20),
	
	
ALTER TABLE "user"
  ALTER COLUMN identification TYPE VARCHAR(100),
  ALTER COLUMN phone TYPE VARCHAR(100);
);

-- =========================
-- Tabla: facturacion
-- =========================
CREATE TABLE billing (
  id_billing       SERIAL PRIMARY KEY,
  id_user           INT                 NOT NULL,
  billing_period  VARCHAR(20)         NOT NULL,
  invoiced_amount      NUMERIC(12,2)       NOT NULL    DEFAULT 0.00
	
	ALTER TABLE billing
  ALTER COLUMN billing_period TYPE VARCHAR(100);
);


-- =========================
-- Tabla: transaccion
-- =========================
CREATE TABLE "transaction" (
  id_billing          VARCHAR(100)    PRIMARY KEY,
  id_user           INT             NOT NULL,
	billing_period    VARCHAR(20),
	invoiced_amount   NUMERIC(12,2)
);
	
















SELECT 
        u.id_user,
        u.name  AS client_name,
        u.email,
        COALESCE(
          SUM(t.amount_paid) FILTER (WHERE t.state_transaction IN ('APPROVED','COMPLETED','CONFIRMED')),
          0
        ) AS total_paid
      FROM "user" u
      LEFT JOIN billing b        ON b.id_user = u.id_user
      LEFT JOIN "transaction" t  ON t.id_billing = b.id_billing
      GROUP BY u.id_user, u.name, u.email
      ORDER BY client_name;
			
SELECT 
				u.id_user,
        u.name  AS client_name,
        u.email,
        COALESCE(
          SUM(t.amount_paid) FILTER (WHERE t.state_transaction IN ('APPROVED','COMPLETED','CONFIRMED')),
          0
        ) AS total_paid
      FROM "user" u
      LEFT JOIN billing b        ON b.id_user = u.id_user
      LEFT JOIN "transaction" t  ON t.id_billing = b.id_billing
      WHERE u.id_user = $1
      GROUP BY u.id_user, u.name, u.email;
			
			
			
			
WITH pagos AS (
        SELECT 
          id_billing,
          COALESCE(
            SUM(amount_paid) FILTER (WHERE state_transaction IN ('APPROVED','COMPLETED','CONFIRMED')),
            0
          ) AS total_pagado
        FROM "transaction"
        GROUP BY id_billing
      ),
      ultima_tx AS (
        SELECT DISTINCT ON (t.id_billing)
          t.id_billing,
          t.id_transaction,
          t.state_transaction,
          t.type_transaction,
          t.plataform,
          t.transaction_amount,
          t.amount_paid,
          t.date_hour_transaction
        FROM "transaction" t
        ORDER BY t.id_billing, t.date_hour_transaction DESC
      )
      SELECT 
        b.id_billing,
        b.billing_period,
        u.id_user,
        u.name AS client_name,
        u.email,
        b.invoiced_amount,
        COALESCE(p.total_pagado, 0) AS total_pagado,
        (b.invoiced_amount - COALESCE(p.total_pagado, 0)) AS saldo_pendiente,
        utx.id_transaction      AS last_transaction_id,
        utx.state_transaction   AS last_transaction_state,
        utx.type_transaction    AS last_transaction_type,
        utx.plataform           AS last_transaction_platform,
        utx.date_hour_transaction AS last_transaction_date
      FROM billing b
      JOIN "user" u   ON u.id_user = b.id_user
      LEFT JOIN pagos p    ON p.id_billing = b.id_billing
      LEFT JOIN ultima_tx utx ON utx.id_billing = b.id_billing
      WHERE (b.invoiced_amount - COALESCE(p.total_pagado, 0)) > 0
      ORDER BY u.name, b.billing_period;
			
			
			
			
SELECT 
        t.id_transaction,
        t.date_hour_transaction,
        t.state_transaction,
        t.type_transaction,
        t.plataform,
        t.transaction_amount,
        t.amount_paid,
        b.id_billing,
        b.billing_period,
        u.id_user,
        u.name  AS client_name,
        u.email
      FROM "transaction" t
      JOIN billing b ON b.id_billing = t.id_billing
      JOIN "user" u  ON u.id_user = b.id_user
      WHERE t.plataform ILIKE $1
      ORDER BY t.date_hour_transaction DESC;
			
			

