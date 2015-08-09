CREATE OR REPLACE FUNCTION do_count_products() RETURNS trigger AS $$ 
  BEGIN 
    IF (TG_OP = 'DELETE') THEN
      UPDATE company SET products_num = products_num - 1 WHERE id = OLD.company_id;
    ELSIF (TG_OP = 'INSERT') THEN
      UPDATE company SET products_num = products_num + 1 WHERE id = NEW.company_id;
    ELSIF (TG_OP = 'UPDATE') THEN
      UPDATE company SET products_num = products_num - 1 WHERE id = OLD.company_id;
      UPDATE company SET products_num = products_num + 1 WHERE id = NEW.company_id;
    END IF;
    RETURN NULL; 
  END; 
$$ LANGUAGE plpgsql;

CREATE TRIGGER count_products 
  AFTER INSERT OR DELETE OR UPDATE OF company_id 
  ON product 
  FOR EACH ROW
  EXECUTE PROCEDURE do_count_products();
