set serveroutput on;

declare
    v_stock number;              -- stocul disponibil pentru produs
    v_totalquantity number := 0; -- suma cantitatilor din comenzile active
    v_excessquantity number;     -- cantitatea in exces fata de stoc
    cursor c_products is
        select productid, stock
        from products;           -- cursor pentru toate produsele
    cursor c_orders (p_productid number) is
        select orderid, quantity
        from orderdetails
        where productid = p_productid
        order by quantity desc;  -- sortam comenzile in ordine descrescatoare dupa cantitate
begin
    -- parcurgem fiecare produs din tabelul products
    for r_product in c_products loop
        v_stock := r_product.stock;

        -- calculam suma cantitatilor din toate comenzile active pentru produsul curent
        select coalesce(sum(quantity), 0) into v_totalquantity
        from orderdetails
        where productid = r_product.productid;

        -- verificam daca suma cantitatilor depaseste stocul
        if v_totalquantity > v_stock then
            v_excessquantity := v_totalquantity - v_stock;

            dbms_output.put_line('pentru productid ' || r_product.productid || ', suma cantitatilor depaseste stocul. anulam comenzile...');

            -- parcurgem comenzile, incepand cu cele mai mari
            for r_order in c_orders(r_product.productid) loop
                -- daca excesul este acoperit, iesim din bucla
                if v_excessquantity <= 0 then
                    exit;
                end if;

                -- anulam comanda curenta
                delete from orderdetails
                where orderid = r_order.orderid;

                dbms_output.put_line('comanda cu orderid ' || r_order.orderid || ' si cantitate ' || r_order.quantity || ' a fost anulata.');

                -- scadem cantitatea din exces
                v_excessquantity := v_excessquantity - r_order.quantity;
            end loop;
        else
            dbms_output.put_line('pentru productid ' || r_product.productid || ', suma cantitatilor este in limitele stocului.');
        end if;
    end loop;
end;

