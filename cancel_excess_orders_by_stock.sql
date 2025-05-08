set serveroutput on;

declare
    v_stock number;              -- available stock for the product
    v_totalquantity number := 0; -- total quantity from active orders
    v_excessquantity number;     -- quantity exceeding the stock
    cursor c_products is
        select productid, stock
        from products;           -- cursor for all products
    cursor c_orders (p_productid number) is
        select orderid, quantity
        from orderdetails
        where productid = p_productid
        order by quantity desc;  -- sort orders in descending order by quantity
begin
    -- loop through each product from the products table
    for r_product in c_products loop
        v_stock := r_product.stock;

        -- calculate the total quantity from all active orders for the current product
        select coalesce(sum(quantity), 0) into v_totalquantity
        from orderdetails
        where productid = r_product.productid;

        -- check if the total quantity exceeds the stock
        if v_totalquantity > v_stock then
            v_excessquantity := v_totalquantity - v_stock;

            dbms_output.put_line('For productid ' || r_product.productid || ', the total order quantity exceeds stock. Cancelling orders...');

            -- iterate through the orders, starting from the largest ones
            for r_order in c_orders(r_product.productid) loop
                -- if the excess is covered, exit the loop
                if v_excessquantity <= 0 then
                    exit;
                end if;

                -- cancel the current order
                delete from orderdetails
                where orderid = r_order.orderid;

                dbms_output.put_line('Order with orderid ' || r_order.orderid || ' and quantity ' || r_order.quantity || ' was cancelled.');

                -- subtract the quantity from the excess
                v_excessquantity := v_excessquantity - r_order.quantity;
            end loop;
        else
            dbms_output.put_line('For productid ' || r_product.productid || ', the total order quantity is within stock limits.');
        end if;
    end loop;
end;
