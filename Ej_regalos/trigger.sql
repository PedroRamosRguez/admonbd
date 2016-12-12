DELIMITER $$
DROP TRIGGER IF EXISTS precioTotal;
CREATE TRIGGER precioTotal before insert on REGALO
FOR EACH ROW
BEGIN  
SET new.Precio_Total = new.Cantidad_articulo * new.Precio_unidad;
END$$
DELIMITER;
