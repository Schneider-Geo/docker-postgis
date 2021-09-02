CREATE SEQUENCE IF NOT EXISTS print_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 4614
  CACHE 1;
ALTER TABLE print_seq
  OWNER TO osm;

DROP TABLE IF EXISTS print_data;
CREATE TABLE IF NOT EXISTS print_data
(
  id bigint NOT NULL DEFAULT nextval('print_seq'::regclass),
  context text NOT NULL,
  name text,
  way geometry,
  type text,
  category text,
  color text,
  width int,
  height int,
  icondir varchar(255)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE print_data
  OWNER TO osm;

DROP TABLE IF EXISTS print_schedule;
CREATE TABLE IF NOT EXISTS print_schedule
(
    id bigint NOT NULL DEFAULT nextval('print_seq'::regclass),
    finishEvent varchar(100) NOT NULL,
    orderGroup text NOT NULL DEFAULT 'NONE',
    orderId varchar(100) NOT NULL,
    processId varchar(100), 
    format text NOT NULL,
    status text NOT NULL,
    bbox text NOT NULL,
    filetype text NOT NULL,
    recordingtime timestamp,
    starttime timestamp,
    endtime timestamp,
    resolution text,
    maptype varchar(1),
    detail smallint,
    bucket varchar(100),
    hgtfiles varchar(100),
    query text,
    printType text,
    priority int

);



ALTER TABLE print_schedule
  OWNER TO osm;

DROP TABLE IF EXISTS tile_schedule;
CREATE TABLE IF NOT EXISTS tile_schedule
(
    id bigint NOT NULL DEFAULT nextval('print_seq'::regclass),
    orderId text NOT NULL,
    sequence int NOT NULL,
     status text NOT NULL,
    hgtfiles varchar(100),
   minZoom int NOT NULL,
   maxZoom int NOT NULL,
   bbox text NOT NULL,
    recordingtime timestamp,
    starttime timestamp,
    endtime timestamp,
    maptype varchar(1)

);
ALTER TABLE tile_schedule
  OWNER TO osm;
  
  
CREATE SEQUENCE custom_osm_seq
    START WITH 4591
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE custom_osm_seq OWNER TO osm;



CREATE TABLE custom_osm_point (
    osm_id bigint DEFAULT nextval('custom_osm_seq'::regclass) NOT NULL,
    name text,
    way geometry,
    id integer,
    type text
);


ALTER TABLE custom_osm_point OWNER TO osm;


CREATE TABLE custom_osm_polygon (
    osm_id bigint DEFAULT nextval('custom_osm_seq'::regclass) NOT NULL,
    name text,
    kind text,
    way geometry
);


ALTER TABLE custom_osm_polygon OWNER TO osm;
  
  
SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
CREATE TABLE "contours" (gid serial,"id" int4,"height" float8);
ALTER TABLE "contours" ADD PRIMARY KEY (gid);
SELECT AddGeometryColumn('','contours','way','0','MULTILINESTRING',2);
CREATE INDEX ON "contours" USING GIST ("way");
COMMIT;
ANALYZE "contours";
SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

