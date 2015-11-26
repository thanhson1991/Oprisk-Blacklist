UPDATE menu_item SET label = 'Báo cáo RR' WHERE label = 'Quản lý báo cáo RR';
UPDATE menu_item SET label = 'Báo cáo tổn thất' WHERE label = 'Quản lý báo cáo tổn thất';
UPDATE menu_item SET label = 'Ðánh giá RR' WHERE label = 'Quản lý đánh giá RR';
UPDATE menu_item SET label = 'Khuyến nghị HÐ' WHERE label = 'Quản lý khuyến nghị hành động';
UPDATE menu_item SET label = 'Bản tin RR' WHERE label = 'Quản lý bản tin RR';

/*Update id thay vi tri*/
UPDATE menu_item SET id = 34 WHERE id = 24;
UPDATE menu_item SET id = 35 WHERE id = 25;
UPDATE menu_item SET id = 36 WHERE id = 26;

/*Update request_map */
UPDATE request_map SET config_attribute = 'GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4' WHERE url = '/selfEvaluation/**';