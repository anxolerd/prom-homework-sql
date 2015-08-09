CREATE OR REPLACE FUNCTION do_count_products() RETURNS trigger AS $$ 
  BEGIN 
    UPDATE company c SET products_num = (
      SELECT count(*) FROM product p WHERE p.company_id = c.id
    ); 
    RETURN NULL; 
  END; 
$$ LANGUAGE plpgsql;

CREATE TRIGGER count_products 
  AFTER INSERT OR DELETE OR UPDATE OF company_id 
  ON product 
  EXECUTE PROCEDURE do_count_products();
