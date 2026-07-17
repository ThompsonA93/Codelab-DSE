SET search_path TO music_store;

INSERT INTO supplier_catalog (supplier_name, catalog_date, product_xml)
VALUES (
    'Vinyl Supply Co.',
    '2025-05-20',
    '
    <catalog name="Spring 2025">
        <item type="vinyl" sku="LP-001">
            <title>The Dark Side of the Moon</title>
            <artist>Pink Floyd</artist>
            <price currency="USD">35.99</price>
            <stock>250</stock>
        </item>
        <item type="CD" sku="CD-015">
            <title>21</title>
            <artist>Adele</artist>
            <price currency="USD">12.99</price>
            <stock>400</stock>
        </item>
    </catalog>
    '::xml
);


SELECT
    s.supplier_name,
    (xpath('/catalog/item/title/text()', s.product_xml))[1]::text AS first_item_title,
    (xpath('/catalog/item/price/text()', s.product_xml))[1]::text AS first_item_price
FROM supplier_catalog s;


SELECT
    s.supplier_name,
    (xpath('//item[stock/text() > 300]', s.product_xml))[1] AS high_stock_item
FROM supplier_catalog s
WHERE
    array_length(xpath('//item[stock/text() > 300]', s.product_xml), 1) > 0;


SELECT
    (xpath('//item[@type="vinyl"]/@sku', s.product_xml))[1]::text AS vinyl_sku
FROM supplier_catalog s;


DROP TABLE supplier_catalog;