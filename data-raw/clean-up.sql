/*
 * vyčistí vše z rczechia.db
 * zbudou pouze prázdné struktury
 *  (děláme delete, ne drop...)  
 */
delete from ciskraj;
delete from cisob;
delete from cisob;
delete from cisokre;
delete from obce_body;
delete from obce_poly;
delete from vazob;
delete from vazokr;
delete from vazpou;
delete from vazorp;
vacuum;
