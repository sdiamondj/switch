--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9
-- Dumped by pg_dump version 10.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: switch_battery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.switch_battery (
    battery_id character varying(36) NOT NULL,
    battery_state smallint DEFAULT 0 NOT NULL,
    box_id character varying(36)
);


ALTER TABLE public.switch_battery OWNER TO postgres;

--
-- Name: COLUMN switch_battery.battery_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_battery.battery_id IS '电池id';


--
-- Name: COLUMN switch_battery.battery_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_battery.battery_state IS '电池状态 0-可用 1-不可用';


--
-- Name: switch_box; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.switch_box (
    box_id character varying(36) NOT NULL,
    box_state smallint DEFAULT 0 NOT NULL,
    site_id character varying(36) NOT NULL,
    box_number smallint NOT NULL
);


ALTER TABLE public.switch_box OWNER TO postgres;

--
-- Name: COLUMN switch_box.box_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_box.box_id IS '换电箱id';


--
-- Name: COLUMN switch_box.box_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_box.box_state IS '换电箱状态0-可出租 1-已出租 2-充电中 3-故障';


--
-- Name: COLUMN switch_box.site_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_box.site_id IS '换电箱所属站点id';


--
-- Name: COLUMN switch_box.box_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_box.box_number IS '换电箱编号';


--
-- Name: switch_box_box_number_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.switch_box_box_number_seq1
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.switch_box_box_number_seq1 OWNER TO postgres;

--
-- Name: switch_box_box_number_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.switch_box_box_number_seq1 OWNED BY public.switch_box.box_number;


--
-- Name: switch_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.switch_order (
    order_id character varying(36) NOT NULL,
    battery_id character varying(36) NOT NULL,
    borrow_time timestamp(6) without time zone,
    order_state smallint DEFAULT 1 NOT NULL,
    return_time timestamp(6) without time zone,
    user_id character varying(36) NOT NULL,
    order_price bigint DEFAULT 0
);


ALTER TABLE public.switch_order OWNER TO postgres;

--
-- Name: COLUMN switch_order.order_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_order.order_id IS '订单id';


--
-- Name: COLUMN switch_order.battery_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_order.battery_id IS '电池id';


--
-- Name: COLUMN switch_order.borrow_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_order.borrow_time IS '电池借出时间';


--
-- Name: COLUMN switch_order.order_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_order.order_state IS '订单状态 0-创建 1-已借用 2-已归还';


--
-- Name: COLUMN switch_order.return_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_order.return_time IS '电池归还时间';


--
-- Name: COLUMN switch_order.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_order.user_id IS '用户id';


--
-- Name: COLUMN switch_order.order_price; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_order.order_price IS '支付金额';


--
-- Name: switch_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.switch_site (
    site_id character varying(36) NOT NULL,
    site_x double precision NOT NULL,
    site_y double precision NOT NULL,
    site_name character varying(100) NOT NULL,
    box_num integer DEFAULT 50 NOT NULL
);


ALTER TABLE public.switch_site OWNER TO postgres;

--
-- Name: COLUMN switch_site.site_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_site.site_id IS '换电站id';


--
-- Name: COLUMN switch_site.site_x; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_site.site_x IS '经度';


--
-- Name: COLUMN switch_site.site_y; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_site.site_y IS '纬度';


--
-- Name: COLUMN switch_site.site_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_site.site_name IS '换电站名字';


--
-- Name: COLUMN switch_site.box_num; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_site.box_num IS '换电箱数量';


--
-- Name: switch_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.switch_user (
    user_id character varying(36) NOT NULL,
    user_phone character varying(32) NOT NULL,
    user_password character varying(64) NOT NULL,
    "isDoing" character varying(4) DEFAULT 0 NOT NULL
);


ALTER TABLE public.switch_user OWNER TO postgres;

--
-- Name: COLUMN switch_user.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_user.user_id IS '用户id';


--
-- Name: COLUMN switch_user.user_phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_user.user_phone IS '用户手机号';


--
-- Name: COLUMN switch_user.user_password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_user.user_password IS '用户密码';


--
-- Name: COLUMN switch_user."isDoing"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.switch_user."isDoing" IS '是否有进行中的订单 0-否 1-是  默认 0';


--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    id integer NOT NULL,
    name character varying(32)
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: switch_box box_number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.switch_box ALTER COLUMN box_number SET DEFAULT nextval('public.switch_box_box_number_seq1'::regclass);


--
-- Data for Name: switch_battery; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.switch_battery VALUES ('093afcb3ffbe4b9a93a90773ae8efe88', 0, 'cd11bb13ac4246d5bc07f8c33a12bf42');
INSERT INTO public.switch_battery VALUES ('c4e08616d3f643a7a4ec8e19a6ce3b2d', 0, 'f4d6658b643a4c1fad7afa38f9c2c065');
INSERT INTO public.switch_battery VALUES ('a282e0eae50c44b6916cb745ca16314d', 0, 'cf3fdb9be6424b8d8c0e1b54777716f0');
INSERT INTO public.switch_battery VALUES ('b2e17e838cc24e638165d8f1665c5f5d', 0, 'df60cd8fef844d85a2b26ba7ab5132b0');
INSERT INTO public.switch_battery VALUES ('09e0d7e0d4164191834e9f9185b2406c', 0, '0b9520cf81f94ac680fccee09bd33a32');
INSERT INTO public.switch_battery VALUES ('c879784aa1a94519b32334a7730f3a10', 0, '4bdc42476c684c4bab44a207434ff085');
INSERT INTO public.switch_battery VALUES ('65f2217cd9c24538a2ad82f0b382afb1', 0, '27864fae87014795bf98561bb47e1e01');
INSERT INTO public.switch_battery VALUES ('bce949d68a54441eb4c844b4de57a15b', 0, '320d2d4346bd476a871bacf74355e187');
INSERT INTO public.switch_battery VALUES ('f1f6c2ef718e4405bd9d9371898b9420', 0, '1d414a85711e4e18b58936df9efa7159');
INSERT INTO public.switch_battery VALUES ('9bf16969578d4676a2acba6ae532948d', 0, 'f8cc6235381e4d0f803dcc011df801dc');
INSERT INTO public.switch_battery VALUES ('89fbea75b01b4583a918148708465d0f', 0, '77f9a0f40de04bacb9c2793b59e62ac5');
INSERT INTO public.switch_battery VALUES ('eecf0d0fe9a448ddb387844a81792650', 0, 'f19e3874488d4734a446f9e06ac725ab');
INSERT INTO public.switch_battery VALUES ('8ed2c0f66fc44a4788133460dd481304', 0, '7660eabae0dc43469209edd49d0e4fc8');
INSERT INTO public.switch_battery VALUES ('c24a820006c3455e9f06558b8bfbcbb9', 0, '1b8a6f3a5aff4b13bd6711d113c2361f');
INSERT INTO public.switch_battery VALUES ('7b7b46988bcf450bac61142badde4d44', 0, '8ed7d0d818024aa6bbccc1f696696133');
INSERT INTO public.switch_battery VALUES ('f983a23b660549dcb08239c0fe396b74', 0, 'af15824ea443421a9ac74c86d17ebf42');
INSERT INTO public.switch_battery VALUES ('0463991654034815b2b2f32d2bcfa24b', 0, '43a2bdcc026e422ba1b78f2df3948358');
INSERT INTO public.switch_battery VALUES ('425581bd896243bcab1bcaf9edb4d878', 0, '19ecdbfce63d43859d1972631c071c23');
INSERT INTO public.switch_battery VALUES ('f74b330c4be343469d76126224279421', 0, 'f3845b59995e4b97943cfe52a1c2a24f');
INSERT INTO public.switch_battery VALUES ('a816df0c90f843118156cf7abe2fcab0', 0, '2285dd153c0f4828a0d805f295647ff3');
INSERT INTO public.switch_battery VALUES ('c2023548331d43b8a306f105ea38207d', 0, '7fdcde6971434e289440e9884da6435c');
INSERT INTO public.switch_battery VALUES ('e9b5ad56fa2e4c0cbb7cbbc70c2f4536', 0, '8195dd1f69574bbfaa4718a1411deda4');
INSERT INTO public.switch_battery VALUES ('a39df9591be645dd864902c53e63c1f7', 0, '8676d8df905f4d84a583c1a3f7e04027');
INSERT INTO public.switch_battery VALUES ('be399111997149028ee28b770e950c96', 0, '91145b7668a5490fa91dff37a8d7b82f');
INSERT INTO public.switch_battery VALUES ('cdbd174f4bec45628a7e48dbd9bb17d9', 0, '057b1e42add54ee9bb04b92d4391419e');
INSERT INTO public.switch_battery VALUES ('157db929ceef4470b277cbf7530aba17', 0, '7deec31ebaeb484c8e359c743faa2676');
INSERT INTO public.switch_battery VALUES ('dc2b6ae7416e49409b50afabc64723fb', 0, '51b8c471d71d4e78a9a09b0335d339cb');
INSERT INTO public.switch_battery VALUES ('5594f5efaf3d4f6aa5675d4f4de88c27', 0, 'db97592d9b1c4fd6a795b384a7648ae3');
INSERT INTO public.switch_battery VALUES ('37313b2c55b34e57ab9658e05b388d91', 0, '3db3d86dc6354f0aaf69ca0b3e6895dd');
INSERT INTO public.switch_battery VALUES ('4582a12c270a454eb52abba2f297a1e0', 0, '34a6935707a84183a6317e3262de52b2');
INSERT INTO public.switch_battery VALUES ('5b354190a1d646bebfd111f1e4c86d8b', 0, '3ffa2d7f9c7345f7bc2a63cfcac7c67b');
INSERT INTO public.switch_battery VALUES ('5693f380ddaa4aff8f9b6d58672644dc', 0, '8edd284c820c4481ab32deeeb1d7493e');
INSERT INTO public.switch_battery VALUES ('b9399bae05b444f89568e3b940f4f2f6', 0, 'd2ebc5e91d0c49a69a7c7d76c4ea7554');
INSERT INTO public.switch_battery VALUES ('5dfdd0b1b5bf4a88a86acb04db8dbece', 0, '243297209e0347459788fa1f5fc81b9e');
INSERT INTO public.switch_battery VALUES ('a1e6d922b00d4ea791b22fb1120f182b', 0, '82f20269d3874d0899c7fc326a05440c');
INSERT INTO public.switch_battery VALUES ('89309d7cf5424345aad606cfce725640', 0, '14611e868a824facbcf764a54fc7fe1a');
INSERT INTO public.switch_battery VALUES ('d7013a6cd2084a8cbe06738bc5c3a82e', 0, 'd9525d85a0ba467cb8c7bac2a4ba799c');
INSERT INTO public.switch_battery VALUES ('d843ff4451a946da9e101d2ce8fa24cf', 0, 'b4c5b357835f4c719a858fbcc70bb550');
INSERT INTO public.switch_battery VALUES ('28c94633d5c1487c8ddf29354d8a21c6', 0, 'dc84c0b037014656b3520b13c81fb497');
INSERT INTO public.switch_battery VALUES ('7f86c6f2d2cb4ae7971bdb5ddbb2e173', 0, 'fef5bdce055f4fadb32b39f7a1f39dca');
INSERT INTO public.switch_battery VALUES ('f57dd767300447db86f5886c2afeb77c', 0, 'e26db44d89ed46b0bc253cf743e390e6');
INSERT INTO public.switch_battery VALUES ('d1e3b165586040a499a398020277ca8b', 0, '047d2f76e5584eca8163b97069e8f165');
INSERT INTO public.switch_battery VALUES ('c645bff36d0d4d9c81f31da211960374', 0, '37b3e7bc238c48ffb819f73f70dfe65d');
INSERT INTO public.switch_battery VALUES ('08fd181647f64f7b9e2e2592fe0427ae', 0, '5075e81d05ee4a2d85ca850ee526f125');
INSERT INTO public.switch_battery VALUES ('4371d57c5e1c4cc78adfbaa0b5b9546d', 0, 'ecdd926a0eb94c62a3752a221443e04f');
INSERT INTO public.switch_battery VALUES ('0b1a7f70d1514e6d89bb625c999ddbc1', 0, 'a0c6180aaaf9489c93ce0403eb2d3e1f');
INSERT INTO public.switch_battery VALUES ('39f6aaf86b74453bb8ac473e8b31d634', 0, 'b680b676680b4ec6910df9e6cbf49def');
INSERT INTO public.switch_battery VALUES ('380e9cda5d0b463b8c50c343b497348c', 0, '3005814f2b1745758711e61e69d4ad33');
INSERT INTO public.switch_battery VALUES ('b51ced76d1ce4bdb8c63ec28e11ca613', 0, 'a9804c04a06b4c5ba93f9002bf80bb46');
INSERT INTO public.switch_battery VALUES ('8fbc5d34d1664424ac7be8e08d60de27', 0, '0265a5fafb61453891f4757062f8261a');
INSERT INTO public.switch_battery VALUES ('da95275dcd8d4b19a4de127b8237f745', 0, '017274c411b5490cb4c6868c9dbf782e');
INSERT INTO public.switch_battery VALUES ('20cd18bbf5cb42bdbcb0342ec472805f', 0, '2fb744fba9ad4763b54179c4fa762dd6');
INSERT INTO public.switch_battery VALUES ('3b73e143a62a472796b7a0f1024d5cb4', 0, 'be8822f91d564d2e9c227e8c993d708e');
INSERT INTO public.switch_battery VALUES ('b954db7be4664d8ba8cf60e547af467f', 0, '48c3a053b1b74191ac51eb185e67a571');
INSERT INTO public.switch_battery VALUES ('2508f9ab4e234604a31efabf63ff9f38', 0, 'b0102dde34d8487fb5fd80c9fdad3736');
INSERT INTO public.switch_battery VALUES ('e3ded633ba2e4b0685152be5b74e2328', 0, '13159b8edeee4d2686895a4714b58ae4');
INSERT INTO public.switch_battery VALUES ('fdc2b58e452f4f39b64e524b85e703fe', 0, '914cf119b7a14408be623c09b9008163');
INSERT INTO public.switch_battery VALUES ('b1e62146530d4979b7b4b546ee451d32', 0, 'abca9c6102bb4d57b093cf1f807a120e');
INSERT INTO public.switch_battery VALUES ('30ac53ac89904c0bbd69ebf25a1b2ab4', 0, '9c85a96ebc464bf2bd54342bf2cee34f');
INSERT INTO public.switch_battery VALUES ('ad91a6d4b6f3463aa07f0cbc7fa66ae6', 0, '14b30aa0ca3b4f2a829e866ace144578');
INSERT INTO public.switch_battery VALUES ('44a5108a3d15464fb572abfa0ceacd8d', 0, '0ced1e526a604084a2beb49b217d6792');
INSERT INTO public.switch_battery VALUES ('2711c3983eff4c5795aacf829859b25a', 0, 'bb4b701ea1094c7eb1b936269bf4dc15');
INSERT INTO public.switch_battery VALUES ('c56e0b5b6c5847e59292ab9b389f2882', 0, 'a2d5190882b44a8f941bd8227be83c1b');
INSERT INTO public.switch_battery VALUES ('fe75052016914183a43d52317dbc36a6', 0, '78649e5228934026bb24f8cee209d3b4');
INSERT INTO public.switch_battery VALUES ('a10dcea7502a4c38bbdba1e71932a425', 0, '8b127bf60fe94056b78bf8ebad0ad2b9');
INSERT INTO public.switch_battery VALUES ('5a0d0133d20a40c1bc5ea52f2750e61d', 0, 'a3b91dee301f49b78986c4f14f139a71');
INSERT INTO public.switch_battery VALUES ('51b8cb46f46a4a46bdd70e226059873c', 0, '713b289575144d34b8c29fff8e5dcc53');
INSERT INTO public.switch_battery VALUES ('36cc0c054830477b9a59a2562e83abd3', 0, 'f2bbca790da54cb5b0864dbdc7c9a985');
INSERT INTO public.switch_battery VALUES ('bac890039ffb4474827002ed2f8bba81', 0, '92a589bdce5a4e1fb8730078bfe19b77');
INSERT INTO public.switch_battery VALUES ('66e182aaf0c64761ae54e075e077f266', 0, 'de43838ef9854042a4092e4a6e617a74');
INSERT INTO public.switch_battery VALUES ('7c83f1e25222400084c1f01db2a3bc2d', 0, 'a5f3d93e95a34669a4ed8d20e4de858f');
INSERT INTO public.switch_battery VALUES ('54ab4284e8534a1184c7bcfaa5367285', 0, 'ad57eef7385945588fc99bdbb32e457e');
INSERT INTO public.switch_battery VALUES ('24982d55cc05440183221aeb60391059', 0, 'f74bec56f5e6423fa018493bd05d87ee');
INSERT INTO public.switch_battery VALUES ('b8b79815236e435098a395af92bcddfe', 0, '9ebbaae2254e4c3abf406435f5c630db');
INSERT INTO public.switch_battery VALUES ('9a8189247bf94c2496483bd7adbed00a', 0, '90c6394744144007aad5b35b5e0d7d27');
INSERT INTO public.switch_battery VALUES ('5561d15ba09243bbbf25176317e710a4', 0, 'cb7db2b7d3e14c1d807f13859e498b22');
INSERT INTO public.switch_battery VALUES ('c8a1d00b9a5f49b1a341fdae04a07f7d', 0, '6b0b53bee693468caacad27c2e7724c4');
INSERT INTO public.switch_battery VALUES ('203359ac07fe4150bf06b3e0bcd645f7', 0, NULL);
INSERT INTO public.switch_battery VALUES ('a985d4c618ab462781ba4c4aeb713f3c', 0, NULL);
INSERT INTO public.switch_battery VALUES ('de7f2f0d7adf40a1b0c8c81221c5a7fc', 0, NULL);
INSERT INTO public.switch_battery VALUES ('a5c8c1e0d0c64b3fa483ea73069316fb', 0, NULL);
INSERT INTO public.switch_battery VALUES ('45492040777847a890a549b5aaee5147', 0, 'c73d9b3269b74418bf9a2b9685e35ee7');
INSERT INTO public.switch_battery VALUES ('8194f347f1fa448ab6c2b3b85b2adbc2', 0, '09868c65d5434bc6a98cf8edbb8cd79a');
INSERT INTO public.switch_battery VALUES ('bbf341e166e445518cfbd91c8e25c6bd', 0, '260aad4a991f482ea8a4a3e87a8dd798');
INSERT INTO public.switch_battery VALUES ('a192294ecd42473b89eb5ba219404289', 0, '73a1f6ddfb5b4fb98eedeefa13e0c119');
INSERT INTO public.switch_battery VALUES ('f1bbc074b0be4a6ebbb95b788cf86a11', 0, 'c061ac97148b499eb3aa11a556c828b5');
INSERT INTO public.switch_battery VALUES ('64a1c46871484a65be461f6eb7d646c8', 0, '8d2d604def4046dea8803c2ed94a60dc');
INSERT INTO public.switch_battery VALUES ('0bee9f51709f442a982bf49e4d7d02f7', 0, 'a6d697bdf9904964bfa0bc52468432c5');
INSERT INTO public.switch_battery VALUES ('e9bec0162ca84e318fa755236a0b6b96', 0, '9932394ac20d413bb1c202c3182d21b2');
INSERT INTO public.switch_battery VALUES ('aa647dbee7914f90a104dab2d4c80c92', 0, '6654eef2a53844daae5f34366d8fed41');
INSERT INTO public.switch_battery VALUES ('b036bc966dc04b92a9a1c6306b0b3d27', 0, 'd3ff641aeb224d3da0bb8d50d44bf75f');
INSERT INTO public.switch_battery VALUES ('3243031cd0e64053ba6ff4051e4d6432', 0, '065682c4c4cf42d0b1462ac30bdca53c');
INSERT INTO public.switch_battery VALUES ('bc4b56be0bca49478385aed3f6aa85ca', 0, '27c11eff407a4071a16746aa00ae6213');
INSERT INTO public.switch_battery VALUES ('822b59836be34a5da29e8b22fb741409', 0, 'e87bca4da21642a88137024aed67eb3c');
INSERT INTO public.switch_battery VALUES ('f86cdecdd1614d13ae70e66e45c4bfff', 0, '9a42e392625e4593a410462288dfa7e0');
INSERT INTO public.switch_battery VALUES ('0aa10750b0544392a09e126a8d047b32', 0, '1eaf00fd5d8042d8b876e0f541eb5090');
INSERT INTO public.switch_battery VALUES ('a6ec0d62798a4b10b9502813bdb870a9', 0, 'e95971089e6a403f9005770d972ee5f9');
INSERT INTO public.switch_battery VALUES ('d6ba2b05a75f4dac984b000784513e2e', 0, 'b591a30aefba422282e08fd2bc01e7ff');
INSERT INTO public.switch_battery VALUES ('a7939f02a6204ef3bce08609ee251218', 0, '12699ff5f91d486a8f48e406ed996a73');
INSERT INTO public.switch_battery VALUES ('0bf46868d7b049ca8b2eb749e930227e', 0, '15793e1fa4b24205be75f87c6734ef4e');
INSERT INTO public.switch_battery VALUES ('d43300502a16475fbefa3616c5214241', 0, 'dbabfdf05b7648e8b27a1e884e1590b0');
INSERT INTO public.switch_battery VALUES ('28961fb39b3a4c96af7741aaa1e48478', 0, '12b89f0b887b4632a5e734e03750629d');
INSERT INTO public.switch_battery VALUES ('464d21e51d254ecfa775d6f508824d6d', 0, '4c8b205ff5964c41bc5de100f0e7d88b');
INSERT INTO public.switch_battery VALUES ('f89323726ffb41c989c8acd2fc308bba', 0, 'bbed79e3f57a4fd1be49de28632b0ea8');
INSERT INTO public.switch_battery VALUES ('1ddaf85e94914fb3b06ec2121c11d1e7', 0, '24d1860522934825b2358c68b76d7816');
INSERT INTO public.switch_battery VALUES ('b2094d1ab02b4adf9cc7671834ffb66d', 0, '2c29bc8f81a2478690db46867a0bdc8f');
INSERT INTO public.switch_battery VALUES ('3f0d3a42ff7e467f9e1f5db2dcf1e8c7', 0, '15d969f76eaf495a975d24c8ad8492d6');
INSERT INTO public.switch_battery VALUES ('f9ea9e32106c4ce4b349a3fd2f404071', 0, 'ef8042eb75a84f879f0e3d0cbe838a23');
INSERT INTO public.switch_battery VALUES ('178feb47ab9a49f2a737d1e6ce7a3814', 0, '8372b56be7a343b9a3d3cbb3f1e9f5eb');
INSERT INTO public.switch_battery VALUES ('72a4ffb7123d4f8899fb73547db160e4', 0, '92233ff774bd4f56b07056b453a04657');
INSERT INTO public.switch_battery VALUES ('aedf05b69d8d47baa8b6dbcf70d84c99', 0, '8b7952ac45414018a5c25ce4f72a92a3');
INSERT INTO public.switch_battery VALUES ('519c25aaee634a4ba3222d31c5e8cebd', 0, '581d386558eb4d94b20ece2d109bc9ec');
INSERT INTO public.switch_battery VALUES ('822af91af9e940f0806226bba46ddf3e', 0, 'd4e7da955b3a4eca9d89947c71743df6');
INSERT INTO public.switch_battery VALUES ('3018f54f44474c95aac7a1d483725c96', 0, '64bb60a0bef2466ba34e95c766674d42');
INSERT INTO public.switch_battery VALUES ('bc382dd94d164497bc9de25e2c2be281', 0, '45345e9bee544a80949581bccea9f85b');
INSERT INTO public.switch_battery VALUES ('92b0178559964feaa7c86dfb784825bd', 0, '2d540403d42e45b3ba440d23ed16a4e9');
INSERT INTO public.switch_battery VALUES ('89e56cbd947d45688d8e8382b8f37e73', 0, 'bba30a111bbd4d5db42e22ce778e8470');
INSERT INTO public.switch_battery VALUES ('035476a09423456680bf32b910c37f43', 0, '9d717ba5fe064c53a5259feed2f9eef7');
INSERT INTO public.switch_battery VALUES ('cce6ba08185940698e4ee154e8e5b27a', 0, '0c565f681762467085316c35b131c8fb');
INSERT INTO public.switch_battery VALUES ('47bd3edef1a74eaab35ba71928136e0c', 0, '710607729fb84a54a126fc14ec3293da');
INSERT INTO public.switch_battery VALUES ('49db68e4a3cf40f181a5aa5cc2c112e0', 0, '33cac11d30a24e87aafee0ce7c16704b');
INSERT INTO public.switch_battery VALUES ('5b5825a29adc4f70b0f681b7756eb8f9', 0, 'ad2207aa93b747a5b288cec7c9067d76');
INSERT INTO public.switch_battery VALUES ('3e2b62bfb19f49e3a07f959c4f05cf77', 0, '442647b3ce24452cbec2f46404b475f7');
INSERT INTO public.switch_battery VALUES ('48b415ded17c40738d2da9fc9d81e255', 0, '3179a3a130ac42dd80c7d2b06d0cfd99');
INSERT INTO public.switch_battery VALUES ('02a7d19a79004aab8c7af725feaea9ee', 0, '7202e9b226074b73961b5824a42a3baf');
INSERT INTO public.switch_battery VALUES ('480800c008a44000aa2e54cf211a4b91', 0, '56bbea972cc047bfa83330aabe36c67b');
INSERT INTO public.switch_battery VALUES ('8f40eea28e8544b8b6a7bee80c651372', 0, '370a1c1715004ea58bb3a6bdef0c7a50');
INSERT INTO public.switch_battery VALUES ('65d2f514bda445d28578ebbaa32ae641', 0, 'e15d09dcb96b42f08215a7421a29faa6');
INSERT INTO public.switch_battery VALUES ('c92145b778fe486aa2df2f55d5df05cd', 0, '426ba58d89af48b182a59c11d40346f2');
INSERT INTO public.switch_battery VALUES ('0f868ed258e041cea7f9c59149837262', 0, 'a38ad3a3b33e42a595c20a5d6b6e5b88');
INSERT INTO public.switch_battery VALUES ('5f68e825aec747f2b65ffe579bf21bd3', 0, '6ab1f1809db2466dbbd99b717deb80d9');
INSERT INTO public.switch_battery VALUES ('dff339f72afb489a978e254aeb89bd78', 0, '6e86c4b7ba71402ea3ae3ced7bd916e5');
INSERT INTO public.switch_battery VALUES ('f9b00bff693b4fc29016ff8408fa97f6', 0, '85119502f6164e0bbab143140b1f00ca');
INSERT INTO public.switch_battery VALUES ('1cbdb96ef14d4c7ca09c291bd0f87bf9', 0, 'b00e1bce0f734d79bf0fa8252ff02167');
INSERT INTO public.switch_battery VALUES ('786c93134ea84350bb0b6a1d53709e3c', 0, '3bbdf302eea54f76b325eb15bc5ba364');
INSERT INTO public.switch_battery VALUES ('dc2d3b61060b4e9ea264b398ca547622', 0, '152c2d04f4884c5fab180068f713856d');
INSERT INTO public.switch_battery VALUES ('adc1335b2d7448029cc153620a8333f6', 0, '55b887faf0534279a8e79286ad93e429');
INSERT INTO public.switch_battery VALUES ('2b7f91706b7842a4bff8ecb3c8009a1b', 0, '98f930bcad604f6790b833fe486e9d47');
INSERT INTO public.switch_battery VALUES ('661b920a28f24ab19a2d6f7c381fc303', 0, '47d46ea8e6a5460cbbc47481f68f05aa');
INSERT INTO public.switch_battery VALUES ('2471af82d213411f9d72a02b5cd7034d', 0, 'cfc181ccf6f346bfac6a0edf7dd15b0e');
INSERT INTO public.switch_battery VALUES ('f921c918b7ed4d1792cb93e243001510', 0, '08f59e2d6b484cd58d82a5dd838c435a');
INSERT INTO public.switch_battery VALUES ('d67b3634a3694d488e564398599de5a0', 0, 'c46ba7286604496fb9e2343af4003b63');
INSERT INTO public.switch_battery VALUES ('d7bc7263aae742f08cad3f71ff0a5d71', 0, '34525724f6ec4abca73c05b42ca41c78');
INSERT INTO public.switch_battery VALUES ('4602174fd9404105946a75c5c9163849', 0, 'ed61c8fd93f043f2b26367abaa7c5b66');
INSERT INTO public.switch_battery VALUES ('95d5570256ea425f9c4cc52766ff83d5', 0, '7f038e1528c74f838fad8a4f1b6d4ac1');
INSERT INTO public.switch_battery VALUES ('75ffa01f1904446e86e1c338d8b91a45', 0, 'cb0b416e2cd34467a19f0a4ba44f4276');
INSERT INTO public.switch_battery VALUES ('77f4f666a72348fcb5fdfd67fe09d982', 0, 'a9053db440af463eba39210237cef283');
INSERT INTO public.switch_battery VALUES ('91a1276e27234196bacc6871497d9d2b', 0, 'cbac9624fec941998c5a21252aafed21');
INSERT INTO public.switch_battery VALUES ('a2afbd2a67394029965b6838475026a8', 0, '88e5d80bf21a4b888590e03f22035520');
INSERT INTO public.switch_battery VALUES ('bc2a0eb3d0234805a2f99dc7e7fe2428', 0, 'bbbeb7321ca749c983d559578877052a');
INSERT INTO public.switch_battery VALUES ('df1687b0ba534bcfbb7b856402d36d44', 0, 'e3e29b3ba686414895840d2088450a74');
INSERT INTO public.switch_battery VALUES ('7ddf4e15c82b4091953bab8878b13fde', 0, 'be823233f744477baa3c0434d82eeaa9');
INSERT INTO public.switch_battery VALUES ('e7bc5141900c4473a8ec8fcc628dfcc8', 0, '56fd17530c6e4cc5871d6801bf068931');
INSERT INTO public.switch_battery VALUES ('d5639fedad2440d983caa2bda719d396', 0, 'b47edfb5eaa84bc8bc8550d2dbebb506');
INSERT INTO public.switch_battery VALUES ('ade5541d66f344f1b8b63401fa6d99cf', 0, '6e0903c64014463b8098f79c5f3001b6');
INSERT INTO public.switch_battery VALUES ('c269384a03b844ef8e74401cd1cc5418', 0, 'b3d9dcb1e2f74ea49c2e76ef47055398');
INSERT INTO public.switch_battery VALUES ('61e7c50628fb40baa4c5a781cb70f24c', 0, '474e54c744b34b188bba46a04d58276d');
INSERT INTO public.switch_battery VALUES ('2a39d39926b24892a69d1da1457d9c8b', 0, '3a26bd18a57e46ddbbd15ae676c2ee11');
INSERT INTO public.switch_battery VALUES ('5f2ea18a7f704c7ea417265e77e35ead', 0, NULL);
INSERT INTO public.switch_battery VALUES ('f13c264edc1d4ea580c9844cad12bbdd', 0, NULL);
INSERT INTO public.switch_battery VALUES ('23669db3c06841d18865aad1983914e0', 0, NULL);
INSERT INTO public.switch_battery VALUES ('2080707190e6480aa5a80834d337bbc3', 0, '5b14102fa0754c4a983689d1f495ec7e');
INSERT INTO public.switch_battery VALUES ('5d46903b394040ecbc9eed5233b92cb9', 0, '5d4dfdfb35a44fa18f747dcc75c93f26');
INSERT INTO public.switch_battery VALUES ('fd60b8c72f2e4ad9be1099f3642511a0', 0, '531d0d54c15f4ac8a9018da4ceae3b05');
INSERT INTO public.switch_battery VALUES ('33cd62937c7c4a8ab6d17178efba4d05', 0, '5aff6b7ff13d4078af1a407b162375a7');
INSERT INTO public.switch_battery VALUES ('04608966bc4b417e97214803e5802f40', 0, '664797a2a48049cc8062d2f4950e3bc8');
INSERT INTO public.switch_battery VALUES ('67dc988d72ea4684bfaaec4f523da941', 0, '5601df2fcc7543a68c29ea3b0f09a916');
INSERT INTO public.switch_battery VALUES ('86ae6f96e7764f0282fe3b0079e21cd3', 0, 'f51120faf8994f3eadf440fb0ece937e');
INSERT INTO public.switch_battery VALUES ('36e89a17ee9148d9901bd651edfafcb6', 0, 'd10cc05e713d48c5a6d6d1ad0ea65058');
INSERT INTO public.switch_battery VALUES ('7f2a2af605a24aae916cf976b4212935', 0, 'd92ca9d08c3a41cfbd4c120300d75a71');
INSERT INTO public.switch_battery VALUES ('aa489184298f4eadaa9d67cd1c78bd33', 0, '9187436b73a04c0e97c7da21548f9740');
INSERT INTO public.switch_battery VALUES ('fb2b9c3f71334a45b44c09aac5ea99bd', 0, 'b7f9660585434ee5811267e51fecc2db');
INSERT INTO public.switch_battery VALUES ('b9b0893a370f4d179073b4849f166d34', 0, '0c1739d9fec54af79b48b98aa4e1ccc2');
INSERT INTO public.switch_battery VALUES ('945337f8825b4850bb203f047e952510', 0, '0486e3927f704b14bae53f1d01971b1f');
INSERT INTO public.switch_battery VALUES ('6125e75d2a144c95952005fd7afa53c9', 0, '0bcc516acb51425996e5eb51c0a3af3b');
INSERT INTO public.switch_battery VALUES ('f181ab6ae9524f5a9ad4d731b0fd3b0a', 0, '24712673996c4fe4bb7115a6d04972f4');
INSERT INTO public.switch_battery VALUES ('56527c95064443f3a4522a9ce44be948', 0, '17106ae6614e449b9bb32803cd921ce5');
INSERT INTO public.switch_battery VALUES ('c25012ef908c471a93b6c0452cd4c3c5', 0, 'c8688f2d0b074137a4e8c4b16a7eabbb');
INSERT INTO public.switch_battery VALUES ('3a9974628851495e81b6c934dff9e784', 0, 'ea3432b2fd314ae6b9ea637edd111fa2');
INSERT INTO public.switch_battery VALUES ('9b8cc17ca5924540bc39b660dfbfebf0', 0, '3eaa2439d8ae4a3e9a2b287c8e2057a2');
INSERT INTO public.switch_battery VALUES ('e8bcd7c0a85a4915b016addb1ae9c082', 0, '4c95af7d92314b91b747f1f6efa3e85f');
INSERT INTO public.switch_battery VALUES ('44861b9c328b454981694c0b153b1ff4', 0, '3fcebec8ce8b401c8ce93e0ba518401c');
INSERT INTO public.switch_battery VALUES ('9d3738fdcc10418088e093416a40875b', 0, 'b29bf5d75deb419ab89d8eb61ba389a4');
INSERT INTO public.switch_battery VALUES ('6eb2fba9d3fa42ad88e3f210801eaa2f', 0, 'c77f5b0ffbac408ea3fd89a166ccd8f8');
INSERT INTO public.switch_battery VALUES ('4e563dc154db4cbf82f7e423965ac45f', 0, '0ef1fdfaf52f4153bb80f8a10601018c');
INSERT INTO public.switch_battery VALUES ('ecafd5f3a72744cc8928089c392f097c', 0, '4015ca3cd7cd4234ab3812f01b04a5a3');
INSERT INTO public.switch_battery VALUES ('76f8fe55d3fc494aa009028215f450b5', 0, '81c2442d9980474899b3b3b489599111');
INSERT INTO public.switch_battery VALUES ('f5609f8e43ea410a90578768da53f3fe', 0, '2ce8394d351443dc94949dbd986fb786');
INSERT INTO public.switch_battery VALUES ('4c5a73c7be854db6924ec9c8abde9c44', 0, '9dae5a18a9f44e1e97d42bd8d0c7af13');
INSERT INTO public.switch_battery VALUES ('3492f9d0df344e2494c4934891a0f51d', 0, '1f8cf9bc62c74ef484acbdd3b1080fe4');
INSERT INTO public.switch_battery VALUES ('6547a7b4e9394fd19cb4168df946c9b2', 0, '7ffb4ec7ef1e4f05b52601faa7a8c1f9');
INSERT INTO public.switch_battery VALUES ('904bc90cc7df4f8792bf5ac15ab634b1', 0, '100798082bcc40feac2e9e089d21426b');
INSERT INTO public.switch_battery VALUES ('68109f27c3eb4cb88b4c380d97f1fa86', 0, 'c9bc395491e4499cb44dd6fb89ceb4a5');
INSERT INTO public.switch_battery VALUES ('dd041b05ed91481392a552e5b219b5ad', 0, '767ad7b75fb84828a51d2381f95c6028');
INSERT INTO public.switch_battery VALUES ('823722a0e9994b15806c32ae2c39cf40', 0, '06677f37138a452e8e3a0ffcbd4955a7');
INSERT INTO public.switch_battery VALUES ('8936f1b2d2834279bdd2a599d53d15e5', 0, '65e55a92ec494433b46bad0ec09ef855');
INSERT INTO public.switch_battery VALUES ('51ed073e88be471aa9c8c8d627ef0694', 0, 'aa8635bedaad4efd98b7c0310891c645');
INSERT INTO public.switch_battery VALUES ('e84731423a02471da9c6cfc5aa4fd6da', 0, '8ee4ca0c608948ccbc76f956f1f11976');
INSERT INTO public.switch_battery VALUES ('10b482eb3d2d412698ece6a89af6212e', 0, 'e5f25dab4f1e47e9a6d0c1bf8d8ff415');
INSERT INTO public.switch_battery VALUES ('bc3a9fe7c4b6438d9c56d3824ae882f9', 0, '0950ed67e2964b648945d2a7a46a7026');
INSERT INTO public.switch_battery VALUES ('5a3517b26d664b2f8b75b0504a5f61c9', 0, '56d3403e6cec45e2aada7d37f0c934cf');
INSERT INTO public.switch_battery VALUES ('19edf4e38a4e452fb5d2669b9620875c', 0, '4b857727ce2e432abe54322a4397eef1');
INSERT INTO public.switch_battery VALUES ('ebbbb45991184553b6ace74809894d32', 0, '6f212c7d1bb9499eb673a8eaef5ec647');
INSERT INTO public.switch_battery VALUES ('3f45f112cdf14bc88fed432695b07857', 0, '6d88e1a418a34675bfde6e402704407c');
INSERT INTO public.switch_battery VALUES ('52357c40d3b44b379b99510b93ec5c8f', 0, '26c83efe96ca4cf69f9f15be405d16ba');
INSERT INTO public.switch_battery VALUES ('cc456d2456c84512947828c84fff1fc5', 0, 'e8532530b41d490584edd419ca3693d5');
INSERT INTO public.switch_battery VALUES ('9f8873ef41624e45848685e62d38a9a9', 0, 'd9e2e5b4e632405eab2b50b0bcb18882');
INSERT INTO public.switch_battery VALUES ('34f3083b7e2743a1afdccde87304d3ac', 0, '8d33054407ef4a6ebee65b96d1aa87f5');
INSERT INTO public.switch_battery VALUES ('6129f97f8b10461d8be4c2499d131e47', 0, '1c2f9195e00d43298a052fece58801f9');
INSERT INTO public.switch_battery VALUES ('1d6bc05c2cdc42ea9f8d7e8ace02cdc0', 0, 'f9fe7f985dd54f4d8d9947e0851ae696');
INSERT INTO public.switch_battery VALUES ('dd1c6ae187b64230ae72444bdc278ae7', 0, '5c1b25fb113447ec8efbe8dd07253573');
INSERT INTO public.switch_battery VALUES ('6bfca2d04d314c15a83da483c40ea534', 0, '39641997a07043ed82d079ffa4ae4240');
INSERT INTO public.switch_battery VALUES ('1eedadf0a54b485db19d1d4e228c1310', 0, 'ebc39c86cbfd4cbbae4f0a988967f91a');
INSERT INTO public.switch_battery VALUES ('518710db0e9f4577add01f84cfb9490e', 0, '61b8e81dcfa4413b8631f1bc6114d889');
INSERT INTO public.switch_battery VALUES ('8dc1819ded8c4b52935111cc82b2ba23', 0, '13a4bc9005d342a5b66bfc6735e06c9a');
INSERT INTO public.switch_battery VALUES ('1f87e6bd03eb451c8f0c4f9f199e6eb6', 0, 'df079551dae146aa9c798e84c4142e95');
INSERT INTO public.switch_battery VALUES ('165c891a84e34b9aa38b662a93aa3ae6', 0, '4a303d39b4104838b7002520b7ff1641');
INSERT INTO public.switch_battery VALUES ('6834a37a90704559a5616f7c6773968b', 0, 'aeef9594fba744d6803eda5fd4053a89');
INSERT INTO public.switch_battery VALUES ('846c817cc7c04b46b2a24a5f61cc8c81', 0, '3e252fa48f9c44158c0c727e34597678');
INSERT INTO public.switch_battery VALUES ('bc982362c8104866be4299e38ba09dfe', 0, '78a452ab6af94331b7165911b0f96b01');
INSERT INTO public.switch_battery VALUES ('4aa464fe587e44819daa99777fe15af7', 0, 'dbf183bcd583445882a649799db8e9c4');
INSERT INTO public.switch_battery VALUES ('8a9551a29d24465f86244df519675020', 0, '1902f2f5890a4c00a1d83599af9205af');
INSERT INTO public.switch_battery VALUES ('e8b4c7d9ed894a14a3d559e45d22a6a9', 0, '6d1e71050895429faba1608c9bb93263');
INSERT INTO public.switch_battery VALUES ('49639d0a46244454977773b3467d5dff', 0, '29e0219450ee4f958f846bd69942b4e6');
INSERT INTO public.switch_battery VALUES ('8f679a8e03a44df7a6d07b6d8fb1bcc1', 0, 'bb2807217d8246b7b1c0c24111e24684');
INSERT INTO public.switch_battery VALUES ('7788d229d429460e9fcda095a374ce1f', 0, 'd939d31daa8846e398d1881f7c56377c');
INSERT INTO public.switch_battery VALUES ('606d331d2e0042898aa2e8d128e84671', 0, '504d337273dd4f6a9b7c39e638c81f34');
INSERT INTO public.switch_battery VALUES ('abf2179387c1402b8ec76c38712e5fa4', 0, 'b6b8eb3d7c31463aa0919681ecfed1c6');
INSERT INTO public.switch_battery VALUES ('5bec48baf36f4da3be7ddedd6b1153cc', 0, 'b219c0b455754a8a93b9af274c7f28c8');
INSERT INTO public.switch_battery VALUES ('4d79a1ad687d44d88be9b96f1e5ad3a4', 0, '3d9613dbeee54c269d5e9dca1c6d3a3c');
INSERT INTO public.switch_battery VALUES ('d194969de3394bc6bfc826a4056d7773', 0, 'df64d703531547fda0eaba9d138403e9');
INSERT INTO public.switch_battery VALUES ('de0d197d310c4fcfb606f0a1a3c0064d', 0, '9733e29ef57049a2becd04892b6ded3e');
INSERT INTO public.switch_battery VALUES ('0c0d06ac452142fcb12bcc4b39c09bfe', 0, 'ba10d8e8bc86442c86230e1e5d0f5f49');
INSERT INTO public.switch_battery VALUES ('90867882dd1e48a283f8a58a139b7f3f', 0, 'e8af256bc4154ec8ac9ed67224dcf297');
INSERT INTO public.switch_battery VALUES ('53286ec3ae5747bcb984acf27c3cb403', 0, 'd468e06b52c34ad899f68bf414704b4b');
INSERT INTO public.switch_battery VALUES ('2f45789e4ecd4098b956aa8eb7e34b40', 0, '086ef526676a4f609f2cdf848ae3759a');
INSERT INTO public.switch_battery VALUES ('acab9f2df25c46a882b1e6006430da45', 0, NULL);
INSERT INTO public.switch_battery VALUES ('b9aeed76d23a47b594fb1a5f274ed84e', 0, NULL);
INSERT INTO public.switch_battery VALUES ('35588c2b53724af094eda06440dee054', 0, NULL);
INSERT INTO public.switch_battery VALUES ('89551b5c520145e1a9c81e16625dca1d', 0, NULL);
INSERT INTO public.switch_battery VALUES ('500748b58d4345febb56b689607ca96b', 0, NULL);
INSERT INTO public.switch_battery VALUES ('9dc87abcb1f34b9aa2f9332f076701dd', 0, NULL);
INSERT INTO public.switch_battery VALUES ('a845cfa9e5324733a856a9d24ab4dc06', 0, '9da7511de3014ac69a450c0e07361aa6');
INSERT INTO public.switch_battery VALUES ('bceca1de47274e9da3ce611a14a06753', 0, '50609fcdba0c43479ac3dfa54a431848');
INSERT INTO public.switch_battery VALUES ('b56dcbb4c522411aac5e536e0a3fb550', 0, '13f1b0463d1a40c2aa28cda7f1b12e5a');
INSERT INTO public.switch_battery VALUES ('a726bb48adf449dd8694f74b2037105e', 0, '8b6a4f167bf54570894d1e538300e200');
INSERT INTO public.switch_battery VALUES ('36df3b5aba7b4bdfa0a9bcca04b33bbf', 0, 'a15b648ceeb04b54b6ca9166ada561fd');
INSERT INTO public.switch_battery VALUES ('9fd24fb768554e928ad8545fbcdb8bc8', 0, '8113c431bf824072bae8f906729ad297');
INSERT INTO public.switch_battery VALUES ('9fee174a5c714e16a75565128601b273', 0, 'b6b15bd3faa74225a5957e601234033d');
INSERT INTO public.switch_battery VALUES ('794cac5e038a4bdba66f3147837a8f99', 0, '765a8ca111014a4c8663a9e6113719bf');
INSERT INTO public.switch_battery VALUES ('bd487c1589824f00a4caa8d929acd557', 0, '2371505fe8b84fb6abd0182bf498a265');
INSERT INTO public.switch_battery VALUES ('cb1be99fdc544f4cbaa666207c75848c', 0, 'cf7cd63ca0974a8694debc26b103f3eb');
INSERT INTO public.switch_battery VALUES ('5f4276c7e3eb4938aca6f94a1da16e94', 0, 'c58bd3b4f29346e494ac22044d64576b');
INSERT INTO public.switch_battery VALUES ('6ce1403c674543319b817d3fd686404d', 0, '9b28a2182027419ab3a688c7ab626f59');
INSERT INTO public.switch_battery VALUES ('c4b5fdeda9204c328f36b13948e7ac30', 0, 'ac90db1212834a1c8650c6d90207604f');
INSERT INTO public.switch_battery VALUES ('c60520ad4d68411ea2a6f721e1fa78c4', 0, 'efeee57946dc4cc49abf28eaad7f81b5');
INSERT INTO public.switch_battery VALUES ('b335058c140444969d5f8f3e18a4839a', 0, '6dbbdb9a932a48fb898229b152da9ca8');
INSERT INTO public.switch_battery VALUES ('6258d54709c74b9ea737ee44a160789e', 0, '5ad5ac6b926c47c697aac1549e7f2fe0');
INSERT INTO public.switch_battery VALUES ('5aad50b83e0e4217ae69de70fc694f57', 0, 'ccfc171096f24da98325d22ddfbf5158');
INSERT INTO public.switch_battery VALUES ('ae1ab40cbdfc465b92e39f249f10bd6a', 0, '58b9533f9ba44e01bea2b95d3d32dbee');
INSERT INTO public.switch_battery VALUES ('05d6a460b3a94f788ed98128013898a4', 0, 'b093afbb082d4cccb2f34bb1512db207');
INSERT INTO public.switch_battery VALUES ('4d04b09020f44070851bea4bf57629dd', 0, '51afbbc410184f8ab3933c600f170296');
INSERT INTO public.switch_battery VALUES ('18aa9e2db3754650bfbe6cf1f073339a', 0, 'bb97e1a9292542cfbab7abd1ad21ada9');
INSERT INTO public.switch_battery VALUES ('76e5fc764c554005b98686485ceb194a', 0, '8c72b2ed49804082a1ef145124725115');
INSERT INTO public.switch_battery VALUES ('7a9a631e16e0477aa492e7a479378f90', 0, '9502a129520544b4a2af4550be7c6fa6');
INSERT INTO public.switch_battery VALUES ('b06f6c338b6e4b4ca78c55fdfcade282', 0, '9438397e8f504f3ead467395d472bef3');
INSERT INTO public.switch_battery VALUES ('dd5ed61210c444bf9bc80718337b8111', 0, 'c22f58cf42d448aeb4d4196b3240d974');
INSERT INTO public.switch_battery VALUES ('2840decec564443096370431294afa58', 0, '040c0d6afe0d4ead88689747d59ef972');
INSERT INTO public.switch_battery VALUES ('3062794cb39043bb8fc2c1ee09198508', 0, 'f9befd19e7d6423a85a673a80c99a66d');
INSERT INTO public.switch_battery VALUES ('501784b007a848e5952b97787acd1486', 0, 'fa4331d8a91d48ca978a7729c589099a');
INSERT INTO public.switch_battery VALUES ('5ae5a1e0a5664907be1227df94c6ab4c', 0, 'eed4cc351dc8423aa64bddb460915cb3');
INSERT INTO public.switch_battery VALUES ('441dfe138dd84b91bd63c82ebcca70c7', 0, '946c1811ccb44c4fa28b5836ceb43578');
INSERT INTO public.switch_battery VALUES ('7059e7a6782a4520a5dcba8c29a4c3fc', 0, 'a13ad1ad890d4d6b85ada68378141ed5');
INSERT INTO public.switch_battery VALUES ('a3c1288de9b64f51b56a5be425c085ab', 0, '7380b3e637274a7cb4662a6c4d281100');
INSERT INTO public.switch_battery VALUES ('80b71a0ccd8b447e9e9f1337ffdc83ce', 0, '973dbd838cc04e08a7b89709884086ee');
INSERT INTO public.switch_battery VALUES ('00c0249f03d24f6092cbad9a467945ea', 0, '2e6dc6d24a024213ac7acd12945b1a42');
INSERT INTO public.switch_battery VALUES ('5c88972372e848efb492fdd95594ab3f', 0, '0d5abdf539cc4a73bb20abade315a229');
INSERT INTO public.switch_battery VALUES ('94cbc721c26b422b9337b2a256111591', 0, '398407c2878a404c989695872b15cb97');
INSERT INTO public.switch_battery VALUES ('f15916384c59424faa10ed636c83257a', 0, '11c098d02c2b43329374d53f29681fc5');
INSERT INTO public.switch_battery VALUES ('7189567a6d73402e86111aa3d3b6dbf9', 0, '6169e77d67a94029bc3e3886aae7d45d');
INSERT INTO public.switch_battery VALUES ('66164dc17bd7478aaca878cc522eb664', 0, 'fb55c824a3db48cfa381040ef86b21db');
INSERT INTO public.switch_battery VALUES ('82c8c8da77ea471fa9768f68032e487a', 0, 'e1832e9d280d4dc993de480b2a3f27ed');
INSERT INTO public.switch_battery VALUES ('7ea95ad90e234027bb47e75c5af0ce4c', 0, '1e5272ff9fdf4ee4b841b7fc37a6a0a9');
INSERT INTO public.switch_battery VALUES ('459e7f2dd2714e738ac3a3f3f230c6ad', 0, '4d885ccc84da444ea6781aa7160afc96');
INSERT INTO public.switch_battery VALUES ('b20b618fc4b5430ca80f23c326049e2f', 0, '0c70705b9b434c58b3b00bfb184cd256');
INSERT INTO public.switch_battery VALUES ('97755fbeb1504dc881284442b2f183fa', 0, 'a6eea73cc4fb47258b7a8d66aa253f9e');
INSERT INTO public.switch_battery VALUES ('9f40d0a5588245e7887cd74aa81123ae', 0, '5a1e16366b904ac2b22a44adc2f96c95');
INSERT INTO public.switch_battery VALUES ('919eec6bbd2f433e8d8a4033ac4c9ddc', 0, '9302b980ac4c4541a6a62710ff514a1b');
INSERT INTO public.switch_battery VALUES ('b16aa42323f149f2b81d75327f93fc2f', 0, '96f520f90e3d48b1b8552b11426e2a65');
INSERT INTO public.switch_battery VALUES ('4b511844702c4eb1ad061bdc8acac79f', 0, '208d1f3a42434bcea344b6619b49e6f1');
INSERT INTO public.switch_battery VALUES ('4b450b217ba743a0b957a454ab8564a9', 0, '628da41908ac4c648edc48d2e9f5a751');
INSERT INTO public.switch_battery VALUES ('1416cb85eedf473592b1912fcc62a920', 0, 'd3dd9a0f5f1249e6aaba2d4103ad8404');
INSERT INTO public.switch_battery VALUES ('69eec13f6e9d43ccbdccac9ad8487f54', 0, 'f89845bea848465cb19b00a2cfc25d5a');
INSERT INTO public.switch_battery VALUES ('1118eba84e174546a563d30284bd6620', 0, 'baa8e47938ca40ccae1ff92f5e621f2f');
INSERT INTO public.switch_battery VALUES ('e70cdbed71d54017825b74efc91e9a80', 0, '3c8ee350c54c4ad3a1e9577235ef49a5');
INSERT INTO public.switch_battery VALUES ('68803b502bf64c74964ceb8de66defce', 0, '4e8885ced7214b9db55cfdc00a82f193');
INSERT INTO public.switch_battery VALUES ('db8246269ce246708884a705ca4792cf', 0, 'b2d24ab3dbda4d29a289e6ea7cd3a3a9');
INSERT INTO public.switch_battery VALUES ('d9b61c0affbc471895a33fac1ef02163', 0, '5918cc6a54b54955a12967ae70a9e9c4');
INSERT INTO public.switch_battery VALUES ('2255716f84904b6cb5f1214b48ace211', 0, '1291e09fa5e14477b6b835b732ff7468');
INSERT INTO public.switch_battery VALUES ('19771505fc6a4a448263616856425ab6', 0, '890712b5ccc7450ea504430837b4c4be');
INSERT INTO public.switch_battery VALUES ('f7c58e3a984a474a91e2e6893be79c6c', 0, '27d8f072c32443fc9cb308734a7ead96');
INSERT INTO public.switch_battery VALUES ('14e0128088b244398ed46eddf57f0418', 0, '45e60076ea8b4e2f8cf03cdaa92a6afd');
INSERT INTO public.switch_battery VALUES ('06130a2f464b440faddc28777d940bf5', 0, '2be2d7be077f40999b122ddf03d3a977');
INSERT INTO public.switch_battery VALUES ('06d0d1e2e6144a929992d528618b70b3', 0, '97fe0736e2fc45e7bc7275888d2c5376');
INSERT INTO public.switch_battery VALUES ('c47c2329ad83472dbc3a16299062b4e5', 0, 'b436fd656403452ebc21bff2ee18a11c');
INSERT INTO public.switch_battery VALUES ('df92f0188518404ab34fe35ef2fd77aa', 0, 'b8b2f51f235647ec95cb6403b3ee924c');
INSERT INTO public.switch_battery VALUES ('b1ce53b372cb47728e78a2666b964699', 0, '6398f44175ad48c68b9261343f0820b5');
INSERT INTO public.switch_battery VALUES ('7333a38dddd34e2caad109ec793399e9', 0, '4f38fb2263ab4b1a99c80946b21f3892');
INSERT INTO public.switch_battery VALUES ('627369a5112944479ac76e2a61fbd0a5', 0, 'd545eaaa3a114752a30b8f809f331e3d');
INSERT INTO public.switch_battery VALUES ('1fc4f4114a00458cb43457d096e26099', 0, '2d3ecc5df0fd4a87933f04bdb6516a46');
INSERT INTO public.switch_battery VALUES ('824798e8308c49e986a4181ddb6421ab', 0, 'bed70a582cc24e0f92b0b6730794f306');
INSERT INTO public.switch_battery VALUES ('97062fb89dc64c78a91a7d631705922c', 0, '5d800e04d6484e65ad46a92d72e2344e');
INSERT INTO public.switch_battery VALUES ('5f4d45b74a5a4b2593d1ae8aa41be424', 0, '236476beaf644c54976a2342cf147155');
INSERT INTO public.switch_battery VALUES ('557b667a3df2495a89aa5c757288216c', 0, '340f2811e295422aa0bffdd858571135');
INSERT INTO public.switch_battery VALUES ('1ab0a1c0f0624f74a6d12004e4ef393f', 0, 'afab18b793ef4f1d8445b962869e9c1f');
INSERT INTO public.switch_battery VALUES ('da88d29914f24ea0a92b3d82d558c23d', 0, 'e6e5abcd3092436d9dcb85084563d0bc');
INSERT INTO public.switch_battery VALUES ('e8cc9350db104f1fbee4591bcb4c3f42', 0, NULL);
INSERT INTO public.switch_battery VALUES ('f70ece70e7574c93887c70a3e04e6b21', 0, NULL);
INSERT INTO public.switch_battery VALUES ('f2a618edb22a4f239033ee0e12194f4d', 0, NULL);
INSERT INTO public.switch_battery VALUES ('21b4502d27964b6b9523374666a38fbc', 0, '69ec63fd968846c5b682d9a37458c458');
INSERT INTO public.switch_battery VALUES ('80d838771ea04220add02dadd69df8ba', 0, '5dc76734ee16457fa6590aabe1d15675');
INSERT INTO public.switch_battery VALUES ('c76b24ed8d30430f943ae0745d50fb15', 0, '26745ebacf904797a3cbd1565d80e4ab');
INSERT INTO public.switch_battery VALUES ('a931f5b9a87a48128fab992658fc0509', 0, '0e7a734b83fd436b83d84c7b95a91399');
INSERT INTO public.switch_battery VALUES ('1de376c52855446f98f0c8240d54557d', 0, NULL);
INSERT INTO public.switch_battery VALUES ('f67bdd79860b4705a5373fce0eed58b7', 0, '9762d21e464248719148fee7bfa6a16d');
INSERT INTO public.switch_battery VALUES ('088578ed4df741b18ff54c8811dda9a1', 0, '2b0c3d720387459984f78c65189ebf87');
INSERT INTO public.switch_battery VALUES ('7f4f8fcc82f640af846025b1bd48f9a3', 0, '9db93be4e49149b580c686602bff0340');
INSERT INTO public.switch_battery VALUES ('fc0ddb85f0b745289315da94756c78d0', 0, '3a533f2efd414bb1b8b7c652ac599470');
INSERT INTO public.switch_battery VALUES ('354a6039cb9c487f81c860ea3befcf37', 0, '160b416398a442a384362e7299eff830');
INSERT INTO public.switch_battery VALUES ('d138be0e42924b54bbf390027f882f50', 0, 'fa77415bce1842dd9974eb3494556dce');
INSERT INTO public.switch_battery VALUES ('c8df82b3b2954ead868dbd6554ac65c1', 0, '151ef81e54f141c7bcb86d4986ec313e');
INSERT INTO public.switch_battery VALUES ('aeef6c3dc0c94c2dbc44524fbb6bbdd4', 0, '0e5510f3c79347888093458e5011769b');
INSERT INTO public.switch_battery VALUES ('7bb7b8e4359b4b42b2c493f7518085e0', 0, '1553ca19da0145f687489d41016691b6');
INSERT INTO public.switch_battery VALUES ('477f4c984f184e16ace15b6f321f136a', 0, '74665fbb15cc41b58ec252002fc695c4');
INSERT INTO public.switch_battery VALUES ('705bd03ff1504adf8030cc92fb176822', 0, 'bff508b4d2314aff8bd17c6f7b3cd0ea');
INSERT INTO public.switch_battery VALUES ('a2d5bf4299334fbd9385fb854fb3d70f', 0, '0474203c976949419a215c03007d418f');
INSERT INTO public.switch_battery VALUES ('c6ea9c341e12441aaeaa44205d603fc8', 0, 'f2c1ddb044cd4bdcb0df7a52059159ff');
INSERT INTO public.switch_battery VALUES ('1d945ecccf3d4ba39c36b82dd6c5dd93', 0, 'cc314d3cccbb45bea68cd0697a253f45');
INSERT INTO public.switch_battery VALUES ('fcf7ef48d60749f3a1ced2a45a953360', 0, '6053268bd91c42308da3edbdd5f47afd');
INSERT INTO public.switch_battery VALUES ('3cc03a3307ae41eeb83f73474cb4ec03', 0, 'f78ecb94a6f146faaa7d09707f6a75d4');
INSERT INTO public.switch_battery VALUES ('164dd224d970429a886243c2f3e7d520', 0, '586bc311d0e449feb7fb880b01491a35');
INSERT INTO public.switch_battery VALUES ('5de405f384594321a5292287463bcaa4', 0, '2d453470191f433c8f9bca7a588f42af');
INSERT INTO public.switch_battery VALUES ('a840d9c219fd48db806c682a269085d1', 0, '53afba8ea2ae4acd914c05203ad10e86');
INSERT INTO public.switch_battery VALUES ('dd24744c1c5f4e29aa3c3b312f6b3328', 0, '9368a3d235b7479283a72e4e345fa941');
INSERT INTO public.switch_battery VALUES ('01865e5392724017b159a00b8784f653', 0, '87e904c47c9d47ac8d44b45e42abc053');
INSERT INTO public.switch_battery VALUES ('f8bdf31808ce461bba0b76c5c3afeb76', 0, 'f94169530b27491cb88205d9b58983d3');
INSERT INTO public.switch_battery VALUES ('6a337feee8194ad0a065c5c5e1fdecd6', 0, '404144c3694444d78a2c2d0610566d5c');
INSERT INTO public.switch_battery VALUES ('5be704cad2fa4054a784f4f44cf15c37', 0, 'a21266fb9b304ec983337fc2540eb1da');
INSERT INTO public.switch_battery VALUES ('e5223a68b3354f81889fd774919e70c7', 0, 'af851de9d2ec4d24a03b0cdca50f9ca0');
INSERT INTO public.switch_battery VALUES ('57f6d169c4fe4ddd858c1cfaea81d7f9', 0, '8c2d2558402f44f99870f5f1581be493');
INSERT INTO public.switch_battery VALUES ('979cefaf66e84c258016df4b7bc6e554', 0, '8c28871153904a8f8006f48f3af932ee');
INSERT INTO public.switch_battery VALUES ('c7ef8a85c72c49c59ad73f4b19b67f1e', 0, 'a45196de321d48f8a4a6983534517614');
INSERT INTO public.switch_battery VALUES ('c76d95b507964e01ac65fe271084eae3', 0, '55ec8dd388894fb7b495130be3b7a932');
INSERT INTO public.switch_battery VALUES ('6853372b38514ddbbb4b620866381a72', 0, '0de07ea1b6054e07bead82439cf03938');
INSERT INTO public.switch_battery VALUES ('c7e6dfd339bc45dc869b7f7743cccc43', 0, 'a1dbb6c0da254f0380314c5046aa1125');
INSERT INTO public.switch_battery VALUES ('b5e18fa1a47049d9bedae754305dc2b0', 0, '1f9e7e4e1e134f87ac9dbd28a48f3824');
INSERT INTO public.switch_battery VALUES ('c925beb1032c4d4abf3866c6a8cd39dd', 0, '26dccdab31ce4aaa8b64a6de6d0e55cf');
INSERT INTO public.switch_battery VALUES ('6b84875465724463b31438b1930fb95e', 0, '78fdc4d84b084fa9aa82b166e0e33280');
INSERT INTO public.switch_battery VALUES ('d72c00fb94b8468e97d4eaa49502382c', 0, '45f093c8afd244c18e3bc93399070202');
INSERT INTO public.switch_battery VALUES ('5a7420cbec2947a89bf18bb7f745cfcd', 0, '083f1ab22a9b41a4a98401c5701baaf4');
INSERT INTO public.switch_battery VALUES ('ad3cb10bc12c47a6a9ef3d92d4570092', 0, '9c1a5761934946fa9618083a90f89847');
INSERT INTO public.switch_battery VALUES ('d9160c0d82c9479a96d589fe6b3d38cc', 0, 'ab9611a590714d2189d9c1595f395859');
INSERT INTO public.switch_battery VALUES ('1352a29c02bd4d0a91db43d6cd09c6ac', 0, 'f7b17ede1b824376981ebdf273b35c8f');
INSERT INTO public.switch_battery VALUES ('1e632cc5ea1e48ee967b4c87708b79a8', 0, 'd0c3ba6c7fc145bf9f0f1a3248883403');
INSERT INTO public.switch_battery VALUES ('65ec28b99f134579828e96c1e633d131', 0, 'eafa5122337544a9afcbd3d01a3c5e36');
INSERT INTO public.switch_battery VALUES ('4f10fab951f94ebab07a287ccc165fd0', 0, '172341eb0a68458abe930077db13b57a');
INSERT INTO public.switch_battery VALUES ('711f700d0c3541eb85410c2cd6d7a332', 0, '0c926a3a6b094b16b540c910e5a9f940');
INSERT INTO public.switch_battery VALUES ('c4a2009aba574152b1ebce0ed5c384d7', 0, 'dfd71226f9934a3b87cb0ec0b2c85089');
INSERT INTO public.switch_battery VALUES ('e26b7c58db2641e28293dca768bb0fd1', 0, 'db0ba5ffa0d04ddbbd4df333693df208');
INSERT INTO public.switch_battery VALUES ('fb29f93f87c84017ba44dd259305bc37', 0, 'cd941d78c9d74584a17559d4abb3b404');
INSERT INTO public.switch_battery VALUES ('d8c2eabd457344a9a4a51ec5aa00465d', 0, 'a69f9af11efe482d86776621af912105');
INSERT INTO public.switch_battery VALUES ('89429c4056f24b4b97dced504d44b303', 0, '336ba234a21c4272a4f07ee7360479e2');
INSERT INTO public.switch_battery VALUES ('0cb5da71ea2344abbed1cf6712edc28d', 0, '60ac21d1ad934b28bf6befc74dee4dca');
INSERT INTO public.switch_battery VALUES ('fce2764da6c749d996faa1eee4925494', 0, '3c8c0f64fa5d4ff185af424b466859e7');
INSERT INTO public.switch_battery VALUES ('9b79e8be7e524d5289146be215959d1a', 0, 'fd62195e5b3a4d9f807105b34e18cdd2');
INSERT INTO public.switch_battery VALUES ('a60772d3a559493cbbb0082e6b3321a9', 0, 'dc78925bfa6a4645bca9342801b65b80');
INSERT INTO public.switch_battery VALUES ('896cebad77d0464d88296e04966769cb', 0, '014f98b8663449088bb2f7fe9e5490c9');
INSERT INTO public.switch_battery VALUES ('b80c06645042410ba86f78c1dc612a9e', 0, 'cb95e07eb2c745bbb203fc0a0e683a06');
INSERT INTO public.switch_battery VALUES ('b62457d08d5246329051621121846729', 0, 'deca36741b6a41d4827e772cb8b0d15f');
INSERT INTO public.switch_battery VALUES ('91dd2ec72cc943f08c7ce08f24f3db26', 0, 'a01ec69117dd48ff81a31955aba5be19');
INSERT INTO public.switch_battery VALUES ('91723d06f5094162bcf39e94a6a6ef36', 0, 'be99da3a0d144aa68227b050cec8b376');
INSERT INTO public.switch_battery VALUES ('5d01061c852b4d3ba7fca2228a1239ea', 0, 'eeaac499fa084ba38bde8dc977c4f80c');
INSERT INTO public.switch_battery VALUES ('77eb6ccd042545f1b7097313346cd0d9', 0, 'ab73be0f92cd428fa07db2b6fd077422');
INSERT INTO public.switch_battery VALUES ('89caa4fd36df4d8e85e67c18c350314d', 0, '28187d3a40c749dfab67a6699e048814');
INSERT INTO public.switch_battery VALUES ('93d5b7dca0c14a36acbc014efeb37ddf', 0, 'ce949c3208dc472fa9be71e5bd347321');
INSERT INTO public.switch_battery VALUES ('4c879f08773f489bb3b68ebb4c340572', 0, 'ff130fca348f406187a10687b2b2b356');
INSERT INTO public.switch_battery VALUES ('be00755c73b54336997a3646174fbae7', 0, 'bd6af511807042459060eb8345319033');
INSERT INTO public.switch_battery VALUES ('3a1ea3b825214b4ba9c7844ad6818424', 0, '4c84ff5ddccb43eb8b15edc7913bd6a0');
INSERT INTO public.switch_battery VALUES ('ece93277d6fe447f885de548fca5f91b', 0, 'f15e9c92f63c4210833ec0fb1072b24f');
INSERT INTO public.switch_battery VALUES ('30237784c0d44699ad6b08c254eaba1c', 0, '3a8aa73371ad4e3aa2fabf560b917cd2');
INSERT INTO public.switch_battery VALUES ('a2846d65a89946cc8988c13955ec38e5', 0, '3af3a961216546229e8bf6755b4d3c87');
INSERT INTO public.switch_battery VALUES ('d0caaf3419e7411a92790bbde42e96ce', 0, 'bff16e53c2304b19a8f1adc8262ca4cd');
INSERT INTO public.switch_battery VALUES ('26160703402541be92df3e4efae2d5f4', 0, 'a910f7fec1f943ae94f5f82eb7aba549');
INSERT INTO public.switch_battery VALUES ('b157016811b14981b2bebeb2d97a539e', 0, 'a9598a53b29c442ca62df32a02d9651d');
INSERT INTO public.switch_battery VALUES ('3e0f6ebba4ed468da4364d31b4d82bbb', 0, 'd09be2cbb7ae4f11a9af5dbe500fd414');
INSERT INTO public.switch_battery VALUES ('9f13978b5e274b878d0c095478578fcb', 0, 'a888897b2a6646ba91006ab0b13b46ac');
INSERT INTO public.switch_battery VALUES ('48159197acfc405899aa46604eb1378d', 0, '9074c1b1a5c441b6aa2e5b674d1a1de2');
INSERT INTO public.switch_battery VALUES ('f7699061b3464b17afb234ed6abf99d7', 0, '1b2a47e178dc4828b30984d1cf1b37b8');
INSERT INTO public.switch_battery VALUES ('17986e772aee4894bdf48ca81d767ff6', 0, 'da27ccb7d56a47ac97feddb93c44e2c9');
INSERT INTO public.switch_battery VALUES ('d7eabde136004914af7554664614bd7f', 0, '98485e830b7345e4a8245b40a014d175');
INSERT INTO public.switch_battery VALUES ('41c2268d74574846a3d2e20377e5b487', 0, '851ee3331be64a989fceabdc405849ec');
INSERT INTO public.switch_battery VALUES ('658284ca840946fab0bc03f598ed8f21', 0, '3f43fa3097544a409fdf94380392b4f5');
INSERT INTO public.switch_battery VALUES ('411c7e7ce420481fba8825bc58a4124d', 0, '9090144374ed4146abafd978c3139288');
INSERT INTO public.switch_battery VALUES ('eefd292b6c604680b0b5772578e4b9ea', 0, '262804e7e12a4dcd9fd77a8413d95914');
INSERT INTO public.switch_battery VALUES ('b4dd817d6d094d9082a656863dc3c5ca', 0, NULL);
INSERT INTO public.switch_battery VALUES ('6aa0b0e9652f42a9afa96fd94dba1679', 0, '0bb6151022954958b87fa3fdf3aaa689');
INSERT INTO public.switch_battery VALUES ('102cba73ea0c47d59f958f7fc2533cfb', 0, 'a77084b6f09e4e85a78f084726435a24');
INSERT INTO public.switch_battery VALUES ('78b44139a0374e78ba00236fdaf667d0', 0, 'd6989bbcdffd4a1c98c1261428b046a4');
INSERT INTO public.switch_battery VALUES ('932031be604d4da88ecf1e96c99a19bc', 0, '3005074289bd4b3f933fba06826a416e');
INSERT INTO public.switch_battery VALUES ('2cf9184d73bd4c22b4987147c7bdfe6b', 0, '7863ba86c357483fb86f0b257bb86019');
INSERT INTO public.switch_battery VALUES ('300d2ab15db248a1a2954e820bb4e75c', 0, 'fede8ae6d1bc4b3fbabc381fee6f8f5c');
INSERT INTO public.switch_battery VALUES ('caed6c4399684c6a8d6bf8395dbb09f1', 0, '9b4ad789280149988f791c7ab7833a79');
INSERT INTO public.switch_battery VALUES ('246d77e4f6db4e69b0e6580f333ae0ac', 0, 'd0d1307971f646b09bd2a46e232da704');
INSERT INTO public.switch_battery VALUES ('9adf81a993d04c6894979032fae07846', 0, '3c5cb3ecdfa342978a5aba11603a4d23');
INSERT INTO public.switch_battery VALUES ('09172b4e98654bda8634ff89feeeca89', 0, '985f9095b04d42248dd8d3dc7997042b');
INSERT INTO public.switch_battery VALUES ('cbcf8fe3416f4ba2be6bddf0ca2c1ef6', 0, '652e966364834ca9bd5c19a2202a9b86');
INSERT INTO public.switch_battery VALUES ('99763aab20d94f5ab50b87c83dcccc9a', 0, '822a7467ee4f4035a07b921c95810411');
INSERT INTO public.switch_battery VALUES ('86dbd2f70cb748818454a0f3d1339241', 0, 'bf3c4d56bc2740bbaddeacc8fca60acf');
INSERT INTO public.switch_battery VALUES ('b1a12065d4f44f68a045e7f95c17e632', 0, '0e7eebd212af43e4821691ee672f8dfb');
INSERT INTO public.switch_battery VALUES ('4b17831ce6534c0eadaa378bbeb0a0dc', 0, 'adac9f38a96c4a41933e10364bd1380a');
INSERT INTO public.switch_battery VALUES ('5f87a6b102774edea8002e5e67ec953c', 0, 'acc9cd8022c845fdbeb17689437bf494');
INSERT INTO public.switch_battery VALUES ('71c393251a104cc18b30340be8e8f914', 0, '0a1d114150bf4087a38edf79373ca8b4');
INSERT INTO public.switch_battery VALUES ('c3676853d8634c20a5e5f51b9377f96c', 0, '926baa30d3844b97bdba33e31e7b42d5');
INSERT INTO public.switch_battery VALUES ('2a38e56f9a1240e8a2e340720e33d1bf', 0, '224b5462938e48a88ae1acce7e40962e');
INSERT INTO public.switch_battery VALUES ('f4e7f9ba055546acb113ec92b64c210b', 0, '428d055fb9594188a6d71002ce839b9e');
INSERT INTO public.switch_battery VALUES ('276f1fbdc4134bff81204aa4ee98e97d', 0, '93857d403ee34cdcb0c39e6b032b2779');
INSERT INTO public.switch_battery VALUES ('11021d9616674afdb2022e7d76b31dc2', 0, 'b6da3e89b5384b7c8cfd94da2b376816');
INSERT INTO public.switch_battery VALUES ('60428e557c564ecbb42bc8dc757548d8', 0, '1e90f38df3544cca919bc5edc21968ee');
INSERT INTO public.switch_battery VALUES ('4aba336d38d54a42bc4291001c31192f', 0, '3f5251f608d148a89735186ccf6bc30f');
INSERT INTO public.switch_battery VALUES ('b1b8e1d7df7b45fc87ce1d6737a31919', 0, 'd65cb73c7a294bc094e483d4de104571');
INSERT INTO public.switch_battery VALUES ('9f89d708b9d6469692e69889847d04bf', 0, 'b376bc43c51549e085758c9da22716ec');
INSERT INTO public.switch_battery VALUES ('3a377b5be27844de9cd6bae315e618d2', 0, 'fd649df136cd44a9b7555016b23ded34');
INSERT INTO public.switch_battery VALUES ('64bcce2413a846d7b0d8cd13713645ff', 0, '9c979bdff86a430687b18ecf681ccc21');
INSERT INTO public.switch_battery VALUES ('d8f38677d58e47fb84a5a29507903a7e', 0, '160cbd7bdca14529926bfd52c144d421');
INSERT INTO public.switch_battery VALUES ('fdd6dfa07eb043dfa0507f96596b9fac', 0, '3e26171f56904be9b0c7c7eb6aee1ab7');
INSERT INTO public.switch_battery VALUES ('b3e24666a4184ae3be3e01f083378a88', 0, '61572219e80a4f1785c97495cb195bef');
INSERT INTO public.switch_battery VALUES ('8f73b84bc4fa4ae3b9c1abc11e8dc450', 0, 'efd07f975b654ae28e3dfd56ffc3b417');
INSERT INTO public.switch_battery VALUES ('d0f910c1a0974721b0bb9171488fe2f7', 0, '316dbab5f2cb47939c393ba9810e20cf');
INSERT INTO public.switch_battery VALUES ('583e929971384a3fba5fd6ea35546095', 0, '641c696bc3ad469c88d6e44c08c6b935');
INSERT INTO public.switch_battery VALUES ('8e51953c5a9c45af9657833e0ff7c903', 0, '21927efc72184c1eb86746847faedd02');
INSERT INTO public.switch_battery VALUES ('9c3e566651244f3588b78ad5f6fe626a', 0, 'a01dd7a145b444299a649d91cbc30cb4');
INSERT INTO public.switch_battery VALUES ('ce9a98837a584a119ffa889661dc2587', 0, 'fcf4638208184aa0869d3abdd3224739');
INSERT INTO public.switch_battery VALUES ('503fc24b868f4ce6b7a2f2511afe455e', 0, 'aaa73178245c449f83a30193bcb38109');
INSERT INTO public.switch_battery VALUES ('35f5007787cb4922997639ba49399b42', 0, 'cc06d76666b0450181b2a4c1afe6dbe6');
INSERT INTO public.switch_battery VALUES ('1049ceb41bfa44e4826025705dba340f', 0, '461b4a33ba6b46a892895f15bb580c20');
INSERT INTO public.switch_battery VALUES ('866ce33d3c264a5a8c1001a9df1f08c8', 0, 'f217e60fa1a64aa2831c550c8d340ae2');
INSERT INTO public.switch_battery VALUES ('125652758b37427480d371e71475ddec', 0, 'f2d0da051c734e2ba457da94c2019e43');
INSERT INTO public.switch_battery VALUES ('152e9cf2815b46ca852801838e4f15c1', 0, 'edb6f7b3d55e40d7a6ba91f41fe3611d');
INSERT INTO public.switch_battery VALUES ('1eb751c134e7472483bdfa0e8ba6dcd9', 0, '653880d8c26647ab9cc5a294c1fe85bd');
INSERT INTO public.switch_battery VALUES ('a9d2b73b14154aec908f54e2787ba876', 0, 'eb4ede4062874f5d8847a8a7ccbde7de');
INSERT INTO public.switch_battery VALUES ('a4419d7f0c4b4c7fba2233a17c161ee9', 0, 'fe5aa214341341aea9bda326d6135ff7');
INSERT INTO public.switch_battery VALUES ('e7b366233b7f440ca8dba0aa97a8d66a', 0, '9c4934b3d3e247649c47cc715a34ba51');
INSERT INTO public.switch_battery VALUES ('38d82d3258014159af4376f30a28d941', 0, 'fcf792ca45d144b386de9f0e24f9382d');
INSERT INTO public.switch_battery VALUES ('fc0764b976e2421d9c718b85c25fa113', 0, '60edddb4bc0947d8ba18248240a518bf');
INSERT INTO public.switch_battery VALUES ('643e6d4dcb594991aed00725834f3faa', 0, '14019f82a7b24696a9f182df89bac056');
INSERT INTO public.switch_battery VALUES ('a1ef49907d434cc2a1b6ff7ed108267a', 0, '3ec0add093184d1289cb21564c0394a1');
INSERT INTO public.switch_battery VALUES ('02591db1475f4ba6bbead9adf5a1ede1', 0, 'e4a494dd36324b569e43538dc011337b');
INSERT INTO public.switch_battery VALUES ('ef457dc31a574e5aab3ed5a317fc7350', 0, 'c66de62714a04ce092000a0eb27dda1b');
INSERT INTO public.switch_battery VALUES ('f5334d2ba79d470499b99be7798c1eef', 0, 'c9ff5597963c402f8e856f3769448eb6');
INSERT INTO public.switch_battery VALUES ('4ac209432e484adbb2f6698bbc0dd140', 0, 'bad666f062a244ae9d329c06e2b11ad2');
INSERT INTO public.switch_battery VALUES ('c90e79baf2ed41e1932414c4a4e0a53e', 0, '2f0ccedc9b35486dbf1d10f0b905544c');
INSERT INTO public.switch_battery VALUES ('82ec76631dae4002ad2b0407c341aba8', 0, '394cb2dfb273486e8693a6374baf11a4');
INSERT INTO public.switch_battery VALUES ('94cd5f681f934f66a6dfb47794364107', 0, '91638646fcc94a758c14534da04fcb94');
INSERT INTO public.switch_battery VALUES ('535f4e96577347aaaa91e82659d1213c', 0, '0ff169dbf7e44d72ba582759cbe5d35f');
INSERT INTO public.switch_battery VALUES ('8cf145b526d246c485d80ded76a8882a', 0, '0160c015dbc24a82b96069c42ac140bd');
INSERT INTO public.switch_battery VALUES ('52021b1709b14378ae0310828cb4e455', 0, '85ba801e88434101a88c3c6d598da36f');
INSERT INTO public.switch_battery VALUES ('18b2dcbc2fa948beb5a8f49f7638ef24', 0, '3da5c260ee5f41418cf1ccbb1b2a3140');
INSERT INTO public.switch_battery VALUES ('da1052282f8c4758a2c589a5123afaf6', 0, '89a79233da944b16b39929a1b833f0c9');
INSERT INTO public.switch_battery VALUES ('4d0f2d72a3984681bf1ccc63c740dd7a', 0, 'd4411b8257c44ccc9989ca0f61ca0914');
INSERT INTO public.switch_battery VALUES ('1f96392c5edf44419ef8d11815f11507', 0, '8bf47106ff634ed19e0c95cc993fa1b8');
INSERT INTO public.switch_battery VALUES ('0d206d6a50ef4b1f9f107c11d8e53625', 0, '4c9d27fb5cc945a3b0fbee74f21d321f');
INSERT INTO public.switch_battery VALUES ('80b041c0228e4553b265385b0232f329', 0, '4e1ceb95d2ac42808c7317fc8a36e8a5');
INSERT INTO public.switch_battery VALUES ('03af27d48a934f52a7e8a76145b08600', 0, '51bf208b0e9c4ae3ae3030a7d70543c3');
INSERT INTO public.switch_battery VALUES ('f10c2a8a36b746508c1a8510881946f3', 0, '7e74dac908c2424db8da9ad73ec786f4');
INSERT INTO public.switch_battery VALUES ('e29df30c2b8941bfa35b93f58578797d', 0, 'ff09406cbd684df99a04c97324cf08a6');
INSERT INTO public.switch_battery VALUES ('5f5ac91fd4744d878263b92c982cbdec', 0, '84a6c1f6c47a4bbaa1bdca0a1f701c93');
INSERT INTO public.switch_battery VALUES ('dba5127db5f74a8bb72fe1941b8919c4', 0, '67387a9682d1410f89411cbf9ad021c9');
INSERT INTO public.switch_battery VALUES ('2107725ba2804bae9dfb889f99edbcba', 0, '5c719240453d46fdad8cda88b15c982d');
INSERT INTO public.switch_battery VALUES ('9658289f85f84677b3b4031e663c2a36', 0, 'aaccd02a7c2a406683976e113d44d618');
INSERT INTO public.switch_battery VALUES ('13e9eb9267b1436083992fd2b3b32609', 0, 'dbd3fb2caee84bd1a925838cd16c7ae7');
INSERT INTO public.switch_battery VALUES ('6049a5fe88124afeb1f0e855adb25f18', 0, 'ffda07d03b4c4313be7f0be5cbb281da');
INSERT INTO public.switch_battery VALUES ('d8c31985c405498e8d339e9d6a779254', 0, 'f6ebe6af9f77478bbb0e429ef9da88e9');
INSERT INTO public.switch_battery VALUES ('12d7b25e069747e38035129e240c0d2e', 0, 'fbab3a079e0944ce96ec6e846a5ac4b3');
INSERT INTO public.switch_battery VALUES ('5c2eb7457f9644c281ed58f29ff4f2a6', 0, NULL);
INSERT INTO public.switch_battery VALUES ('7e84d623d55f41f9baea48afe37a7b76', 0, NULL);
INSERT INTO public.switch_battery VALUES ('58c2d41670194a75a32bed762b864c28', 0, 'f50de1a59a0c43149d5a6e0b41a61dd9');
INSERT INTO public.switch_battery VALUES ('1943f27910bb4d9eab697ba2d51be17b', 0, '15579f20265f4ea78557fc114d9a2a0b');
INSERT INTO public.switch_battery VALUES ('0959f183f8fe4efb8d809fb4d245a9ca', 0, '2662ba3f79e24cd09d0025b33d1b219a');
INSERT INTO public.switch_battery VALUES ('6637ec656e43439d95341c4a2a2c0138', 0, 'caa55c1243244cf6a10b7c419515c0c8');
INSERT INTO public.switch_battery VALUES ('351941a2e7ab418fa50819f3d53c3b21', 0, 'c0b2b831d9274116b3c70aeea46b1a07');
INSERT INTO public.switch_battery VALUES ('2abda62ff26143e68dd4b4a2e867b3ac', 0, 'c611aa2da95b48dfad363e276cfda0a7');
INSERT INTO public.switch_battery VALUES ('4e644aa0625e427785ec86567892277c', 0, '8a320659ea9b4fd78994a413dbadb9c4');
INSERT INTO public.switch_battery VALUES ('b77de88b899f4307828248ff76792fd4', 0, '377a9d3ec714402c996307d85ce33482');
INSERT INTO public.switch_battery VALUES ('e9c34368ab8b4bf7b27ff56b5fb46076', 0, 'b2fb2de419524b7694378643ad3618e3');
INSERT INTO public.switch_battery VALUES ('95d196709e2a47a0ba97ffab6a2be36d', 0, 'cc9f93f6330f44729b07153d7d23d593');
INSERT INTO public.switch_battery VALUES ('4ba85049e636496db4d8196e740de599', 0, 'de8859980d3748028cd31b8f185cd780');
INSERT INTO public.switch_battery VALUES ('126d59b9f5664f519d5f5d598d2b30ff', 0, '04aba9842c4948108e6b61d3a7ce7a32');
INSERT INTO public.switch_battery VALUES ('0db4edf87e5644239e8f591f5819f474', 0, 'e3d906416c504aff878b976ecda59343');
INSERT INTO public.switch_battery VALUES ('1131c5b2927c4bc2b5c1fa4347d6babe', 0, '8da128c70cf64cb78a5c7597f38e7f9b');
INSERT INTO public.switch_battery VALUES ('ba3153e1eb8b409e9a95dd67a95ccfeb', 0, 'ca6f2d5d7c0346d0a14a54095bba4201');
INSERT INTO public.switch_battery VALUES ('0b51fdb69aa04e9b9d69484a91a85dc5', 0, '7f24a12fe777414c8df28dfe3737b8e0');
INSERT INTO public.switch_battery VALUES ('2f57a09f42b945e595de97576368c714', 0, '84acfd8a3a9145cb937a3e1dd98cf611');
INSERT INTO public.switch_battery VALUES ('99ef6b005499489280721008d09ba77b', 0, '6c7d074cc35e4abb9a791960c5a5cc53');
INSERT INTO public.switch_battery VALUES ('f146fc048e2f4a23825ffa9e29827dc3', 0, 'eed33daa2bac4d9ba96e3f9af636930a');
INSERT INTO public.switch_battery VALUES ('bd3f03d8fbbc4f69998a83af256d79de', 0, '4a4f402f81c34240a4c912b27b75e629');
INSERT INTO public.switch_battery VALUES ('8f0fdcf84079495c912011119299ad0f', 0, 'ea4238da9aff432db3f22ab99e958463');
INSERT INTO public.switch_battery VALUES ('03ae568cdad54bb1b524dfba2249e13b', 0, 'fd0e0fc593d34b63adade3fadeb2a89c');
INSERT INTO public.switch_battery VALUES ('5d802a0348974f9eaf8a199df8e99abd', 0, 'ec8562e0ab8247b889eac96d19fe6194');
INSERT INTO public.switch_battery VALUES ('472ba3e3ad484bfca5ab41bdc253ab99', 0, '6801e3caec334011aa04ce1f85779ce6');
INSERT INTO public.switch_battery VALUES ('0b56ac18701c482bb77480c7ea85d70e', 0, '7c4ad70374c34649a0e66b2956321328');
INSERT INTO public.switch_battery VALUES ('308b82b3dd7f4387a1209dcc99c96f34', 0, '8b6964fae78f4fc68512f3e4f26b3aee');
INSERT INTO public.switch_battery VALUES ('ffbe0c729f7546c88fe36d99ea388015', 0, 'a94f991699954b85ab68a6101bfa0635');
INSERT INTO public.switch_battery VALUES ('49f3c034d551447792e9b7418846646d', 0, 'fbbaeec6fd83485cb6e785612d731f05');
INSERT INTO public.switch_battery VALUES ('bce2924f15fe4e3e92ee004f6c458c6d', 0, 'dc64bbdf413b457bb128eb03dd07e068');
INSERT INTO public.switch_battery VALUES ('e56f0213dc7947d7ba09f859a4f81a8e', 0, '9b668b11e3e44ddd98268887546b2380');
INSERT INTO public.switch_battery VALUES ('1c3c266b69d2446abce58c48bd33d949', 0, '1d70ff5ef69d48f68bf05ace54be4e4f');
INSERT INTO public.switch_battery VALUES ('1b56a66fe4f94cc1804c33aac47a3e26', 0, '60f8d475b54543ba8e9844fd163965c6');
INSERT INTO public.switch_battery VALUES ('84268d6d6220478d9b6fda9c507dd05b', 0, 'e0844e33fc0a4cdf9cfea09402e6df9a');
INSERT INTO public.switch_battery VALUES ('30cf3b14635846a199edf131ad1ce112', 0, '9fca56e6240e44d1923b5bccba7d3333');
INSERT INTO public.switch_battery VALUES ('93337655c65c40cd8e53a9d499b3fdfd', 0, 'da1666a4390b456095e86d868a9bcf41');
INSERT INTO public.switch_battery VALUES ('497da53383ff46529b7843d4a8faff20', 0, '1ea6867d5a714bb9a69395b7972676f7');
INSERT INTO public.switch_battery VALUES ('02b0a720765b4102a9e44f7234780a3f', 0, '31157c908ac7455d8eb966170360f19b');
INSERT INTO public.switch_battery VALUES ('b73ed80232dc4189b1935b3ac64de1e4', 0, '2d41cee6cd634bf090c21bf20b2c2505');
INSERT INTO public.switch_battery VALUES ('1c82ab4a152e4de791cbad6121b8d7dc', 0, 'dfc8cc5872d8440fb7d4fcbec55d2b1c');
INSERT INTO public.switch_battery VALUES ('781f5af3148c49baa2756463fcf1767f', 0, 'd4eaa029c16647beb12914f32f776ead');
INSERT INTO public.switch_battery VALUES ('c91e33cd103d47c2ba0139fee6629bdb', 0, '51139524dcbd4f6f8a25fe93ed31a22c');
INSERT INTO public.switch_battery VALUES ('20ed9170de314252bc1a35cceb0ff57b', 0, '9284cc64c31a42f6a0a9b9a64fb6d660');
INSERT INTO public.switch_battery VALUES ('31ac9e2efa694df994d0e80a9dbe5420', 0, '9fa425bf088e40d1aaf2673fe5a837cb');
INSERT INTO public.switch_battery VALUES ('3eff39a464694299909a69fa89a74917', 0, '2144127d0de448f498d7fba1cd0cde8e');
INSERT INTO public.switch_battery VALUES ('b0e9743e54bb442da489e87dcde9c9b6', 0, 'cf955dc344874ffab9adf7685f13185b');
INSERT INTO public.switch_battery VALUES ('3c4fccab24984a0f8dbfd19ad7e2e6ad', 0, '1b9253c9cf48430aa8d9dd30b00f1518');
INSERT INTO public.switch_battery VALUES ('a38a4b8039ac49caa5fae09b6b5bed0a', 0, '28b8e5c76a464558875075d28e81e477');
INSERT INTO public.switch_battery VALUES ('858a92700fd44a03a6bcb845e212816b', 0, '32f3797af21f47a4be9eb359fc298e1a');
INSERT INTO public.switch_battery VALUES ('1bf5331a7d4643648d738ebb1f380783', 0, '88ede7892afe49369308451831a370f5');
INSERT INTO public.switch_battery VALUES ('b1f3c1323bb04b1296e94fd7e64097bd', 0, 'c7bb9a9178954b369189ec1a326d1bad');
INSERT INTO public.switch_battery VALUES ('f04c2136086a4924ba37878253a460c3', 0, '31f7e2d9f3384c03bb5b1cd40166b6bb');
INSERT INTO public.switch_battery VALUES ('a2f59671b207411eba87362352323368', 0, 'f378c17212ca474eaca4b99919212ea3');
INSERT INTO public.switch_battery VALUES ('4768676358d54e87a0afec9c138276dc', 0, 'e02b94c91c51437a8fbbb4ca4914b879');
INSERT INTO public.switch_battery VALUES ('f965ccc54a7d4ef0bf1818b45ef23a08', 0, 'ecc7c408f6064d8e9be52fe6e98c610f');
INSERT INTO public.switch_battery VALUES ('5faa68ddcb474514b4ad06e52c3feb5e', 0, '42af1c5f98b9400fa513edf6165cd101');
INSERT INTO public.switch_battery VALUES ('d3c4f04ca7eb4455b636b97caaf4ea10', 0, 'd610bca346f24122b382a9d46adbe2b5');
INSERT INTO public.switch_battery VALUES ('e30af24f42734b46bf2e0c2021c5a613', 0, '34997f3a4c204b638c412808d4927ec2');
INSERT INTO public.switch_battery VALUES ('5f2edb90d8af4618b4da12bdc2fd843e', 0, '19caa27c4a4a420f92b020fda0a891c6');
INSERT INTO public.switch_battery VALUES ('df47663b109547d29c9d618bc4cb4927', 0, 'cc154d6e442e44d890d4bcad1c0207a2');
INSERT INTO public.switch_battery VALUES ('a035157b2b1b41e2bd799423a92b3fa1', 0, '3dc700850f3d4529a70ba9d0411366ba');
INSERT INTO public.switch_battery VALUES ('765b40c36bea432d9758c545739c096b', 0, 'c7c30776c5d540c8a9252c95baecd188');
INSERT INTO public.switch_battery VALUES ('64e5283c52f7493bb54f662a6c979247', 0, 'c41bd866262542ea9319a75801ea7251');
INSERT INTO public.switch_battery VALUES ('dc78d9966d2a4b13b6eaff8b42789532', 0, '5227696dc6a44719a0c20038dd90211a');
INSERT INTO public.switch_battery VALUES ('db80e7a9129e442db9cc9008c18dea9d', 0, '73d35af05aa5438b8d5d388409acdf74');
INSERT INTO public.switch_battery VALUES ('62ae7eac92024389bed595b6652fd8fc', 0, '4a711cc5b4a64d538d6ae7218997b07e');
INSERT INTO public.switch_battery VALUES ('b56a9920bdc94177aae87f4770c556bd', 0, 'b6723927d2d04170a654bce130011176');
INSERT INTO public.switch_battery VALUES ('090c5005efd24809b7796b725496aaec', 0, '3ff6ac5b1f0b4ee8adfb7da0f6e52b8d');
INSERT INTO public.switch_battery VALUES ('713caef5a0c84dd1974e29ee33abdd72', 0, 'b35b5dc865184178bec7474191ebd630');
INSERT INTO public.switch_battery VALUES ('a27fe8a34c35440abbfe72f3914fbb02', 0, 'cc8107e96c444b619c6afa988fbe01b0');
INSERT INTO public.switch_battery VALUES ('1ece28ed298949b18ceb6795494b96fe', 0, 'eb4c5aebe5be428fbfc4e2e8aee91d08');
INSERT INTO public.switch_battery VALUES ('7ab80b18d7304e1e8d7912aa7975a481', 0, 'ed64dd7c9a784abe8e3e2ee412437023');
INSERT INTO public.switch_battery VALUES ('d64d997885c742519185310b75162c85', 0, 'f3285fc966af498cb1a203547aff80a7');
INSERT INTO public.switch_battery VALUES ('44efc615c04343a88cdf5a539fe12b37', 0, '9e1b69a7a89446fe91a5963699fd4842');
INSERT INTO public.switch_battery VALUES ('e2ada9f4fd90468c88d98817e4044c7d', 0, 'cb11bbc261594df8b9339049b2b638ba');
INSERT INTO public.switch_battery VALUES ('db7ccf0db4d845e2a095f318a88f6a1b', 0, '2b60f086c2fa480289908eda0f84dcce');
INSERT INTO public.switch_battery VALUES ('8c6a990f24af49cc8df297282841c641', 0, 'e154030e8f014da2a109c38beb05dde9');
INSERT INTO public.switch_battery VALUES ('bb3772b6a52d4c7890b096cfb7e47e49', 0, '9ef0e8da6f444cb7adb57c26eef36f41');
INSERT INTO public.switch_battery VALUES ('ea966f5437d045e69096921cacd68707', 0, 'cad5eb1721354dffb54e062b9d8d6a57');
INSERT INTO public.switch_battery VALUES ('23c77bb807d4437fb25110ef2b4b4c56', 0, '5b7af0b59ab749168f6f1b7b147fd0d6');
INSERT INTO public.switch_battery VALUES ('ea81983a9de74f4481ad0932b2e842dc', 0, '93992260e5964c8eb0903ccaf88948ed');
INSERT INTO public.switch_battery VALUES ('6809bf495f874df08fcf1b8aa4392567', 0, NULL);
INSERT INTO public.switch_battery VALUES ('7613aa1b39b54eb59d578373fde8b796', 0, NULL);
INSERT INTO public.switch_battery VALUES ('ceaad36d1bb34ff79c18813c095ea9bd', 0, '58b6494eb34543c39c5bcbf7d8a9dae3');
INSERT INTO public.switch_battery VALUES ('30ee1a0983ae4c4f86e6fd31ca68984a', 0, '65182186a4a44ff9b371cc9fcaecdb4c');
INSERT INTO public.switch_battery VALUES ('997586f23f7742b1934b78b2f1e425b8', 0, 'a1e41b880de64198882afb5d005f24ad');
INSERT INTO public.switch_battery VALUES ('47b687e7f8b941a3922f1cf384b5c2b8', 0, '85c89bda4b034d0fb80f104219707fa2');
INSERT INTO public.switch_battery VALUES ('9e5c8831da754349a6369e7efbd648e3', 0, '4ff4a2f6f15e42d1ae1a53c8fde03df2');
INSERT INTO public.switch_battery VALUES ('94f902aaa1a74212ac4328e97de6c4d2', 0, '0bec74b0c78c48f28985082656b718d3');
INSERT INTO public.switch_battery VALUES ('8365723a45124c36ad80da5a71ac34bc', 0, 'e617352835734f948aeb1416e75580c9');
INSERT INTO public.switch_battery VALUES ('879fd09e97cc4a13a57b11a9ba1852cc', 0, '1e180f51f35a4bfc9e0e00fe2e00e2fb');
INSERT INTO public.switch_battery VALUES ('5261eae1a3ab4e90abcf6f75a3543941', 0, '7864ae5b56c949529f09581d3c483913');
INSERT INTO public.switch_battery VALUES ('191a4aa5c69d47ff851281f2b7c6ff7f', 0, '98427bda6a2b4747b16c2d73ac900e99');
INSERT INTO public.switch_battery VALUES ('b674eb22cbdb40eba31f904de3003744', 0, '4ae1242a8b9f42d1bf22266d7b7554a8');
INSERT INTO public.switch_battery VALUES ('aca5f488ae934f04813df5e06f8ec708', 0, 'd6c3440a6f6040929c32eee1547731fd');
INSERT INTO public.switch_battery VALUES ('d6a8d6df78ad4536927b8050d4030c15', 0, '76eb5e75a1fa47de8d9294040152bd5e');
INSERT INTO public.switch_battery VALUES ('034966cf54274006bfae4eeb20e3e1d7', 0, 'd340fd941ce24a3e9deb5c70a0f044b2');
INSERT INTO public.switch_battery VALUES ('01c9548bfe4443d9b013a009af2f1f93', 0, '2da0a7143bd44b00b3821e6ff682dc72');
INSERT INTO public.switch_battery VALUES ('f258f06fb994431bb865d3937dab8c31', 0, '91b1548bc8d4496e9fac293060e60679');
INSERT INTO public.switch_battery VALUES ('b2efda541ee6445f8f67c476c46273e5', 0, 'c122ba974f044eeba6356fa2d9a8f2de');
INSERT INTO public.switch_battery VALUES ('6050b38e9c37426c8049934086dc3122', 0, '356ce86e279e4cea893237d668e5e4e0');
INSERT INTO public.switch_battery VALUES ('0187cc71fab042fd94a8bd35726520f0', 0, '878538abfdb447e0bd509d51233419d0');
INSERT INTO public.switch_battery VALUES ('3d659ab2a3974f05b6ea4cd24165948d', 0, 'b15206a9534e4b6cbe71509509ae248d');
INSERT INTO public.switch_battery VALUES ('07fc7c1f298943569a47f6056468f73a', 0, 'fed32607b1224451bc3c3c0589c0e410');
INSERT INTO public.switch_battery VALUES ('4283ad43d8324a7cbc38dc4e414f5f28', 0, 'eac560af8aa041b6887ee415f168d5ca');
INSERT INTO public.switch_battery VALUES ('f0c38dac435042798af58d0ec60a9ce6', 0, '0c7fbea1c46743f49c10f018df6dbbd7');
INSERT INTO public.switch_battery VALUES ('b66207f4e0654d77a174eb2407dddb41', 0, '1f9cb58f49614f25b3eb06494ee2114c');
INSERT INTO public.switch_battery VALUES ('13255524c8164f4dbb4ccfdacde3497c', 0, '9b75538ff1824bf7a7fff64b7f70aa4d');
INSERT INTO public.switch_battery VALUES ('6d7db4fe06e74e96a17721a5ccf6b9b8', 0, '555a7012169243078a050c6eaf303080');
INSERT INTO public.switch_battery VALUES ('aaf46cd2d9f042d9a6ebee36ba1fe2d6', 0, '46e43c4e33c14e7bb9e081f4fca3d77a');
INSERT INTO public.switch_battery VALUES ('fb11f84933944b25a066d0b7952319c3', 0, '6f343088be8340e6886e27ed7cc9f2ec');
INSERT INTO public.switch_battery VALUES ('c4011b34d44f442eb903b2706bcd1d39', 0, '4a2228c9ab924ab2b78d4fad2b3e2bb5');
INSERT INTO public.switch_battery VALUES ('1ab76a0371b04c54a8329b65f4589b73', 0, '03b18402640b486c8506cf4d6c59180c');
INSERT INTO public.switch_battery VALUES ('541fc650bcc94a2a9da5e2d1f9659baa', 0, 'a7483a06061144f2a791109408abf30d');
INSERT INTO public.switch_battery VALUES ('b2c2eef1c91e4ae29e68f744c11e98bc', 0, '389aa906524f400097ffc1a284be779a');
INSERT INTO public.switch_battery VALUES ('de98739f389d4abba7e9f7e9c656699d', 0, '2892b6acbe7e499d9a21aed4c0b05d05');
INSERT INTO public.switch_battery VALUES ('282bddacce14426e9383bfd6b6c70ea8', 0, '094cd0fa2a8744c4b0cb29a3418edba6');
INSERT INTO public.switch_battery VALUES ('64404388e07e41b3a44300f092f281e8', 0, 'e28e6f72fa174ccfada70116389a64ad');
INSERT INTO public.switch_battery VALUES ('52744f9d129246ef9c7d070e831cdaa7', 0, 'a7a3a9924ca040d9a321143046b755ab');
INSERT INTO public.switch_battery VALUES ('2640692f4ee5429b870b31c4357b48d9', 0, '9535352f82c64ffdba3cd5bdd969cc96');
INSERT INTO public.switch_battery VALUES ('36980b834e5444259efb423adad39a29', 0, 'ad27e5c4940c4a13a1718b0f74f51a83');
INSERT INTO public.switch_battery VALUES ('5722ffd07118461a847f91368339213c', 0, 'd149263857bd490fb4c4957f55810669');
INSERT INTO public.switch_battery VALUES ('846ea350dbfe41cdbbf996dfc1721750', 0, 'fc97903b8fac4e0cbb60a1fedbe7b9f3');
INSERT INTO public.switch_battery VALUES ('f33ee7bc3e8a4dd5810199f8ef26a0b6', 0, '38c30b789c1d442b88bc305f1bfe4aa5');
INSERT INTO public.switch_battery VALUES ('78be3207418b41d6b66b41acae3bf75e', 0, '52aa29366d8e4601854389e465417c80');
INSERT INTO public.switch_battery VALUES ('478e0c2ff60f4316afefe00ab6cb7eaa', 0, '18b95488a3254b07bbbf2f1e9595b827');
INSERT INTO public.switch_battery VALUES ('fbe7b8996ce847319ab80ca629301fca', 0, 'b0850b0c4e9c4ac8956d71756de5d905');
INSERT INTO public.switch_battery VALUES ('edc02e510a1c4cf3b7bbe7f05928bc13', 0, 'aacf0fe02aa1490293d10480b734429c');
INSERT INTO public.switch_battery VALUES ('29a27ab8db574e72b81854b522bc964b', 0, 'eccafc0a231e41f0a980788ed161cca4');
INSERT INTO public.switch_battery VALUES ('bcb3042ef7304b62b2e0c4697500245a', 0, '7a7d4dc7ca25438a864f7aa90daacff0');
INSERT INTO public.switch_battery VALUES ('4ad070437f5648cfa89f8e25120c7451', 0, '2867292caa8144aab2a798f50dfff7b4');
INSERT INTO public.switch_battery VALUES ('4d2aed861a054e1fa7e1990699a5148d', 0, 'a513bff9f8194b09a833b04a3d2b7a62');
INSERT INTO public.switch_battery VALUES ('b07c16cf8c1746b58c6728d9b98fbe86', 0, '473e2f51814d4de29e6907fc3d133912');
INSERT INTO public.switch_battery VALUES ('032402a20ca6434790d4a5ee0befba51', 0, 'f545b9f5d9f04e8c88ad289ab7840dc4');
INSERT INTO public.switch_battery VALUES ('f9dc4ee07e5943a68c80f82bb69ccccd', 0, '2f1423a956684ffaab4babea0372913a');
INSERT INTO public.switch_battery VALUES ('b4000ef9cf5b4dbebf935bac0e65eb4e', 0, '63eabb6634974de3a5bcf3e3f02a9060');
INSERT INTO public.switch_battery VALUES ('0b4a7d2caf9f461b982f5dc0471f72c7', 0, '792bab845b7a486e8ad7d94ace6eb647');
INSERT INTO public.switch_battery VALUES ('fdc3534ac0644145b8fe7c7057faaa12', 0, 'a0b3631cdcf04c4186287f21b53ffda0');
INSERT INTO public.switch_battery VALUES ('260d4dddfbe84b53b05d414fd8204a01', 0, '76071b999f3a4b2e8b573eab18d2ef5c');
INSERT INTO public.switch_battery VALUES ('b6c6076bb2ba4e13a490a56a62e86578', 0, '489ecc276684474ab6d6a5cf5252c476');
INSERT INTO public.switch_battery VALUES ('e1e90ab251ae4ae4877e802661222dc9', 0, 'e97b5945921b41558467ed180501ec64');
INSERT INTO public.switch_battery VALUES ('33f8919553f04f2c8716546eb3059a06', 0, '451dc863ec2a47cd930574513eae93a4');
INSERT INTO public.switch_battery VALUES ('a235b075aaac409f82eacb4a31f4c0c4', 0, '8ce4d8d57f2f4edfa16e7b37bed8a00e');
INSERT INTO public.switch_battery VALUES ('5060f5acd3374f46ac3f9740b7698425', 0, '5fde2f3cf6fa47e8aa3ff0d410a2bc23');
INSERT INTO public.switch_battery VALUES ('731f48b093a74d36aca414357c4a81e8', 0, '01612d837e604edd8c3e55ec05e33743');
INSERT INTO public.switch_battery VALUES ('bd19df156e404d30a8621324ba6dac28', 0, NULL);


--
-- Data for Name: switch_box; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.switch_box VALUES ('cd11bb13ac4246d5bc07f8c33a12bf42', 0, '2fb294bb2258ffd5bd7ecdad39851383', 2);
INSERT INTO public.switch_box VALUES ('f4d6658b643a4c1fad7afa38f9c2c065', 0, '2fb294bb2258ffd5bd7ecdad39851383', 4);
INSERT INTO public.switch_box VALUES ('cf3fdb9be6424b8d8c0e1b54777716f0', 0, '2fb294bb2258ffd5bd7ecdad39851383', 5);
INSERT INTO public.switch_box VALUES ('df60cd8fef844d85a2b26ba7ab5132b0', 0, '2fb294bb2258ffd5bd7ecdad39851383', 6);
INSERT INTO public.switch_box VALUES ('0b9520cf81f94ac680fccee09bd33a32', 0, '2fb294bb2258ffd5bd7ecdad39851383', 7);
INSERT INTO public.switch_box VALUES ('4bdc42476c684c4bab44a207434ff085', 0, '2fb294bb2258ffd5bd7ecdad39851383', 8);
INSERT INTO public.switch_box VALUES ('27864fae87014795bf98561bb47e1e01', 0, '2fb294bb2258ffd5bd7ecdad39851383', 9);
INSERT INTO public.switch_box VALUES ('320d2d4346bd476a871bacf74355e187', 0, '2fb294bb2258ffd5bd7ecdad39851383', 10);
INSERT INTO public.switch_box VALUES ('1d414a85711e4e18b58936df9efa7159', 0, '2fb294bb2258ffd5bd7ecdad39851383', 11);
INSERT INTO public.switch_box VALUES ('f8cc6235381e4d0f803dcc011df801dc', 0, '2fb294bb2258ffd5bd7ecdad39851383', 12);
INSERT INTO public.switch_box VALUES ('77f9a0f40de04bacb9c2793b59e62ac5', 0, '2fb294bb2258ffd5bd7ecdad39851383', 13);
INSERT INTO public.switch_box VALUES ('f19e3874488d4734a446f9e06ac725ab', 0, '2fb294bb2258ffd5bd7ecdad39851383', 14);
INSERT INTO public.switch_box VALUES ('7660eabae0dc43469209edd49d0e4fc8', 0, '2fb294bb2258ffd5bd7ecdad39851383', 15);
INSERT INTO public.switch_box VALUES ('1b8a6f3a5aff4b13bd6711d113c2361f', 0, '2fb294bb2258ffd5bd7ecdad39851383', 16);
INSERT INTO public.switch_box VALUES ('8ed7d0d818024aa6bbccc1f696696133', 0, '2fb294bb2258ffd5bd7ecdad39851383', 18);
INSERT INTO public.switch_box VALUES ('af15824ea443421a9ac74c86d17ebf42', 0, '2fb294bb2258ffd5bd7ecdad39851383', 19);
INSERT INTO public.switch_box VALUES ('43a2bdcc026e422ba1b78f2df3948358', 0, '2fb294bb2258ffd5bd7ecdad39851383', 20);
INSERT INTO public.switch_box VALUES ('19ecdbfce63d43859d1972631c071c23', 0, '2fb294bb2258ffd5bd7ecdad39851383', 21);
INSERT INTO public.switch_box VALUES ('f3845b59995e4b97943cfe52a1c2a24f', 0, '2fb294bb2258ffd5bd7ecdad39851383', 22);
INSERT INTO public.switch_box VALUES ('2285dd153c0f4828a0d805f295647ff3', 0, '2fb294bb2258ffd5bd7ecdad39851383', 23);
INSERT INTO public.switch_box VALUES ('7fdcde6971434e289440e9884da6435c', 0, '2fb294bb2258ffd5bd7ecdad39851383', 25);
INSERT INTO public.switch_box VALUES ('8195dd1f69574bbfaa4718a1411deda4', 0, '2fb294bb2258ffd5bd7ecdad39851383', 26);
INSERT INTO public.switch_box VALUES ('8676d8df905f4d84a583c1a3f7e04027', 0, '2fb294bb2258ffd5bd7ecdad39851383', 27);
INSERT INTO public.switch_box VALUES ('91145b7668a5490fa91dff37a8d7b82f', 0, '2fb294bb2258ffd5bd7ecdad39851383', 28);
INSERT INTO public.switch_box VALUES ('057b1e42add54ee9bb04b92d4391419e', 0, '2fb294bb2258ffd5bd7ecdad39851383', 29);
INSERT INTO public.switch_box VALUES ('7deec31ebaeb484c8e359c743faa2676', 0, '2fb294bb2258ffd5bd7ecdad39851383', 30);
INSERT INTO public.switch_box VALUES ('51b8c471d71d4e78a9a09b0335d339cb', 0, '2fb294bb2258ffd5bd7ecdad39851383', 31);
INSERT INTO public.switch_box VALUES ('db97592d9b1c4fd6a795b384a7648ae3', 0, '2fb294bb2258ffd5bd7ecdad39851383', 32);
INSERT INTO public.switch_box VALUES ('3db3d86dc6354f0aaf69ca0b3e6895dd', 0, '2fb294bb2258ffd5bd7ecdad39851383', 33);
INSERT INTO public.switch_box VALUES ('34a6935707a84183a6317e3262de52b2', 0, '2fb294bb2258ffd5bd7ecdad39851383', 34);
INSERT INTO public.switch_box VALUES ('3ffa2d7f9c7345f7bc2a63cfcac7c67b', 0, '2fb294bb2258ffd5bd7ecdad39851383', 35);
INSERT INTO public.switch_box VALUES ('8edd284c820c4481ab32deeeb1d7493e', 0, '2fb294bb2258ffd5bd7ecdad39851383', 36);
INSERT INTO public.switch_box VALUES ('d2ebc5e91d0c49a69a7c7d76c4ea7554', 0, '2fb294bb2258ffd5bd7ecdad39851383', 37);
INSERT INTO public.switch_box VALUES ('243297209e0347459788fa1f5fc81b9e', 0, '2fb294bb2258ffd5bd7ecdad39851383', 38);
INSERT INTO public.switch_box VALUES ('82f20269d3874d0899c7fc326a05440c', 0, '2fb294bb2258ffd5bd7ecdad39851383', 39);
INSERT INTO public.switch_box VALUES ('14611e868a824facbcf764a54fc7fe1a', 0, '2fb294bb2258ffd5bd7ecdad39851383', 40);
INSERT INTO public.switch_box VALUES ('d9525d85a0ba467cb8c7bac2a4ba799c', 0, '2fb294bb2258ffd5bd7ecdad39851383', 41);
INSERT INTO public.switch_box VALUES ('b4c5b357835f4c719a858fbcc70bb550', 0, '2fb294bb2258ffd5bd7ecdad39851383', 42);
INSERT INTO public.switch_box VALUES ('dc84c0b037014656b3520b13c81fb497', 0, '2fb294bb2258ffd5bd7ecdad39851383', 43);
INSERT INTO public.switch_box VALUES ('fef5bdce055f4fadb32b39f7a1f39dca', 0, '2fb294bb2258ffd5bd7ecdad39851383', 44);
INSERT INTO public.switch_box VALUES ('e26db44d89ed46b0bc253cf743e390e6', 0, '2fb294bb2258ffd5bd7ecdad39851383', 45);
INSERT INTO public.switch_box VALUES ('047d2f76e5584eca8163b97069e8f165', 0, '2fb294bb2258ffd5bd7ecdad39851383', 46);
INSERT INTO public.switch_box VALUES ('37b3e7bc238c48ffb819f73f70dfe65d', 0, '2fb294bb2258ffd5bd7ecdad39851383', 47);
INSERT INTO public.switch_box VALUES ('5075e81d05ee4a2d85ca850ee526f125', 0, '2fb294bb2258ffd5bd7ecdad39851383', 48);
INSERT INTO public.switch_box VALUES ('ecdd926a0eb94c62a3752a221443e04f', 0, '2fb294bb2258ffd5bd7ecdad39851383', 49);
INSERT INTO public.switch_box VALUES ('a0c6180aaaf9489c93ce0403eb2d3e1f', 0, '2fb294bb2258ffd5bd7ecdad39851383', 50);
INSERT INTO public.switch_box VALUES ('b680b676680b4ec6910df9e6cbf49def', 0, '2fb294bb2258ffd5bd7ecdad39851383', 51);
INSERT INTO public.switch_box VALUES ('3005814f2b1745758711e61e69d4ad33', 0, '2fb294bb2258ffd5bd7ecdad39851383', 52);
INSERT INTO public.switch_box VALUES ('a9804c04a06b4c5ba93f9002bf80bb46', 0, '2fb294bb2258ffd5bd7ecdad39851383', 53);
INSERT INTO public.switch_box VALUES ('0265a5fafb61453891f4757062f8261a', 0, '2fb294bb2258ffd5bd7ecdad39851383', 54);
INSERT INTO public.switch_box VALUES ('017274c411b5490cb4c6868c9dbf782e', 0, '2fb294bb2258ffd5bd7ecdad39851383', 55);
INSERT INTO public.switch_box VALUES ('2fb744fba9ad4763b54179c4fa762dd6', 0, '2fb294bb2258ffd5bd7ecdad39851383', 56);
INSERT INTO public.switch_box VALUES ('be8822f91d564d2e9c227e8c993d708e', 0, '2fb294bb2258ffd5bd7ecdad39851383', 57);
INSERT INTO public.switch_box VALUES ('48c3a053b1b74191ac51eb185e67a571', 0, '2fb294bb2258ffd5bd7ecdad39851383', 58);
INSERT INTO public.switch_box VALUES ('b0102dde34d8487fb5fd80c9fdad3736', 0, '2fb294bb2258ffd5bd7ecdad39851383', 59);
INSERT INTO public.switch_box VALUES ('13159b8edeee4d2686895a4714b58ae4', 0, '2fb294bb2258ffd5bd7ecdad39851383', 60);
INSERT INTO public.switch_box VALUES ('914cf119b7a14408be623c09b9008163', 0, '2fb294bb2258ffd5bd7ecdad39851383', 61);
INSERT INTO public.switch_box VALUES ('abca9c6102bb4d57b093cf1f807a120e', 0, '2fb294bb2258ffd5bd7ecdad39851383', 62);
INSERT INTO public.switch_box VALUES ('9c85a96ebc464bf2bd54342bf2cee34f', 0, '2fb294bb2258ffd5bd7ecdad39851383', 63);
INSERT INTO public.switch_box VALUES ('14b30aa0ca3b4f2a829e866ace144578', 0, '2fb294bb2258ffd5bd7ecdad39851383', 64);
INSERT INTO public.switch_box VALUES ('0ced1e526a604084a2beb49b217d6792', 0, '2fb294bb2258ffd5bd7ecdad39851383', 65);
INSERT INTO public.switch_box VALUES ('bb4b701ea1094c7eb1b936269bf4dc15', 0, '2fb294bb2258ffd5bd7ecdad39851383', 66);
INSERT INTO public.switch_box VALUES ('a2d5190882b44a8f941bd8227be83c1b', 0, '2fb294bb2258ffd5bd7ecdad39851383', 67);
INSERT INTO public.switch_box VALUES ('78649e5228934026bb24f8cee209d3b4', 0, '2fb294bb2258ffd5bd7ecdad39851383', 68);
INSERT INTO public.switch_box VALUES ('8b127bf60fe94056b78bf8ebad0ad2b9', 0, '2fb294bb2258ffd5bd7ecdad39851383', 69);
INSERT INTO public.switch_box VALUES ('a3b91dee301f49b78986c4f14f139a71', 0, '2fb294bb2258ffd5bd7ecdad39851383', 70);
INSERT INTO public.switch_box VALUES ('713b289575144d34b8c29fff8e5dcc53', 0, '2fb294bb2258ffd5bd7ecdad39851383', 71);
INSERT INTO public.switch_box VALUES ('f2bbca790da54cb5b0864dbdc7c9a985', 0, '2fb294bb2258ffd5bd7ecdad39851383', 72);
INSERT INTO public.switch_box VALUES ('92a589bdce5a4e1fb8730078bfe19b77', 0, '2fb294bb2258ffd5bd7ecdad39851383', 73);
INSERT INTO public.switch_box VALUES ('de43838ef9854042a4092e4a6e617a74', 0, '2fb294bb2258ffd5bd7ecdad39851383', 74);
INSERT INTO public.switch_box VALUES ('a5f3d93e95a34669a4ed8d20e4de858f', 0, '2fb294bb2258ffd5bd7ecdad39851383', 75);
INSERT INTO public.switch_box VALUES ('ad57eef7385945588fc99bdbb32e457e', 0, '2fb294bb2258ffd5bd7ecdad39851383', 76);
INSERT INTO public.switch_box VALUES ('f74bec56f5e6423fa018493bd05d87ee', 0, '2fb294bb2258ffd5bd7ecdad39851383', 77);
INSERT INTO public.switch_box VALUES ('9ebbaae2254e4c3abf406435f5c630db', 0, '2fb294bb2258ffd5bd7ecdad39851383', 78);
INSERT INTO public.switch_box VALUES ('90c6394744144007aad5b35b5e0d7d27', 0, '2fb294bb2258ffd5bd7ecdad39851383', 79);
INSERT INTO public.switch_box VALUES ('cb7db2b7d3e14c1d807f13859e498b22', 0, '2fb294bb2258ffd5bd7ecdad39851383', 80);
INSERT INTO public.switch_box VALUES ('6b0b53bee693468caacad27c2e7724c4', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 1);
INSERT INTO public.switch_box VALUES ('272300b84dbb4d82925b2c314c236438', 1, '2fb294bb2258ffd5bd7ecdad39851383', 24);
INSERT INTO public.switch_box VALUES ('410ed82a74554145b1cb199d392661a6', 1, '2fb294bb2258ffd5bd7ecdad39851383', 1);
INSERT INTO public.switch_box VALUES ('9da7511de3014ac69a450c0e07361aa6', 0, '2fb294bb2258ffd5bd7ecdad39851383', 3);
INSERT INTO public.switch_box VALUES ('c73d9b3269b74418bf9a2b9685e35ee7', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 3);
INSERT INTO public.switch_box VALUES ('09868c65d5434bc6a98cf8edbb8cd79a', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 5);
INSERT INTO public.switch_box VALUES ('260aad4a991f482ea8a4a3e87a8dd798', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 6);
INSERT INTO public.switch_box VALUES ('73a1f6ddfb5b4fb98eedeefa13e0c119', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 8);
INSERT INTO public.switch_box VALUES ('c061ac97148b499eb3aa11a556c828b5', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 9);
INSERT INTO public.switch_box VALUES ('8d2d604def4046dea8803c2ed94a60dc', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 10);
INSERT INTO public.switch_box VALUES ('a6d697bdf9904964bfa0bc52468432c5', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 11);
INSERT INTO public.switch_box VALUES ('9932394ac20d413bb1c202c3182d21b2', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 12);
INSERT INTO public.switch_box VALUES ('6654eef2a53844daae5f34366d8fed41', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 13);
INSERT INTO public.switch_box VALUES ('d3ff641aeb224d3da0bb8d50d44bf75f', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 14);
INSERT INTO public.switch_box VALUES ('065682c4c4cf42d0b1462ac30bdca53c', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 15);
INSERT INTO public.switch_box VALUES ('27c11eff407a4071a16746aa00ae6213', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 16);
INSERT INTO public.switch_box VALUES ('e87bca4da21642a88137024aed67eb3c', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 17);
INSERT INTO public.switch_box VALUES ('9a42e392625e4593a410462288dfa7e0', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 19);
INSERT INTO public.switch_box VALUES ('1eaf00fd5d8042d8b876e0f541eb5090', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 20);
INSERT INTO public.switch_box VALUES ('e95971089e6a403f9005770d972ee5f9', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 21);
INSERT INTO public.switch_box VALUES ('b591a30aefba422282e08fd2bc01e7ff', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 22);
INSERT INTO public.switch_box VALUES ('12699ff5f91d486a8f48e406ed996a73', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 23);
INSERT INTO public.switch_box VALUES ('15793e1fa4b24205be75f87c6734ef4e', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 24);
INSERT INTO public.switch_box VALUES ('dbabfdf05b7648e8b27a1e884e1590b0', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 25);
INSERT INTO public.switch_box VALUES ('12b89f0b887b4632a5e734e03750629d', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 26);
INSERT INTO public.switch_box VALUES ('4c8b205ff5964c41bc5de100f0e7d88b', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 27);
INSERT INTO public.switch_box VALUES ('bbed79e3f57a4fd1be49de28632b0ea8', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 28);
INSERT INTO public.switch_box VALUES ('24d1860522934825b2358c68b76d7816', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 29);
INSERT INTO public.switch_box VALUES ('2c29bc8f81a2478690db46867a0bdc8f', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 30);
INSERT INTO public.switch_box VALUES ('15d969f76eaf495a975d24c8ad8492d6', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 31);
INSERT INTO public.switch_box VALUES ('ef8042eb75a84f879f0e3d0cbe838a23', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 32);
INSERT INTO public.switch_box VALUES ('8372b56be7a343b9a3d3cbb3f1e9f5eb', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 33);
INSERT INTO public.switch_box VALUES ('92233ff774bd4f56b07056b453a04657', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 34);
INSERT INTO public.switch_box VALUES ('8b7952ac45414018a5c25ce4f72a92a3', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 35);
INSERT INTO public.switch_box VALUES ('581d386558eb4d94b20ece2d109bc9ec', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 36);
INSERT INTO public.switch_box VALUES ('d4e7da955b3a4eca9d89947c71743df6', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 37);
INSERT INTO public.switch_box VALUES ('64bb60a0bef2466ba34e95c766674d42', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 38);
INSERT INTO public.switch_box VALUES ('45345e9bee544a80949581bccea9f85b', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 39);
INSERT INTO public.switch_box VALUES ('2d540403d42e45b3ba440d23ed16a4e9', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 40);
INSERT INTO public.switch_box VALUES ('bba30a111bbd4d5db42e22ce778e8470', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 41);
INSERT INTO public.switch_box VALUES ('9d717ba5fe064c53a5259feed2f9eef7', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 42);
INSERT INTO public.switch_box VALUES ('0c565f681762467085316c35b131c8fb', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 43);
INSERT INTO public.switch_box VALUES ('710607729fb84a54a126fc14ec3293da', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 44);
INSERT INTO public.switch_box VALUES ('33cac11d30a24e87aafee0ce7c16704b', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 45);
INSERT INTO public.switch_box VALUES ('ad2207aa93b747a5b288cec7c9067d76', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 46);
INSERT INTO public.switch_box VALUES ('442647b3ce24452cbec2f46404b475f7', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 47);
INSERT INTO public.switch_box VALUES ('3179a3a130ac42dd80c7d2b06d0cfd99', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 48);
INSERT INTO public.switch_box VALUES ('7202e9b226074b73961b5824a42a3baf', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 49);
INSERT INTO public.switch_box VALUES ('56bbea972cc047bfa83330aabe36c67b', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 50);
INSERT INTO public.switch_box VALUES ('370a1c1715004ea58bb3a6bdef0c7a50', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 51);
INSERT INTO public.switch_box VALUES ('e15d09dcb96b42f08215a7421a29faa6', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 52);
INSERT INTO public.switch_box VALUES ('426ba58d89af48b182a59c11d40346f2', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 53);
INSERT INTO public.switch_box VALUES ('a38ad3a3b33e42a595c20a5d6b6e5b88', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 54);
INSERT INTO public.switch_box VALUES ('6ab1f1809db2466dbbd99b717deb80d9', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 55);
INSERT INTO public.switch_box VALUES ('6e86c4b7ba71402ea3ae3ced7bd916e5', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 56);
INSERT INTO public.switch_box VALUES ('85119502f6164e0bbab143140b1f00ca', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 57);
INSERT INTO public.switch_box VALUES ('b00e1bce0f734d79bf0fa8252ff02167', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 58);
INSERT INTO public.switch_box VALUES ('3bbdf302eea54f76b325eb15bc5ba364', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 59);
INSERT INTO public.switch_box VALUES ('152c2d04f4884c5fab180068f713856d', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 60);
INSERT INTO public.switch_box VALUES ('55b887faf0534279a8e79286ad93e429', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 61);
INSERT INTO public.switch_box VALUES ('98f930bcad604f6790b833fe486e9d47', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 62);
INSERT INTO public.switch_box VALUES ('47d46ea8e6a5460cbbc47481f68f05aa', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 63);
INSERT INTO public.switch_box VALUES ('cfc181ccf6f346bfac6a0edf7dd15b0e', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 64);
INSERT INTO public.switch_box VALUES ('08f59e2d6b484cd58d82a5dd838c435a', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 65);
INSERT INTO public.switch_box VALUES ('c46ba7286604496fb9e2343af4003b63', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 66);
INSERT INTO public.switch_box VALUES ('34525724f6ec4abca73c05b42ca41c78', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 67);
INSERT INTO public.switch_box VALUES ('ed61c8fd93f043f2b26367abaa7c5b66', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 68);
INSERT INTO public.switch_box VALUES ('7f038e1528c74f838fad8a4f1b6d4ac1', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 69);
INSERT INTO public.switch_box VALUES ('cb0b416e2cd34467a19f0a4ba44f4276', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 70);
INSERT INTO public.switch_box VALUES ('a9053db440af463eba39210237cef283', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 71);
INSERT INTO public.switch_box VALUES ('cbac9624fec941998c5a21252aafed21', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 72);
INSERT INTO public.switch_box VALUES ('88e5d80bf21a4b888590e03f22035520', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 73);
INSERT INTO public.switch_box VALUES ('bbbeb7321ca749c983d559578877052a', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 74);
INSERT INTO public.switch_box VALUES ('e3e29b3ba686414895840d2088450a74', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 75);
INSERT INTO public.switch_box VALUES ('be823233f744477baa3c0434d82eeaa9', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 76);
INSERT INTO public.switch_box VALUES ('56fd17530c6e4cc5871d6801bf068931', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 77);
INSERT INTO public.switch_box VALUES ('b47edfb5eaa84bc8bc8550d2dbebb506', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 78);
INSERT INTO public.switch_box VALUES ('6e0903c64014463b8098f79c5f3001b6', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 79);
INSERT INTO public.switch_box VALUES ('b3d9dcb1e2f74ea49c2e76ef47055398', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 80);
INSERT INTO public.switch_box VALUES ('474e54c744b34b188bba46a04d58276d', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 81);
INSERT INTO public.switch_box VALUES ('3a26bd18a57e46ddbbd15ae676c2ee11', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 82);
INSERT INTO public.switch_box VALUES ('d77c41ae6e794cd6847a3b912e4f96d1', 1, 'ad6e0e8993bd7462d5860e0faf07e7a4', 4);
INSERT INTO public.switch_box VALUES ('148a99b312464a3ba72413b1d9ccfabc', 1, 'ad6e0e8993bd7462d5860e0faf07e7a4', 7);
INSERT INTO public.switch_box VALUES ('bab68dfd2f5945039ae96a8cfa288db7', 1, 'ad6e0e8993bd7462d5860e0faf07e7a4', 2);
INSERT INTO public.switch_box VALUES ('5d4dfdfb35a44fa18f747dcc75c93f26', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 83);
INSERT INTO public.switch_box VALUES ('531d0d54c15f4ac8a9018da4ceae3b05', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 84);
INSERT INTO public.switch_box VALUES ('5aff6b7ff13d4078af1a407b162375a7', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 85);
INSERT INTO public.switch_box VALUES ('664797a2a48049cc8062d2f4950e3bc8', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 86);
INSERT INTO public.switch_box VALUES ('5601df2fcc7543a68c29ea3b0f09a916', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 87);
INSERT INTO public.switch_box VALUES ('f51120faf8994f3eadf440fb0ece937e', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 88);
INSERT INTO public.switch_box VALUES ('d10cc05e713d48c5a6d6d1ad0ea65058', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 89);
INSERT INTO public.switch_box VALUES ('d92ca9d08c3a41cfbd4c120300d75a71', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 90);
INSERT INTO public.switch_box VALUES ('9187436b73a04c0e97c7da21548f9740', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 91);
INSERT INTO public.switch_box VALUES ('b7f9660585434ee5811267e51fecc2db', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 92);
INSERT INTO public.switch_box VALUES ('0c1739d9fec54af79b48b98aa4e1ccc2', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 93);
INSERT INTO public.switch_box VALUES ('0486e3927f704b14bae53f1d01971b1f', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 94);
INSERT INTO public.switch_box VALUES ('0bcc516acb51425996e5eb51c0a3af3b', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 95);
INSERT INTO public.switch_box VALUES ('24712673996c4fe4bb7115a6d04972f4', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 96);
INSERT INTO public.switch_box VALUES ('17106ae6614e449b9bb32803cd921ce5', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 97);
INSERT INTO public.switch_box VALUES ('c8688f2d0b074137a4e8c4b16a7eabbb', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 98);
INSERT INTO public.switch_box VALUES ('ea3432b2fd314ae6b9ea637edd111fa2', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 99);
INSERT INTO public.switch_box VALUES ('3eaa2439d8ae4a3e9a2b287c8e2057a2', 0, 'ad6e0e8993bd7462d5860e0faf07e7a4', 100);
INSERT INTO public.switch_box VALUES ('4c95af7d92314b91b747f1f6efa3e85f', 0, '9b88728bf76143c7b984ed9de3ef2429', 1);
INSERT INTO public.switch_box VALUES ('3fcebec8ce8b401c8ce93e0ba518401c', 0, '9b88728bf76143c7b984ed9de3ef2429', 3);
INSERT INTO public.switch_box VALUES ('b29bf5d75deb419ab89d8eb61ba389a4', 0, '9b88728bf76143c7b984ed9de3ef2429', 4);
INSERT INTO public.switch_box VALUES ('c77f5b0ffbac408ea3fd89a166ccd8f8', 0, '9b88728bf76143c7b984ed9de3ef2429', 5);
INSERT INTO public.switch_box VALUES ('0ef1fdfaf52f4153bb80f8a10601018c', 0, '9b88728bf76143c7b984ed9de3ef2429', 6);
INSERT INTO public.switch_box VALUES ('4015ca3cd7cd4234ab3812f01b04a5a3', 0, '9b88728bf76143c7b984ed9de3ef2429', 8);
INSERT INTO public.switch_box VALUES ('81c2442d9980474899b3b3b489599111', 0, '9b88728bf76143c7b984ed9de3ef2429', 9);
INSERT INTO public.switch_box VALUES ('2ce8394d351443dc94949dbd986fb786', 0, '9b88728bf76143c7b984ed9de3ef2429', 10);
INSERT INTO public.switch_box VALUES ('9dae5a18a9f44e1e97d42bd8d0c7af13', 0, '9b88728bf76143c7b984ed9de3ef2429', 11);
INSERT INTO public.switch_box VALUES ('1f8cf9bc62c74ef484acbdd3b1080fe4', 0, '9b88728bf76143c7b984ed9de3ef2429', 12);
INSERT INTO public.switch_box VALUES ('7ffb4ec7ef1e4f05b52601faa7a8c1f9', 0, '9b88728bf76143c7b984ed9de3ef2429', 13);
INSERT INTO public.switch_box VALUES ('100798082bcc40feac2e9e089d21426b', 0, '9b88728bf76143c7b984ed9de3ef2429', 15);
INSERT INTO public.switch_box VALUES ('c9bc395491e4499cb44dd6fb89ceb4a5', 0, '9b88728bf76143c7b984ed9de3ef2429', 16);
INSERT INTO public.switch_box VALUES ('767ad7b75fb84828a51d2381f95c6028', 0, '9b88728bf76143c7b984ed9de3ef2429', 17);
INSERT INTO public.switch_box VALUES ('06677f37138a452e8e3a0ffcbd4955a7', 0, '9b88728bf76143c7b984ed9de3ef2429', 19);
INSERT INTO public.switch_box VALUES ('65e55a92ec494433b46bad0ec09ef855', 0, '9b88728bf76143c7b984ed9de3ef2429', 20);
INSERT INTO public.switch_box VALUES ('aa8635bedaad4efd98b7c0310891c645', 0, '9b88728bf76143c7b984ed9de3ef2429', 21);
INSERT INTO public.switch_box VALUES ('8ee4ca0c608948ccbc76f956f1f11976', 0, '9b88728bf76143c7b984ed9de3ef2429', 22);
INSERT INTO public.switch_box VALUES ('e5f25dab4f1e47e9a6d0c1bf8d8ff415', 0, '9b88728bf76143c7b984ed9de3ef2429', 23);
INSERT INTO public.switch_box VALUES ('0950ed67e2964b648945d2a7a46a7026', 0, '9b88728bf76143c7b984ed9de3ef2429', 24);
INSERT INTO public.switch_box VALUES ('56d3403e6cec45e2aada7d37f0c934cf', 0, '9b88728bf76143c7b984ed9de3ef2429', 25);
INSERT INTO public.switch_box VALUES ('4b857727ce2e432abe54322a4397eef1', 0, '9b88728bf76143c7b984ed9de3ef2429', 26);
INSERT INTO public.switch_box VALUES ('6f212c7d1bb9499eb673a8eaef5ec647', 0, '9b88728bf76143c7b984ed9de3ef2429', 27);
INSERT INTO public.switch_box VALUES ('6d88e1a418a34675bfde6e402704407c', 0, '9b88728bf76143c7b984ed9de3ef2429', 28);
INSERT INTO public.switch_box VALUES ('26c83efe96ca4cf69f9f15be405d16ba', 0, '9b88728bf76143c7b984ed9de3ef2429', 29);
INSERT INTO public.switch_box VALUES ('e8532530b41d490584edd419ca3693d5', 0, '9b88728bf76143c7b984ed9de3ef2429', 30);
INSERT INTO public.switch_box VALUES ('d9e2e5b4e632405eab2b50b0bcb18882', 0, '9b88728bf76143c7b984ed9de3ef2429', 31);
INSERT INTO public.switch_box VALUES ('8d33054407ef4a6ebee65b96d1aa87f5', 0, '9b88728bf76143c7b984ed9de3ef2429', 32);
INSERT INTO public.switch_box VALUES ('1c2f9195e00d43298a052fece58801f9', 0, '9b88728bf76143c7b984ed9de3ef2429', 33);
INSERT INTO public.switch_box VALUES ('f9fe7f985dd54f4d8d9947e0851ae696', 0, '9b88728bf76143c7b984ed9de3ef2429', 34);
INSERT INTO public.switch_box VALUES ('5c1b25fb113447ec8efbe8dd07253573', 0, '9b88728bf76143c7b984ed9de3ef2429', 35);
INSERT INTO public.switch_box VALUES ('39641997a07043ed82d079ffa4ae4240', 0, '9b88728bf76143c7b984ed9de3ef2429', 36);
INSERT INTO public.switch_box VALUES ('ebc39c86cbfd4cbbae4f0a988967f91a', 0, '9b88728bf76143c7b984ed9de3ef2429', 37);
INSERT INTO public.switch_box VALUES ('61b8e81dcfa4413b8631f1bc6114d889', 0, '9b88728bf76143c7b984ed9de3ef2429', 38);
INSERT INTO public.switch_box VALUES ('13a4bc9005d342a5b66bfc6735e06c9a', 0, '9b88728bf76143c7b984ed9de3ef2429', 39);
INSERT INTO public.switch_box VALUES ('df079551dae146aa9c798e84c4142e95', 0, '9b88728bf76143c7b984ed9de3ef2429', 40);
INSERT INTO public.switch_box VALUES ('4a303d39b4104838b7002520b7ff1641', 0, '9b88728bf76143c7b984ed9de3ef2429', 41);
INSERT INTO public.switch_box VALUES ('aeef9594fba744d6803eda5fd4053a89', 0, '9b88728bf76143c7b984ed9de3ef2429', 42);
INSERT INTO public.switch_box VALUES ('3e252fa48f9c44158c0c727e34597678', 0, '9b88728bf76143c7b984ed9de3ef2429', 43);
INSERT INTO public.switch_box VALUES ('78a452ab6af94331b7165911b0f96b01', 0, '9b88728bf76143c7b984ed9de3ef2429', 44);
INSERT INTO public.switch_box VALUES ('dbf183bcd583445882a649799db8e9c4', 0, '9b88728bf76143c7b984ed9de3ef2429', 45);
INSERT INTO public.switch_box VALUES ('1902f2f5890a4c00a1d83599af9205af', 0, '9b88728bf76143c7b984ed9de3ef2429', 46);
INSERT INTO public.switch_box VALUES ('6d1e71050895429faba1608c9bb93263', 0, '9b88728bf76143c7b984ed9de3ef2429', 47);
INSERT INTO public.switch_box VALUES ('29e0219450ee4f958f846bd69942b4e6', 0, '9b88728bf76143c7b984ed9de3ef2429', 48);
INSERT INTO public.switch_box VALUES ('bb2807217d8246b7b1c0c24111e24684', 0, '9b88728bf76143c7b984ed9de3ef2429', 49);
INSERT INTO public.switch_box VALUES ('d939d31daa8846e398d1881f7c56377c', 0, '9b88728bf76143c7b984ed9de3ef2429', 50);
INSERT INTO public.switch_box VALUES ('504d337273dd4f6a9b7c39e638c81f34', 0, '90bd00e227174eb4a447630e7222668f', 2);
INSERT INTO public.switch_box VALUES ('b6b8eb3d7c31463aa0919681ecfed1c6', 0, '90bd00e227174eb4a447630e7222668f', 3);
INSERT INTO public.switch_box VALUES ('b219c0b455754a8a93b9af274c7f28c8', 0, '90bd00e227174eb4a447630e7222668f', 4);
INSERT INTO public.switch_box VALUES ('3d9613dbeee54c269d5e9dca1c6d3a3c', 0, '90bd00e227174eb4a447630e7222668f', 6);
INSERT INTO public.switch_box VALUES ('df64d703531547fda0eaba9d138403e9', 0, '90bd00e227174eb4a447630e7222668f', 7);
INSERT INTO public.switch_box VALUES ('9733e29ef57049a2becd04892b6ded3e', 0, '90bd00e227174eb4a447630e7222668f', 9);
INSERT INTO public.switch_box VALUES ('ba10d8e8bc86442c86230e1e5d0f5f49', 0, '90bd00e227174eb4a447630e7222668f', 10);
INSERT INTO public.switch_box VALUES ('e8af256bc4154ec8ac9ed67224dcf297', 0, '90bd00e227174eb4a447630e7222668f', 11);
INSERT INTO public.switch_box VALUES ('d468e06b52c34ad899f68bf414704b4b', 0, '90bd00e227174eb4a447630e7222668f', 12);
INSERT INTO public.switch_box VALUES ('086ef526676a4f609f2cdf848ae3759a', 0, '90bd00e227174eb4a447630e7222668f', 13);
INSERT INTO public.switch_box VALUES ('93c5f91344a04991a053cd9255c5ae50', 1, '9b88728bf76143c7b984ed9de3ef2429', 2);
INSERT INTO public.switch_box VALUES ('1f1b35a15d724ad5a337372a63774282', 1, '9b88728bf76143c7b984ed9de3ef2429', 7);
INSERT INTO public.switch_box VALUES ('8117dda4a2344773bcf8b98c4ec1d771', 1, '90bd00e227174eb4a447630e7222668f', 8);
INSERT INTO public.switch_box VALUES ('287e62f501c345608138b224750e0177', 1, '9b88728bf76143c7b984ed9de3ef2429', 14);
INSERT INTO public.switch_box VALUES ('be1fbe28a26647f29501fbb128ad6b3d', 1, '9b88728bf76143c7b984ed9de3ef2429', 18);
INSERT INTO public.switch_box VALUES ('5b14102fa0754c4a983689d1f495ec7e', 0, '90bd00e227174eb4a447630e7222668f', 1);
INSERT INTO public.switch_box VALUES ('50609fcdba0c43479ac3dfa54a431848', 0, '90bd00e227174eb4a447630e7222668f', 14);
INSERT INTO public.switch_box VALUES ('13f1b0463d1a40c2aa28cda7f1b12e5a', 0, '90bd00e227174eb4a447630e7222668f', 15);
INSERT INTO public.switch_box VALUES ('8b6a4f167bf54570894d1e538300e200', 0, '90bd00e227174eb4a447630e7222668f', 16);
INSERT INTO public.switch_box VALUES ('a15b648ceeb04b54b6ca9166ada561fd', 0, '90bd00e227174eb4a447630e7222668f', 17);
INSERT INTO public.switch_box VALUES ('8113c431bf824072bae8f906729ad297', 0, '90bd00e227174eb4a447630e7222668f', 19);
INSERT INTO public.switch_box VALUES ('b6b15bd3faa74225a5957e601234033d', 0, '90bd00e227174eb4a447630e7222668f', 20);
INSERT INTO public.switch_box VALUES ('765a8ca111014a4c8663a9e6113719bf', 0, '90bd00e227174eb4a447630e7222668f', 21);
INSERT INTO public.switch_box VALUES ('2371505fe8b84fb6abd0182bf498a265', 0, '90bd00e227174eb4a447630e7222668f', 22);
INSERT INTO public.switch_box VALUES ('cf7cd63ca0974a8694debc26b103f3eb', 0, '90bd00e227174eb4a447630e7222668f', 23);
INSERT INTO public.switch_box VALUES ('c58bd3b4f29346e494ac22044d64576b', 0, '90bd00e227174eb4a447630e7222668f', 24);
INSERT INTO public.switch_box VALUES ('9b28a2182027419ab3a688c7ab626f59', 0, '90bd00e227174eb4a447630e7222668f', 25);
INSERT INTO public.switch_box VALUES ('ac90db1212834a1c8650c6d90207604f', 0, '90bd00e227174eb4a447630e7222668f', 26);
INSERT INTO public.switch_box VALUES ('efeee57946dc4cc49abf28eaad7f81b5', 0, '90bd00e227174eb4a447630e7222668f', 27);
INSERT INTO public.switch_box VALUES ('6dbbdb9a932a48fb898229b152da9ca8', 0, '90bd00e227174eb4a447630e7222668f', 28);
INSERT INTO public.switch_box VALUES ('5ad5ac6b926c47c697aac1549e7f2fe0', 0, '90bd00e227174eb4a447630e7222668f', 29);
INSERT INTO public.switch_box VALUES ('ccfc171096f24da98325d22ddfbf5158', 0, '90bd00e227174eb4a447630e7222668f', 30);
INSERT INTO public.switch_box VALUES ('58b9533f9ba44e01bea2b95d3d32dbee', 0, '90bd00e227174eb4a447630e7222668f', 31);
INSERT INTO public.switch_box VALUES ('b093afbb082d4cccb2f34bb1512db207', 0, '90bd00e227174eb4a447630e7222668f', 32);
INSERT INTO public.switch_box VALUES ('51afbbc410184f8ab3933c600f170296', 0, '90bd00e227174eb4a447630e7222668f', 33);
INSERT INTO public.switch_box VALUES ('bb97e1a9292542cfbab7abd1ad21ada9', 0, '90bd00e227174eb4a447630e7222668f', 34);
INSERT INTO public.switch_box VALUES ('8c72b2ed49804082a1ef145124725115', 0, '90bd00e227174eb4a447630e7222668f', 35);
INSERT INTO public.switch_box VALUES ('9502a129520544b4a2af4550be7c6fa6', 0, '90bd00e227174eb4a447630e7222668f', 36);
INSERT INTO public.switch_box VALUES ('9438397e8f504f3ead467395d472bef3', 0, '90bd00e227174eb4a447630e7222668f', 37);
INSERT INTO public.switch_box VALUES ('c22f58cf42d448aeb4d4196b3240d974', 0, '90bd00e227174eb4a447630e7222668f', 38);
INSERT INTO public.switch_box VALUES ('040c0d6afe0d4ead88689747d59ef972', 0, '90bd00e227174eb4a447630e7222668f', 39);
INSERT INTO public.switch_box VALUES ('f9befd19e7d6423a85a673a80c99a66d', 0, '90bd00e227174eb4a447630e7222668f', 40);
INSERT INTO public.switch_box VALUES ('fa4331d8a91d48ca978a7729c589099a', 0, '90bd00e227174eb4a447630e7222668f', 41);
INSERT INTO public.switch_box VALUES ('eed4cc351dc8423aa64bddb460915cb3', 0, '90bd00e227174eb4a447630e7222668f', 42);
INSERT INTO public.switch_box VALUES ('946c1811ccb44c4fa28b5836ceb43578', 0, '90bd00e227174eb4a447630e7222668f', 43);
INSERT INTO public.switch_box VALUES ('a13ad1ad890d4d6b85ada68378141ed5', 0, '90bd00e227174eb4a447630e7222668f', 44);
INSERT INTO public.switch_box VALUES ('7380b3e637274a7cb4662a6c4d281100', 0, '90bd00e227174eb4a447630e7222668f', 45);
INSERT INTO public.switch_box VALUES ('973dbd838cc04e08a7b89709884086ee', 0, '90bd00e227174eb4a447630e7222668f', 46);
INSERT INTO public.switch_box VALUES ('2e6dc6d24a024213ac7acd12945b1a42', 0, '90bd00e227174eb4a447630e7222668f', 47);
INSERT INTO public.switch_box VALUES ('0d5abdf539cc4a73bb20abade315a229', 0, '90bd00e227174eb4a447630e7222668f', 48);
INSERT INTO public.switch_box VALUES ('398407c2878a404c989695872b15cb97', 0, '90bd00e227174eb4a447630e7222668f', 49);
INSERT INTO public.switch_box VALUES ('11c098d02c2b43329374d53f29681fc5', 0, '90bd00e227174eb4a447630e7222668f', 50);
INSERT INTO public.switch_box VALUES ('6169e77d67a94029bc3e3886aae7d45d', 0, 'c9e446cee2684bcaba11a85d623e99ad', 2);
INSERT INTO public.switch_box VALUES ('fb55c824a3db48cfa381040ef86b21db', 0, 'c9e446cee2684bcaba11a85d623e99ad', 3);
INSERT INTO public.switch_box VALUES ('e1832e9d280d4dc993de480b2a3f27ed', 0, 'c9e446cee2684bcaba11a85d623e99ad', 5);
INSERT INTO public.switch_box VALUES ('1e5272ff9fdf4ee4b841b7fc37a6a0a9', 0, 'c9e446cee2684bcaba11a85d623e99ad', 6);
INSERT INTO public.switch_box VALUES ('4d885ccc84da444ea6781aa7160afc96', 0, 'c9e446cee2684bcaba11a85d623e99ad', 7);
INSERT INTO public.switch_box VALUES ('0c70705b9b434c58b3b00bfb184cd256', 0, 'c9e446cee2684bcaba11a85d623e99ad', 8);
INSERT INTO public.switch_box VALUES ('a6eea73cc4fb47258b7a8d66aa253f9e', 0, 'c9e446cee2684bcaba11a85d623e99ad', 9);
INSERT INTO public.switch_box VALUES ('5a1e16366b904ac2b22a44adc2f96c95', 0, 'c9e446cee2684bcaba11a85d623e99ad', 10);
INSERT INTO public.switch_box VALUES ('9302b980ac4c4541a6a62710ff514a1b', 0, 'c9e446cee2684bcaba11a85d623e99ad', 11);
INSERT INTO public.switch_box VALUES ('96f520f90e3d48b1b8552b11426e2a65', 0, 'c9e446cee2684bcaba11a85d623e99ad', 12);
INSERT INTO public.switch_box VALUES ('208d1f3a42434bcea344b6619b49e6f1', 0, 'c9e446cee2684bcaba11a85d623e99ad', 13);
INSERT INTO public.switch_box VALUES ('628da41908ac4c648edc48d2e9f5a751', 0, 'c9e446cee2684bcaba11a85d623e99ad', 14);
INSERT INTO public.switch_box VALUES ('d3dd9a0f5f1249e6aaba2d4103ad8404', 0, 'c9e446cee2684bcaba11a85d623e99ad', 15);
INSERT INTO public.switch_box VALUES ('f89845bea848465cb19b00a2cfc25d5a', 0, 'c9e446cee2684bcaba11a85d623e99ad', 16);
INSERT INTO public.switch_box VALUES ('baa8e47938ca40ccae1ff92f5e621f2f', 0, 'c9e446cee2684bcaba11a85d623e99ad', 17);
INSERT INTO public.switch_box VALUES ('3c8ee350c54c4ad3a1e9577235ef49a5', 0, 'c9e446cee2684bcaba11a85d623e99ad', 18);
INSERT INTO public.switch_box VALUES ('4e8885ced7214b9db55cfdc00a82f193', 0, 'c9e446cee2684bcaba11a85d623e99ad', 19);
INSERT INTO public.switch_box VALUES ('b2d24ab3dbda4d29a289e6ea7cd3a3a9', 0, 'c9e446cee2684bcaba11a85d623e99ad', 20);
INSERT INTO public.switch_box VALUES ('5918cc6a54b54955a12967ae70a9e9c4', 0, 'c9e446cee2684bcaba11a85d623e99ad', 21);
INSERT INTO public.switch_box VALUES ('1291e09fa5e14477b6b835b732ff7468', 0, 'c9e446cee2684bcaba11a85d623e99ad', 22);
INSERT INTO public.switch_box VALUES ('890712b5ccc7450ea504430837b4c4be', 0, 'c9e446cee2684bcaba11a85d623e99ad', 24);
INSERT INTO public.switch_box VALUES ('27d8f072c32443fc9cb308734a7ead96', 0, 'c9e446cee2684bcaba11a85d623e99ad', 25);
INSERT INTO public.switch_box VALUES ('45e60076ea8b4e2f8cf03cdaa92a6afd', 0, 'c9e446cee2684bcaba11a85d623e99ad', 26);
INSERT INTO public.switch_box VALUES ('2be2d7be077f40999b122ddf03d3a977', 0, 'c9e446cee2684bcaba11a85d623e99ad', 27);
INSERT INTO public.switch_box VALUES ('97fe0736e2fc45e7bc7275888d2c5376', 0, 'c9e446cee2684bcaba11a85d623e99ad', 28);
INSERT INTO public.switch_box VALUES ('b436fd656403452ebc21bff2ee18a11c', 0, 'c9e446cee2684bcaba11a85d623e99ad', 29);
INSERT INTO public.switch_box VALUES ('b8b2f51f235647ec95cb6403b3ee924c', 0, 'c9e446cee2684bcaba11a85d623e99ad', 30);
INSERT INTO public.switch_box VALUES ('6398f44175ad48c68b9261343f0820b5', 0, 'c9e446cee2684bcaba11a85d623e99ad', 31);
INSERT INTO public.switch_box VALUES ('4f38fb2263ab4b1a99c80946b21f3892', 0, 'c9e446cee2684bcaba11a85d623e99ad', 32);
INSERT INTO public.switch_box VALUES ('d545eaaa3a114752a30b8f809f331e3d', 0, 'c9e446cee2684bcaba11a85d623e99ad', 33);
INSERT INTO public.switch_box VALUES ('2d3ecc5df0fd4a87933f04bdb6516a46', 0, 'c9e446cee2684bcaba11a85d623e99ad', 34);
INSERT INTO public.switch_box VALUES ('bed70a582cc24e0f92b0b6730794f306', 0, 'c9e446cee2684bcaba11a85d623e99ad', 35);
INSERT INTO public.switch_box VALUES ('5d800e04d6484e65ad46a92d72e2344e', 0, 'c9e446cee2684bcaba11a85d623e99ad', 36);
INSERT INTO public.switch_box VALUES ('236476beaf644c54976a2342cf147155', 0, 'c9e446cee2684bcaba11a85d623e99ad', 37);
INSERT INTO public.switch_box VALUES ('340f2811e295422aa0bffdd858571135', 0, 'c9e446cee2684bcaba11a85d623e99ad', 38);
INSERT INTO public.switch_box VALUES ('afab18b793ef4f1d8445b962869e9c1f', 0, 'c9e446cee2684bcaba11a85d623e99ad', 39);
INSERT INTO public.switch_box VALUES ('e6e5abcd3092436d9dcb85084563d0bc', 0, 'c9e446cee2684bcaba11a85d623e99ad', 40);
INSERT INTO public.switch_box VALUES ('db93c0755fd64a138b858b35bff0fa21', 1, 'ad6e0e8993bd7462d5860e0faf07e7a4', 18);
INSERT INTO public.switch_box VALUES ('910bcda6f6254255af9ed1aedcb09f99', 1, '2fb294bb2258ffd5bd7ecdad39851383', 17);
INSERT INTO public.switch_box VALUES ('0aa041202eea4cde936393031404563d', 1, 'c9e446cee2684bcaba11a85d623e99ad', 1);
INSERT INTO public.switch_box VALUES ('a938d87b65ff4645b2927d1c2a459022', 1, '90bd00e227174eb4a447630e7222668f', 5);
INSERT INTO public.switch_box VALUES ('525b45b428f141b0a3b9e31b5353d6b4', 1, 'c9e446cee2684bcaba11a85d623e99ad', 4);
INSERT INTO public.switch_box VALUES ('69ec63fd968846c5b682d9a37458c458', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 1);
INSERT INTO public.switch_box VALUES ('f50de1a59a0c43149d5a6e0b41a61dd9', 0, '90bd00e227174eb4a447630e7222668f', 18);
INSERT INTO public.switch_box VALUES ('5dc76734ee16457fa6590aabe1d15675', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 3);
INSERT INTO public.switch_box VALUES ('26745ebacf904797a3cbd1565d80e4ab', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 4);
INSERT INTO public.switch_box VALUES ('0e7a734b83fd436b83d84c7b95a91399', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 5);
INSERT INTO public.switch_box VALUES ('9762d21e464248719148fee7bfa6a16d', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 6);
INSERT INTO public.switch_box VALUES ('2b0c3d720387459984f78c65189ebf87', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 7);
INSERT INTO public.switch_box VALUES ('9db93be4e49149b580c686602bff0340', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 8);
INSERT INTO public.switch_box VALUES ('3a533f2efd414bb1b8b7c652ac599470', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 9);
INSERT INTO public.switch_box VALUES ('160b416398a442a384362e7299eff830', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 11);
INSERT INTO public.switch_box VALUES ('fa77415bce1842dd9974eb3494556dce', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 12);
INSERT INTO public.switch_box VALUES ('151ef81e54f141c7bcb86d4986ec313e', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 13);
INSERT INTO public.switch_box VALUES ('0e5510f3c79347888093458e5011769b', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 14);
INSERT INTO public.switch_box VALUES ('1553ca19da0145f687489d41016691b6', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 15);
INSERT INTO public.switch_box VALUES ('74665fbb15cc41b58ec252002fc695c4', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 16);
INSERT INTO public.switch_box VALUES ('bff508b4d2314aff8bd17c6f7b3cd0ea', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 17);
INSERT INTO public.switch_box VALUES ('0474203c976949419a215c03007d418f', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 18);
INSERT INTO public.switch_box VALUES ('f2c1ddb044cd4bdcb0df7a52059159ff', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 19);
INSERT INTO public.switch_box VALUES ('cc314d3cccbb45bea68cd0697a253f45', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 20);
INSERT INTO public.switch_box VALUES ('6053268bd91c42308da3edbdd5f47afd', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 21);
INSERT INTO public.switch_box VALUES ('f78ecb94a6f146faaa7d09707f6a75d4', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 22);
INSERT INTO public.switch_box VALUES ('586bc311d0e449feb7fb880b01491a35', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 23);
INSERT INTO public.switch_box VALUES ('2d453470191f433c8f9bca7a588f42af', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 24);
INSERT INTO public.switch_box VALUES ('53afba8ea2ae4acd914c05203ad10e86', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 25);
INSERT INTO public.switch_box VALUES ('9368a3d235b7479283a72e4e345fa941', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 26);
INSERT INTO public.switch_box VALUES ('87e904c47c9d47ac8d44b45e42abc053', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 27);
INSERT INTO public.switch_box VALUES ('f94169530b27491cb88205d9b58983d3', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 28);
INSERT INTO public.switch_box VALUES ('404144c3694444d78a2c2d0610566d5c', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 29);
INSERT INTO public.switch_box VALUES ('a21266fb9b304ec983337fc2540eb1da', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 30);
INSERT INTO public.switch_box VALUES ('af851de9d2ec4d24a03b0cdca50f9ca0', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 31);
INSERT INTO public.switch_box VALUES ('8c2d2558402f44f99870f5f1581be493', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 32);
INSERT INTO public.switch_box VALUES ('8c28871153904a8f8006f48f3af932ee', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 33);
INSERT INTO public.switch_box VALUES ('a45196de321d48f8a4a6983534517614', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 34);
INSERT INTO public.switch_box VALUES ('55ec8dd388894fb7b495130be3b7a932', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 35);
INSERT INTO public.switch_box VALUES ('0de07ea1b6054e07bead82439cf03938', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 36);
INSERT INTO public.switch_box VALUES ('a1dbb6c0da254f0380314c5046aa1125', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 37);
INSERT INTO public.switch_box VALUES ('1f9e7e4e1e134f87ac9dbd28a48f3824', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 38);
INSERT INTO public.switch_box VALUES ('26dccdab31ce4aaa8b64a6de6d0e55cf', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 39);
INSERT INTO public.switch_box VALUES ('78fdc4d84b084fa9aa82b166e0e33280', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 40);
INSERT INTO public.switch_box VALUES ('45f093c8afd244c18e3bc93399070202', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 41);
INSERT INTO public.switch_box VALUES ('083f1ab22a9b41a4a98401c5701baaf4', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 42);
INSERT INTO public.switch_box VALUES ('9c1a5761934946fa9618083a90f89847', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 43);
INSERT INTO public.switch_box VALUES ('ab9611a590714d2189d9c1595f395859', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 44);
INSERT INTO public.switch_box VALUES ('f7b17ede1b824376981ebdf273b35c8f', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 45);
INSERT INTO public.switch_box VALUES ('d0c3ba6c7fc145bf9f0f1a3248883403', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 46);
INSERT INTO public.switch_box VALUES ('eafa5122337544a9afcbd3d01a3c5e36', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 47);
INSERT INTO public.switch_box VALUES ('172341eb0a68458abe930077db13b57a', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 48);
INSERT INTO public.switch_box VALUES ('0c926a3a6b094b16b540c910e5a9f940', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 49);
INSERT INTO public.switch_box VALUES ('dfd71226f9934a3b87cb0ec0b2c85089', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 50);
INSERT INTO public.switch_box VALUES ('db0ba5ffa0d04ddbbd4df333693df208', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 51);
INSERT INTO public.switch_box VALUES ('cd941d78c9d74584a17559d4abb3b404', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 52);
INSERT INTO public.switch_box VALUES ('a69f9af11efe482d86776621af912105', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 53);
INSERT INTO public.switch_box VALUES ('336ba234a21c4272a4f07ee7360479e2', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 54);
INSERT INTO public.switch_box VALUES ('60ac21d1ad934b28bf6befc74dee4dca', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 55);
INSERT INTO public.switch_box VALUES ('3c8c0f64fa5d4ff185af424b466859e7', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 56);
INSERT INTO public.switch_box VALUES ('fd62195e5b3a4d9f807105b34e18cdd2', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 57);
INSERT INTO public.switch_box VALUES ('dc78925bfa6a4645bca9342801b65b80', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 58);
INSERT INTO public.switch_box VALUES ('014f98b8663449088bb2f7fe9e5490c9', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 59);
INSERT INTO public.switch_box VALUES ('cb95e07eb2c745bbb203fc0a0e683a06', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 60);
INSERT INTO public.switch_box VALUES ('deca36741b6a41d4827e772cb8b0d15f', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 61);
INSERT INTO public.switch_box VALUES ('a01ec69117dd48ff81a31955aba5be19', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 62);
INSERT INTO public.switch_box VALUES ('be99da3a0d144aa68227b050cec8b376', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 63);
INSERT INTO public.switch_box VALUES ('eeaac499fa084ba38bde8dc977c4f80c', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 64);
INSERT INTO public.switch_box VALUES ('ab73be0f92cd428fa07db2b6fd077422', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 65);
INSERT INTO public.switch_box VALUES ('28187d3a40c749dfab67a6699e048814', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 66);
INSERT INTO public.switch_box VALUES ('ce949c3208dc472fa9be71e5bd347321', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 67);
INSERT INTO public.switch_box VALUES ('ff130fca348f406187a10687b2b2b356', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 68);
INSERT INTO public.switch_box VALUES ('bd6af511807042459060eb8345319033', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 69);
INSERT INTO public.switch_box VALUES ('4c84ff5ddccb43eb8b15edc7913bd6a0', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 70);
INSERT INTO public.switch_box VALUES ('f15e9c92f63c4210833ec0fb1072b24f', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 71);
INSERT INTO public.switch_box VALUES ('3a8aa73371ad4e3aa2fabf560b917cd2', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 72);
INSERT INTO public.switch_box VALUES ('3af3a961216546229e8bf6755b4d3c87', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 73);
INSERT INTO public.switch_box VALUES ('bff16e53c2304b19a8f1adc8262ca4cd', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 74);
INSERT INTO public.switch_box VALUES ('a910f7fec1f943ae94f5f82eb7aba549', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 75);
INSERT INTO public.switch_box VALUES ('a9598a53b29c442ca62df32a02d9651d', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 76);
INSERT INTO public.switch_box VALUES ('d09be2cbb7ae4f11a9af5dbe500fd414', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 77);
INSERT INTO public.switch_box VALUES ('a888897b2a6646ba91006ab0b13b46ac', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 78);
INSERT INTO public.switch_box VALUES ('9074c1b1a5c441b6aa2e5b674d1a1de2', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 79);
INSERT INTO public.switch_box VALUES ('1b2a47e178dc4828b30984d1cf1b37b8', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 80);
INSERT INTO public.switch_box VALUES ('da27ccb7d56a47ac97feddb93c44e2c9', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 81);
INSERT INTO public.switch_box VALUES ('98485e830b7345e4a8245b40a014d175', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 82);
INSERT INTO public.switch_box VALUES ('59bca8de84b34bdb9a2f96d48da49b4c', 1, 'b5c42b2aa3b44b80b5d2067343a7db8b', 10);
INSERT INTO public.switch_box VALUES ('851ee3331be64a989fceabdc405849ec', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 83);
INSERT INTO public.switch_box VALUES ('3f43fa3097544a409fdf94380392b4f5', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 84);
INSERT INTO public.switch_box VALUES ('9090144374ed4146abafd978c3139288', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 85);
INSERT INTO public.switch_box VALUES ('262804e7e12a4dcd9fd77a8413d95914', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 86);
INSERT INTO public.switch_box VALUES ('0bb6151022954958b87fa3fdf3aaa689', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 87);
INSERT INTO public.switch_box VALUES ('a77084b6f09e4e85a78f084726435a24', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 88);
INSERT INTO public.switch_box VALUES ('d6989bbcdffd4a1c98c1261428b046a4', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 89);
INSERT INTO public.switch_box VALUES ('3005074289bd4b3f933fba06826a416e', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 90);
INSERT INTO public.switch_box VALUES ('7863ba86c357483fb86f0b257bb86019', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 91);
INSERT INTO public.switch_box VALUES ('fede8ae6d1bc4b3fbabc381fee6f8f5c', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 92);
INSERT INTO public.switch_box VALUES ('9b4ad789280149988f791c7ab7833a79', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 93);
INSERT INTO public.switch_box VALUES ('d0d1307971f646b09bd2a46e232da704', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 94);
INSERT INTO public.switch_box VALUES ('3c5cb3ecdfa342978a5aba11603a4d23', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 95);
INSERT INTO public.switch_box VALUES ('985f9095b04d42248dd8d3dc7997042b', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 96);
INSERT INTO public.switch_box VALUES ('652e966364834ca9bd5c19a2202a9b86', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 97);
INSERT INTO public.switch_box VALUES ('822a7467ee4f4035a07b921c95810411', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 98);
INSERT INTO public.switch_box VALUES ('bf3c4d56bc2740bbaddeacc8fca60acf', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 99);
INSERT INTO public.switch_box VALUES ('0e7eebd212af43e4821691ee672f8dfb', 0, 'b5c42b2aa3b44b80b5d2067343a7db8b', 100);
INSERT INTO public.switch_box VALUES ('417194e2b34c48fa96bac97511de9987', 1, 'b5c42b2aa3b44b80b5d2067343a7db8b', 2);
INSERT INTO public.switch_box VALUES ('adac9f38a96c4a41933e10364bd1380a', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 1);
INSERT INTO public.switch_box VALUES ('acc9cd8022c845fdbeb17689437bf494', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 2);
INSERT INTO public.switch_box VALUES ('0a1d114150bf4087a38edf79373ca8b4', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 4);
INSERT INTO public.switch_box VALUES ('926baa30d3844b97bdba33e31e7b42d5', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 5);
INSERT INTO public.switch_box VALUES ('224b5462938e48a88ae1acce7e40962e', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 6);
INSERT INTO public.switch_box VALUES ('428d055fb9594188a6d71002ce839b9e', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 7);
INSERT INTO public.switch_box VALUES ('93857d403ee34cdcb0c39e6b032b2779', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 8);
INSERT INTO public.switch_box VALUES ('b6da3e89b5384b7c8cfd94da2b376816', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 9);
INSERT INTO public.switch_box VALUES ('1e90f38df3544cca919bc5edc21968ee', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 10);
INSERT INTO public.switch_box VALUES ('3f5251f608d148a89735186ccf6bc30f', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 11);
INSERT INTO public.switch_box VALUES ('d65cb73c7a294bc094e483d4de104571', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 12);
INSERT INTO public.switch_box VALUES ('b376bc43c51549e085758c9da22716ec', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 13);
INSERT INTO public.switch_box VALUES ('fd649df136cd44a9b7555016b23ded34', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 14);
INSERT INTO public.switch_box VALUES ('9c979bdff86a430687b18ecf681ccc21', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 15);
INSERT INTO public.switch_box VALUES ('160cbd7bdca14529926bfd52c144d421', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 16);
INSERT INTO public.switch_box VALUES ('3e26171f56904be9b0c7c7eb6aee1ab7', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 17);
INSERT INTO public.switch_box VALUES ('61572219e80a4f1785c97495cb195bef', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 18);
INSERT INTO public.switch_box VALUES ('efd07f975b654ae28e3dfd56ffc3b417', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 19);
INSERT INTO public.switch_box VALUES ('316dbab5f2cb47939c393ba9810e20cf', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 20);
INSERT INTO public.switch_box VALUES ('641c696bc3ad469c88d6e44c08c6b935', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 21);
INSERT INTO public.switch_box VALUES ('21927efc72184c1eb86746847faedd02', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 22);
INSERT INTO public.switch_box VALUES ('a01dd7a145b444299a649d91cbc30cb4', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 23);
INSERT INTO public.switch_box VALUES ('fcf4638208184aa0869d3abdd3224739', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 24);
INSERT INTO public.switch_box VALUES ('aaa73178245c449f83a30193bcb38109', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 25);
INSERT INTO public.switch_box VALUES ('cc06d76666b0450181b2a4c1afe6dbe6', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 26);
INSERT INTO public.switch_box VALUES ('461b4a33ba6b46a892895f15bb580c20', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 27);
INSERT INTO public.switch_box VALUES ('f217e60fa1a64aa2831c550c8d340ae2', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 28);
INSERT INTO public.switch_box VALUES ('f2d0da051c734e2ba457da94c2019e43', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 29);
INSERT INTO public.switch_box VALUES ('edb6f7b3d55e40d7a6ba91f41fe3611d', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 30);
INSERT INTO public.switch_box VALUES ('653880d8c26647ab9cc5a294c1fe85bd', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 31);
INSERT INTO public.switch_box VALUES ('eb4ede4062874f5d8847a8a7ccbde7de', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 32);
INSERT INTO public.switch_box VALUES ('fe5aa214341341aea9bda326d6135ff7', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 33);
INSERT INTO public.switch_box VALUES ('9c4934b3d3e247649c47cc715a34ba51', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 34);
INSERT INTO public.switch_box VALUES ('fcf792ca45d144b386de9f0e24f9382d', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 35);
INSERT INTO public.switch_box VALUES ('60edddb4bc0947d8ba18248240a518bf', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 36);
INSERT INTO public.switch_box VALUES ('14019f82a7b24696a9f182df89bac056', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 37);
INSERT INTO public.switch_box VALUES ('3ec0add093184d1289cb21564c0394a1', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 38);
INSERT INTO public.switch_box VALUES ('e4a494dd36324b569e43538dc011337b', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 39);
INSERT INTO public.switch_box VALUES ('c66de62714a04ce092000a0eb27dda1b', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 40);
INSERT INTO public.switch_box VALUES ('c9ff5597963c402f8e856f3769448eb6', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 41);
INSERT INTO public.switch_box VALUES ('bad666f062a244ae9d329c06e2b11ad2', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 42);
INSERT INTO public.switch_box VALUES ('2f0ccedc9b35486dbf1d10f0b905544c', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 43);
INSERT INTO public.switch_box VALUES ('394cb2dfb273486e8693a6374baf11a4', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 44);
INSERT INTO public.switch_box VALUES ('91638646fcc94a758c14534da04fcb94', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 45);
INSERT INTO public.switch_box VALUES ('0ff169dbf7e44d72ba582759cbe5d35f', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 46);
INSERT INTO public.switch_box VALUES ('0160c015dbc24a82b96069c42ac140bd', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 47);
INSERT INTO public.switch_box VALUES ('85ba801e88434101a88c3c6d598da36f', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 48);
INSERT INTO public.switch_box VALUES ('3da5c260ee5f41418cf1ccbb1b2a3140', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 49);
INSERT INTO public.switch_box VALUES ('89a79233da944b16b39929a1b833f0c9', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 50);
INSERT INTO public.switch_box VALUES ('d4411b8257c44ccc9989ca0f61ca0914', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 51);
INSERT INTO public.switch_box VALUES ('8bf47106ff634ed19e0c95cc993fa1b8', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 52);
INSERT INTO public.switch_box VALUES ('4c9d27fb5cc945a3b0fbee74f21d321f', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 53);
INSERT INTO public.switch_box VALUES ('4e1ceb95d2ac42808c7317fc8a36e8a5', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 54);
INSERT INTO public.switch_box VALUES ('51bf208b0e9c4ae3ae3030a7d70543c3', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 55);
INSERT INTO public.switch_box VALUES ('7e74dac908c2424db8da9ad73ec786f4', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 56);
INSERT INTO public.switch_box VALUES ('ff09406cbd684df99a04c97324cf08a6', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 57);
INSERT INTO public.switch_box VALUES ('84a6c1f6c47a4bbaa1bdca0a1f701c93', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 58);
INSERT INTO public.switch_box VALUES ('67387a9682d1410f89411cbf9ad021c9', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 59);
INSERT INTO public.switch_box VALUES ('5c719240453d46fdad8cda88b15c982d', 0, 'bc00ccb9a7a5448ba1baefdadf037ebd', 60);
INSERT INTO public.switch_box VALUES ('aaccd02a7c2a406683976e113d44d618', 0, '1590a939a2b243b6b1e6957eff0e7319', 1);
INSERT INTO public.switch_box VALUES ('dbd3fb2caee84bd1a925838cd16c7ae7', 0, '1590a939a2b243b6b1e6957eff0e7319', 2);
INSERT INTO public.switch_box VALUES ('ffda07d03b4c4313be7f0be5cbb281da', 0, '1590a939a2b243b6b1e6957eff0e7319', 4);
INSERT INTO public.switch_box VALUES ('f6ebe6af9f77478bbb0e429ef9da88e9', 0, '1590a939a2b243b6b1e6957eff0e7319', 6);
INSERT INTO public.switch_box VALUES ('fbab3a079e0944ce96ec6e846a5ac4b3', 0, '1590a939a2b243b6b1e6957eff0e7319', 7);
INSERT INTO public.switch_box VALUES ('15579f20265f4ea78557fc114d9a2a0b', 0, '1590a939a2b243b6b1e6957eff0e7319', 8);
INSERT INTO public.switch_box VALUES ('2662ba3f79e24cd09d0025b33d1b219a', 0, '1590a939a2b243b6b1e6957eff0e7319', 9);
INSERT INTO public.switch_box VALUES ('caa55c1243244cf6a10b7c419515c0c8', 0, '1590a939a2b243b6b1e6957eff0e7319', 10);
INSERT INTO public.switch_box VALUES ('c0b2b831d9274116b3c70aeea46b1a07', 0, '1590a939a2b243b6b1e6957eff0e7319', 11);
INSERT INTO public.switch_box VALUES ('c611aa2da95b48dfad363e276cfda0a7', 0, '1590a939a2b243b6b1e6957eff0e7319', 12);
INSERT INTO public.switch_box VALUES ('8a320659ea9b4fd78994a413dbadb9c4', 0, '1590a939a2b243b6b1e6957eff0e7319', 13);
INSERT INTO public.switch_box VALUES ('377a9d3ec714402c996307d85ce33482', 0, '1590a939a2b243b6b1e6957eff0e7319', 14);
INSERT INTO public.switch_box VALUES ('b2fb2de419524b7694378643ad3618e3', 0, '1590a939a2b243b6b1e6957eff0e7319', 15);
INSERT INTO public.switch_box VALUES ('cc9f93f6330f44729b07153d7d23d593', 0, '1590a939a2b243b6b1e6957eff0e7319', 16);
INSERT INTO public.switch_box VALUES ('de8859980d3748028cd31b8f185cd780', 0, '1590a939a2b243b6b1e6957eff0e7319', 17);
INSERT INTO public.switch_box VALUES ('04aba9842c4948108e6b61d3a7ce7a32', 0, '1590a939a2b243b6b1e6957eff0e7319', 18);
INSERT INTO public.switch_box VALUES ('e3d906416c504aff878b976ecda59343', 0, '1590a939a2b243b6b1e6957eff0e7319', 19);
INSERT INTO public.switch_box VALUES ('8da128c70cf64cb78a5c7597f38e7f9b', 0, '1590a939a2b243b6b1e6957eff0e7319', 20);
INSERT INTO public.switch_box VALUES ('ca6f2d5d7c0346d0a14a54095bba4201', 0, '1590a939a2b243b6b1e6957eff0e7319', 21);
INSERT INTO public.switch_box VALUES ('7f24a12fe777414c8df28dfe3737b8e0', 0, '1590a939a2b243b6b1e6957eff0e7319', 22);
INSERT INTO public.switch_box VALUES ('84acfd8a3a9145cb937a3e1dd98cf611', 0, '1590a939a2b243b6b1e6957eff0e7319', 23);
INSERT INTO public.switch_box VALUES ('6c7d074cc35e4abb9a791960c5a5cc53', 0, '1590a939a2b243b6b1e6957eff0e7319', 24);
INSERT INTO public.switch_box VALUES ('eed33daa2bac4d9ba96e3f9af636930a', 0, '1590a939a2b243b6b1e6957eff0e7319', 25);
INSERT INTO public.switch_box VALUES ('4a4f402f81c34240a4c912b27b75e629', 0, '1590a939a2b243b6b1e6957eff0e7319', 26);
INSERT INTO public.switch_box VALUES ('ea4238da9aff432db3f22ab99e958463', 0, '1590a939a2b243b6b1e6957eff0e7319', 27);
INSERT INTO public.switch_box VALUES ('fd0e0fc593d34b63adade3fadeb2a89c', 0, '1590a939a2b243b6b1e6957eff0e7319', 28);
INSERT INTO public.switch_box VALUES ('ec8562e0ab8247b889eac96d19fe6194', 0, '1590a939a2b243b6b1e6957eff0e7319', 29);
INSERT INTO public.switch_box VALUES ('6801e3caec334011aa04ce1f85779ce6', 0, '1590a939a2b243b6b1e6957eff0e7319', 30);
INSERT INTO public.switch_box VALUES ('7c4ad70374c34649a0e66b2956321328', 0, '1590a939a2b243b6b1e6957eff0e7319', 31);
INSERT INTO public.switch_box VALUES ('8b6964fae78f4fc68512f3e4f26b3aee', 0, '1590a939a2b243b6b1e6957eff0e7319', 32);
INSERT INTO public.switch_box VALUES ('a94f991699954b85ab68a6101bfa0635', 0, '1590a939a2b243b6b1e6957eff0e7319', 33);
INSERT INTO public.switch_box VALUES ('fbbaeec6fd83485cb6e785612d731f05', 0, '1590a939a2b243b6b1e6957eff0e7319', 34);
INSERT INTO public.switch_box VALUES ('dc64bbdf413b457bb128eb03dd07e068', 0, '1590a939a2b243b6b1e6957eff0e7319', 35);
INSERT INTO public.switch_box VALUES ('9b668b11e3e44ddd98268887546b2380', 0, '1590a939a2b243b6b1e6957eff0e7319', 36);
INSERT INTO public.switch_box VALUES ('1d70ff5ef69d48f68bf05ace54be4e4f', 0, '1590a939a2b243b6b1e6957eff0e7319', 37);
INSERT INTO public.switch_box VALUES ('60f8d475b54543ba8e9844fd163965c6', 0, '1590a939a2b243b6b1e6957eff0e7319', 38);
INSERT INTO public.switch_box VALUES ('e0844e33fc0a4cdf9cfea09402e6df9a', 0, '1590a939a2b243b6b1e6957eff0e7319', 39);
INSERT INTO public.switch_box VALUES ('9fca56e6240e44d1923b5bccba7d3333', 0, '1590a939a2b243b6b1e6957eff0e7319', 40);
INSERT INTO public.switch_box VALUES ('da1666a4390b456095e86d868a9bcf41', 0, '1590a939a2b243b6b1e6957eff0e7319', 41);
INSERT INTO public.switch_box VALUES ('1ea6867d5a714bb9a69395b7972676f7', 0, '1590a939a2b243b6b1e6957eff0e7319', 42);
INSERT INTO public.switch_box VALUES ('31157c908ac7455d8eb966170360f19b', 0, '1590a939a2b243b6b1e6957eff0e7319', 43);
INSERT INTO public.switch_box VALUES ('2d41cee6cd634bf090c21bf20b2c2505', 0, '1590a939a2b243b6b1e6957eff0e7319', 44);
INSERT INTO public.switch_box VALUES ('dfc8cc5872d8440fb7d4fcbec55d2b1c', 0, '1590a939a2b243b6b1e6957eff0e7319', 45);
INSERT INTO public.switch_box VALUES ('d4eaa029c16647beb12914f32f776ead', 0, '1590a939a2b243b6b1e6957eff0e7319', 46);
INSERT INTO public.switch_box VALUES ('51139524dcbd4f6f8a25fe93ed31a22c', 0, '1590a939a2b243b6b1e6957eff0e7319', 47);
INSERT INTO public.switch_box VALUES ('9284cc64c31a42f6a0a9b9a64fb6d660', 0, '1590a939a2b243b6b1e6957eff0e7319', 48);
INSERT INTO public.switch_box VALUES ('9fa425bf088e40d1aaf2673fe5a837cb', 0, '1590a939a2b243b6b1e6957eff0e7319', 49);
INSERT INTO public.switch_box VALUES ('2144127d0de448f498d7fba1cd0cde8e', 0, '1590a939a2b243b6b1e6957eff0e7319', 50);
INSERT INTO public.switch_box VALUES ('cf955dc344874ffab9adf7685f13185b', 0, 'f820320a4dd34187b715189178eb38f6', 1);
INSERT INTO public.switch_box VALUES ('1b9253c9cf48430aa8d9dd30b00f1518', 0, 'f820320a4dd34187b715189178eb38f6', 3);
INSERT INTO public.switch_box VALUES ('28b8e5c76a464558875075d28e81e477', 0, 'f820320a4dd34187b715189178eb38f6', 4);
INSERT INTO public.switch_box VALUES ('32f3797af21f47a4be9eb359fc298e1a', 0, 'f820320a4dd34187b715189178eb38f6', 5);
INSERT INTO public.switch_box VALUES ('88ede7892afe49369308451831a370f5', 0, 'f820320a4dd34187b715189178eb38f6', 6);
INSERT INTO public.switch_box VALUES ('c7bb9a9178954b369189ec1a326d1bad', 0, 'f820320a4dd34187b715189178eb38f6', 7);
INSERT INTO public.switch_box VALUES ('31f7e2d9f3384c03bb5b1cd40166b6bb', 0, 'f820320a4dd34187b715189178eb38f6', 9);
INSERT INTO public.switch_box VALUES ('f378c17212ca474eaca4b99919212ea3', 0, 'f820320a4dd34187b715189178eb38f6', 10);
INSERT INTO public.switch_box VALUES ('e02b94c91c51437a8fbbb4ca4914b879', 0, 'f820320a4dd34187b715189178eb38f6', 11);
INSERT INTO public.switch_box VALUES ('ecc7c408f6064d8e9be52fe6e98c610f', 0, 'f820320a4dd34187b715189178eb38f6', 12);
INSERT INTO public.switch_box VALUES ('42af1c5f98b9400fa513edf6165cd101', 0, 'f820320a4dd34187b715189178eb38f6', 13);
INSERT INTO public.switch_box VALUES ('d610bca346f24122b382a9d46adbe2b5', 0, 'f820320a4dd34187b715189178eb38f6', 14);
INSERT INTO public.switch_box VALUES ('34997f3a4c204b638c412808d4927ec2', 0, 'f820320a4dd34187b715189178eb38f6', 15);
INSERT INTO public.switch_box VALUES ('19caa27c4a4a420f92b020fda0a891c6', 0, 'f820320a4dd34187b715189178eb38f6', 16);
INSERT INTO public.switch_box VALUES ('cc154d6e442e44d890d4bcad1c0207a2', 0, 'f820320a4dd34187b715189178eb38f6', 17);
INSERT INTO public.switch_box VALUES ('3dc700850f3d4529a70ba9d0411366ba', 0, 'f820320a4dd34187b715189178eb38f6', 18);
INSERT INTO public.switch_box VALUES ('c7c30776c5d540c8a9252c95baecd188', 0, 'f820320a4dd34187b715189178eb38f6', 19);
INSERT INTO public.switch_box VALUES ('c41bd866262542ea9319a75801ea7251', 0, 'f820320a4dd34187b715189178eb38f6', 20);
INSERT INTO public.switch_box VALUES ('5227696dc6a44719a0c20038dd90211a', 0, 'f820320a4dd34187b715189178eb38f6', 21);
INSERT INTO public.switch_box VALUES ('73d35af05aa5438b8d5d388409acdf74', 0, 'f820320a4dd34187b715189178eb38f6', 22);
INSERT INTO public.switch_box VALUES ('4a711cc5b4a64d538d6ae7218997b07e', 0, 'f820320a4dd34187b715189178eb38f6', 23);
INSERT INTO public.switch_box VALUES ('b6723927d2d04170a654bce130011176', 0, 'f820320a4dd34187b715189178eb38f6', 24);
INSERT INTO public.switch_box VALUES ('3ff6ac5b1f0b4ee8adfb7da0f6e52b8d', 0, 'f820320a4dd34187b715189178eb38f6', 25);
INSERT INTO public.switch_box VALUES ('b35b5dc865184178bec7474191ebd630', 0, 'f820320a4dd34187b715189178eb38f6', 26);
INSERT INTO public.switch_box VALUES ('cc8107e96c444b619c6afa988fbe01b0', 0, 'f820320a4dd34187b715189178eb38f6', 27);
INSERT INTO public.switch_box VALUES ('eb4c5aebe5be428fbfc4e2e8aee91d08', 0, 'f820320a4dd34187b715189178eb38f6', 28);
INSERT INTO public.switch_box VALUES ('ed64dd7c9a784abe8e3e2ee412437023', 0, 'f820320a4dd34187b715189178eb38f6', 29);
INSERT INTO public.switch_box VALUES ('f3285fc966af498cb1a203547aff80a7', 0, 'f820320a4dd34187b715189178eb38f6', 30);
INSERT INTO public.switch_box VALUES ('9e1b69a7a89446fe91a5963699fd4842', 0, 'f820320a4dd34187b715189178eb38f6', 31);
INSERT INTO public.switch_box VALUES ('cb11bbc261594df8b9339049b2b638ba', 0, 'f820320a4dd34187b715189178eb38f6', 32);
INSERT INTO public.switch_box VALUES ('2b60f086c2fa480289908eda0f84dcce', 0, 'f820320a4dd34187b715189178eb38f6', 33);
INSERT INTO public.switch_box VALUES ('1bfa68b575fb467d96ac3f1b42bad979', 1, 'f820320a4dd34187b715189178eb38f6', 8);
INSERT INTO public.switch_box VALUES ('c75f235024464a998f10d656a0cabc62', 1, 'f820320a4dd34187b715189178eb38f6', 2);
INSERT INTO public.switch_box VALUES ('7269504c79e24f08b7711647082e18cc', 1, '1590a939a2b243b6b1e6957eff0e7319', 5);
INSERT INTO public.switch_box VALUES ('e154030e8f014da2a109c38beb05dde9', 0, 'f820320a4dd34187b715189178eb38f6', 34);
INSERT INTO public.switch_box VALUES ('9ef0e8da6f444cb7adb57c26eef36f41', 0, 'f820320a4dd34187b715189178eb38f6', 35);
INSERT INTO public.switch_box VALUES ('cad5eb1721354dffb54e062b9d8d6a57', 0, 'f820320a4dd34187b715189178eb38f6', 36);
INSERT INTO public.switch_box VALUES ('5b7af0b59ab749168f6f1b7b147fd0d6', 0, 'f820320a4dd34187b715189178eb38f6', 37);
INSERT INTO public.switch_box VALUES ('93992260e5964c8eb0903ccaf88948ed', 0, 'f820320a4dd34187b715189178eb38f6', 38);
INSERT INTO public.switch_box VALUES ('58b6494eb34543c39c5bcbf7d8a9dae3', 0, 'f820320a4dd34187b715189178eb38f6', 39);
INSERT INTO public.switch_box VALUES ('65182186a4a44ff9b371cc9fcaecdb4c', 0, 'f820320a4dd34187b715189178eb38f6', 40);
INSERT INTO public.switch_box VALUES ('a1e41b880de64198882afb5d005f24ad', 0, 'f820320a4dd34187b715189178eb38f6', 41);
INSERT INTO public.switch_box VALUES ('85c89bda4b034d0fb80f104219707fa2', 0, 'f820320a4dd34187b715189178eb38f6', 42);
INSERT INTO public.switch_box VALUES ('4ff4a2f6f15e42d1ae1a53c8fde03df2', 0, 'f820320a4dd34187b715189178eb38f6', 43);
INSERT INTO public.switch_box VALUES ('0bec74b0c78c48f28985082656b718d3', 0, 'f820320a4dd34187b715189178eb38f6', 44);
INSERT INTO public.switch_box VALUES ('e617352835734f948aeb1416e75580c9', 0, 'f820320a4dd34187b715189178eb38f6', 45);
INSERT INTO public.switch_box VALUES ('1e180f51f35a4bfc9e0e00fe2e00e2fb', 0, 'f820320a4dd34187b715189178eb38f6', 46);
INSERT INTO public.switch_box VALUES ('7864ae5b56c949529f09581d3c483913', 0, 'f820320a4dd34187b715189178eb38f6', 47);
INSERT INTO public.switch_box VALUES ('98427bda6a2b4747b16c2d73ac900e99', 0, 'f820320a4dd34187b715189178eb38f6', 48);
INSERT INTO public.switch_box VALUES ('4ae1242a8b9f42d1bf22266d7b7554a8', 0, 'f820320a4dd34187b715189178eb38f6', 49);
INSERT INTO public.switch_box VALUES ('d6c3440a6f6040929c32eee1547731fd', 0, 'f820320a4dd34187b715189178eb38f6', 50);
INSERT INTO public.switch_box VALUES ('76eb5e75a1fa47de8d9294040152bd5e', 0, 'f820320a4dd34187b715189178eb38f6', 51);
INSERT INTO public.switch_box VALUES ('d340fd941ce24a3e9deb5c70a0f044b2', 0, 'f820320a4dd34187b715189178eb38f6', 52);
INSERT INTO public.switch_box VALUES ('2da0a7143bd44b00b3821e6ff682dc72', 0, 'f820320a4dd34187b715189178eb38f6', 53);
INSERT INTO public.switch_box VALUES ('91b1548bc8d4496e9fac293060e60679', 0, 'f820320a4dd34187b715189178eb38f6', 54);
INSERT INTO public.switch_box VALUES ('c122ba974f044eeba6356fa2d9a8f2de', 0, 'f820320a4dd34187b715189178eb38f6', 55);
INSERT INTO public.switch_box VALUES ('356ce86e279e4cea893237d668e5e4e0', 0, 'f820320a4dd34187b715189178eb38f6', 56);
INSERT INTO public.switch_box VALUES ('878538abfdb447e0bd509d51233419d0', 0, 'f820320a4dd34187b715189178eb38f6', 57);
INSERT INTO public.switch_box VALUES ('b15206a9534e4b6cbe71509509ae248d', 0, 'f820320a4dd34187b715189178eb38f6', 58);
INSERT INTO public.switch_box VALUES ('fed32607b1224451bc3c3c0589c0e410', 0, 'f820320a4dd34187b715189178eb38f6', 59);
INSERT INTO public.switch_box VALUES ('eac560af8aa041b6887ee415f168d5ca', 0, 'f820320a4dd34187b715189178eb38f6', 60);
INSERT INTO public.switch_box VALUES ('0c7fbea1c46743f49c10f018df6dbbd7', 0, 'f820320a4dd34187b715189178eb38f6', 61);
INSERT INTO public.switch_box VALUES ('1f9cb58f49614f25b3eb06494ee2114c', 0, 'f820320a4dd34187b715189178eb38f6', 62);
INSERT INTO public.switch_box VALUES ('9b75538ff1824bf7a7fff64b7f70aa4d', 0, 'f820320a4dd34187b715189178eb38f6', 63);
INSERT INTO public.switch_box VALUES ('555a7012169243078a050c6eaf303080', 0, 'f820320a4dd34187b715189178eb38f6', 64);
INSERT INTO public.switch_box VALUES ('46e43c4e33c14e7bb9e081f4fca3d77a', 0, 'f820320a4dd34187b715189178eb38f6', 65);
INSERT INTO public.switch_box VALUES ('6f343088be8340e6886e27ed7cc9f2ec', 0, 'f820320a4dd34187b715189178eb38f6', 66);
INSERT INTO public.switch_box VALUES ('4a2228c9ab924ab2b78d4fad2b3e2bb5', 0, 'f820320a4dd34187b715189178eb38f6', 67);
INSERT INTO public.switch_box VALUES ('03b18402640b486c8506cf4d6c59180c', 0, 'f820320a4dd34187b715189178eb38f6', 68);
INSERT INTO public.switch_box VALUES ('a7483a06061144f2a791109408abf30d', 0, 'f820320a4dd34187b715189178eb38f6', 69);
INSERT INTO public.switch_box VALUES ('389aa906524f400097ffc1a284be779a', 0, 'f820320a4dd34187b715189178eb38f6', 70);
INSERT INTO public.switch_box VALUES ('2892b6acbe7e499d9a21aed4c0b05d05', 0, 'f820320a4dd34187b715189178eb38f6', 71);
INSERT INTO public.switch_box VALUES ('094cd0fa2a8744c4b0cb29a3418edba6', 0, 'f820320a4dd34187b715189178eb38f6', 72);
INSERT INTO public.switch_box VALUES ('e28e6f72fa174ccfada70116389a64ad', 0, 'f820320a4dd34187b715189178eb38f6', 73);
INSERT INTO public.switch_box VALUES ('a7a3a9924ca040d9a321143046b755ab', 0, 'f820320a4dd34187b715189178eb38f6', 74);
INSERT INTO public.switch_box VALUES ('9535352f82c64ffdba3cd5bdd969cc96', 0, 'f820320a4dd34187b715189178eb38f6', 75);
INSERT INTO public.switch_box VALUES ('ad27e5c4940c4a13a1718b0f74f51a83', 0, 'f820320a4dd34187b715189178eb38f6', 76);
INSERT INTO public.switch_box VALUES ('d149263857bd490fb4c4957f55810669', 0, 'f820320a4dd34187b715189178eb38f6', 77);
INSERT INTO public.switch_box VALUES ('fc97903b8fac4e0cbb60a1fedbe7b9f3', 0, 'f820320a4dd34187b715189178eb38f6', 78);
INSERT INTO public.switch_box VALUES ('38c30b789c1d442b88bc305f1bfe4aa5', 0, 'f820320a4dd34187b715189178eb38f6', 79);
INSERT INTO public.switch_box VALUES ('52aa29366d8e4601854389e465417c80', 0, 'f820320a4dd34187b715189178eb38f6', 80);
INSERT INTO public.switch_box VALUES ('18b95488a3254b07bbbf2f1e9595b827', 0, 'f820320a4dd34187b715189178eb38f6', 81);
INSERT INTO public.switch_box VALUES ('b0850b0c4e9c4ac8956d71756de5d905', 0, 'f820320a4dd34187b715189178eb38f6', 82);
INSERT INTO public.switch_box VALUES ('aacf0fe02aa1490293d10480b734429c', 0, 'f820320a4dd34187b715189178eb38f6', 83);
INSERT INTO public.switch_box VALUES ('eccafc0a231e41f0a980788ed161cca4', 0, 'f820320a4dd34187b715189178eb38f6', 84);
INSERT INTO public.switch_box VALUES ('7a7d4dc7ca25438a864f7aa90daacff0', 0, 'f820320a4dd34187b715189178eb38f6', 85);
INSERT INTO public.switch_box VALUES ('2867292caa8144aab2a798f50dfff7b4', 0, 'f820320a4dd34187b715189178eb38f6', 86);
INSERT INTO public.switch_box VALUES ('a513bff9f8194b09a833b04a3d2b7a62', 0, 'f820320a4dd34187b715189178eb38f6', 87);
INSERT INTO public.switch_box VALUES ('473e2f51814d4de29e6907fc3d133912', 0, 'f820320a4dd34187b715189178eb38f6', 88);
INSERT INTO public.switch_box VALUES ('f545b9f5d9f04e8c88ad289ab7840dc4', 0, 'f820320a4dd34187b715189178eb38f6', 89);
INSERT INTO public.switch_box VALUES ('2f1423a956684ffaab4babea0372913a', 0, 'f820320a4dd34187b715189178eb38f6', 90);
INSERT INTO public.switch_box VALUES ('63eabb6634974de3a5bcf3e3f02a9060', 0, 'f820320a4dd34187b715189178eb38f6', 91);
INSERT INTO public.switch_box VALUES ('792bab845b7a486e8ad7d94ace6eb647', 0, 'f820320a4dd34187b715189178eb38f6', 92);
INSERT INTO public.switch_box VALUES ('a0b3631cdcf04c4186287f21b53ffda0', 0, 'f820320a4dd34187b715189178eb38f6', 93);
INSERT INTO public.switch_box VALUES ('76071b999f3a4b2e8b573eab18d2ef5c', 0, 'f820320a4dd34187b715189178eb38f6', 94);
INSERT INTO public.switch_box VALUES ('489ecc276684474ab6d6a5cf5252c476', 0, 'f820320a4dd34187b715189178eb38f6', 95);
INSERT INTO public.switch_box VALUES ('e97b5945921b41558467ed180501ec64', 0, 'f820320a4dd34187b715189178eb38f6', 96);
INSERT INTO public.switch_box VALUES ('451dc863ec2a47cd930574513eae93a4', 0, 'f820320a4dd34187b715189178eb38f6', 97);
INSERT INTO public.switch_box VALUES ('8ce4d8d57f2f4edfa16e7b37bed8a00e', 0, 'f820320a4dd34187b715189178eb38f6', 98);
INSERT INTO public.switch_box VALUES ('5fde2f3cf6fa47e8aa3ff0d410a2bc23', 0, 'f820320a4dd34187b715189178eb38f6', 99);
INSERT INTO public.switch_box VALUES ('01612d837e604edd8c3e55ec05e33743', 0, 'f820320a4dd34187b715189178eb38f6', 100);
INSERT INTO public.switch_box VALUES ('74b4196cf7604f079a427d2317fe3a3f', 1, '1590a939a2b243b6b1e6957eff0e7319', 3);
INSERT INTO public.switch_box VALUES ('efa37512dc324330ac4367859788b540', 1, 'c9e446cee2684bcaba11a85d623e99ad', 23);
INSERT INTO public.switch_box VALUES ('9f8446ddc2de493eaa1887b488548f09', 1, 'bc00ccb9a7a5448ba1baefdadf037ebd', 3);


--
-- Data for Name: switch_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.switch_order VALUES ('6e9df248397e4c1396b9a7ff51c63b91', 'acab9f2df25c46a882b1e6006430da45', '2019-09-02 16:32:25.434448', 1, NULL, '4915cf5978ce4d91bdee4ca23beae369', 0);
INSERT INTO public.switch_order VALUES ('ff042d29731f4d13a17b67e35a1c8676', '203359ac07fe4150bf06b3e0bcd645f7', '2019-09-02 16:31:54.499715', 1, NULL, '50ea8433a4334da8b70f4ddf3d568575', 0);
INSERT INTO public.switch_order VALUES ('cd7de5f745b446ada8b86a5f7142e4d0', 'b9aeed76d23a47b594fb1a5f274ed84e', '2019-09-02 16:32:33.789209', 1, NULL, '4915cf5978ce4d91bdee4ca23beae369', 0);
INSERT INTO public.switch_order VALUES ('8496c7b641484b09a1b469bdcb12e4bd', 'e8cc9350db104f1fbee4591bcb4c3f42', '2019-09-02 16:32:08.875251', 1, NULL, '4915cf5978ce4d91bdee4ca23beae369', 0);
INSERT INTO public.switch_order VALUES ('daa491fcab54412a88faece0ec75dc28', 'a985d4c618ab462781ba4c4aeb713f3c', '2019-09-02 16:32:16.191206', 1, NULL, '4915cf5978ce4d91bdee4ca23beae369', 0);
INSERT INTO public.switch_order VALUES ('7b54894699f94812a2f232f5b8d93adf', 'de7f2f0d7adf40a1b0c8c81221c5a7fc', '2019-09-02 16:33:27.046025', 1, NULL, '2e9c721d546543ccbb43778b236ac9d6', 0);
INSERT INTO public.switch_order VALUES ('43aabe73df314467ae92651d8444e1c3', 'f70ece70e7574c93887c70a3e04e6b21', '2019-09-02 16:33:33.650022', 1, NULL, '2e9c721d546543ccbb43778b236ac9d6', 0);
INSERT INTO public.switch_order VALUES ('e3f189ecc9064f919cf90589d22e9e85', '5f2ea18a7f704c7ea417265e77e35ead', '2019-09-02 16:33:41.115335', 1, NULL, '2e9c721d546543ccbb43778b236ac9d6', 0);
INSERT INTO public.switch_order VALUES ('6b1fd9d0951e4e258ff501fbd233e8d1', '35588c2b53724af094eda06440dee054', '2019-09-02 16:33:47.26031', 1, NULL, '2e9c721d546543ccbb43778b236ac9d6', 0);
INSERT INTO public.switch_order VALUES ('7a8bdb9fd1f04cd2a3de78b56e6b74aa', '89551b5c520145e1a9c81e16625dca1d', '2019-09-02 16:33:55.931245', 1, NULL, '2e9c721d546543ccbb43778b236ac9d6', 0);
INSERT INTO public.switch_order VALUES ('faba7b7fd6fb4d1ba79e9d095e1632b5', '500748b58d4345febb56b689607ca96b', '2019-09-02 16:34:04.235135', 1, NULL, '2e9c721d546543ccbb43778b236ac9d6', 0);
INSERT INTO public.switch_order VALUES ('2602c6121eac45d88f8b13a3a1725035', '9dc87abcb1f34b9aa2f9332f076701dd', '2019-09-02 16:34:15.230965', 1, NULL, '2e9c721d546543ccbb43778b236ac9d6', 0);
INSERT INTO public.switch_order VALUES ('980b92baadf140058265f08c47d45138', 'f13c264edc1d4ea580c9844cad12bbdd', '2019-09-02 16:34:45.911069', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('f4d25b9b75af4efea46f72097546b04a', 'a5c8c1e0d0c64b3fa483ea73069316fb', '2019-09-02 16:34:51.738975', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('55055a9ae6a84ec2947b69f084f46f9b', 'f2a618edb22a4f239033ee0e12194f4d', '2019-09-02 16:35:17.785801', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('4a68eec037f941a3a0f0c398dcedbe6f', 'a845cfa9e5324733a856a9d24ab4dc06', '2019-09-02 16:35:00.288506', 2, '2019-09-02 17:56:51.03326', '4c4cb24046f44b85bfc9f558c393508b', 9);
INSERT INTO public.switch_order VALUES ('739d97f4f04f4e7ba6a389647bfafa1f', 'bd19df156e404d30a8621324ba6dac28', '2019-09-02 17:56:58.5896', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('036996d950bb435ea8ab0dbfc6601a1f', '6809bf495f874df08fcf1b8aa4392567', '2019-09-02 17:57:09.934253', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('36c762cc60ce428c8a5299c6dde33d9a', '7613aa1b39b54eb59d578373fde8b796', '2019-09-02 17:57:17.219025', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('6ea2399f48c44ab4b8f98e8802228102', '5c2eb7457f9644c281ed58f29ff4f2a6', '2019-09-02 17:57:31.648654', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('6742ac98bc004e3e814dbd415aa044f0', '1de376c52855446f98f0c8240d54557d', '2019-09-02 17:57:41.212473', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('121b9c018a734927bb9f7ad0702854d1', 'b4dd817d6d094d9082a656863dc3c5ca', '2019-09-02 17:57:53.355894', 1, NULL, '4c4cb24046f44b85bfc9f558c393508b', 0);
INSERT INTO public.switch_order VALUES ('40d5c3087b2d40418fd04aa0a8e85f2f', '7e84d623d55f41f9baea48afe37a7b76', '2019-09-03 08:02:01.667114', 1, NULL, '50ea8433a4334da8b70f4ddf3d568575', 0);
INSERT INTO public.switch_order VALUES ('482c28f146884056ac2dec7f68d01d50', '58c2d41670194a75a32bed762b864c28', '2019-09-02 17:06:14.787562', 2, '2019-09-03 08:02:53.43456', '50ea8433a4334da8b70f4ddf3d568575', 18);
INSERT INTO public.switch_order VALUES ('79298660e7364309b77d196b82bd410b', '23669db3c06841d18865aad1983914e0', '2019-09-03 08:51:50.900052', 1, NULL, '50ea8433a4334da8b70f4ddf3d568575', 0);
INSERT INTO public.switch_order VALUES ('1f09e13724c5462885f6b982fee47249', '2080707190e6480aa5a80834d337bbc3', '2019-08-29 16:31:19', 2, '2019-09-03 08:55:49.895368', '50ea8433a4334da8b70f4ddf3d568575', 54);


--
-- Data for Name: switch_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.switch_site VALUES ('2fb294bb2258ffd5bd7ecdad39851383', 121.36879999999999, 31.1188, '上海市2电站', 80);
INSERT INTO public.switch_site VALUES ('9b88728bf76143c7b984ed9de3ef2429', 115.84999999999999, 28.68, '南昌市第一换电站点', 50);
INSERT INTO public.switch_site VALUES ('90bd00e227174eb4a447630e7222668f', 120.15000000000001, 30.18, '杭州市换电分部', 50);
INSERT INTO public.switch_site VALUES ('ad6e0e8993bd7462d5860e0faf07e7a4', 121.47, 31.32, '上海市1电站', 100);
INSERT INTO public.switch_site VALUES ('b5c42b2aa3b44b80b5d2067343a7db8b', 116.40000000000001, 39.899999999999999, '北京市换电所', 100);
INSERT INTO public.switch_site VALUES ('bc00ccb9a7a5448ba1baefdadf037ebd', 104.06999999999999, 30.670000000000002, '成都1电站', 60);
INSERT INTO public.switch_site VALUES ('1590a939a2b243b6b1e6957eff0e7319', 108.93000000000001, 34.270000000000003, '西安秦始皇换电站', 50);
INSERT INTO public.switch_site VALUES ('f820320a4dd34187b715189178eb38f6', 114.3, 30.600000000000001, '武汉新电站', 100);
INSERT INTO public.switch_site VALUES ('c9e446cee2684bcaba11a85d623e99ad', 118.78, 32.07, '南京市换电中心', 40);


--
-- Data for Name: switch_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.switch_user VALUES ('4c4cb24046f44b85bfc9f558c393508b', '10086', '10086', '1');
INSERT INTO public.switch_user VALUES ('50ea8433a4334da8b70f4ddf3d568575', '1234', '1234', '1');
INSERT INTO public.switch_user VALUES ('4915cf5978ce4d91bdee4ca23beae369', '666', '666', '1');
INSERT INTO public.switch_user VALUES ('2e9c721d546543ccbb43778b236ac9d6', '777', '777', '1');


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.test VALUES (1, 'tom');
INSERT INTO public.test VALUES (2, 'jerry');
INSERT INTO public.test VALUES (3, 'uzi');
INSERT INTO public.test VALUES (4, 'jay');
INSERT INTO public.test VALUES (5, 'leo');
INSERT INTO public.test VALUES (6, 'mike');
INSERT INTO public.test VALUES (7, 'clearlove');
INSERT INTO public.test VALUES (8, 'john');
INSERT INTO public.test VALUES (9, 'sam');
INSERT INTO public.test VALUES (10, 'nancy');
INSERT INTO public.test VALUES (11, 'xiaoming');
INSERT INTO public.test VALUES (12, 'xiaohong');


--
-- Name: switch_box_box_number_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.switch_box_box_number_seq1', 15, true);


--
-- Name: switch_battery switch_battery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.switch_battery
    ADD CONSTRAINT switch_battery_pkey PRIMARY KEY (battery_id);


--
-- Name: switch_box switch_box_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.switch_box
    ADD CONSTRAINT switch_box_pkey PRIMARY KEY (box_id);


--
-- Name: switch_site switch_cabinet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.switch_site
    ADD CONSTRAINT switch_cabinet_pkey PRIMARY KEY (site_id);


--
-- Name: switch_order switch_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.switch_order
    ADD CONSTRAINT switch_order_pkey PRIMARY KEY (order_id);


--
-- Name: switch_user switch_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.switch_user
    ADD CONSTRAINT switch_user_pkey PRIMARY KEY (user_id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: switch_user_user_phone_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX switch_user_user_phone_idx ON public.switch_user USING btree (user_phone);


--
-- PostgreSQL database dump complete
--

