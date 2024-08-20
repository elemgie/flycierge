--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

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
-- Name: the_sequence; Type: SEQUENCE; Schema: public; Owner: flycierge_user
--

CREATE SEQUENCE public.the_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.the_sequence OWNER TO flycierge_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: airline; Type: TABLE; Schema: public; Owner: flycierge_user
--

CREATE TABLE public.airline (
    airline_id bigint DEFAULT nextval('public.the_sequence'::regclass) NOT NULL,
    name character varying(1024) NOT NULL,
    iata_code character(2) NOT NULL,
    icao_code character(3) NOT NULL,
    logo_url character varying(2048)
);


ALTER TABLE public.airline OWNER TO flycierge_user;

--
-- Name: airport; Type: TABLE; Schema: public; Owner: flycierge_user
--

CREATE TABLE public.airport (
    airport_id bigint DEFAULT nextval('public.the_sequence'::regclass) NOT NULL,
    name character varying(256) NOT NULL,
    city character varying(128) NOT NULL,
    country character varying(128) NOT NULL,
    country_code character varying(8) NOT NULL,
    iata_code character(3) NOT NULL,
    icao_code character(4) NOT NULL,
    longitude double precision,
    latitude double precision,
    time_zone_region_name character varying(64),
    search_count bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.airport OWNER TO flycierge_user;

--
-- Name: flight; Type: TABLE; Schema: public; Owner: flycierge_user
--

CREATE TABLE public.flight (
    flight_id bigint DEFAULT nextval('public.the_sequence'::regclass) NOT NULL,
    origin character(3) NOT NULL,
    destination character(3) NOT NULL,
    number character varying(16) NOT NULL,
    airline character varying(128) NOT NULL,
    start_date_time timestamp without time zone NOT NULL,
    landing_date_time timestamp without time zone NOT NULL,
    create_ts bigint DEFAULT EXTRACT(epoch FROM now()) NOT NULL
);


ALTER TABLE public.flight OWNER TO flycierge_user;

--
-- Name: itinerary; Type: TABLE; Schema: public; Owner: flycierge_user
--

CREATE TABLE public.itinerary (
    itinerary_id bigint DEFAULT nextval('public.the_sequence'::regclass) NOT NULL,
    create_ts bigint DEFAULT EXTRACT(epoch FROM now()) NOT NULL,
    flights_hash character varying(320)
);


ALTER TABLE public.itinerary OWNER TO flycierge_user;

--
-- Name: itinerary_flight; Type: TABLE; Schema: public; Owner: flycierge_user
--

CREATE TABLE public.itinerary_flight (
    itinerary_flight_id bigint DEFAULT nextval('public.the_sequence'::regclass) NOT NULL,
    itinerary_id bigint NOT NULL,
    flight_id bigint NOT NULL,
    is_return_flight boolean NOT NULL
);


ALTER TABLE public.itinerary_flight OWNER TO flycierge_user;

--
-- Name: price; Type: TABLE; Schema: public; Owner: flycierge_user
--

CREATE TABLE public.price (
    price_id bigint DEFAULT nextval('public.the_sequence'::regclass) NOT NULL,
    itinerary_id bigint NOT NULL,
    value real NOT NULL,
    currency character varying(8) NOT NULL,
    create_ts bigint DEFAULT EXTRACT(epoch FROM now()) NOT NULL
);


ALTER TABLE public.price OWNER TO flycierge_user;

--
-- Name: route_price_metric; Type: TABLE; Schema: public; Owner: flycierge_user
--

CREATE TABLE public.route_price_metric (
    route_price_metric_id bigint DEFAULT nextval('public.the_sequence'::regclass) NOT NULL,
    origin character(3) NOT NULL,
    destination character(3) NOT NULL,
    departure_date date NOT NULL,
    currency character varying(8) NOT NULL,
    one_way boolean NOT NULL,
    minimal_value real NOT NULL,
    first_quartile real NOT NULL,
    second_quartile real NOT NULL,
    third_quartile real NOT NULL,
    maximal_value real NOT NULL,
    create_ts bigint DEFAULT EXTRACT(epoch FROM now()) NOT NULL
);


ALTER TABLE public.route_price_metric OWNER TO flycierge_user;

--
-- Name: search; Type: TABLE; Schema: public; Owner: flycierge_user
--

CREATE TABLE public.search (
    search_id bigint DEFAULT nextval('public.the_sequence'::regclass) NOT NULL,
    origin character(3) NOT NULL,
    destination character(3) NOT NULL,
    departure_date timestamp without time zone NOT NULL,
    return_date timestamp without time zone,
    adult_number integer NOT NULL,
    create_ts bigint DEFAULT EXTRACT(epoch FROM now()) NOT NULL
);


ALTER TABLE public.search OWNER TO flycierge_user;

--
-- Data for Name: airline; Type: TABLE DATA; Schema: public; Owner: flycierge_user
--

COPY public.airline (airline_id, name, iata_code, icao_code, logo_url) FROM stdin;
7569	Cobra Aviation	0C	CBR	\N
7571	Premium Jet	0J	PJZ	\N
7572	VASCO	0V	VFC	\N
7573	Air Astra	2A	AWA	\N
7575	Air Burkina	2J	VBW	\N
7576	Avianca Ecuador	2K	GLG	\N
7577	TAB Airlines	2L	OAW	\N
7579	PAL Express	2P	GAP	\N
7581	World Cargo Airlines	3G	WCM	\N
7582	Air Inuit	3H	AIE	\N
7583	Jetstar Asia	3K	JSA	\N
7585	Silver Airways	3M	SIL	\N
7586	Air Urga	3N	URG	\N
7587	Air Arabia Maroc	3O	MAC	\N
7588	World2Fly Portugal	3P	WPT	\N
7589	Air Antilles	4I	GUY	\N
7590	Sichuan Airlines	3U	CSC	\N
7591	ASL Airlines Belgium	3V	TAY	\N
7592	Malawi Airlines	3W	MWI	\N
7593	Japan Air Commuter	JC	JAC	\N
7594	Everts Air Alaska	5V	VTS	\N
7595	Jetair Caribbean	4J	JRC	\N
7596	ATSA Airlines	4A	AMP	\N
7597	Air Kiribati	IK	AKL	\N
7599	LATAM Airlines Colombia	4C	ARE	\N
7600	FLYYO	4D	DIR	\N
7601	Stabo Air	4E	SBO	\N
7602	Gazpromavia	4G	GZP	\N
7603	Air North	4N	ANT	\N
7608	Airlink	4Z	LNK	\N
7609	Challenge Airlines IL	5C	ICL	\N
7610	Aeromexico Connect	5D	SLI	\N
7611	Cebu Pacific	5J	CEB	\N
7613	Smartavia	5N	AUL	\N
7614	ASL Airlines France	5O	FPO	\N
7615	Global Air Transport	5S	GAK	\N
7616	Canadian North	5T	AKT	\N
7617	UPS	5X	UPS	\N
7618	Atlas Air	5Y	GTI	\N
7619	Armenia Airways	6A	AMW	\N
7620	TUIfly Nordic	6B	BLX	\N
7621	Pelita Air Service	IP	PAS	\N
7622	IndiGo	6E	IGO	\N
7623	Southern Airways Express	9X	FDY	\N
7625	Israir	6H	ISR	\N
7626	Air Alsie	6I	MMD	\N
7627	Alrosa Air Company	6R	TNO	\N
7629	SmartLynx Latvia	6Y	ART	\N
7630	BBN Airlines Indonesia	7B	BBL	\N
7631	MASwings	MY	MWG	\N
7632	Jeju Air	7C	COY	\N
7634	Sylt Air	7E	AWU	\N
7635	StarFlyer	7G	SFJ	\N
7636	New Pacific Airlines	7H	RVF	\N
7637	Air Libya	7I	TLR	\N
7638	Tajik Air	7J	TJK	\N
7639	Silk Way West Airlines	7L	AZG	\N
7640	Smartwings Hungary	7O	TVL	\N
7641	RusLine	7R	RLU	\N
7642	Ryan Air	7S	RYA	\N
7643	Federal Airlines	7V	FDR	\N
7644	Windrose Airlines	7W	WRC	\N
7645	Mann Yadanarpon Airlines	7Y	MYP	\N
7647	FitsAir	8D	EXV	\N
7648	Bering Air	8E	BRG	\N
7649	STP Airways	8F	STP	\N
7650	K-Mile Asia	8K	KMI	\N
7651	Lucky Air	8L	LKE	\N
7652	Myanmar Airways International	8M	MMA	\N
7653	Pacific Coastal Airlines	8P	PCO	\N
7654	Air Tindi	8T	TIN	\N
7655	Afriqiyah Airways	8U	AAW	\N
7657	China Postal Airlines	CF	CYZ	\N
7658	Congo Airways	8Z	COG	\N
7659	Spring Airlines	9C	CQH	\N
7660	Genghis Khan Airlines	9D	NMG	\N
7661	Endeavor Air	9E	EDV	\N
7662	Air Changan	9H	CGN	\N
7663	Dana Air	9J	DAN	\N
7664	Cape Air	9K	KAP	\N
7665	Central Mountain Air	9M	GLR	\N
7666	Caicos Express Airways	9Q	CXE	\N
7667	Satena	9R	NSE	\N
7668	Avior Airlines	9V	ROI	\N
7669	National Airways	9Y	NAE	\N
7580	Moalem Aviation	2Y	MYU	\N
7671	Aegean Airlines	A3	AEE	\N
7673	Air Travel	A6	OTC	\N
7674	Georgian Airways	A9	TGZ	\N
7675	American Airlines	AA	AAL	\N
7676	Air Atlanta Europe	CT	AAE	\N
7677	Anguilla Air Services	Q3	AXL	\N
7678	Air Belgium	KF	ABB	\N
7680	Airblue	PA	ABQ	\N
7681	Air Canada	AC	ACA	\N
7656	Astral Aviation	8V	WRF	\N
7683	Azul	AD	AZU	\N
7684	Compass Cargo Airlines	HQ	ADZ	\N
7685	Mandarin Airlines	AE	MDA	\N
7686	Amelia International	NL	AEH	\N
7687	Aeroitalia	XZ	AEZ	\N
7688	Air France	AF	AFR	\N
7690	Africa World Airlines	AW	AFW	\N
7691	Aruba Airlines	AG	ARU	\N
7692	Air Algerie	AH	DAH	\N
7695	Amakusa Airlines	MZ	AHX	\N
7696	Air India	AI	AIC	\N
7697	Amelia	8R	AIA	\N
7698	Aero Contractors	N2	NIG	\N
7699	Aztec Airways	AJ	AZY	\N
7700	AJet	VF	TKJ	\N
7646	Ameristar Charters	7Z	EZR	\N
7605	Allied Air Cargo	4W	WAV	\N
7703	AirAsia	AK	AXM	\N
7704	Akasa Air	QP	AKJ	\N
7705	Aeromexico	AM	AMX	\N
7706	Jupiter Jet	IM	JPJ	\N
7707	Air Montenegro	4O	MNE	\N
7689	FlyArystan	FS	AFE	\N
7598	Boutique Air	4B	TUP	\N
7574	21 Air	2I	SRU	\N
7679	Enter Air	E4	ABJ	\N
7584	Hi Fly Malta	3L	ADY	\N
7672	Aerosucre Colombia	A4	AZO	\N
7612	Mel Air	5M	MNT	\N
7606	Avion Express Malta	4X	MEC	\N
7693	CM Airlines	H5	VJH	\N
7570	Rom Cargo Airlines	NJ	GMS	\N
7624	Aeroregional	6G	RLX	\N
7694	Sounds Air	S8	AHW	\N
7604	Xejet	4U	GWI	\N
7708	Advanced Air	AN	WSN	\N
7709	Aero Nomad Airlines	KA	ANK	\N
7710	YanAir	YE	ANR	\N
7711	PopulAir	HP	APF	\N
7712	Peach Aviation	MM	APJ	\N
7713	Air Peace	P4	APK	\N
7714	Alpavia	AL	APP	\N
7715	Air Premia	YP	APZ	\N
7716	9 Air	AQ	JYH	\N
7717	Aerolineas Argentinas	AR	ARG	\N
7719	Royal Air Maroc	AT	RAM	\N
7720	Aerotranscargo	F5	ATG	\N
7721	Air Transport International	8C	ATN	\N
7722	Asia Union Airlines	7Q	AUV	\N
7723	Avianca	AV	AVA	\N
7724	Titan Airways	ZT	AWC	\N
7725	Animawings	A2	AWG	\N
7726	Finnair	AY	FIN	\N
7728	ITA Airways	AZ	ITY	\N
7729	Zambia Airways	ZN	AZB	\N
7732	Belavia	B2	BRU	\N
7733	French Bee	BF	FBU	\N
7734	SkyAlps	BQ	SWU	\N
7735	Bees Airlines	E8	BES	\N
7736	Bhutan Airlines	B3	BTN	\N
7737	JetBlue	B6	JBU	\N
7738	Uni Air	B7	UIA	\N
7739	Eritrean Airlines	B8	ERT	\N
7740	Iran Airtour Airline	B9	IRB	\N
7741	British Airways	BA	BAW	\N
7743	Seaborne Airlines	BB	SBS	\N
7745	BBN Airlines	B5	BBT	\N
7746	Skymark Airlines	BC	SKY	\N
7748	Bluebird Nordic	BO	BBD	\N
7749	Biman Bangladesh Airlines	BG	BBC	\N
7607	Airbus Transport International	4Y	OCN	\N
7751	BH Air	8H	BGH	\N
7752	Budget Lines	BD	BGN	\N
7747	Buddha Air	U4	BCU	\N
7754	Royal Brunei Airlines	BI	RBA	\N
7755	Braathens International Airways	TT	BIX	\N
7756	Nouvelair Tunisie	BJ	LBT	\N
7757	Okay Airways	BK	OKA	\N
7758	Pacific Airlines	BL	PIC	\N
7759	Aero	5E	BLK	\N
7760	BermudAir	2T	BMA	\N
7761	Berniq Airways	NB	BNL	\N
7762	Bonza	AB	BNZ	\N
7763	AeroLogic	3S	BOX	\N
7764	Air Botswana	BP	BOT	\N
7765	BASe Airlines	RP	BPS	\N
7766	EVA Air	BR	EVA	\N
7767	Bridges Air Cargo	5B	BRD	\N
7768	US-Bangla Airlines	BS	UBG	\N
7769	Aerostan	KW	BSC	\N
7770	Air Baltic	BT	BTI	\N
7771	FlyCAA	BU	DBP	\N
7772	European Air Charter	H6	BUC	\N
7774	Caribbean Airlines	BW	BWA	\N
7775	Air Busan	BX	ABL	\N
7776	BeOnd	B4	BYD	\N
7744	Blue Dart Aviation	BZ	BBG	\N
7778	Ceiba Intercontinental	C2	CEL	\N
7779	Conquest Air	C4	QAI	\N
7780	CommuteAir	C5	UCA	\N
7781	Cinnamon Air	C7	CIN	\N
7784	Camair-Co	QC	CRC	\N
7785	Cardig Air	7D	CAD	\N
7786	Corendon Airlines	XC	CAI	\N
7783	Air China Cargo	CA	CCA	\N
7788	Air Atlanta Icelandic	CC	ABD	\N
7789	Alliance Air	9I	LLR	\N
7790	Chalair Aviation	CE	CLG	\N
7791	Air Century	Y2	CEY	\N
7792	PNG Air	CG	TOK	\N
7793	Air Guilin	GT	CGH	\N
7794	Colorful Guizhou Airlines	GY	CGZ	\N
7795	Bemidji Aviation	CH	BMJ	\N
7796	Challenge Air Cargo	X6	CHZ	\N
7797	China Airlines	CI	CAL	\N
7798	BA CityFlyer	CJ	CFE	\N
7799	Jetlines	AU	CJL	\N
7800	China Cargo Airlines	CK	CKK	\N
7801	Lufthansa CityLine	CL	CLH	\N
7802	Copa Airlines	CM	CMP	\N
7803	CMA CGM Air Cargo	2C	CMA	\N
7804	Camex Airlines	Z7	CMS	\N
7805	Grand China Air	CN	GDC	\N
7806	Corendon Dutch Airlines	CD	CND	\N
7807	North-Western Cargo International	CO	CNW	\N
7808	AlisCargo Airlines	CP	LSI	\N
7809	Aer Caribe Peru	EF	CPR	\N
7810	Coastal Aviation	CQ	CSV	\N
7811	Chongqing Airlines	OQ	CQN	\N
7782	Cronos Airlines	C8	ICV	\N
7814	Citilink	QG	CTV	\N
7816	Cubana de Aviacion	CU	CUB	\N
7817	Cargolux	CV	CLX	\N
7818	Air Chathams	3C	CVA	\N
7819	Crown Airlines	FQ	CWN	\N
7820	Cathay Pacific	CX	CPA	\N
7821	Comlux Aruba	CS	CXB	\N
7822	Corendon Airlines Europe	XR	CXI	\N
7823	Cyprus Airways	CY	CYP	\N
7824	Tus Airways	U8	CYF	\N
7825	China Southern Airlines	CZ	CSN	\N
7826	DHL Air UK	D0	DHK	\N
7827	Severstal Aircompany	D2	SSF	\N
7828	AeroDomca	DC	OLO	\N
7829	Fly Khiva	D3	DAO	\N
7831	Geo Sky	D4	GEL	\N
7832	DHL Aero Expreso	D5	DAE	\N
7833	Sunrise Airways (Dominicana)	D6	GCA	\N
7834	AirAsia X	D7	XAX	\N
7835	Norwegian Air Sweden	D8	NSZ	\N
7836	Daallo Airlines (Somalia)	D9	DMQ	\N
7837	Aerovias DAP	V5	DAP	\N
7838	Braathens Regional Airlines	TF	BRX	\N
7839	Nok Air	DD	NOK	\N
7840	Condor	DE	CFG	\N
7841	Cebgo	DG	SRQ	\N
7842	DHL Air Austria	Q7	DHA	\N
7843	La Compagnie	B0	DJT	\N
7718	Alpha Sky	AS	ASA	\N
7773	Libyan Express	LB	BVL	\N
7815	Trade Air	C3	CTW	\N
7731	Silk Way Airlines	ZP	AZP	\N
7730	Pivot Airlines	ZX	AZD	\N
7844	Sunclass Airlines	DK	VKG	\N
7845	Delta Air Lines	DL	DAL	\N
7847	Pobeda	DP	PBD	\N
7848	Ruili Airlines	DR	RLH	\N
7849	EasyJet Switzerland	DS	EZS	\N
7850	TAAG Angola Airlines	DT	DTA	\N
7851	Airzena	LV	DTG	\N
7852	SCAT Airlines	DV	VSV	\N
7853	Divi Divi Air	3R	DVR	\N
7854	Arajet	DM	DWI	\N
7855	Danish Air Transport	DX	DTR	\N
7857	Norwegian	DY	NOZ	\N
7858	Electra Airways	3E	EAF	\N
7859	Aer Lingus UK	EG	EUK	\N
7860	Avianca Express	EX	AVR	\N
7862	Estafeta Carga Aerea	E7	ESF	\N
7863	Emerald Airlines	EA	EAI	\N
7864	Elitavia Malta	MA	EAU	\N
7865	Wamos Air	EB	PLM	\N
7866	EcoJet	8J	ECO	\N
7867	AirExplore	ED	AXE	\N
7868	Fly Allways	8W	EDR	\N
7869	Edelweiss Air	WK	EDW	\N
7870	Xfly	EE	EST	\N
7871	BA EuroFlyer	A0	EFW	\N
7872	Clic Air	VE	EFY	\N
7873	ANA Wings	EH	AKX	\N
7874	Aer Lingus	EI	EIN	\N
7875	EasyJet Europe	EC	EJU	\N
7876	Emirates	EK	UAE	\N
7877	Empire Airlines	EM	CFS	\N
7878	Air Dolomiti	EN	DLA	\N
7880	Iran Aseman Airlines	EP	IRC	\N
7881	Donghai Airlines	DZ	EPA	\N
7883	Ethiopian Airlines	ET	ETH	\N
7882	Estelar	ES	DHX	\N
7885	Chengdu Airlines	EU	UEA	\N
7886	Iberojet (Spain)	E9	EVE	\N
7887	Eurowings	EW	EWG	\N
7861	Eurowings Europe	E6	BCT	\N
7889	Ewa Air	ZD	EWR	\N
7890	Etihad Airways	EY	ETD	\N
7891	Sun-Air	EZ	SUS	\N
7892	Safarilink	F2	XLK	\N
7893	Fanjet Express	7F	FJE	\N
7894	Flair Airlines	F8	FLE	\N
7895	Frontier Airlines	F9	FFT	\N
7896	Safair	FA	SFR	\N
7897	Flyadeal	F3	FAD	\N
7898	Bulgaria Air	FB	LZB	\N
7899	Nordic Regional Airlines	N7	FCM	\N
7900	Thai AirAsia	FD	AIQ	\N
7901	Fuji Dream Airlines	JH	FDA	\N
7902	Freedom Airline Express (Kenya)	4F	FDT	\N
7904	Ariana Afghan Airlines	FG	AFG	\N
7905	FTL Airlines	C0	FGO	\N
7906	Freebird Airlines Europe	MI	FHM	\N
7907	Freebird Airlines	FH	FHY	\N
7908	Icelandair	FI	ICE	\N
7909	FlyOne	5F	FIA	\N
7910	FlyOne Armenia	3F	FIE	\N
7911	Fiji Airways	FJ	FJI	\N
7912	Fly Jinnah	9P	FJL	\N
7913	Fastjet Zimbabwe	FN	FJW	\N
7914	Flightlink	YS	FLZ	\N
7915	Shanghai Airlines	FM	CSH	\N
7916	Sky Mali	ML	FML	\N
7917	Flybondi	FO	FBZ	\N
7918	FlyOne Romania	OE	FOE	\N
7919	Play	OG	FPY	\N
7920	Quikjet	QO	FQA	\N
7921	Ryanair	FR	RYR	\N
7922	Challenge Airlines BE	X7	CHG	\N
7923	FlyEgypt	FT	FEG	\N
7924	Fuzhou Airlines	FU	FZA	\N
7925	Rossiya Airlines	FV	SDM	\N
7926	ValueJet	VK	FVJ	\N
7927	Solenta Aviation Mozambique	FW	IBX	\N
7929	FedEx	FX	FDX	\N
7930	Firefly	FY	FFM	\N
7931	Flydubai	FZ	FDB	\N
7932	GullivAir	G2	GBG	\N
7934	Gol	G3	GLO	\N
7933	Costa Rica Green Airways	GW	GJT	\N
7936	Allegiant Air	G4	AAY	\N
7937	China Express Airlines	G5	HXA	\N
7938	GoJet Airlines	G7	GJS	\N
7939	Air Arabia	G9	ABY	\N
7940	Garuda Indonesia	GA	GIA	\N
7941	ABX Air	GB	ABX	\N
7942	Gulf Air	GF	GFA	\N
7943	Sky Lease Cargo	GG	KYE	\N
7846	Loong Air	GJ	DML	\N
7946	Airhub Airlines	RE	GJM	\N
7947	Jetstar Japan	GK	JJP	\N
7948	Air Greenland	GL	GRL	\N
7944	ULS Airlines Cargo	GO	GHN	\N
7951	Fly91	IC	GOA	\N
7952	GP Aviation	IV	GPX	\N
7953	Sky Express	GQ	SEH	\N
7954	Aurigny	GR	AUR	\N
7955	Tianjin Airlines	GS	GCR	\N
7956	Galistair	8S	GTR	\N
7957	Groupe Transair	R2	GTS	\N
7958	Avianca Guatemala	GU	GUG	\N
7959	Grant Aviation	GV	GUN	\N
7960	GX Airlines	GX	CBG	\N
7961	GlobalX	G6	GXA	\N
7962	Sky Airline	H2	SKU	\N
7963	Air Horizont	HT	CTJ	\N
7965	Heli Securite	HS	HLI	\N
7966	Sky Airline Peru	H8	SKX	\N
7967	Himalaya Airlines	H9	HIM	\N
7968	Hawaiian Airlines	HA	HAL	\N
7969	Air Do	HD	ADO	\N
7971	Hi Fly	5K	HFY	\N
7973	Greater Bay Airlines	HB	HGB	\N
7976	HelloJets	H3	HLJ	\N
7977	Air Seychelles	HM	SEY	\N
7978	Juneyao Air	HO	DKH	\N
7979	Air France Hop	A5	HOP	\N
7980	Hahn Air	HR	HHN	\N
7981	Heston Airlines	HN	HST	\N
7972	Hala Air	HG	HBN	\N
7983	Hainan Airlines	HU	CHH	\N
7984	Skybus Peru	HV	TRA	\N
7986	North Wright Airways	HW	NWL	\N
7987	Hong Kong Airlines	HX	CRK	\N
7988	Uzbekistan Airways	HY	UZB	\N
7989	HiSky	H7	HYM	\N
7974	Air Senegal	HC	HGO	\N
7949	Asia Cargo Airlines	GM	GSW	\N
7975	Humo Air	HJ	TMN	\N
7903	Air Flamenco	F4	FFA	\N
7990	HiSky Europe	H4	HYS	\N
7991	Hayways	Y5	HYY	\N
7992	Aurora Airlines	HZ	SHU	\N
7994	Iberia Express	I2	IBS	\N
7995	Island Air Express	I4	EXP	\N
7996	AIX Connect	I5	IAD	\N
7997	Izhavia	I8	IZA	\N
7998	Central Airlines	I9	HLF	\N
7999	Iraqi Airways	IA	IAW	\N
8000	IrAero	IO	IAE	\N
8001	Ibom Air	QI	IAN	\N
8002	Iberia	IB	IBE	\N
8003	Batik Air	ID	BTK	\N
8004	Solomon Airlines	IE	SOL	\N
8006	Georgian Airlines	GH	IGT	\N
8007	IBC Airways	II	CSQ	\N
8008	Interjet West	K8	IJW	\N
8009	Pegas Fly	EO	KAR	\N
8010	Zimex Aviation	XM	IMX	\N
8011	Nam Air	IN	LKN	\N
8012	IndiaOne Air	I7	IOA	\N
8013	Qazaq Air	IQ	QAZ	\N
8014	Iran Air	IR	IRA	\N
8015	Qeshm Air	QB	QSM	\N
8016	AirSwift	T6	ATX	\N
8017	Wings Air	IW	WON	\N
8018	Air India Express	IX	AXB	\N
8019	Yemenia	IY	IYE	\N
8020	Arkia	IZ	AIZ	\N
8021	Azerbaijan Airlines	J2	AHY	\N
8023	Armenian Airlines	JI	AAG	\N
8024	Starlux Airlines	JX	SJX	\N
8025	JetSmart Peru	JZ	JAP	\N
8026	Northwestern Air	J3	PLR	\N
8027	Buffalo Airways	J0	BFL	\N
8028	Badr Airlines	J4	BDR	\N
8029	Afrijet	J7	ABS	\N
8030	Berjaya Air	J8	BVT	\N
8031	Jazeera Airways	J9	JZR	\N
8032	TUIfly Belgium	TB	JAF	\N
8033	JetSmart Chile	JA	JAT	\N
8034	Jordan Aviation	R5	JAV	\N
8035	Capital Airlines	JD	CBJ	\N
8036	Jiangsu Jingdong Cargo Airlines	JG	JDL	\N
8037	JetSmart Colombia	J6	JEC	\N
8038	PSA Airlines	OH	JIA	\N
8039	LATAM Airlines Brasil	JJ	TAM	\N
8040	AerCaribe	JK	ACL	\N
8042	Jambojet	JM	JMA	\N
8043	Dan Air	DN	JOC	\N
8044	Jetstar	JQ	JST	\N
8045	Joy Air	JR	JOY	\N
8046	Air Koryo	JS	KOR	\N
8047	Lion Air	JT	LNI	\N
8048	Jettime	JP	JTD	\N
8041	Jet Linx Aviation	JL	JAL	\N
8050	Air Serbia	JU	ASL	\N
8052	Bearskin Airlines	JV	BLS	\N
8053	National Air Charters	JY	IWY	\N
8055	Safe Air (Kenya)	K3	TQN	\N
8057	Kalitta Air	K4	CKS	\N
8058	Cambodia Angkor Air	K6	KHV	\N
8059	KrasAvia	KV	SSJ	\N
8060	Drukair	KB	DRK	\N
8061	Mingalar	K7	KBZ	\N
8062	Air Astana	KC	KZR	\N
8063	Western Global Airlines	KD	WGN	\N
8064	Korean Air	KE	KAL	\N
8065	CemAir	5Z	KEM	\N
8066	KF Cargo	FK	KFA	\N
8068	Sapsan Airline	S2	KGB	\N
8069	Aloha Air Cargo	KH	AAH	\N
8070	Alexandria Airlines	DQ	KHH	\N
8071	Kalitta Charters II	K5	KII	\N
8072	Air Incheon	KJ	AIH	\N
8073	KLM	KL	KLM	\N
8074	KM Malta Airlines	KM	KMM	\N
8075	Cambodia Airways	KR	KME	\N
8076	China United Airlines	KN	CUA	\N
8077	ACE Air Cargo	KO	AER	\N
8078	Air Connect	KS	KON	\N
8079	ASKY	KP	SKK	\N
8080	Kenya Airways	KQ	KQA	\N
8082	AirAsia Cambodia	KT	KTC	\N
8084	Kuwait Airways	KU	KAC	\N
8085	Cayman Airways	KX	CAY	\N
8086	Kunming Airlines	KY	KNA	\N
8087	Nippon Cargo Airlines	KZ	NCA	\N
8088	Lynden Air Cargo	L2	LYC	\N
8089	LongJiang Airlines	LT	SNG	\N
8090	Lauda Europe	LW	LDA	\N
8091	DHL de Guatemala	L3	JOS	\N
8092	Red Air	L5	REA	\N
8093	Lulutai Airlines	L8	TON	\N
8094	LATAM Airlines	LA	LAN	\N
8095	LATAM Cargo Colombia	L7	LAE	\N
8096	Legend Airlines	LZ	LAL	\N
8097	LAS Cargo	4L	LAU	\N
8098	AlbaStar	AP	LAV	\N
8099	ECAir	EJ	EQR	\N
8100	TAR Aerolineas	YQ	LCT	\N
8101	Air Hong Kong	LD	AHK	\N
8102	Luxair	LG	LGL	\N
8103	Longtail Aviation	6T	LGT	\N
8104	Lufthansa	LH	DLH	\N
8105	Air Central	GI	LHA	\N
8106	Lufthansa City Airlines	VL	LHX	\N
8108	Fly Lili	FL	LIL	\N
8109	Lipican Aer	8I	LIP	\N
8110	Air Liaison	DU	LSJ	\N
8111	Jin Air	LJ	JNA	\N
8112	Lao Skyway	LK	LLL	\N
8113	Libyan Airlines	LN	LAA	\N
8114	LOT Polish Airlines	LO	LOT	\N
8115	Loganair	LM	LOG	\N
8117	LATAM Airlines Peru	LP	LPE	\N
8118	Avianca Costa Rica	LR	LRC	\N
8119	Jet2	LS	EXS	\N
8120	LanExpress	LU	LXP	\N
8121	Luxwing	BN	LWG	\N
8122	Lumiwings	L9	LWI	\N
8123	Swiss	LX	SWR	\N
8125	El Al	LY	ELY	\N
8126	Key Lime Air	KG	LYM	\N
8129	LATAM Cargo Brasil	M3	LTG	\N
8128	MHS Aviation	M2	MXS	\N
8107	Azul Conecta	2F	EZZ	\N
8116	Sky Cana	RD	LOL	\N
7993	Solinair	ZS	HZS	\N
8083	Safari Express Cargo	ZF	AZV	\N
8067	Tez Jet Airlines	K9	KFS	\N
8005	Gulf and Caribbean Cargo	IF	FBA	\N
8051	Almasria Universal Airlines	UJ	JUS	\N
8127	NG Eagle	2N	LYX	\N
8130	Kenmore Air	M5	KEN	\N
8131	Amerijet International	M6	AJT	\N
8132	Motor Sich	M9	MSI	\N
8133	Manta Air	NR	MAV	\N
8134	Air Mediterranean	MV	MAR	\N
8135	Mauritania Airlines	L6	MAI	\N
8136	Malta Air	MW	MAY	\N
8137	Chrono Jet	MB	MNB	\N
8139	Marabu Airlines	DI	MBU	\N
8140	United States Air Force - AMC	MC	RCH	\N
8142	Madagascar Airlines	MD	MGY	\N
8144	Middle East Airlines	ME	MEA	\N
8145	Xiamen Airlines	MF	CXA	\N
8146	My Freighter	C6	MFX	\N
8147	Mavi Gok Airlines	4M	MGH	\N
8148	Mongolian Airways	XF	MGW	\N
8149	Malaysia Airlines	MH	MAS	\N
8151	Myway Airlines	MJ	MYW	\N
8152	Air Mauritius	MK	MAU	\N
8154	Maleth-Aero	DB	MLT	\N
8156	Malta MedAir	MT	MMO	\N
8157	EuroAtlantic Airways	YU	MMZ	\N
8158	Aero Mongolia	M0	MNG	\N
8160	Medsky Airways	BM	MNS	\N
8161	Calm Air	MO	CAV	\N
8162	Martinair	MP	MPH	\N
8163	Envoy Air	MQ	ENY	\N
8164	EgyptAir	MS	MSR	\N
8165	Poste Air Cargo	M4	MSA	\N
8166	Air Cairo	SM	MSC	\N
8167	MetroJets	7N	MTD	\N
8168	Marathon Airlines	O8	MTO	\N
8169	China Eastern Airlines	MU	CES	\N
8170	Transair	R9	MUI	\N
8171	Modern Logistics	WD	MWM	\N
8159	Mexicana de Aviacion	XN	MNM	\N
8173	Batik Air Malaysia	OD	MXD	\N
8174	Maximus Airlines	6M	MXM	\N
8175	Breeze Airways	MX	MXY	\N
8176	MasAir	M7	MAA	\N
8177	Maya Island Air	2M	MYD	\N
8178	Nordica	ND	NDA	\N
8179	Nordwind Airlines	N4	NWS	\N
8180	Nolinor Aviation	N5	NRL	\N
8181	National Airlines	N8	NCR	\N
8183	Skypower Express Airways	NV	EAN	\N
8184	Norse Atlantic Airways	N0	NBT	\N
8185	Northern Air Cargo	NC	NAC	\N
8186	Nesma Airlines	NE	NMA	\N
8187	NovAir	NG	NAI	\N
8188	Leav Aviation	KK	NGN	\N
8189	Air Dilijans	RM	NGT	\N
8190	ANA	NH	ANA	\N
8191	Portugalia Airlines	NI	PGA	\N
8192	Niger Airlines	6N	NIN	\N
8193	Spirit Airlines	NK	NKS	\N
8182	Neos	NO	NAB	\N
8196	Nile Air	NP	NIA	\N
8197	Supernova Airlines	P7	NPG	\N
8198	AirJapan	NQ	AJX	\N
8199	Hebei Airlines	NS	HBH	\N
8200	Binter Canarias	NT	IBB	\N
8201	Air Moana	NM	NTR	\N
8204	Nomad Aviation	NA	NUM	\N
8205	North-West Air Company	0E	NWC	\N
8202	New Way Cargo Airlines	NU	JTA	\N
8207	Air Macau	NX	AMU	\N
8208	NyxAir	OJ	NYX	\N
8209	Air New Zealand	NZ	ANZ	\N
8210	Hopscotch Air	O2	HPK	\N
8194	Star Air	S5	NKP	\N
8212	Passion Air	OP	DIG	\N
8213	SF Airlines	O3	CSS	\N
8214	Olympic Air	OA	OAL	\N
7856	Omni Air International	OY	DXE	\N
8216	BoA	OB	BOV	\N
8217	Iberojet (Portugal)	6O	OBS	\N
8218	Oriental Air Bridge	OC	ORC	\N
8219	Hinterland Aviation	OI	HND	\N
8220	Overland Airways	OF	OLA	\N
8221	Czech Airlines	OK	CSA	\N
8222	Miat Mongolian Airlines	OM	MGL	\N
8223	Omni-Blu Aviation	O7	OMB	\N
8224	SalamAir	OV	OMS	\N
8226	Nauru Airlines	ON	RON	\N
8227	SkyWest Airlines	OO	SKW	\N
8228	TUIfly Netherlands	OR	TFL	\N
8229	Austrian	OS	AUA	\N
8230	OTT Airlines	JF	OTT	\N
8231	Croatia Airlines	OU	CTN	\N
8232	Air Europa Express	X5	OVA	\N
8233	Skyward Express	OW	SEW	\N
8235	Andes Lineas Aereas	O4	ANS	\N
8236	Fly Oya	YI	OYA	\N
8237	Asiana Airlines	OZ	AAR	\N
8238	Proflight Zambia	P0	PFZ	\N
8239	AirKenya Express	P2	XAK	\N
8241	VoePass	2Z	PTB	\N
8242	Porter Airlines	P3	PTR	\N
8243	Aerolineas Sosa	S0	NSO	\N
8244	Wingo	P5	RPB	\N
8245	Privilege Style	P6	PSC	\N
8247	Asia Pacific Airlines	P9	MGE	\N
8248	MAP Linhas Aereas	7M	PAM	\N
8249	Samoa Airways	OL	PAO	\N
8250	PAL Airlines	PB	PVL	\N
8251	Pegasus	PC	PGT	\N
8252	Porter Airlines	PD	POE	\N
8253	Piedmont Airlines	PT	PDT	\N
8254	Petroleum Air Services	UF	PER	\N
8255	People's	PE	PEV	\N
8256	Air Sial	PF	SIF	\N
8257	Bangkok Airways	PG	BKP	\N
8240	Phoenix Air Group	PH	PHA	\N
8259	Air Saint-Pierre	PJ	SPM	\N
8260	Pakistan International Airlines	PK	PIA	\N
8262	West Air	PN	CHB	\N
8263	Polar Air Cargo	PO	PAC	\N
8264	Jet Aviation Business Jets	PP	PJS	\N
8265	Philippine Airlines	PR	PAL	\N
8266	Pradhaan Air Express	6P	PRX	\N
8267	Ukraine International Airlines	PS	AUI	\N
8261	Prescott Support Company	PM	CNF	\N
8270	Air Panama	7P	PST	\N
8141	West Atlantic Sweden	T2	MCS	\N
8272	Plus Ultra	PU	PUE	\N
8273	St Barth Commuter	PV	SBU	\N
8274	Fly Pro	FP	PVV	\N
8155	Air Master	MR	MML	\N
8203	Business Aviation Asia	UN	NUA	\N
8275	Precision Air	PW	PRF	\N
8276	Air Niugini	PX	ANG	\N
8277	Surinam Airways	PY	SLM	\N
8278	LATAM Airlines Paraguay	PZ	LAP	\N
8279	Maldivian	Q2	DQA	\N
8280	Euroairlines	Q4	ELE	\N
8281	40-Mile Air	Q5	MLA	\N
8282	Skytrans	QN	SKP	\N
8283	Trans Air Congo	Q8	TSG	\N
8284	Green Africa Airways	Q9	GWG	\N
8285	Queen Bilqis Airways	QA	QBA	\N
8287	Express Freighters Australia	QE	EFA	\N
8288	Qantas	QF	QFA	\N
8289	Lift	GE	GBB	\N
8290	Bamboo Airways	QH	BAV	\N
8291	Jazz	QK	JZA	\N
8292	LASER Airlines	QL	LER	\N
8293	Qanot Sharq	HH	QNT	\N
8294	Alliance Airlines	QQ	UTY	\N
8295	Qatar Airways	QR	QTR	\N
8296	Smartwings	QS	TVS	\N
8297	Avianca Cargo	QT	TPA	\N
8298	Skyline Express Airline	QU	UTN	\N
8299	Lao Airlines	QV	LAO	\N
8300	Qingdao Airlines	QW	QDA	\N
8301	Horizon Air	QX	QXE	\N
8302	European Air Transport	QY	BCS	\N
8303	Indonesia AirAsia	QZ	AWQ	\N
8305	Yakutia Airlines	R3	SYL	\N
8306	DAT LT	R6	DNU	\N
8307	Nepal Airlines	RA	RNA	\N
8308	Rano Air	R4	RAN	\N
8309	Syrianair	RB	SYR	\N
8310	Air Arabia Egypt	E5	RBG	\N
8311	Atlantic Airways	RC	FLI	\N
8314	Regional Air Services	8N	REG	\N
8304	E-Cargo	RF	EOK	\N
8317	Aerus	ZV	RFD	\N
8318	Hong Kong Air Cargo	RH	HKC	\N
8319	Rimbun Air	RI	OEY	\N
8320	APG Airlines	GP	RIV	\N
8321	Royal Jordanian	RJ	RJA	\N
8322	Rotana Jet	RG	RJD	\N
8323	Ryanair UK	RK	RUK	\N
8324	Polar Airlines	PI	RKA	\N
8325	Sunlight Air	2R	RLB	\N
8327	Tarom	RO	ROT	\N
8328	Kam Air	RQ	KMF	\N
8329	Buzz	RR	RYS	\N
8331	Fly Red Sea	Z4	RSG	\N
8332	Red Sea Airlines	4S	RSX	\N
8333	Ifly	F7	RSY	\N
8334	DHL Ecuador	7T	RTM	\N
8335	AirBridgeCargo	RU	ABW	\N
8336	Rutaca	5R	RUC	\N
8337	ACT Air	9T	RUN	\N
8338	Air Canada Rouge	RV	ROU	\N
8339	Royal Air Philippines	RW	RYL	\N
8340	Jiangxi Air	RY	CJX	\N
8341	SANSA	RZ	LRS	\N
8342	Shree Airlines	N9	SHA	\N
8343	Azores Airlines	S4	RZO	\N
8344	Sunrise Airways (Haiti)	S6	KSZ	\N
8345	S7 Airlines	S7	SBI	\N
8346	South African Airways	SA	SAA	\N
8347	Aircalin	SB	ACI	\N
8348	Shandong Airlines	SC	CDG	\N
8349	SkyWest Charter	CW	SCW	\N
8350	Sudan Airways	SD	SUD	\N
8352	Sundair	SR	SDR	\N
8353	Star East Airline	4R	SEK	\N
8354	Serene Air	ER	SEP	\N
8355	SkyUp MT	U5	SEU	\N
8356	Tassili Airlines	SF	DTH	\N
8357	SpiceJet	SG	SEJ	\N
8358	SkyHigh Dominicana	DO	SHH	\N
8359	Sepehran Airlines	IS	SHI	\N
8360	Shirak Avia	5G	SHS	\N
8362	Sriwijaya Air	SJ	SJY	\N
8363	SKS Airways	KI	SJB	\N
8364	Spring Airlines Japan	IJ	SJO	\N
8365	Super Air Jet	IU	SJV	\N
8366	SAS	SK	SAS	\N
8368	Freedom Airline Express (Somalia)	4K	SMK	\N
8369	Somon Air	SZ	SMR	\N
8370	Brussels Airlines	SN	BEL	\N
8371	Air Cargo Carriers	2Q	SNC	\N
8372	Solaseed Air	6J	SNJ	\N
8374	SATA Air Acores	SP	SAT	\N
8361	Sierra Pacific Airlines	SI	BCI	\N
8376	Singapore Airlines	SQ	SIA	\N
8377	SkyUp Airlines	PQ	SQP	\N
8378	SprintAir	P8	SRN	\N
8379	Maersk Air Cargo	DJ	SRR	\N
8380	Southern Sky Airlines	IH	SRS	\N
8381	Sterling Airways	VC	SRY	\N
8382	Corsair	SS	CRL	\N
8384	St Barth Executive	LE	STB	\N
8385	Southwind Airlines	2S	STW	\N
8386	Aeroflot	SU	AFL	\N
8387	Saudia	SV	SVA	\N
8268	Sky Vision Airlines	SE	URO	\N
8389	Sunwing Airlines	WG	SWG	\N
8390	iAero Airways	WQ	SWQ	\N
8391	Swiftair	WT	SWT	\N
8393	Sun Country Airlines	SY	SCX	\N
8394	Eswatini Air	RN	SZL	\N
8367	SAS Connect	SL	TLM	\N
8397	Air Anka	6K	TAH	\N
8398	Eastern Airways	T3	EZE	\N
8399	Turkmenistan Airlines	T5	TUA	\N
8401	Terra Avia	T8	TVR	\N
8402	Avianca El Salvador	TA	TAI	\N
8403	Tbilisi Airways	TD	TBC	\N
8404	Air Tanzania	TC	ATC	\N
8406	SkyTaxi	TE	IGA	\N
8408	Thai Airways International	TG	THA	\N
8409	Trigana Air	IL	TGN	\N
8410	TAG Airlines	5U	TGU	\N
8411	Raya Airways	TH	RMY	\N
8400	Transcarga International Airways	T7	TJT	\N
8414	Tradewind Aviation	TJ	GPD	\N
8415	Turkish Airlines	TK	THY	\N
8416	Airnorth	TL	ANO	\N
8417	Titan Airways Malta	TM	LAM	\N
8420	Air Tahiti Nui	TN	THT	\N
8421	TransNusa	8B	TNU	\N
8422	Transavia France	TO	TVF	\N
8423	TUI Airways	BY	TOM	\N
8286	Thai VietJet Air	VZ	QCL	\N
8330	Asian Express Airline	RS	ASV	\N
8383	Air Thanlwin	ST	STT	\N
8424	FlyGTA Airlines	SX	TOR	\N
8425	Tropic Air	9N	TOS	\N
8426	AirTanker	9L	TOW	\N
8427	TAP Air Portugal	TP	TAP	\N
8428	Scoot	TR	TGW	\N
8429	Tarco Aviation	3T	TQQ	\N
8430	Air Transat	TS	TSC	\N
8432	Total Linhas Aereas	0T	TTL	\N
8433	Tigerair Taiwan	IT	TTW	\N
8434	Tunisair	TU	TAR	\N
8435	Tibet Airlines	TV	TBA	\N
8437	Smartwings Poland	3Z	TVP	\N
8438	Smartwings Slovakia	6D	TVQ	\N
8439	T'way Air	TW	TWB	\N
8412	Tailwind Airlines	TI	FTO	\N
8441	Air Caraibes	TX	FWI	\N
8443	Air Caledonie	TY	TPC	\N
8444	NordStar	Y7	TYA	\N
8445	Tsaradia	TZ	TDS	\N
8446	TCA	N6	TZS	\N
8447	EasyJet	U2	EZY	\N
8448	Sky Gates Airlines	U3	SAY	\N
8449	Ural Airlines	U6	SVR	\N
8450	Uniworld Air Cargo	U7	UCG	\N
8451	United Airlines	UA	UAL	\N
8452	Myanmar National Airlines	UB	UBA	\N
8453	UR Airlines	UD	UBD	\N
8454	Norse Atlantic UK	Z0	UBT	\N
8455	LATAM Cargo Chile	UC	LCO	\N
8456	Tunisair Express	UG	TUX	\N
8457	Auric Air	UI	AUK	\N
8459	Ultimate Air Shuttle	UE	UJC	\N
8460	Vistara	UK	VTI	\N
8461	SriLankan Airlines	UL	ALK	\N
8462	Air Zimbabwe	UM	AZW	\N
8464	HK Express	UO	HKE	\N
8465	Bahamasair	UP	BHS	\N
8466	Urumqi Air	UQ	CUH	\N
8467	Uganda Airlines	UR	UGD	\N
8468	Silk Avia	US	USA	\N
8470	USC	XG	USY	\N
8471	Utair	UT	UTA	\N
8472	Air Austral	UU	REU	\N
8473	Universal Airways	UV	UVA	\N
8474	Universal Air Charter and Management	VO	UVL	\N
8475	UVT Aero	RT	UVT	\N
8476	Air Europa	UX	AEA	\N
8477	Buraq Air	UZ	BRQ	\N
8478	Panorama Airways	5P	UZP	\N
8479	Air Samarkand	9S	UZS	\N
8480	Conviasa	V0	VCV	\N
8481	Vietravel Airlines	VU	VAG	\N
8482	Carpatair	V3	KRP	\N
8484	Iliamna Air Taxi	V8	VAS	\N
8486	Van Air Europe	V9	VAA	\N
8487	Virgin Australia	VA	VOZ	\N
8488	Fly2Sky	F6	VAW	\N
8489	VivaAerobus	VB	VIV	\N
8483	Vieques Air Link	V4	VEC	\N
8491	Volga-Dnepr	VI	VDA	\N
8492	VietJet Air	VJ	VJC	\N
8493	Max Air	VM	NGL	\N
8494	Vietnam Airlines	VN	HVN	\N
8496	Volaris Costa Rica	Q6	VOC	\N
8497	Volotea	V7	VOE	\N
8498	Volaris El Salvador	N3	VOS	\N
8499	Flyme	VP	VQI	\N
8500	Novoair	VQ	NVQ	\N
8501	Cabo Verde Airlines	VR	TCV	\N
8502	Air Cote D'Ivoire	HF	VRE	\N
8503	Virgin Atlantic	VS	VIR	\N
8504	Air Tahiti	VT	VTA	\N
8505	Contour Aviation	LF	VTE	\N
8506	Turpial Airlines	T9	VTU	\N
8507	Vueling	VY	VLG	\N
8508	FlexFlight	W2	FXT	\N
8495	Kargo Xpress	WW	VNE	\N
8510	Arik Air	W3	ARA	\N
8511	Mahan Air	W5	IRM	\N
8512	Wizz Air	W6	WZZ	\N
8513	Cargojet Airways	W8	CJT	\N
8514	Wizz Air UK	W9	WUK	\N
8515	KLM Cityhopper	WA	KLC	\N
8516	FlyNamibia	WV	WAA	\N
8518	Wizz Air Abu Dhabi	5W	WAZ	\N
8519	RwandAir	WB	RWD	\N
8520	Meregrass	WC	QHD	\N
8521	German Airways	ZQ	GER	\N
8522	WestJet Encore	WR	WEN	\N
8523	Rise Air	4T	WEW	\N
8524	Wideroe	WF	WIF	\N
8525	World2Fly	2W	WFL	\N
8526	White Airways	WI	WHT	\N
8527	Awesome Cargo	A7	WIN	\N
8528	JetSmart Argentina	WJ	JES	\N
8529	Winair	WM	WIA	\N
8530	Makers Air	W7	WMA	\N
8531	Wizz Air Malta	W4	WMT	\N
8532	Southwest Airlines	WN	SWA	\N
8533	WestJet	WS	WJA	\N
8534	Wasaya Airways	WP	WSG	\N
8535	Western Air	WU	WST	\N
8536	Swoop	WO	WSW	\N
8537	Wingo Panama	WH	WWP	\N
8538	CityJet	WX	BCY	\N
8539	Oman Air	WY	OMA	\N
8540	Red Wings Airlines	WZ	RWZ	\N
8541	TUIfly	X3	TUI	\N
8542	Avion Express	X9	NVD	\N
8543	ARINCDirect Flight Support Services	XA	XAA	\N
8544	Aerolink Uganda	A8	XAU	\N
8545	JSX Air	XE	JSX	\N
8547	Thai AirAsia X	XJ	TAX	\N
8548	Air Corsica	XK	CCM	\N
8549	LATAM Airlines Ecuador	XL	LNE	\N
8551	South East Asian Airlines (SEAIR)	XO	SGD	\N
8552	Avelo Airlines	XP	VXP	\N
8553	SunExpress	XQ	SXS	\N
8554	Express Air Cargo	7A	XRC	\N
8555	Flynas	XY	KNE	\N
8556	Volaris	Y4	VOI	\N
8557	Suparna Airlines	Y8	YZR	\N
8558	Yamal Airlines	YC	LLM	\N
8559	Ascend Airways	YD	SYG	\N
8560	YTO Cargo Airlines	YG	HYT	\N
8562	Libyan Wings	YL	LWA	\N
8563	Air Creebec	YN	CRQ	\N
8564	Scenic Airlines	YR	SCE	\N
8565	Yeti Airlines	YT	NYT	\N
8566	Mesa Airlines	YV	ASH	\N
8567	Air Nostrum	YW	ANE	\N
8568	Republic Airways	YX	RPA	\N
8569	Philippines AirAsia	Z2	APG	\N
8570	Avia Traffic Company	YK	AVJ	\N
8571	Sky Angkor Airlines	ZA	SWM	\N
8572	Air Albania	ZB	ABN	\N
8573	Eastar Jet	ZE	ESR	\N
8574	Zipair Tokyo	ZG	TZP	\N
8575	Shenzhen Airlines	ZH	CSZ	\N
8576	ZetAvia	ZK	ZAV	\N
8577	Regional Express	ZL	RXA	\N
8578	Zoom Air	ZO	ZOM	\N
8580	World Atlantic Airlines	WL	WAL	\N
8581	Aviacon Zitotrans	ZR	AZS	\N
8582	Sun Air Aviation	SO	SNR	\N
8583	Air Wisconsin	ZW	AWI	\N
8585	Eznis Airways	MG	EZA	\N
8586	China Air Cargo	ZY	CCO	\N
\.


--
-- Data for Name: airport; Type: TABLE DATA; Schema: public; Owner: flycierge_user
--

COPY public.airport (airport_id, name, city, country, country_code, iata_code, icao_code, longitude, latitude, time_zone_region_name, search_count) FROM stdin;
1	Anaa Airport	Anaa	French Polynesia	PF	AAA	NTGA	-145.50913	-17.355648	Pacific/Tahiti	0
2	Arrabury Airport	Arrabury	Australia	AU	AAB	YARY	141.047509	-26.691196	Australia/Brisbane	0
3	El Arish International Airport	El Arish	Egypt	EG	AAC	HEAR	33.832288	31.076415	Africa/Cairo	0
4	Rabah Bitat Airport	Annaba	Algeria	DZ	AAE	DABB	7.811857	36.821392	Africa/Algiers	0
5	Apalachicola Municipal Airport	Apalachicola	United States	US	AAF	KAAF	-84.983333	29.733333	America/New_York	0
6	Aachen/Merzbruck Airport	Aachen	Germany	DE	AAH	EDKA	6.186389	50.823055	Europe/Berlin	0
7	Arraias Airport	Arraias	Brazil	BR	AAI	SWRA	-46.933333	-12.916667	America/Belem	0
8	Aranuka Airport	Aranuka	Kiribati	KI	AAK	NGUK	173.583333	0.166667	Pacific/Tarawa	0
9	Aalborg Airport	Aalborg	Denmark	DK	AAL	EKYT	9.872241	57.086551	Europe/Copenhagen	0
10	Mala Mala Airport	Mala Mala	South Africa	ZA	AAM	FAMD	31.533333	-24.8	Africa/Johannesburg	0
11	Al Ain Airport	Al Ain	United Arab Emirates	AE	AAN	OMAL	55.616626	24.260231	Asia/Dubai	0
12	Anaco Airport	Anaco	Venezuela	VE	AAO	SVAN	-64.463889	9.431944	America/Caracas	0
13	Anapa Airport	Anapa	Russian Federation	RU	AAQ	URKA	37.346599	45.001659	Europe/Moscow	0
14	Aarhus Airport	Aarhus	Denmark	DK	AAR	EKAH	10.626351	56.30823	Europe/Copenhagen	0
15	Altay Airport	Altay	China	CN	AAT	ZWAT	88.084444	47.750361	Asia/Shanghai	0
16	Asau Airport	Asau	Samoa	WS	AAU	NSAU	-172.6	-13.458333	Pacific/Apia	0
17	Allah Valley Airport	Surallah	Philippines	PH	AAV	RPMA	124.752781	6.367314	Asia/Manila	0
18	Araxa Airport	Araxa	Brazil	BR	AAX	SBAX	-46.929167	-19.568056	America/Sao_Paulo	0
19	Al Ghaydah Airport	Al Ghaydah	Republic of Yemen	YE	AAY	OYGD	52.173255	16.195959	Asia/Aden	0
20	Quetzaltenango Airport	Quetzaltenango	Guatemala	GT	AAZ	MGQZ	-91.50194	14.86556	America/Guatemala	0
21	Abakan Airport	Abakan	Russian Federation	RU	ABA	UNAA	91.385002	53.740002	Asia/Krasnoyarsk	0
22	Asaba International Airport	Asaba	Nigeria	NG	ABB	DNAS	6.667222	6.203055	Africa/Lagos	0
23	Albacete Airport	Albacete	Spain and Canary Islands	ES	ABC	LEAB	-1.863333	38.948333	Europe/Madrid	0
24	Abadan Airport	Abadan	Iran	IR	ABD	OIAA	48.226598	30.363905	Asia/Tehran	0
25	Lehigh Valley International Airport	Allentown	United States	US	ABE	KABE	-75.434366	40.651573	America/New_York	0
26	Abaiang Airport	Abaiang	Kiribati	KI	ABF	NGAB	173.304167	1.670833	Pacific/Tarawa	0
27	Abingdon Airport	Abingdon	Australia	AU	ABG	YABI	143.2	-17.666667	Australia/Brisbane	0
28	Alpha Airport	Alpha	Australia	AU	ABH	YAPH	146.633333	-23.65	Australia/Brisbane	0
29	Abilene Regional Airport	Abilene	United States	US	ABI	KABI	-99.680052	32.412843	America/Chicago	0
30	Felix Houphouet Boigny Airport	Abidjan	Cote d'Ivoire	CI	ABJ	DIAP	-3.933015	5.254879	Africa/Abidjan	0
31	Kabri Dar Airport	Kabri Dar	Ethiopia	ET	ABK	HAKD	44.249676	6.733207	Africa/Addis_Ababa	0
32	Ambler Airport	Ambler	United States	US	ABL	PAFM	-157.845833	67.0875	America/Anchorage	0
33	Northern Peninsula Airport	Bamaga	Australia	AU	ABM	YNPE	142.450334	-10.942619	Australia/Brisbane	0
34	Aboisso Airport	Aboisso	Cote d'Ivoire	CI	ABO	DIAO	-3.216667	5.433333	Africa/Abidjan	0
35	Albuquerque International Sunport	Albuquerque	United States	US	ABQ	KABQ	-106.617193	35.049625	America/Denver	0
36	Aberdeen Regional Airport	Aberdeen	United States	US	ABR	KABR	-98.421829	45.44906	America/Chicago	0
37	Abu Simbel Airport	Abu Simbel	Egypt	EG	ABS	HEBL	31.609773	22.367567	Africa/Cairo	0
38	Al-Aqiq Airport	Al-Baha	Saudi Arabia	SA	ABT	OEBA	41.64002	20.294011	Asia/Riyadh	0
39	Haliwen Airport	Atambua	Indonesia	ID	ABU	WATA	124.906972	-9.075208	Asia/Makassar	0
40	Nnamdi Azikiwe International Airport	Abuja	Nigeria	NG	ABV	DNAA	7.270447	9.004614	Africa/Lagos	0
41	Albury Airport	Albury	Australia	AU	ABX	YMAY	146.954531	-36.069625	Australia/Sydney	0
42	Southwest Georgia Regional Airport	Albany	United States	US	ABY	KABY	-84.196111	31.532222	America/New_York	0
43	Aberdeen International Airport	Aberdeen	United Kingdom	GB	ABZ	EGPD	-2.204186	57.200253	Europe/London	0
44	Acapulco International Airport	Acapulco	Mexico	MX	ACA	MMAA	-99.754592	16.762403	America/Mexico_City	0
45	Antrim County Airport	Bellaire	United States	US	ACB	KACB	-85.216667	44.983333	America/New_York	0
46	Kotoka International Airport	Accra	Ghana	GH	ACC	DGAA	-0.171769	5.60737	Africa/Accra	0
47	Alcides Fernandez Airport	Acandi	Colombia	CO	ACD	SKAD	-77.3	8.516667	America/Bogota	0
48	Lanzarote Airport	Lanzarote	Spain and Canary Islands	ES	ACE	GCRR	-13.609059	28.950668	Atlantic/Canary	0
49	Altenrhein Airport	Altenrhein	Switzerland	CH	ACH	LSZR	9.566667	47.483333	Europe/Zurich	0
50	Alderney Airport	Alderney	United Kingdom	GB	ACI	EGJA	-2.21531	49.706717	Europe/London	0
51	Anuradhapura Airport	Anuradhapura	Sri Lanka	LK	ACJ	VCCA	80.383333	8.35	Asia/Colombo	0
52	Nantucket Memorial Airport	Nantucket	United States	US	ACK	KACK	-70.059722	41.256667	America/New_York	0
53	Aguaclara Airport	Aguaclara	Colombia	CO	ACL	SKAW	-73	4.75	America/Bogota	0
54	Ciudad Acuna International Airport	Ciudad Acuna	Mexico	MX	ACN	MMCC	-101.099371	29.332855	America/Matamoros	0
55	Araracuara Airport	Araracuara	Colombia	CO	ACR	SKAC	-72.399498	-0.600268	America/Bogota	0
56	Waco Municipal Airport	Waco	United States	US	ACT	KACT	-97.223217	31.609132	America/Chicago	0
57	Arcata-Eureka Airport	Arcata	United States	US	ACV	KACV	-124.106929	40.970912	America/Los_Angeles	0
58	Xingyi Airport	Xingyi	China	CN	ACX	ZUYI	104.959444	25.085556	Asia/Shanghai	0
59	Atlantic City International Airport	Atlantic City	United States	US	ACY	KACY	-74.572233	39.450701	America/New_York	0
60	Zabol Airport	Zabol	Iran	IR	ACZ	OIZB	61.542245	31.087694	Asia/Tehran	0
61	Adana Sakirpasa Airport	Adana	Turkiye	TR	ADA	LTAF	35.280391	36.982185	Europe/Istanbul	0
62	Izmir Adnan Menderes Airport	Izmir	Turkiye	TR	ADB	LTBJ	27.147594	38.294403	Europe/Istanbul	0
63	Addis Ababa Bole International Airport	Addis Ababa	Ethiopia	ET	ADD	HAAB	38.795899	8.983759	Africa/Addis_Ababa	0
64	Aden International Airport	Aden	Republic of Yemen	YE	ADE	OYAA	45.037535	12.826116	Asia/Aden	0
65	Adiyaman Airport	Adiyaman	Turkiye	TR	ADF	LTCP	38.266667	37.75	Europe/Istanbul	0
66	Lenawee County Airport	Adrian	United States	US	ADG	KADG	-84.033333	41.9	America/New_York	0
67	Aldan Airport	Aldan	Russian Federation	RU	ADH	UEEA	125.406095	58.601214	Asia/Yakutsk	0
68	Arandis Airport	Arandis	Namibia	NA	ADI	FYAR	15	-22.4	Africa/Windhoek	0
69	Marka International Airport	Amman	Jordan	JO	ADJ	OJAM	35.98277	31.97533	Asia/Amman	0
70	Adak Island Naval Station	Adak Island	United States	US	ADK	PADK	-176.644722	51.882778	America/Adak	0
71	Adelaide Airport	Adelaide	Australia	AU	ADL	YPAD	138.537351	-34.938176	Australia/Adelaide	0
72	Ardmore Municipal Airport	Ardmore	United States	US	ADM	KADM	-97.019444	34.303056	America/Chicago	0
73	Andamooka Airport	Andamooka	Australia	AU	ADO	YAMK	137.15	-31.016667	Australia/Adelaide	0
74	Ampara Airport	Gal Oya	Sri Lanka	LK	ADP	VCCG	81.626701	7.338118	Asia/Colombo	0
75	Kodiak Benny Benson State Airport	Kodiak	United States	US	ADQ	PADQ	-152.514408	57.753887	America/Anchorage	0
76	Andrews Airport	Andrews	United States	US	ADR	KPHH	-79.566667	33.45	America/New_York	0
77	Dallas Addison Airport	Dallas	United States	US	ADS	KADS	-96.842922	32.966626	America/Chicago	0
78	Ada Airport	Ada	United States	US	ADT	KADH	-96.666667	34.8	America/Chicago	0
79	Ardabil Airport	Ardabil	Iran	IR	ADU	OITL	48.42125	38.323826	Asia/Tehran	0
80	Andrews Air Force Base	Camp Springs	United States	US	ADW	KADW	-76.866667	38.816667	America/New_York	0
81	Leuchars Airport	Saint Andrews	United Kingdom	GB	ADX	EGQL	-2.866667	56.366667	Europe/London	0
82	Alldays Airport	Alldays	South Africa	ZA	ADY	FAAL	29.05	-22.666667	Africa/Johannesburg	0
83	Gustavo Rojas Pinilla Airport	San Andres Island	Colombia	CO	ADZ	SKSP	-81.702208	12.586047	America/Bogota	0
84	Abemama Atoll Airport	Abemama Atoll	Kiribati	KI	AEA	NGTB	173.85	0.483333	Pacific/Tarawa	0
85	Baise Bama Airport	Baise	China	CN	AEB	ZGBS	106.967772	23.719469	Asia/Shanghai	0
86	Aek Godang Airport	South Tapanuli Regency	Indonesia	ID	AEG	WIME	99.430407	1.400148	Asia/Jakarta	0
87	Abecher Airport	Abecher	Chad	TD	AEH	FTTC	20.850833	13.851389	Africa/Ndjamena	0
88	Albert Lea Airport	Albert Lea	United States	US	AEL	KAEL	-93.366667	43.65	America/Chicago	0
89	Aioun El Atrouss Airport	Aioun El Atrouss	Mauritania	MR	AEO	GQNA	-9.635556	16.709167	Africa/Nouakchott	0
90	Buenos Aires Jorge Newbery Airfield	Buenos Aires	Argentina	AR	AEP	SABE	-58.41667	-34.556221	America/Argentina/Buenos_Aires	0
91	Sochi International Airport	Adler/Sochi	Russian Federation	RU	AER	URSS	39.941106	43.44884	Europe/Moscow	0
92	Vigra Alesund Airport	Aalesund	Norway	NO	AES	ENAL	6.116605	62.559644	Europe/Oslo	0
93	Abu Musa Airport	Abu Musa	Iran	IR	AEU	OIBA	55.033913	25.875475	Asia/Tehran	0
94	Alexandria International Airport	Alexandria	United States	US	AEX	KAEX	-92.542568	31.322573	America/Chicago	0
95	Akureyri Airport	Akureyri	Iceland	IS	AEY	BIAR	-18.075068	65.654567	Atlantic/Reykjavik	0
96	San Rafael Airport	San Rafael	Argentina	AR	AFA	SAMR	-68.400556	-34.589167	America/Argentina/Buenos_Aires	0
97	Port Alfred Airport	Port Alfred	South Africa	ZA	AFD	FAPA	26.883333	-33.583333	Africa/Johannesburg	0
98	United States Air Force Academy Airport	Colorado Springs	United States	US	AFF	KAFF	-104.822	38.972	America/Denver	0
99	Amalfi Airport	Amalfi	Colombia	CO	AFI	SKAM	-75.066667	6.916667	America/Bogota	0
100	Alta Floresta Airport	Alta Floresta	Brazil	BR	AFL	SBAT	-56.104768	-9.872456	America/Campo_Grande	0
101	Jaffrey Municipal Airport	Jaffrey	United States	US	AFN	KAFN	-72.066667	42.833333	America/New_York	0
102	Afton Municipal Airport	Afton	United States	US	AFO	KAFO	-110.933333	42.733333	America/Denver	0
103	Zarafshan Airport	Zarafshan	Uzbekistan	UZ	AFS	USTN	64.233056	41.613611	Asia/Tashkent	0
104	Afutara Aerodrome	Afutara	Solomon Islands	SB	AFT	AGAF	160.85	-9.2	Pacific/Guadalcanal	0
105	Fort Worth Alliance Airport	Fort Worth	United States	US	AFW	KAFW	-97.315295	32.985651	America/Chicago	0
106	Afyon Airport	Afyon	Turkiye	TR	AFY	LTAH	30.6	38.733333	Europe/Istanbul	0
107	Sabzevar Airport	Sabzevar	Iran	IR	AFZ	OIMS	57.60332	36.171512	Asia/Tehran	0
108	Agadir Al Massira Airport	Agadir	Morocco	MA	AGA	GMAD	-9.410592	30.328562	Africa/Casablanca	0
109	Augsburg Airport	Augsburg	Germany	DE	AGB	EDMA	10.931667	48.425278	Europe/Berlin	0
110	Allegheny County Airport	Pittsburgh	United States	US	AGC	KAGC	-79.93	40.354722	America/New_York	0
111	Anggi Airport	Anggi	Indonesia	ID	AGD	WAUA	133.866667	-1.383333	Asia/Jayapura	0
112	Flugplatz Airport	Wangerooge	Germany	DE	AGE	EDWG	7.916667	53.783333	Europe/Berlin	0
113	La Garenne Airport	Agen	France	FR	AGF	LFBA	0.598611	44.173611	Europe/Paris	0
114	Angelholm Helsingborg Airport	Angelholm/Helsingborg	Sweden	SE	AGH	ESTA	12.867092	56.287066	Europe/Stockholm	0
115	Wageningen Airport	Wageningen	Suriname	SR	AGI	SMWA	-56.833333	5.833333	America/Paramaribo	0
116	Aguni Airport	Aguni	Japan	JP	AGJ	RORA	127.238056	26.589722	Asia/Tokyo	0
117	Ammassalik Heliport	Tasiilaq	Greenland	GL	AGM	BGAM	-37.61831	65.612256	America/Godthab	0
118	Angoon Seaplane Base	Angoon	United States	US	AGN	PAGN	-134.568858	57.496784	America/Anchorage	0
119	Magnolia Municipal Airport	Magnolia	United States	US	AGO	KAGO	-93.233333	33.266667	America/Chicago	0
120	Manaoba Airport	Malaita	Solomon Islands	SB	MHM	AGOB	160.79528	-8.32167	Pacific/Guadalcanal	0
121	Malaga-Costa del Sol Airport	Malaga	Spain and Canary Islands	ES	AGP	LEMG	-4.489616	36.675181	Europe/Madrid	0
122	Agrinion Airport	Agrinion	Greece	GR	AGQ	LGAG	21.351944	38.604167	Europe/Athens	0
123	Kheria Airport	Agra	India	IN	AGR	VIAG	77.962778	27.158333	Asia/Kolkata	0
124	Augusta Regional Airport	Augusta	United States	US	AGS	KAGS	-81.973438	33.373666	America/New_York	0
125	Guarani International Airport	Ciudad del Este	Paraguay	PY	AGT	SGES	-54.843581	-25.455507	America/Asuncion	0
126	Jesus Teran Peredo International Airport	Aguascalientes	Mexico	MX	AGU	MMAS	-102.317818	21.705535	America/Mexico_City	0
127	Acarigua Airport	Acarigua	Venezuela	VE	AGV	SVAC	-69.233333	9.552222	America/Caracas	0
128	Agnew Airport	Agnew	Australia	AU	AGW	YAGN	142.15	-12.15	Australia/Brisbane	0
129	Agatti Island Airport	Agatti Island	India	IN	AGX	VOAT	72.179874	10.828967	Asia/Kolkata	0
130	Aggeneys Airport	Aggeneys	South Africa	ZA	AGZ	FAAG	18.85	-29.05	Africa/Johannesburg	0
131	Abha Regional Airport	Abha	Saudi Arabia	SA	AHB	OEAB	42.657575	18.23429	Asia/Riyadh	0
132	Amedee Army Air Field	Herlong	United States	US	AHC	KAHC	-120.133333	40.15	America/Los_Angeles	0
133	Amery Municipal Airport	Amery	United States	US	AHH	KAHH	-92.35	45.3	America/Chicago	0
134	Amahai Airport	Amahai	Indonesia	ID	AHI	WAPA	128.916667	-3.333333	Asia/Jayapura	0
135	Aishalton Airport	Aishalton	Guyana	GY	AHL	SYAH	-59.316667	2.483333	America/Guyana	0
136	Athens-Ben Epps Airport	Athens	United States	US	AHN	KAHN	-83.324725	33.951951	America/New_York	0
137	Alghero-Fertilia Airport	Alghero	Italy	IT	AHO	LIEA	8.295891	40.630405	Europe/Rome	0
138	Charif Al Idrissi Airport	Al Hoceima	Morocco	MA	AHU	GMTA	-3.836944	35.179722	Africa/Casablanca	0
139	Alliance Airport	Alliance	United States	US	AIA	KAIA	-102.806667	42.051667	America/Denver	0
140	Anderson Municipal Airport	Anderson	United States	US	AID	KAID	-85.683333	40.166667	America/Indiana/Indianapolis	0
141	Assis Airport	Assis	Brazil	BR	AIF	SBAS	-50.416667	-22.666667	America/Sao_Paulo	0
142	Yalinga Airport	Yalinga	Central African Republic	CF	AIG	FEFY	23.25	6.516667	Africa/Bangui	0
143	Ali-Sabieh Airport	Ali-Sabieh	Djibouti	DJ	AII	HDAS	42.716667	11.15	Africa/Djibouti	0
144	Aiken Municipal Airport	Aiken	United States	US	AIK	KAIK	-81.684066	33.649014	America/New_York	0
145	Wainwright Airport	Wainwright	United States	US	AIN	PAWT	-160.033333	70.633333	America/Anchorage	0
146	Atlantic Municipal Airport	Atlantic	United States	US	AIO	KAIO	-95.016667	41.4	America/Chicago	0
147	Adampur Airport	Adampur	India	IN	AIP	VIAX	75.760556	31.433056	Asia/Kolkata	0
148	Arorae Island Airport	Arorae Island	Kiribati	KI	AIS	NGTR	176.833333	-2.65	Pacific/Tarawa	0
149	Aitutaki Airport	Aitutaki	Cook Islands	CK	AIT	NCAI	-159.766992	-18.829443	Pacific/Rarotonga	0
150	Atiu Island Airport	Atiu Island	Cook Islands	CK	AIU	NCAT	-158.119014	-19.967872	Pacific/Rarotonga	0
151	George Downer Airport	Aliceville	United States	US	AIV	KAIV	-88.15	33.133333	America/Chicago	0
152	Ai-Ais Airport	Ai-Ais	Namibia	NA	AIW	FYAA	17.583333	-27.983333	Africa/Windhoek	0
153	Lee C Fine Memorial Airport	Kaiser/Lake Ozark	United States	US	AIZ	KAIZ	-92.547222	38.098333	America/Chicago	0
154	Ajaccio Napoleon Bonaparte Airport	Ajaccio	France	FR	AJA	LFKJ	8.794013	41.919867	Europe/Paris	0
155	Jouf Airport	Jouf	Saudi Arabia	SA	AJF	OESK	40.101486	29.788668	Asia/Riyadh	0
156	Agri Airport	Agri	Turkiye	TR	AJI	LTCO	43.025	39.65	Europe/Istanbul	0
157	Akjoujt Airport	Akjoujt	Mauritania	MR	AJJ	GQNJ	-14.374444	19.730556	Africa/Nouakchott	0
158	Arak Airport	Arak	Iran	IR	AJK	OIHR	49.842483	34.134875	Asia/Tehran	0
159	Aizawl Airport	Aizawl	India	IN	AJL	VELP	92.624815	23.838986	Asia/Kolkata	0
160	Ouani Airport	Anjouan	Comoros	KM	AJN	FMCV	44.430473	-12.131109	Indian/Comoro	0
161	Arvidsjaur Airport	Arvidsjaur	Sweden	SE	AJR	ESNX	19.285556	65.591389	Europe/Stockholm	0
162	Aracaju Airport	Aracaju	Brazil	BR	AJU	SBAR	-37.072791	-10.987206	America/Belem	0
163	Manu Dayak International Airport	Agades	Niger	NE	AJY	DRZA	7.993056	16.964167	Africa/Niamey	0
164	Atka Airport	Atka	United States	US	AKB	PAAK	-174.206194	52.220583	America/Adak	0
165	Akron Fulton International Airport	Akron	United States	US	AKC	KAKR	-81.468098	41.035899	America/New_York	0
166	Akola Airport	Akola	India	IN	AKD	VAAK	77.083333	20.666667	Asia/Kolkata	0
167	Kufra Airport	Kufra	Libya	LY	AKF	HLKF	23.320841	24.183924	Africa/Tripoli	0
168	Prince Sultan Air Base	Al Kharj	Saudi Arabia	SA	AKH	OEPS	47.580556	24.063333	Asia/Riyadh	0
169	Akiak Airport	Akiak	United States	US	AKI	PFAK	-161.223333	60.905556	America/Anchorage	0
170	Asahikawa Airport	Asahikawa	Japan	JP	AKJ	RJEC	142.454546	43.671091	Asia/Tokyo	0
171	Akhiok Sea Plane Base	Akhiok	United States	US	AKK	PAKH	-154.166667	56.944444	America/Anchorage	0
172	Auckland Airport	Auckland	New Zealand	NZ	AKL	NZAA	174.783524	-37.004786	Pacific/Auckland	0
173	King Salmon Airport	King Salmon	United States	US	AKN	PAKN	-156.669016	58.682741	America/Anchorage	0
174	Washington County Airport	Akron	United States	US	AKO	KAKO	-103.216667	40.166667	America/Denver	0
175	Anaktuvuk Airport	Anaktuvuk	United States	US	AKP	PAKP	-151.74	68.1375	America/Anchorage	0
176	Gunung Batin Airport	Astraksetra	Indonesia	ID	AKQ	WILM	105.233333	-4.616667	Asia/Jakarta	0
177	Akure Airport	Akure	Nigeria	NG	AKR	DNAK	5.300223	7.250303	Africa/Lagos	0
178	Gwaunaru'u Airport	Auki	Solomon Islands	SB	AKS	AGGA	160.681469	-8.70428	Pacific/Guadalcanal	0
179	Akrotiri RAF Station	Akrotiri	Cyprus	CY	AKT	LCRA	32.987887	34.590395	Asia/Nicosia	0
180	Aksu Airport	Aksu	China	CN	AKU	ZWAK	80.292618	41.259984	Asia/Shanghai	0
181	Akulivik Airport	Akulivik	Canada	CA	AKV	CYKO	-78.583333	60.733333	America/Toronto	0
182	Aghajari Airport	Aghajari	Iran	IR	AKW	OIAG	49.683333	30.75	Asia/Tehran	0
183	Aktobe Airport	Aktobe	Kazakhstan	KZ	AKX	UATT	57.211403	50.249336	Asia/Aqtobe	0
184	Civil Airport	Sittwe	Myanmar	MM	AKY	VYSW	92.880278	20.130278	Asia/Yangon	0
185	Almaty International Airport	Almaty	Kazakhstan	KZ	ALA	UAAA	77.037091	43.35136	Asia/Almaty	0
186	Albany International Airport	Albany	United States	US	ALB	KALB	-73.809556	42.745279	America/New_York	0
187	Alicante-Elche Miguel Hernandez Airport	Alicante	Spain and Canary Islands	ES	ALC	LEAL	-0.557381	38.287098	Europe/Madrid	0
188	Alerta Airport	Alerta	Peru	PE	ALD	SPAR	-69.333333	-11.683333	America/Lima	0
189	Alta Airport	Alta	Norway	NO	ALF	ENAT	23.355809	69.977167	Europe/Oslo	0
190	Algiers Houari Boumediene Airport	Algiers	Algeria	DZ	ALG	DAAG	3.207136	36.697892	Africa/Algiers	0
191	Albany Airport	Albany	Australia	AU	ALH	YABA	117.804001	-34.944997	Australia/Perth	0
192	Alice International Airport	Alice	United States	US	ALI	KALI	-98.026901	27.7409	America/Chicago	0
193	Alexander Bay Airport	Alexander Bay	South Africa	ZA	ALJ	FAAB	16.53333	-28.574996	Africa/Johannesburg	0
194	Albenga Airport	Albenga	Italy	IT	ALL	LIMG	8.216667	44.05	Europe/Rome	0
195	Alamogordo Municipal Airport	Alamogordo	United States	US	ALM	KALM	-105.985278	32.845833	America/Denver	0
196	St. Louis Regional Airport	Alton	United States	US	ALN	KALN	-90.048333	38.891667	America/Chicago	0
197	Waterloo Airport	Waterloo	United States	US	ALO	KALO	-92.399722	42.556111	America/Chicago	0
198	Aleppo International Airport	Aleppo	Syrian Arab Republic	SY	ALP	OSAP	37.227073	36.185351	Asia/Damascus	0
199	Federal Airport	Alegrete	Brazil	BR	ALQ	SSAL	-55.763333	-29.799722	America/Sao_Paulo	0
200	Alexandra Airport	Alexandra	New Zealand	NZ	ALR	NZLX	169.369444	-45.213889	Pacific/Auckland	0
201	Alamosa Municipal Airport	Alamosa	United States	US	ALS	KALS	-105.866667	37.436667	America/Denver	0
202	Alula Airport	Alula	Somalia	SO	ALU	HCMA	50.8	11.966667	Africa/Mogadishu	0
203	Walla Walla Airport	Walla Walla	United States	US	ALW	KALW	-118.291111	46.094722	America/Los_Angeles	0
204	Thomas C Russell Field	Alexander City	United States	US	ALX	KALX	-85.95	32.933333	America/Chicago	0
205	El Nohza Airport	Alexandria	Egypt	EG	ALY	HEAX	29.953059	31.192545	Africa/Cairo	0
206	Rick Husband Amarillo International Airport	Amarillo	United States	US	AMA	KAMA	-101.705134	35.218274	America/Chicago	0
207	Ambilobe Airport	Ambilobe	Madagascar	MG	AMB	FMNE	48.983333	-13.183333	Indian/Antananarivo	0
208	Am Timan Airport	Am Timan	Chad	TD	AMC	FTTN	20.283333	11.033333	Africa/Ndjamena	0
209	Ahmedabad Airport	Ahmedabad	India	IN	AMD	VAAH	72.624167	23.066389	Asia/Kolkata	0
210	Arba Mintch Airport	Arba Mintch	Ethiopia	ET	AMH	HAAM	37.576944	6.036111	Africa/Addis_Ababa	0
211	Selaparang Airport	Mataram	Indonesia	ID	AMI	WRRA	116.102375	-8.563165	Asia/Makassar	0
212	Almenara Airport	Almenara	Brazil	BR	AMJ	SNAR	-40.683333	-16.183333	America/Sao_Paulo	0
213	Queen Alia International Airport	Amman	Jordan	JO	AMM	OJAI	35.989318	31.722535	Asia/Amman	0
214	Gratiot Community Airport	Alma	United States	US	AMN	KAMN	-84.65	43.383333	America/New_York	0
215	Mao Airport	Mao	Chad	TD	AMO	FTTU	15.316667	14.116667	Africa/Ndjamena	0
216	Ampanihy Airport	Ampanihy	Madagascar	MG	AMP	FMSY	44.733333	-24.7	Indian/Antananarivo	0
217	Pattimura Airport	Ambon	Indonesia	ID	AMQ	WAPP	128.088876	-3.704996	Asia/Jayapura	0
218	Amsterdam Schiphol Airport	Amsterdam	Netherlands	NL	AMS	EHAM	4.763385	52.309069	Europe/Amsterdam	0
219	Amata Airport	Amata	Australia	AU	AMT	YAMT	132.033333	-26.766667	Australia/Darwin	0
220	Amderma Airport	Amderma	Russian Federation	RU	AMV	ULDD	61.574462	69.761503	Europe/Moscow	0
221	Ames Airport	Ames	United States	US	AMW	KAMW	-93.618333	41.994167	America/Chicago	0
222	Ammaroo Airport	Ammaroo	Australia	AU	AMX	YAMM	135.24	-21.74	Australia/Darwin	0
223	Ardmore Airport	Ardmore	New Zealand	NZ	AMZ	NZAR	174.975362	-37.029957	Pacific/Auckland	0
224	Anniston Regional Airport	Anniston	United States	US	ANB	KANB	-85.8581	33.588193	America/Chicago	0
225	Ted Stevens Anchorage International Airport	Anchorage	United States	US	ANC	PANC	-149.996389	61.174444	America/Anchorage	0
226	Anderson Airport	Anderson	United States	US	AND	KAND	-82.71	34.493611	America/New_York	0
227	Angers-Marce Airport	Angers	France	FR	ANE	LFJR	-0.312245	47.560351	Europe/Paris	0
228	Cerro Moreno International Airport	Antofagasta	Chile	CL	ANF	SCFA	-70.440789	-23.449	America/Santiago	0
229	Brie-Champniers Airport	Angouleme	France	FR	ANG	LFBU	0.218923	45.727359	Europe/Paris	0
230	Aniak Airport	Aniak	United States	US	ANI	PANI	-159.536971	61.574399	America/Anchorage	0
231	Zanaga Airport	Zanaga	Congo	CG	ANJ	FCBZ	13.833333	-2.85	Africa/Brazzaville	0
232	Etimesgut Airport	Ankara	Turkiye	TR	ANK	LTAD	32.689136	39.950283	Europe/Istanbul	0
233	Antsirabato Airport	Antalaha	Madagascar	MG	ANM	FMNH	50.320257	-14.999396	Indian/Antananarivo	0
234	Annette Island Airport	Annette Island	United States	US	ANN	PANT	-131.570556	55.036944	America/Anchorage	0
235	Angoche Airport	Angoche	Mozambique	MZ	ANO	FQAG	39.936944	-16.177778	Africa/Maputo	0
236	Lee Airport	Annapolis	United States	US	ANP	KANP	-76.5	38.983333	America/New_York	0
237	Tri-State Steuben County Airport	Angola	United States	US	ANQ	KANQ	-85	41.633333	America/Indiana/Indianapolis	0
238	Antwerp International Airport	Antwerp	Belgium	BE	ANR	EBAW	4.450672	51.18916	Europe/Brussels	0
239	Andahuaylas Airport	Andahuaylas	Peru	PE	ANS	SPHY	-73.355833	-13.716667	America/Lima	0
240	V.C. Bird International Airport	Antigua	Antigua and Barbuda	AG	ANU	TAPA	-61.791717	17.139383	America/Antigua	0
241	Anvik Airport	Anvik	United States	US	ANV	PANV	-160.188889	62.647778	America/Anchorage	0
242	Ainsworth Airport	Ainsworth	United States	US	ANW	KANW	-99.866667	42.55	America/Chicago	0
243	Andoya Airport	Andenes	Norway	NO	ANX	ENAN	16.144184	69.292486	Europe/Oslo	0
244	Anthony Airport	Anthony	United States	US	ANY	KANY	-98.033333	37.15	America/Chicago	0
245	Altenburg Nobitz Airport	Altenburg	Germany	DE	AOC	EDAC	12.506389	50.981945	Europe/Berlin	0
246	Anadolu Airport	Eskisehir	Turkiye	TR	AOE	LTBY	30.519444	39.81	Europe/Istanbul	0
247	Anshan Teng'ao Airport	Anshan	China	CN	AOG	ZYAS	122.853926	41.105975	Asia/Shanghai	0
248	Allen County Airport	Lima	United States	US	AOH	KAOH	-84.1	40.766667	America/New_York	0
249	Ancona Falconara Airport	Ancona	Italy	IT	AOI	LIPY	13.355723	43.606911	Europe/Rome	0
250	Aomori Airport	Aomori	Japan	JP	AOJ	RJSA	140.689224	40.738757	Asia/Tokyo	0
251	Karpathos Airport	Karpathos	Greece	GR	AOK	LGKP	27.146728	35.420683	Europe/Athens	0
252	Paso de los Libres Airport	Paso de los Libres	Argentina	AR	AOL	SARL	-57.15	-29.683333	America/Argentina/Buenos_Aires	0
253	Altoona Airport	Altoona	United States	US	AOO	KAOO	-78.32	40.297222	America/New_York	0
254	Alfredo V. Sara Bauer Airport	Andoas	Peru	PE	AOP	SPAS	-76.474722	-2.791389	America/Lima	0
255	Aappilattoq-Upernanik Heliport	Aappilattoq	Greenland	GL	AOQ	BGAG	-55.596145	72.887041	America/Godthab	0
256	Sultan Abdul Halim Airport	Alor Setar	Malaysia	MY	AOR	WMKA	100.396629	6.191186	Asia/Kuala_Lumpur	0
257	Corrado Gex Airport	Aosta	Italy	IT	AOT	LIMW	7.3625	45.738611	Europe/Rome	0
258	Attopeu Airport	Attopeu	Lao People's Democratic Republic	LA	AOU	VLAP	106.833333	14.8	Asia/Vientiane	0
259	Centennial Airport	Denver	United States	US	APA	KAPA	-104.848713	39.572123	America/Denver	0
260	Apolo Airport	Apolo	Bolivia	BO	APB	SLAP	-68.516667	-14.716667	America/La_Paz	0
261	Napa County Airport	Napa	United States	US	APC	KAPC	-122.28	38.212222	America/Los_Angeles	0
262	Naples Airport	Naples	United States	US	APF	KAPF	-81.775278	26.152778	America/New_York	0
263	Phillips Army Air Field	Aberdeen	United States	US	APG	KAPG	-76.166667	39.5	America/New_York	0
264	Camp A P Hill Airport	Bowling Green	United States	US	APH	KAPH	-77.35	38.05	America/New_York	0
265	Apataki Airport	Apataki	French Polynesia	PF	APK	NTGD	-146.414129	-15.572857	Pacific/Tahiti	0
266	Nampula Airport	Nampula	Mozambique	MZ	APL	FQNP	39.287222	-15.101667	Africa/Maputo	0
267	Alpena County Regional Airport	Alpena	United States	US	APN	KAPN	-83.555833	45.081667	America/New_York	0
268	Apartado Airport	Apartado	Colombia	CO	APO	SKLC	-76.71766	7.817678	America/Bogota	0
269	Arapiraca Airport	Arapiraca	Brazil	BR	APQ	SNAL	-36.65	-9.75	America/Belem	0
270	Anapolis Airport	Anapolis	Brazil	BR	APS	SWNS	-48.924353	-16.360671	America/Sao_Paulo	0
271	Marion County Airport	Jasper	United States	US	APT	KAPT	-85.5	35.066667	America/Chicago	0
272	Apucarana Airport	Apucarana	Brazil	BR	APU	SSAP	-51.483333	-23.55	America/Sao_Paulo	0
273	Apple Valley Airport	Apple Valley	United States	US	APV	KAPV	-117.185485	34.579105	America/Los_Angeles	0
274	Faleolo Airport	Apia	Samoa	WS	APW	NSFA	-171.997244	-13.832793	Pacific/Apia	0
275	Arapongas Airport	Arapongas	Brazil	BR	APX	SSOG	-51.491699	-23.3529	America/Sao_Paulo	0
276	Alto Parnaiba Airport	Alto Parnaiba	Brazil	BR	APY	SNAI	-45.933333	-9.133333	America/Belem	0
277	Zapala Airport	Zapala	Argentina	AR	APZ	SAHZ	-70.083333	-38.916667	America/Argentina/Buenos_Aires	0
278	Araraquara Airport	Araraquara	Brazil	BR	AQA	SBAQ	-48.136911	-21.806642	America/Sao_Paulo	0
279	Anqing Tianzhushan Airport	Anqing	China	CN	AQG	ZSAQ	117.0509	30.5825	Asia/Shanghai	0
280	Qaisumah Airport	Qaisumah	Saudi Arabia	SA	AQI	OEPA	46.121316	28.334408	Asia/Riyadh	0
281	King Hussein International Airport	Aqaba	Jordan	JO	AQJ	OJAQ	35.021511	29.610074	Asia/Amman	0
282	Ariquemes Airport	Ariquemes	Brazil	BR	AQM	SWNI	-63.066667	-9.933333	America/Porto_Velho	0
283	Rodriguez Ballon International Airport	Arequipa	Peru	PE	AQP	SPQU	-71.567993	-16.344812	America/Lima	0
284	Acadiana Regional Airport	New Iberia	United States	US	ARA	KARA	-91.883889	30.037778	America/Chicago	0
285	Ann Arbor Municipal Airport	Ann Arbor	United States	US	ARB	KARB	-83.74559	42.224912	America/New_York	0
286	Arctic Village Airport	Arctic Village	United States	US	ARC	PARC	-145.524444	68.1375	America/Anchorage	0
287	Alor Island Airport	Alor Island	Indonesia	ID	ARD	WATM	124.598106	-8.132639	Asia/Makassar	0
288	Arecibo Airport	Arecibo	Puerto Rico	PR	ARE	TJAB	-66.675833	18.45	America/Puerto_Rico	0
289	Acaricuara Airport	Acaricuara	Colombia	CO	ARF	SKWA	-70.133333	0.533333	America/Bogota	0
290	Walnut Ridge Airport	Walnut Ridge	United States	US	ARG	KARG	-90.95	36.066667	America/Chicago	0
291	Talagi Airport	Arkhangelsk	Russian Federation	RU	ARH	ULAA	40.713989	64.597581	Europe/Moscow	0
292	Chacalluta Airport	Arica	Chile	CL	ARI	SCAR	-70.335559	-18.349765	America/Santiago	0
293	Arso Airport	Arso	Indonesia	ID	ARJ	WAJA	140.783333	-2.933333	Asia/Jayapura	0
294	Arusha Airport	Arusha	United Republic of Tanzania	TZ	ARK	HTAR	36.683333	-3.366667	Africa/Dar_es_Salaam	0
295	Arly Airport	Arly	Burkina Faso	BF	ARL	DFER	1.482278	11.597078	Africa/Ouagadougou	0
296	Armidale Airport	Armidale	Australia	AU	ARM	YARM	151.61493	-30.532297	Australia/Sydney	0
297	Stockholm Arlanda Airport	Stockholm	Sweden	SE	ARN	ESSA	17.930364	59.649818	Europe/Stockholm	0
298	Arboletas Airport	Arboletas	Colombia	CO	ARO	SQRQ	-76.433333	8.85	America/Bogota	0
299	Arauquita Airport	Arauquita	Colombia	CO	ARQ	SKAT	-71.431667	7.033056	America/Bogota	0
300	Alto Rio Senguerr Airport	Alto Rio Senguerr	Argentina	AR	ARR	SAVR	-70.833333	-45.033333	America/Argentina/Buenos_Aires	0
301	Aragarcas Airport	Aragarcas	Brazil	BR	ARS	SWAC	-52.233333	-15.9	America/Sao_Paulo	0
302	Watertown Airport	Watertown	United States	US	ART	KART	-76.021389	43.990833	America/New_York	0
303	Aracatuba Airport	Aracatuba	Brazil	BR	ARU	SBAU	-50.426111	-21.143611	America/Sao_Paulo	0
304	Noble F. Lee Airport	Minocqua	United States	US	ARV	KARV	-89.732222	45.924167	America/Chicago	0
305	Arad International Airport	Arad	Romania	RO	ARW	LRAR	21.276296	46.17201	Europe/Bucharest	0
306	Ararat Airport	Ararat	Australia	AU	ARY	YARA	143	-37.316667	Australia/Sydney	0
307	N'Zeto Airport	N'Zeto	Angola	AO	ARZ	FNZE	13.5	-7.5	Africa/Luanda	0
308	Assab Airport	Assab	Eritrea	ER	ASA	HHSB	42.638333	13.07	Africa/Asmara	0
309	Ashgabat Airport	Ashgabat	Turkmenistan	TM	ASB	UTAA	58.366978	37.984183	Asia/Ashgabat	0
310	Andros Town Airport	Andros Town	Bahamas	BS	ASD	MYAF	-77.796111	24.697778	America/Nassau	0
311	Aspen Airport	Aspen	United States	US	ASE	KASE	-106.864688	39.219685	America/Denver	0
312	Astrakhan Airport	Astrakhan	Russian Federation	RU	ASF	URWA	47.999979	46.287699	Europe/Astrakhan	0
313	Ashburton Airport	Ashburton	New Zealand	NZ	ASG	NZAS	171.783333	-43.9	Pacific/Auckland	0
314	Boire Field	Nashua	United States	US	ASH	KASH	-71.514801	42.7817	America/New_York	0
315	Ascension Island RAF Station	Ascension Island	St. Helena	SH	ASI	FHAW	-14.393682	-7.969604	Atlantic/St_Helena	0
316	Amami Airport	Amami O Shima	Japan	JP	ASJ	RJKA	129.707933	28.431522	Asia/Tokyo	0
317	Yamoussoukro Airport	Yamoussoukro	Cote d'Ivoire	CI	ASK	DIYO	-5.283333	6.816667	Africa/Abidjan	0
318	Harrison County Airport	Marshall	United States	US	ASL	KASL	-94.383333	32.55	America/Chicago	0
319	Asmara International Airport	Asmara	Eritrea	ER	ASM	HHAS	38.910278	15.291111	Africa/Asmara	0
320	Talladega Municipal Airport	Talladega	United States	US	ASN	KASN	-86.05219	33.571351	America/Chicago	0
321	Asosa Airport	Asosa	Ethiopia	ET	ASO	HASO	34.536667	10.047222	Africa/Addis_Ababa	0
322	Alice Springs Airport	Alice Springs	Australia	AU	ASP	YBAS	133.903384	-23.801389	Australia/Darwin	0
323	Kayseri Airport	Kayseri	Turkiye	TR	ASR	LTAU	35.494891	38.770293	Europe/Istanbul	0
324	Arathusa Safari Lodge Airport	Chitwa Chitwa	South Africa	ZA	ASS	FACC	31.514126	-24.736469	Africa/Johannesburg	0
325	Astoria Regional Airport	Astoria	United States	US	AST	KAST	-123.88	46.159722	America/Los_Angeles	0
326	Silvio Pettirossi International Airport	Asuncion	Paraguay	PY	ASU	SGAS	-57.513795	-25.241795	America/Asuncion	0
327	Amboseli Airport	Amboseli	Kenya	KE	ASV	HKAM	37.25	-2.633333	Africa/Nairobi	0
328	Aswan International Airport	Aswan	Egypt	EG	ASW	HESN	32.824818	23.968022	Africa/Cairo	0
329	Ashland Airport	Ashland	United States	US	ASX	KASX	-90.916667	46.55	America/Chicago	0
330	Ashley Airport	Ashley	United States	US	ASY	KASY	-99.366667	46.033333	America/Chicago	0
331	Comandante FAP German Arias Graziani Airport	Anta	Peru	PE	ATA	SPHZ	-77.6	-9.347222	America/Lima	0
332	Atbara Airport	Atbara	Sudan	SD	ATB	HSAT	34.016667	17.716667	Africa/Khartoum	0
333	Arthur's Town Airport	Arthur's Town	Bahamas	BS	ATC	MYCA	-75.671389	24.628611	America/Nassau	0
334	Atoifi Airport	Atoifi	Solomon Islands	SB	ATD	AGAT	161.033333	-8.866667	Pacific/Guadalcanal	0
335	Chachoan Airport	Ambato	Ecuador	EC	ATF	SEAM	-78.7	-1.083333	America/Guayaquil	0
336	Athens Eleftherios Venizelos International Airport	Athens	Greece	GR	ATH	LGAV	23.946486	37.93635	Europe/Athens	0
337	Artigas Airport	Artigas	Uruguay	UY	ATI	SUAG	-56.508333	-30.4	America/Montevideo	0
338	Antsirabe Airport	Antsirabe	Madagascar	MG	ATJ	FMME	47.066926	-19.835319	Indian/Antananarivo	0
339	Atqasuk Airport	Atqasuk	United States	US	ATK	PATQ	-157.333333	70.5	America/Anchorage	0
340	Atlanta Hartsfield-Jackson International Airport	Atlanta	United States	US	ATL	KATL	-84.44403	33.640067	America/New_York	0
341	Altamira Airport	Altamira	Brazil	BR	ATM	SBHT	-52.216667	-3.2	America/Belem	0
342	Ohio University Airport	Athens	United States	US	ATO	KUNI	-82.1	39.333333	America/New_York	0
343	Sri Guru Ram Dass Jee International Airport	Amritsar	India	IN	ATQ	VIAR	74.806739	31.705398	Asia/Kolkata	0
344	Atar International Airport	Atar	Mauritania	MR	ATR	GQPA	-13.046389	20.499444	Africa/Nouakchott	0
345	Artesia Airport	Artesia	United States	US	ATS	KATS	-104.466944	32.848333	America/Denver	0
346	Casco Cove Airport	Attu Island	United States	US	ATU	PAAT	173.172778	52.825833	America/Adak	0
347	Ati Airport	Ati	Chad	TD	ATV	FTTI	18.3075	13.242222	Africa/Ndjamena	0
348	Appleton International Airport	Appleton	United States	US	ATW	KATW	-88.509943	44.26011	America/Chicago	0
349	Watertown Airport	Watertown	United States	US	ATY	KATY	-97.154167	44.908889	America/Chicago	0
350	Asyut Airport	Asyut	Egypt	EG	ATZ	HEAT	31.011268	27.052679	Africa/Cairo	0
351	Reina Beatrix International Airport	Aruba	Aruba	AW	AUA	TNCA	-70.013889	12.502222	America/Aruba	0
352	Arauca Airport	Arauca	Colombia	CO	AUC	SKUC	-70.7425	7.071667	America/Bogota	0
353	Augustus Downs Airport	Augustus Downs	Australia	AU	AUD	YAGD	139.881667	-18.506944	Australia/Brisbane	0
354	Aeroport Auxerre Branches	Auxerre	France	FR	AUF	LFLA	3.5	47.85	Europe/Paris	0
355	Augusta Airport	Augusta	United States	US	AUG	KAUG	-69.796667	44.318056	America/New_York	0
356	Abu Dhabi Zayed International Airport	Abu Dhabi	United Arab Emirates	AE	AUH	OMAA	54.645974	24.426912	Asia/Dubai	0
357	Alakanuk Airport	Alakanuk	United States	US	AUK	PAUK	-164.610833	62.689167	America/Anchorage	0
358	Austin Airport	Austin	United States	US	AUM	KAUM	-92.983333	43.666667	America/Chicago	0
359	Auburn Airport	Auburn	United States	US	AUN	KAUN	-121.066667	38.9	America/Los_Angeles	0
360	Auburn University Regional Airport	Auburn	United States	US	AUO	KAUO	-85.433875	32.615046	America/Chicago	0
361	Hiva Oa Airport	Atuona	French Polynesia	PF	AUQ	NTMN	-139.009944	-9.768596	Pacific/Marquesas	0
362	Aurillac Airport	Aurillac	France	FR	AUR	LFLW	2.418056	44.8975	Europe/Paris	0
363	Austin-Bergstrom International Airport	Austin	United States	US	AUS	KAUS	-97.667064	30.202545	America/Chicago	0
364	Aurukun Airport	Aurukun	Australia	AU	AUU	YAUR	141.721917	-13.356451	Australia/Brisbane	0
365	Wausau Downtown Airport	Wausau	United States	US	AUW	KAUW	-89.626599	44.926188	America/Chicago	0
366	Araguaina Airport	Araguaina	Brazil	BR	AUX	SWGN	-48.2	-7.2	America/Belem	0
367	Aneityum Airport	Aneityum	Vanuatu	VU	AUY	NVVA	169.666667	-20.333333	Pacific/Efate	0
368	Aurora Municipal Airport	Aurora	United States	US	AUZ	KARR	-88.471194	41.770365	America/Chicago	0
369	Aviano Air Base	Aviano	Italy	IT	AVB	LIPA	12.6	46.033333	Europe/Rome	0
370	Auvergne Airport	Auvergne	Australia	AU	AVG	YAUV	130.016667	-15.65	Australia/Darwin	0
371	Maximo Gomez Airport	Ciego De Avila	Cuba	CU	AVI	MUCA	-78.791389	22.025	America/Havana	0
372	Arvaikheer Airport	Arvaikheer	Mongolia	MN	AVK	ZMAH	102.783333	46.266667	Asia/Ulaanbaatar	0
373	Asheville Regional Airport	Asheville	United States	US	AVL	KAVL	-82.537314	35.43508	America/New_York	0
374	Caumont Airport	Avignon	France	FR	AVN	LFMV	4.902082	43.906542	Europe/Paris	0
375	Avon Park Municipal Airport	Avon Park	United States	US	AVO	KAVO	-81.516667	27.6	America/New_York	0
376	Wilkes-Barre/Scranton International Airport	Wilkes-Barre	United States	US	AVP	KAVP	-75.730643	41.336698	America/New_York	0
377	Avu Avu Airport	Avu Avu	Solomon Islands	SB	AVU	AGGJ	160.383333	-9.833333	Pacific/Guadalcanal	0
378	Avalon Airport	Avalon	Australia	AU	AVV	YMAV	144.473084	-38.026372	Australia/Sydney	0
379	Marana Regional Airport	Tucson	United States	US	AVW	KAVQ	-111.215615	32.407605	America/Phoenix	0
380	Catalina Airport	Avalon	United States	US	AVX	KAVX	-118.416	33.4049	America/Los_Angeles	0
381	Awasa Airport	Awasa	Ethiopia	ET	AWA	HALA	38.490802	7.062777	Africa/Addis_Ababa	0
382	Aniwa Airport	Aniwa	Vanuatu	VU	AWD	NVVB	169.5	-19.25	Pacific/Efate	0
383	Wake Island Airport	Wake Island	US Minor Outlying Islands	UM	AWK	PWAK	166.633333	19.283333	Pacific/Wake	0
384	West Memphis Municipal Airport	West Memphis	United States	US	AWM	KAWM	-90.231974	35.137882	America/Chicago	0
385	Alton Downs Airport	Alton Downs	Australia	AU	AWN	YADS	138.666667	-26.25	Australia/Adelaide	0
386	Austral Downs Airport	Austral Downs	Australia	AU	AWP	YAUS	137.75	-20.5	Australia/Darwin	0
387	Awantipur Air Force Station	Awantipur	India	IN	AWT	VIAW	74.975681	33.876628	Asia/Kolkata	0
388	Ahwaz Airport	Ahwaz	Iran	IR	AWZ	OIAW	48.746682	31.342921	Asia/Tehran	0
389	Clayton J. Lloyd International Airport	Anguilla	Anguilla	AI	AXA	TQPF	-63.051754	18.205944	America/Anguilla	0
390	Aramac Airport	Aramac	Australia	AU	AXC	YAMC	145.2425	-22.958056	Australia/Brisbane	0
391	Demokritos Airport	Alexandroupolis	Greece	GR	AXD	LGAL	25.944893	40.856784	Europe/Athens	0
392	Algona Airport	Algona	United States	US	AXG	KAXA	-94.233333	43.066667	America/Chicago	0
393	Amakusa Airport	Amakusa	Japan	JP	AXJ	RJDA	130.155645	32.483262	Asia/Tokyo	0
394	Ataq Airport	Ataq	Republic of Yemen	YE	AXK	OYAT	46.3	13.866667	Asia/Aden	0
395	Alexandria Airport	Alexandria	Australia	AU	AXL	YALX	136.7	-19.066667	Australia/Darwin	0
396	El Eden Airport	Armenia	Colombia	CO	AXM	SKAR	-75.768045	4.452869	America/Bogota	0
397	Chandler Field	Alexandria	United States	US	AXN	KAXN	-95.394167	45.867222	America/Chicago	0
398	Springpoint Airport	Spring Point	Bahamas	BS	AXP	MYAP	-73.966667	22.45	America/Nassau	0
399	Arutua Airport	Arutua	French Polynesia	PF	AXR	NTGU	-146.75	-15.25	Pacific/Tahiti	0
400	Altus Municipal Airport	Altus	United States	US	AXS	KAXS	-99.338056	34.696667	America/Chicago	0
401	Akita Airport	Akita	Japan	JP	AXT	RJSK	140.220147	39.611771	Asia/Tokyo	0
402	Axum Airport	Axum	Ethiopia	ET	AXU	HAAX	38.716667	14.120833	Africa/Addis_Ababa	0
403	Neil Armstrong Airport	Wapakoneta	United States	US	AXV	KAXV	-84.2	40.566667	America/New_York	0
404	Angel Fire Airport	Angel Fire	United States	US	AXX	KAXX	-105.290381	36.419646	America/Denver	0
405	Ayapel Airport	Ayapel	Colombia	CO	AYA	SKOY	-75.15	8.316667	America/Bogota	0
406	Alroy Downs Airport	Alroy Downs	Australia	AU	AYD	YALD	135.95	-19.3	Australia/Darwin	0
407	Yaguara Airport	Yaguara	Colombia	CO	AYG	SKYA	-73.933333	1.533333	America/Bogota	0
408	Ayodhya Airport	Ayodhya	India	IN	AYJ	VEAY	82.1572	26.7525	Asia/Kolkata	0
409	Arkalyk Airport	Arkalyk	Kazakhstan	KZ	AYK	UAUR	66.952694	50.318621	Asia/Qostanay	0
410	Anthony Lagoon Airport	Anthony Lagoon	Australia	AU	AYL	YANL	135.533333	-18.033333	Australia/Darwin	0
411	Anyang Airport	Anyang	China	CN	AYN	ZHAY	114.35	36.1	Asia/Shanghai	0
412	Yanamilla Airport	Ayacucho	Peru	PE	AYP	SPHO	-74.247222	-13.197222	America/Lima	0
413	Connellan Airport	Ayers Rock	Australia	AU	AYQ	YAYE	130.976578	-25.190877	Australia/Darwin	0
414	Ayr Airport	Ayr	Australia	AU	AYR	YAYR	147.324444	-19.596667	Australia/Brisbane	0
415	Ware County Airport	Waycross	United States	US	AYS	KAYS	-82.396667	31.248611	America/New_York	0
416	Antalya Airport	Antalya	Turkiye	TR	AYT	LTAI	30.801349	36.899282	Europe/Istanbul	0
417	Ayawasi Airport	Ayawasi	Indonesia	ID	AYW	WAFM	132.5	-1.2	Asia/Jayapura	0
418	Gerardo Perez Pinedo Airport	Atalaya	Peru	PE	AYX	SPAY	-73.768	-10.73056	America/Lima	0
419	Phoenix-Mesa Gateway Airport	Mesa	United States	US	AZA	KIWA	-111.655556	33.307778	America/Phoenix	0
420	Yazd Airport	Yazd	Iran	IR	AZD	OIYY	54.283264	31.903602	Asia/Tehran	0
421	Bateen Airport	Abu Dhabi	United Arab Emirates	AE	AZI	OMAD	54.45961	24.428429	Asia/Dubai	0
422	Andizhan Airport	Andizhan	Uzbekistan	UZ	AZN	UTFA	72.3	40.733333	Asia/Tashkent	0
423	Kalamazoo/Battle Creek International Airport	Kalamazoo	United States	US	AZO	KAZO	-85.556553	42.239962	America/New_York	0
424	Atizapan Airport	Mexico City	Mexico	MX	AZP	MMJC	-99.289487	19.57415	America/Mexico_City	0
425	Adrar Airport	Adrar	Algeria	DZ	AZR	DAUA	-0.283333	27.883333	Africa/Algiers	0
426	Samana El Catey Airport	El Catey/Samana	Dominican Republic	DO	AZS	MDCY	-69.736944	19.270555	America/Santo_Domingo	0
427	Zapatoca Airport	Zapatoca	Colombia	CO	AZT	SQZP	-73.25	6.866667	America/Bogota	0
428	Ambriz Airport	Ambriz	Angola	AO	AZZ	FNAM	13.15	-7.883333	Africa/Luanda	0
429	Beale Air Force Base	Marysville	United States	US	BAB	KBAB	-121.436957	39.136103	America/Los_Angeles	0
430	Barksdale Air Force Base	Shreveport	United States	US	BAD	KBAD	-93.666667	32.5	America/Chicago	0
431	St-Pons Airport	Barcelonnette	France	FR	BAE	LFMR	6.609135	44.387189	Europe/Paris	0
432	Westfield-Barnes Regional Airport	Springfield	United States	US	BAF	KBAF	-72.715624	42.157954	America/New_York	0
433	Loakan Airport	Baguio	Philippines	PH	BAG	RPUB	120.617778	16.376667	Asia/Manila	0
434	Bahrain International Airport	Bahrain	Bahrain	BH	BAH	OBBI	50.62605	26.269181	Asia/Bahrain	0
435	Buenos Aires Airport	Buenos Aires	Costa Rica	CR	BAI	MRBA	-83.333333	9.166667	America/Costa_Rica	0
436	Batman Airport	Batman	Turkiye	TR	BAL	LTCJ	41.083333	37.916667	Europe/Istanbul	0
437	Lander County Airport	Battle Mountain	United States	US	BAM	KBAM	-116.933333	40.633333	America/Los_Angeles	0
438	Basongo Airport	Basongo	The Democratic Republic of The Congo	CD	BAN	FZVR	20.428056	-4.313333	Africa/Lubumbashi	0
439	Ernesto Cortissoz International Airport	Barranquilla	Colombia	CO	BAQ	SKBQ	-74.780818	10.889594	America/Bogota	0
440	Balalae Airport	Balalae	Solomon Islands	SB	BAS	AGGE	155.883276	-6.993418	Pacific/Guadalcanal	0
441	Barretos Airport	Barretos	Brazil	BR	BAT	SBBT	-48.55	-20.55	America/Sao_Paulo	0
442	Baotou Airport	Baotou	China	CN	BAV	ZBOW	109.998495	40.563442	Asia/Shanghai	0
443	Barnaul Airport	Barnaul	Russian Federation	RU	BAX	UNBB	83.547643	53.361086	Asia/Barnaul	0
444	Baia Mare Airport	Baia Mare	Romania	RO	BAY	LRBM	23.466204	47.658213	Europe/Bucharest	0
445	Barbelos Airport	Barbelos	Brazil	BR	BAZ	SWBC	-62.933611	-0.966944	America/Porto_Velho	0
446	Teniente Vidal Airport	Balmaceda	Chile	CL	BBA	SCBA	-71.695	-45.916667	America/Santiago	0
447	Benson Municipal Airport	Benson	United States	US	BBB	KBBB	-95.6	45.316667	America/Chicago	0
448	Bay City Airport	Bay City	United States	US	BBC	KBYY	-95.966667	28.983333	America/Chicago	0
449	Curtis Field	Brady	United States	US	BBD	KBBD	-99.333333	31.133333	America/Chicago	0
450	Butaritari Airport	Butaritari	Kiribati	KI	BBG	NGTU	172.75	3.166667	Pacific/Tarawa	0
451	Barth Airport	Barth	Germany	DE	BBH	EDBH	12.711667	54.339722	Europe/Berlin	0
452	Biju Patnaik International Airport	Bhubaneswar	India	IN	BBI	VEBS	85.817385	20.252853	Asia/Kolkata	0
453	Bitburg Airport	Bitburg	Germany	DE	BBJ	EDRB	6.560565	49.944064	Europe/Berlin	0
454	Kasane Airport	Kasane	Botswana	BW	BBK	FBKE	25.15	-17.816667	Africa/Gaborone	0
455	Battambang Airport	Battambang	Cambodia	KH	BBM	VDBG	103.2	13.116667	Asia/Phnom_Penh	0
456	Bario Airport	Bario	Malaysia	MY	BBN	WBGZ	115.466667	3.683333	Asia/Kuala_Lumpur	0
457	Berbera Airport	Berbera	Somalia	SO	BBO	HCMI	45.006389	10.419444	Africa/Mogadishu	0
458	Bembridge Airport	Bembridge	United Kingdom	GB	BBP	EGHJ	-1.083333	50.683333	Europe/London	0
459	Barbuda Codrington Airport	Barbuda	Antigua and Barbuda	AG	BBQ	TAPH	-61.826681	17.636433	America/Antigua	0
460	Baillif Airport	Basse Terre	Guadeloupe	GP	BBR	TFFB	-61.739444	16.016389	America/Guadeloupe	0
461	Blackbush Airport	Blackbush	United Kingdom	GB	BBS	EGLK	-0.85	51.333333	Europe/London	0
462	Berberati Airport	Berberati	Central African Republic	CF	BBT	FEFT	15.788056	4.219167	Africa/Bangui	0
463	Baneasa Airport	Bucharest	Romania	RO	BBU	LRBS	26.080995	44.495932	Europe/Bucharest	0
464	Bereby Airport	Bereby	Cote d'Ivoire	CI	BBV	DIGN	-6.95	4.666667	Africa/Abidjan	0
465	Broken Bow Municipal Airport	Broken Bow	United States	US	BBW	KBBW	-99.638354	41.431867	America/Chicago	0
466	Wings Field	Blue Bell	United States	US	BBX	KLOM	-75.2675	40.136667	America/New_York	0
467	Bambari Airport	Bambari	Central African Republic	CF	BBY	FEFM	20.649722	5.845833	Africa/Bangui	0
468	Zambezi Airport	Zambezi	Zambia	ZM	BBZ	FLZB	23.11	-13.537222	Africa/Lusaka	0
469	Baracoa Airport	Baracoa	Cuba	CU	BCA	MUBA	-74.5	20.35	America/Havana	0
470	Virginia Tech Airport	Blacksburg	United States	US	BCB	KBCB	-80.416667	37.233333	America/New_York	0
471	Silay International Airport	Bacolod	Philippines	PH	BCD	RPVB	123.014999	10.7764	Asia/Manila	0
472	Bryce Airport	Bryce	United States	US	BCE	KBCE	-112.135278	37.701111	America/Denver	0
473	Bouca Airport	Bouca	Central African Republic	CF	BCF	FEGU	18.416667	6.75	Africa/Bangui	0
474	Bemichi Airport	Bemichi	Guyana	GY	BCG	SYBE	-58.55	6.55	America/Guyana	0
475	Baucau Airport	Baucau	Indonesia	ID	BCH	WPEC	126.396437	-8.480239	Asia/Jayapura	0
476	Barcaldine Airport	Barcaldine	Australia	AU	BCI	YBAR	145.301944	-23.559167	Australia/Brisbane	0
477	Bolwarra Airport	Bolwarra	Australia	AU	BCK	YBWR	144.171	-17.386	Australia/Brisbane	0
478	Barra del Colorado Airport	Barra del Colorado	Costa Rica	CR	BCL	MRBC	-83.586633	10.771923	America/Costa_Rica	0
479	Bacau Airport	Bacau	Romania	RO	BCM	LRBC	26.910299	46.5219	Europe/Bucharest	0
480	Barcelona-El Prat Airport	Barcelona	Spain and Canary Islands	ES	BCN	LEBL	2.07593	41.303027	Europe/Madrid	0
481	Bako Airport	Jinka	Ethiopia	ET	BCO	HABC	36.562038	5.783127	Africa/Addis_Ababa	0
482	Boca Raton Airport	Boca Raton	United States	US	BCT	KBCT	-80.107981	26.379022	America/New_York	0
483	Bauchi Airport	Bauchi	Nigeria	NG	BCU	DNBA	9.817992	10.299222	Africa/Lagos	0
484	Bulchi Airport	Bulchi	Ethiopia	ET	BCY	HABU	36.666667	6.216667	Africa/Addis_Ababa	0
485	Bickerton Island Airport	Bickerton Island	Australia	AU	BCZ	YBIC	137.8	-13.783333	Australia/Darwin	0
486	L.F. Wade International Airport	Bermuda	Bermuda	BM	BDA	TXKF	-64.701148	32.35994	Atlantic/Bermuda	0
487	Bundaberg Airport	Bundaberg	Australia	AU	BDB	YBUD	152.321873	-24.898709	Australia/Brisbane	0
488	Barra Do Corda Airport	Barra Do Corda	Brazil	BR	BDC	SNBC	-45.266667	-5.466667	America/Belem	0
489	Badu Island Airport	Badu Island	Australia	AU	BDD	YBAU	142.173303	-10.149247	Australia/Brisbane	0
490	Baudette Airport	Baudette	United States	US	BDE	KBDE	-94.606944	48.722778	America/Chicago	0
491	Blanding Airport	Blanding	United States	US	BDG	KBDG	-109.483333	37.616667	America/Denver	0
492	Bandar Lengeh Airport	Bandar Lengeh	Iran	IR	BDH	OIBL	54.829146	26.529485	Asia/Tehran	0
493	Bird Island Airport	Bird Island	Seychelles	SC	BDI	FSSB	55.216667	-3.716667	Indian/Mahe	0
494	Syamsudin Noor International Airport	Banjarmasin	Indonesia	ID	BDJ	WAOO	114.754253	-3.43804	Asia/Makassar	0
495	Bondoukou Airport	Bondoukou	Cote d'Ivoire	CI	BDK	DIBU	-2.8	8.033333	Africa/Abidjan	0
496	Bradley International Airport	Hartford	United States	US	BDL	KBDL	-72.684701	41.92953	America/New_York	0
497	Bandirma Airport	Bandirma	Turkiye	TR	BDM	LTBG	27.977222	40.318333	Europe/Istanbul	0
498	Husein Sastranegara Airport	Bandung	Indonesia	ID	BDO	WICC	107.581779	-6.904648	Asia/Jakarta	0
499	Vadodara Airport	Vadodara	India	IN	BDQ	VABO	73.215701	22.329077	Asia/Kolkata	0
500	Igor I. Sikorsky Memorial Airport	Bridgeport	United States	US	BDR	KBDR	-73.124444	41.164167	America/New_York	0
501	Brindisi - Salento Airport	Brindisi	Italy	IT	BDS	LIBR	17.939053	40.657995	Europe/Rome	0
502	Gbadolite Airport	Gbadolite	The Democratic Republic of The Congo	CD	BDT	FZFD	22.45	4.083333	Africa/Kinshasa	0
503	Bardufoss Airport	Bardufoss	Norway	NO	BDU	ENDU	18.54	69.056111	Europe/Oslo	0
504	Moba Airport	Moba	The Democratic Republic of The Congo	CD	BDV	FZRB	29.8	-7	Africa/Lubumbashi	0
505	Bedford Downs Airport	Bedford Downs	Australia	AU	BDW	YBDF	127.466667	-17.3	Australia/Perth	0
506	Broadus Airport	Broadus	United States	US	BDX	KBDX	-105.366667	45.466667	America/Denver	0
507	Benbecula Airport	Benbecula	United Kingdom	GB	BEB	EGPL	-7.376028	57.473414	Europe/London	0
508	Beech Airport	Wichita	United States	US	BEC	KBEC	-97.333333	37.683333	America/Chicago	0
509	Bedford Hanscom Field	Bedford/Hanscom	United States	US	BED	KBED	-71.29	42.470833	America/New_York	0
510	Beagle Bay Airport	Beagle Bay	Australia	AU	BEE	YBGB	122.666667	-16.966667	Australia/Perth	0
511	Bluefields Airport	Bluefields	Nicaragua	NI	BEF	MNBL	-83.773942	11.990889	America/Managua	0
512	Belgrade Nikola Tesla Airport	Belgrade	Republic of Serbia	RS	BEG	LYBE	20.2914	44.8194	Europe/Belgrade	0
513	Southwest Michigan Regional Airport	Benton Harbor	United States	US	BEH	KBEH	-86.428333	42.127778	America/New_York	0
514	Beica Airport	Beica	Ethiopia	ET	BEI	HABE	34.533333	9.391667	Africa/Addis_Ababa	0
515	Kalimarau Airport	Berau	Indonesia	ID	BEJ	WAQT	117.433488	2.155327	Asia/Makassar	0
516	Bareilly Airport	Bareilly	India	IN	BEK	VIBY	79.447575	28.423379	Asia/Kolkata	0
517	Val De Cans International Airport	Belem	Brazil	BR	BEL	SBBE	-48.480003	-1.389865	America/Belem	0
518	Beni Mellal National Airport	Beni Mellal	Morocco	MA	BEM	GMMD	-6.317363	32.400744	Africa/Casablanca	0
519	Benina International Airport	Benghazi	Libya	LY	BEN	HLLB	20.264891	32.085423	Africa/Tripoli	0
520	Honington Airport	Bury St. Edmunds	United Kingdom	GB	BEQ	EGXH	0.766667	52.35	Europe/London	0
521	Berlin Brandenburg Airport	Berlin	Germany	DE	BER	EDDB	13.503333	52.366667	Europe/Berlin	0
522	Brest Bretagne Airport	Brest	France	FR	BES	LFRB	-4.420175	48.443377	Europe/Paris	0
523	Bethel Airport	Bethel	United States	US	BET	PABE	-161.831389	60.784444	America/Anchorage	0
524	Bedourie Airport	Bedourie	Australia	AU	BEU	YBIE	139.445	-24.23	Australia/Brisbane	0
525	Beer Sheba Airport	Beer Sheba	Israel	IL	BEV	LLBS	34.8	31.25	Asia/Jerusalem	0
526	Beira Airport	Beira	Mozambique	MZ	BEW	FQBR	34.901919	-19.798806	Africa/Maputo	0
527	RAF Benson	Benson	United Kingdom	GB	BEX	EGUB	-1.095776	51.616115	Europe/London	0
528	Beirut-Rafic Hariri International Airport	Beirut	Lebanon	LB	BEY	OLBA	35.493082	33.826073	Asia/Beirut	0
529	Beru Airport	Beru	Kiribati	KI	BEZ	NGBR	176	-1.333333	Pacific/Tarawa	0
530	Bloomfield Airport	Bloomfield	Australia	AU	BFC	YBMD	145.32677	-15.871359	Australia/Brisbane	0
531	Bradford Airport	Bradford	United States	US	BFD	KBFD	-78.639444	41.802222	America/New_York	0
532	Bielefeld Airport	Bielefeld	Germany	DE	BFE	EDLI	8.55	52.016667	Europe/Berlin	0
533	Western Nebraska Regional Airport	Scottsbluff	United States	US	BFF	KBFF	-103.595968	41.873989	America/Denver	0
534	Bacacheri Airport	Curitiba	Brazil	BR	BFH	SBBI	-49.233889	-25.4025	America/Sao_Paulo	0
535	King County International Airport	Seattle	United States	US	BFI	KBFI	-122.302253	47.530204	America/Los_Angeles	0
536	Buckley Air National Guard Base	Denver	United States	US	BFK	KBKF	-104.765732	39.707224	America/Denver	0
537	Meadows Field Airport	Bakersfield	United States	US	BFL	KBFL	-119.055263	35.437466	America/Los_Angeles	0
538	Mobile Downtown Airport	Mobile	United States	US	BFM	KBFM	-88.075247	30.636651	America/Chicago	0
539	Bram Fischer International Airport	Bloemfontein	South Africa	ZA	BFN	FABL	26.297516	-29.095853	Africa/Johannesburg	0
540	Buffalo Range Airport	Buffalo Range	Zimbabwe	ZW	BFO	FVCZ	31.579167	-21.009167	Africa/Harare	0
541	Beaver Falls Airport	Beaver Falls	United States	US	BFP	KBVI	-80.4	40.766667	America/New_York	0
542	Bahia Pinas Airport	Bahia Pinas	Panama	PA	BFQ	MPPI	-78.166667	7.583333	America/Panama	0
543	Virgil I Grissom Municipal Airport	Bedford	United States	US	BFR	KBFR	-86.483333	38.866667	America/Indiana/Indianapolis	0
544	Belfast International Airport	Belfast	United Kingdom	GB	BFS	EGAA	-6.217616	54.662397	Europe/London	0
545	Beaufort County Airport	Beaufort	United States	US	BFT	KARW	-80.635	32.410833	America/New_York	0
546	Bengbu Airport	Bengbu	China	CN	BFU	ZSBB	117.320278	32.8475	Asia/Shanghai	0
547	Sidi Belabbes Airport	Sidi Belabbes	Algeria	DZ	BFW	DAOS	-0.589444	35.171667	Africa/Algiers	0
548	Bafoussam Airport	Bafoussam	Cameroon	CM	BFX	FKKU	10.355854	5.531431	Africa/Douala	0
549	Palonegro International Airport	Bucaramanga	Colombia	CO	BGA	SKBG	-73.181394	7.128045	America/Bogota	0
550	Booue Airport	Booue	Gabon	GA	BGB	FOGB	11.938889	-0.106667	Africa/Libreville	0
551	Braganca Airport	Braganca	Portugal	PT	BGC	LPBG	-6.706141	41.856158	Europe/Lisbon	0
552	Borger Airport	Borger	United States	US	BGD	KBGD	-101.4	35.65	America/Chicago	0
553	Decatur County Airport	Bainbridge	United States	US	BGE	KBGE	-84.583333	30.916667	America/New_York	0
554	M'poko International Airport	Bangui	Central African Republic	CF	BGF	FEFF	18.520278	4.396111	Africa/Bangui	0
555	Bingol Airport	Bingol	Turkiye	TR	BGG	LTCU	40.593889	38.86	Europe/Istanbul	0
556	Abbaye Airport	Boghe	Mauritania	MR	BGH	GQNE	-14.2	16.633333	Africa/Nouakchott	0
557	Grantley Adams International Airport	Bridgetown	Barbados	BB	BGI	TBPB	-59.487835	13.080732	America/Barbados	0
558	Baglung Airport	Baglung	Nepal	NP	BGL	VNBL	83.683333	28.215278	Asia/Kathmandu	0
559	Greater Binghamton Airport	Binghamton	United States	US	BGM	KBGM	-75.982944	42.208533	America/New_York	0
560	Belaya Gora Airport	Belaya Gora	Russian Federation	RU	BGN	UESG	146.22973	68.555771	Asia/Srednekolymsk	0
561	Bergen Flesland Airport	Bergen	Norway	NO	BGO	ENBR	5.228169	60.289064	Europe/Oslo	0
562	Big Lake Airport	Big Lake	United States	US	BGQ	PAGQ	-149.813995	61.536098	America/Anchorage	0
563	Bangor International Airport	Bangor	United States	US	BGR	KBGR	-68.817799	44.808699	America/New_York	0
564	Bangassou Airport	Bangassou	Central African Republic	CF	BGU	FEFG	22.784444	4.786667	Africa/Bangui	0
565	Baghdad International Airport	Baghdad	Iraq	IQ	BGW	ORBI	44.232069	33.255879	Asia/Baghdad	0
566	Bage Airport	Bage	Brazil	BR	BGX	SBBG	-54.1125	-31.398611	America/Sao_Paulo	0
567	Milan Bergamo Airport	Milan	Italy	IT	BGY	LIME	9.698713	45.665315	Europe/Rome	0
568	Braga Airport	Braga	Portugal	PT	BGZ	LPBR	-8.433333	41.55	Europe/Lisbon	0
569	Bahia De Caraquez Airport	Bahia De Caraquez	Ecuador	EC	BHA	SESV	-80.416667	-0.6	America/Guayaquil	0
570	Hancock County-Bar Harbor Airport	Bar Harbor	United States	US	BHB	KBHB	-68.361667	44.448889	America/New_York	0
571	George Best Belfast City Airport	Belfast	United Kingdom	GB	BHD	EGAC	-5.870215	54.61452	Europe/London	0
572	Woodbourne Airport	Blenheim	New Zealand	NZ	BHE	NZWB	173.871084	-41.51779	Pacific/Auckland	0
573	Bisha Airport	Bisha	Saudi Arabia	SA	BHH	OEBH	42.618485	19.994509	Asia/Riyadh	0
574	Comandante Espora Airport	Bahia Blanca	Argentina	AR	BHI	SAZB	-62.150556	-38.730556	America/Argentina/Buenos_Aires	0
575	Rudra Mata Airport	Bhuj	India	IN	BHJ	VABJ	69.670556	23.2875	Asia/Kolkata	0
576	Bukhara Airport	Bukhara	Uzbekistan	UZ	BHK	UTSB	64.474792	39.760369	Asia/Tashkent	0
577	Birmingham-Shuttlesworth International Airport	Birmingham	United States	US	BHM	KBHM	-86.752189	33.560834	America/Chicago	0
578	Beihan Airport	Beihan	Republic of Yemen	YE	BHN	OYBN	45.733333	14.783333	Asia/Aden	0
579	Raja Bhoj Airport	Bhopal	India	IN	BHO	VABP	77.335531	23.290623	Asia/Kolkata	0
580	Bhojpur Airport	Bhojpur	Nepal	NP	BHP	VNBJ	87.051044	27.1478	Asia/Kathmandu	0
581	Broken Hill Airport	Broken Hill	Australia	AU	BHQ	YBHI	141.468921	-32.000589	Australia/Adelaide	0
582	Bharatpur Airport	Bharatpur	Nepal	NP	BHR	VNBP	84.4325	27.676389	Asia/Kathmandu	0
583	Raglan Airport	Bathurst	Australia	AU	BHS	YBTH	149.655181	-33.413872	Australia/Sydney	0
584	Brighton Downs Airport	Brighton Downs	Australia	AU	BHT	YBTD	141.566667	-23.366667	Australia/Brisbane	0
585	Bhavnagar Airport	Bhavnagar	India	IN	BHU	VABV	72.184444	21.755	Asia/Kolkata	0
586	Bahawalpur Airport	Bahawalpur	Pakistan	PK	BHV	OPBW	71.683333	29.4	Asia/Karachi	0
587	Birmingham Airport	Birmingham	United Kingdom	GB	BHX	EGBB	-1.733256	52.452518	Europe/London	0
588	Beihai Fucheng Airport	Beihai	China	CN	BHY	ZGBH	109.288702	21.5431	Asia/Shanghai	0
589	Bastia Poretta Airport	Bastia	France	FR	BIA	LFKB	9.480124	42.547616	Europe/Paris	0
590	Baidoa Airport	Baidoa	Somalia	SO	BIB	HCMB	43.630635	3.10504	Africa/Mogadishu	0
591	Block Island Airport	Block Island	United States	US	BID	KBID	-71.579613	41.169432	America/New_York	0
592	Beatrice Municipal Airport	Beatrice	United States	US	BIE	KBIE	-96.75	40.3	America/Chicago	0
593	Biggs Army Air Field	El Paso	United States	US	BIF	KBIF	-106.375514	31.854273	America/Denver	0
594	Eastern Sierra Regional Airport	Bishop	United States	US	BIH	KBIH	-118.365	37.373333	America/Los_Angeles	0
595	Frans Kaisiepo Airport	Biak	Indonesia	ID	BIK	WABB	136.107301	-1.189503	Asia/Jayapura	0
596	Billings Logan International Airport	Billings	United States	US	BIL	KBIL	-108.537229	45.803419	America/Denver	0
597	Bimini International Airport	Bimini	Bahamas	BS	BIM	MYBS	-79.26399	25.700065	America/Nassau	0
598	Bamiyan Airport	Bamiyan	Afghanistan	AF	BIN	OABN	67.830777	34.813272	Asia/Kabul	0
599	Bilbao Airport	Bilbao	Spain and Canary Islands	ES	BIO	LEBB	-2.905808	43.305535	Europe/Madrid	0
600	Bulimba Airport	Bulimba	Australia	AU	BIP	YBWM	143.75	-16.15	Australia/Brisbane	0
601	Biarritz Pays Basque Airport	Biarritz	France	FR	BIQ	LFBZ	-1.521784	43.466478	Europe/Paris	0
602	Biratnagar Airport	Biratnagar	Nepal	NP	BIR	VNVT	87.266187	26.483439	Asia/Kathmandu	0
603	Bismarck Airport	Bismarck	United States	US	BIS	KBIS	-100.758211	46.77448	America/Chicago	0
604	Patan Airport	Baitadi	Nepal	NP	BIT	VNBT	80.546758	29.465284	Asia/Kathmandu	0
605	Bildudalur Airport	Bildudalur	Iceland	IS	BIU	BIBD	-23.983333	65.833333	Atlantic/Reykjavik	0
606	Bria Airport	Bria	Central African Republic	CF	BIV	FEFR	21.983333	6.533333	Africa/Bangui	0
607	Billiluna Airport	Billiluna	Australia	AU	BIW	YBIL	127.166667	-19.566667	Australia/Perth	0
608	Keesler Air Force Base	Biloxi	United States	US	BIX	KBIX	-88.923622	30.41129	America/Chicago	0
609	Bisho Airport	Bisho	South Africa	ZA	BIY	FABE	27.283333	-35.883333	Africa/Johannesburg	0
610	Bejaia Airport	Bejaia	Algeria	DZ	BJA	DAAE	5.083333	36.75	Africa/Algiers	0
611	Bojnord Airport	Bojnord	Iran	IR	BJB	OIMN	57.308849	37.489719	Asia/Tehran	0
612	Rocky Mountain Metropolitan Airport	Broomfield	United States	US	BJC	KBJC	-105.117236	39.910441	America/Denver	0
613	Batsfjord Airport	Batsfjord	Norway	NO	BJF	ENBS	29.666667	70.6	Europe/Oslo	0
614	Bajhang Airport	Bajhang	Nepal	NP	BJH	VNBG	81.25	29.55	Asia/Kathmandu	0
615	Bemidji Airport	Bemidji	United States	US	BJI	KBJI	-94.934722	47.509722	America/Chicago	0
616	Wayne County Airport	Wooster	United States	US	BJJ	KBJJ	-81.933333	40.8	America/New_York	0
617	Banjul International Airport	Banjul	Gambia	GM	BJL	GBYD	-16.6522	13.34406	Africa/Banjul	0
618	Bujumbura International Airport	Bujumbura	Burundi	BI	BJM	HBBA	29.320148	-3.320557	Africa/Bujumbura	0
619	Bermejo Airport	Bermejo	Bolivia	BO	BJO	SLBJ	-64.333333	-22.866667	America/La_Paz	0
620	Arthur Siqueira State Airport	Braganca Paulista	Brazil	BR	BJP	SBBP	-46.521832	-22.974502	America/Sao_Paulo	0
621	Bahar Dar Airport	Bahar Dar	Ethiopia	ET	BJR	HABD	37.32324	11.603292	Africa/Addis_Ababa	0
622	Bajura Airport	Bajura	Nepal	NP	BJU	VNBR	81.333333	29.366667	Asia/Kathmandu	0
623	Milas-Bodrum Airport	Bodrum	Turkiye	TR	BJV	LTFE	27.672781	37.243952	Europe/Istanbul	0
624	Bajawa Soa Airport	Bajawa	Indonesia	ID	BJW	WATB	120.998515	-8.813029	Asia/Makassar	0
625	Del Bajio International Airport	Leon/Guanajuato	Mexico	MX	BJX	MMLO	-101.481003	20.9935	America/Mexico_City	0
626	Batajnica Airbase	Belgrade	Republic of Serbia	RS	BJY	LYBT	20.2575	44.935278	Europe/Belgrade	0
627	Badajoz Airport	Badajoz	Spain and Canary Islands	ES	BJZ	LEBZ	-6.819564	38.893312	Europe/Madrid	0
628	Nal Airport	Bikaner	India	IN	BKB	VIBK	73.207199	28.070601	Asia/Kolkata	0
629	Buckland Airport	Buckland	United States	US	BKC	PABL	-161.126667	65.978889	America/Anchorage	0
630	Stephens County Airport	Breckenridge	United States	US	BKD	KBKD	-98.9	32.75	America/Chicago	0
631	Baker Airport	Baker	United States	US	BKE	KBKE	-117.81	44.838333	America/Los_Angeles	0
632	Branson Airport	Hollister	United States	US	BKG	KBBG	-93.200544	36.532082	America/Chicago	0
633	Barking Sands Airport	Kekaha	United States	US	BKH	PHBK	-159.765001	22.017555	Pacific/Honolulu	0
634	Kota Kinabalu International Airport	Kota Kinabalu	Malaysia	MY	BKI	WBKK	116.050753	5.923961	Asia/Kuala_Lumpur	0
635	Baralande Airport	Boke	Guinea	GN	BKJ	GUOK	-14.281276	10.965816	Africa/Conakry	0
636	Bangkok Suvarnabhumi International Airport	Bangkok	Thailand	TH	BKK	VTBS	100.752044	13.693062	Asia/Bangkok	0
637	Burke Lakefront Airport	Cleveland	United States	US	BKL	KBKL	-81.683333	41.516944	America/New_York	0
638	Bakalalan Airport	Bakalalan	Malaysia	MY	BKM	WBGQ	115.616667	3.966667	Asia/Kuala_Lumpur	0
639	Bamako-Senou International Airport	Bamako	Mali	ML	BKO	GABS	-7.947951	12.540926	Africa/Bamako	0
640	Barkly Downs Airport	Barkly Downs	Australia	AU	BKP	YBAW	138.5	-20.5	Australia/Brisbane	0
641	Blackall Airport	Blackall	Australia	AU	BKQ	YBCK	145.428333	-24.434167	Australia/Brisbane	0
642	Bokoro Airport	Bokoro	Chad	TD	BKR	FTTK	17.233333	12.416667	Africa/Ndjamena	0
643	Fatmawati Soekarno Airport	Bengkulu	Indonesia	ID	BKS	WIGG	102.338273	-3.860561	Asia/Jakarta	0
644	Blackstone Army Air Field	Blackstone	United States	US	BKT	KBKT	-78	37.066667	America/New_York	0
645	Betioky Airport	Betioky	Madagascar	MG	BKU	FMSV	44.391111	-23.732222	Indian/Antananarivo	0
646	Raleigh County Memorial Airport	Beckley	United States	US	BKW	KBKW	-81.124167	37.781944	America/New_York	0
647	Brookings Airport	Brookings	United States	US	BKX	KBKX	-96.811111	44.303333	America/Chicago	0
648	Kavumu Airport	Bukavu	The Democratic Republic of The Congo	CD	BKY	FZMA	28.808803	-2.308978	Africa/Lubumbashi	0
649	Bukoba Airport	Bukoba	United Republic of Tanzania	TZ	BKZ	HTBU	31.82253	-1.331923	Africa/Dar_es_Salaam	0
650	General Jose Antonio Anzoategui International Airport	Barcelona	Venezuela	VE	BLA	SVBC	-64.685894	10.107936	America/Caracas	0
651	Panama Pacifico Airport	Balboa	Panama	PA	BLB	MPPA	-79.598088	8.914011	America/Panama	0
652	Dala Airport	Borlange/Falun	Sweden	SE	BLE	ESSD	15.50826	60.429731	Europe/Stockholm	0
653	Mercer County Airport	Bluefield	United States	US	BLF	KBLF	-81.208056	37.295833	America/New_York	0
654	Belaga Airport	Belaga	Malaysia	MY	BLG	WBGC	113.783333	2.7	Asia/Kuala_Lumpur	0
655	Blythe Airport	Blythe	United States	US	BLH	KBLH	-114.718889	33.620833	America/Los_Angeles	0
656	Bellingham International Airport	Bellingham	United States	US	BLI	KBLI	-122.532672	48.795733	America/Los_Angeles	0
657	Mostepha Ben Boulaid Airport	Batna	Algeria	DZ	BLJ	DABT	6.310521	35.752548	Africa/Algiers	0
658	Blackpool Airport	Blackpool	United Kingdom	GB	BLK	EGNH	-3.041985	53.778387	Europe/London	0
659	Billund Airport	Billund	Denmark	DK	BLL	EKBI	9.147874	55.747382	Europe/Copenhagen	0
660	Monmouth Executive Airport	Belmar	United States	US	BLM	KBLM	-74.122223	40.184548	America/New_York	0
661	Benalla Airport	Benalla	Australia	AU	BLN	YBLA	145.983333	-36.55	Australia/Sydney	0
662	Blonduos Airport	Blonduos	Iceland	IS	BLO	BIBL	-20.3	65.666667	Atlantic/Reykjavik	0
663	Bellavista Airport	Bellavista	Peru	PE	BLP	SPBL	-69.416667	-16.583333	America/Lima	0
664	Bologna Guglielmo Marconi Airport	Bologna	Italy	IT	BLQ	LIPE	11.293289	44.529268	Europe/Rome	0
665	Bengaluru Kempegowda International Airport	Bengaluru	India	IN	BLR	VOBL	77.710228	13.200771	Asia/Kolkata	0
666	Bollon Airport	Bollon	Australia	AU	BLS	YBLL	147.483333	-28.05	Australia/Brisbane	0
667	Blackwater Airport	Blackwater	Australia	AU	BLT	YBTR	148.808401	-23.602184	Australia/Brisbane	0
668	Blue Canyon Airport	Blue Canyon	United States	US	BLU	KBLU	-120.716667	39.25	America/Los_Angeles	0
669	MidAmerica Saint Louis Airport	Belleville	United States	US	BLV	KBLV	-89.815909	38.547326	America/Chicago	0
670	Beletwene Airport	Beletwene	Somalia	SO	BLW	HCMN	45.238472	4.766305	Africa/Mogadishu	0
671	Belluno Airport	Belluno	Italy	IT	BLX	LIDB	12.216667	46.15	Europe/Rome	0
672	Belmullet Airport	Belmullet	Ireland	IE	BLY	EIBT	-10	54.233333	Europe/Dublin	0
673	Chileka Airport	Blantyre	Malawi	MW	BLZ	FWCL	34.970833	-15.674722	Africa/Blantyre	0
674	Bromma Airport	Stockholm	Sweden	SE	BMA	ESSB	17.946079	59.35566	Europe/Stockholm	0
675	Bumba Airport	Bumba	The Democratic Republic of The Congo	CD	BMB	FZFU	22.481667	2.182778	Africa/Kinshasa	0
676	Brigham City Airport	Brigham City	United States	US	BMC	KBMC	-112.062222	41.549167	America/Denver	0
677	Belo sur Tsiribihina Airport	Belo sur Tsiribihina	Madagascar	MG	BMD	FMML	44.544843	-19.689339	Indian/Antananarivo	0
678	Broome Airport	Broome	Australia	AU	BME	YBRM	122.23429	-17.952641	Australia/Perth	0
679	Bakouma Airport	Bakouma	Central African Republic	CF	BMF	FEGM	22.8	5.733333	Africa/Bangui	0
680	Monroe County Airport	Bloomington	United States	US	BMG	KBMG	-86.614722	39.14	America/Indiana/Indianapolis	0
681	Central Illinois Regional Airport	Bloomington	United States	US	BMI	KBMI	-88.914834	40.48401	America/Chicago	0
682	Baramita Airport	Baramita	Guyana	GY	BMJ	SYBR	-60	6.75	America/Guyana	0
683	Borkum Airport	Borkum	Germany	DE	BMK	EDWR	6.709167	53.59639	Europe/Berlin	0
684	Berlin Airport	Berlin	United States	US	BML	KBML	-71.176389	44.574722	America/New_York	0
685	Bitam Airport	Bitam	Gabon	GA	BMM	FOOB	11.490833	2.075833	Africa/Libreville	0
686	Banmaw Airport	Bhamo	Myanmar	MM	BMO	VYBM	97.249057	24.268355	Asia/Yangon	0
687	Brampton Island Airport	Brampton Island	Australia	AU	BMP	YBPI	149.233333	-20.783333	Australia/Brisbane	0
688	Bamburi Airport	Bamburi	Kenya	KE	BMQ	HKBM	39.833333	-4.5	Africa/Nairobi	0
689	Baltrum Airport	Baltrum	Germany	DE	BMR	EDWZ	7.4	53.716667	Europe/Berlin	0
690	Beaumont Municipal Airport	Beaumont	United States	US	BMT	KBMT	-94.215797	30.0707	America/Chicago	0
691	Sultan Muhammad Salahuddin Airport	Bima	Indonesia	ID	BMU	WADB	118.691765	-8.542521	Asia/Makassar	0
692	Buon Ma Thout Airport	Buon Ma Thout	Viet Nam	VN	BMV	VVBM	108.05	12.666667	Asia/Ho_Chi_Minh	0
693	Bordj Badji Mokhtar Airport	Bordj Badji Mokhtar	Algeria	DZ	BMW	DATM	0.926334	21.375816	Africa/Algiers	0
694	Belep Island Airport	Belep Island	New Caledonia	NC	BMY	NWWC	163.666667	-19.75	Pacific/Noumea	0
695	Nashville International Airport	Nashville	United States	US	BNA	KBNA	-86.668945	36.13174	America/Chicago	0
696	Boende Airport	Boende	The Democratic Republic of The Congo	CD	BNB	FZGN	20.883973	-0.286845	Africa/Kinshasa	0
697	Beni Airport	Beni	The Democratic Republic of The Congo	CD	BNC	FZNP	29.470181	0.577121	Africa/Lubumbashi	0
698	Bandar Abbas International Airport	Bandar Abbas	Iran	IR	BND	OIKB	56.368384	27.21059	Asia/Tehran	0
699	Brisbane Airport	Brisbane	Australia	AU	BNE	YBBN	153.109058	-27.403031	Australia/Brisbane	0
700	Banning Airport	Banning	United States	US	BNG	KBNG	-116.866667	33.933333	America/Los_Angeles	0
701	Benin City Airport	Benin City	Nigeria	NG	BNI	DNBE	5.603863	6.316943	Africa/Lagos	0
702	Ballina Byron Airport	Ballina	Australia	AU	BNK	YBNA	153.556396	-28.837606	Australia/Sydney	0
703	Barnwell County Airport	Barnwell	United States	US	BNL	KBNL	-81.383333	33.25	America/New_York	0
704	Bronnoysund Airport, Bronnoy	Bronnoysund	Norway	NO	BNN	ENBN	12.209954	65.459439	Europe/Oslo	0
705	Burns Municipal Airport	Burns	United States	US	BNO	KBNO	-118.955192	43.590557	America/Los_Angeles	0
706	Bannu Airport	Bannu	Pakistan	PK	BNP	OPBN	70.666667	33	Asia/Karachi	0
707	Banfora Airport	Banfora	Burkina Faso	BF	BNR	DFOB	-4.666667	10.666667	Africa/Ouagadougou	0
708	Barinas Airport	Barinas	Venezuela	VE	BNS	SVBI	-70.221111	8.618056	America/Caracas	0
709	Blumenau Airport	Blumenau	Brazil	BR	BNU	SSBL	-49.090302	-26.830601	America/Sao_Paulo	0
710	Boone Airport	Boone	United States	US	BNW	KBNW	-93.883333	42.066667	America/Chicago	0
711	Banja Luka Airport	Banja Luka	Bosnia and Herzegovina	BA	BNX	LQBK	17.3	44.933333	Europe/Sarajevo	0
712	Bellona Airport	Bellona	Solomon Islands	SB	BNY	AGGB	159.816667	-11.3	Pacific/Guadalcanal	0
713	Boma Airport	Boma	The Democratic Republic of The Congo	CD	BOA	FZAJ	13.066667	-5.866667	Africa/Kinshasa	0
714	Motu Mute Airport	Bora Bora	French Polynesia	PF	BOB	NTTB	-151.754476	-16.446207	Pacific/Tahiti	0
715	Bocas Del Toro Airport	Bocas Del Toro	Panama	PA	BOC	MPBO	-82.251944	9.34	America/Panama	0
716	Bordeaux Airport	Bordeaux	France	FR	BOD	LFBD	-0.70217	44.83102	Europe/Paris	0
717	Boundji Airport	Boundji	Congo	CG	BOE	FCOB	15.383333	-1.033333	Africa/Brazzaville	0
718	Bolling Air Force Base	Washington	United States	US	BOF	KBOF	-77.012501	38.851693	America/New_York	0
719	Bogota El Dorado International Airport	Bogota	Colombia	CO	BOG	SKBO	-74.143136	4.698602	America/Bogota	0
720	Bournemouth Airport	Bournemouth	United Kingdom	GB	BOH	EGHH	-1.832476	50.778269	Europe/London	0
721	Boise Air Terminal	Boise	United States	US	BOI	KBOI	-116.221934	43.569263	America/Denver	0
722	Bourgas Airport	Bourgas	Bulgaria	BG	BOJ	LBBG	27.515544	42.56745	Europe/Sofia	0
723	Brookings State Airport	Brookings	United States	US	BOK	KBOK	-124.283333	42.05	America/Los_Angeles	0
724	Mumbai Chhatrapati Shivaji International Airport	Mumbai	India	IN	BOM	VABB	72.868047	19.089891	Asia/Kolkata	0
725	Flamingo International Airport	Bonaire	Caribbean Netherlands	BQ	BON	TNCB	-68.276873	12.133403	America/Curacao	0
726	Bodo Airport	Bodo	Norway	NO	BOO	ENBO	14.367839	67.27262	Europe/Oslo	0
727	Bouar Airport	Bouar	Central African Republic	CF	BOP	FEFO	15.666667	6	Africa/Bangui	0
728	Boston Logan International Airport	Boston	United States	US	BOS	KBOS	-71.020176	42.36646	America/New_York	0
729	Bourges Airport	Bourges	France	FR	BOU	LFLD	2.37028	47.058102	Europe/Paris	0
730	Bartow Airport	Bartow	United States	US	BOW	KBOW	-81.833333	27.9	America/New_York	0
731	Borroloola Airport	Borroloola	Australia	AU	BOX	YBRL	136.283333	-16.066667	Australia/Darwin	0
732	Borgo Airport	Bobo Dioulasso	Burkina Faso	BF	BOY	DFOO	-4.324444	11.163611	Africa/Ouagadougou	0
733	Bozoum Airport	Bozoum	Central African Republic	CF	BOZ	FEGZ	16.583333	6.416667	Africa/Bangui	0
734	Borongan Airport	Borongan	Philippines	PH	BPA	RPVW	125.47833	11.67583	Asia/Manila	0
735	Bamenda Airport	Bamenda	Cameroon	CM	BPC	FKKV	10.15	5.916667	Africa/Douala	0
736	Batuna Airport	Batuna	Solomon Islands	SB	BPF	AGBT	158.116667	-8.55	Pacific/Guadalcanal	0
737	Barra Do Garcas Airport	Barra Do Garcas	Brazil	BR	BPG	SBBW	-52.388965	-15.861337	America/Campo_Grande	0
738	Bislig Airport	Bislig	Philippines	PH	BPH	RPMF	126.321111	8.196667	Asia/Manila	0
739	Miley Memorial Field	Big Piney	United States	US	BPI	KBPI	-110.111064	42.585029	America/Denver	0
740	Sultan Aji Muhamad Sulaiman Airport	Balikpapan	Indonesia	ID	BPN	WALL	116.900817	-1.260623	Asia/Makassar	0
741	Porto Seguro Airport	Porto Seguro	Brazil	BR	BPS	SBPS	-39.081095	-16.441158	America/Belem	0
742	Jefferson County Airport	Beaumont	United States	US	BPT	KBPT	-94.02	29.950833	America/Chicago	0
743	Bangda Airport	Bangda	China	CN	BPX	ZUBD	97.106667	30.555833	Asia/Shanghai	0
744	Besalampy Airport	Besalampy	Madagascar	MG	BPY	FMNQ	44.483333	-16.75	Indian/Antananarivo	0
745	Dr. Juan C. Angara Airport	Baler	Philippines	PH	BQA	RPUR	121.502761	15.732205	Asia/Manila	0
746	Busselton Airport	Busselton	Australia	AU	BQB	YBLN	115.402035	-33.686879	Australia/Perth	0
747	Bubaque Airport	Bubaque	Guinea-Bissau	GW	BQE	GGBU	-15.85	11.3	Africa/Bissau	0
748	Bogorodskoye Airport	Bogorodskoye	Russian Federation	RU	BQG	UHNB	140.44833	52.378334	Asia/Vladivostok	0
749	Biggin Hill Airport	London	United Kingdom	GB	BQH	EGKB	0.033333	51.333333	Europe/London	0
750	Bagani Airport	Bagani	Namibia	NA	BQI	FYBG	21.629722	-18.118056	Africa/Windhoek	0
751	Batagay Airport	Batagay	Russian Federation	RU	BQJ	UEBB	134.695	67.648889	Asia/Vladivostok	0
752	Glynco Jetport	Brunswick	United States	US	BQK	KBQK	-81.483333	31.166667	America/New_York	0
753	Boulia Airport	Boulia	Australia	AU	BQL	YBOU	139.9	-22.9	Australia/Brisbane	0
754	Rafael Hernandez Airport	Aguadilla	Puerto Rico	PR	BQN	TJBQ	-67.134133	18.495347	America/Puerto_Rico	0
755	Bouna Airport	Bouna	Cote d'Ivoire	CI	BQO	DIBN	-3	9.266667	Africa/Abidjan	0
756	Barra Airport	Barra	Brazil	BR	BQQ	SNBX	-43.133333	-11.083333	America/Belem	0
757	Blagoveschensk Airport	Blagoveschensk	Russian Federation	RU	BQS	UHBB	127.4	50.416667	Asia/Yakutsk	0
758	Brest Airport	Brest	Belarus	BY	BQT	UMBB	23.898222	52.110065	Europe/Minsk	0
759	Balgo Hills Airport	Balgo Hills	Australia	AU	BQW	YBGO	127.8	-20.183333	Australia/Perth	0
760	Barreiras Airport	Barreiras	Brazil	BR	BRA	SNBR	-45.008333	-12.073056	America/Belem	0
761	Barreirinhas Airport	Barreirinhas	Brazil	BR	BRB	SBRR	-42.817098	-2.755616	America/Belem	0
762	San Carlos de Bariloche International Airport	San Carlos de Bariloche	Argentina	AR	BRC	SAZS	-71.161085	-41.145965	America/Argentina/Buenos_Aires	0
763	Crow Wing County Airport	Brainerd	United States	US	BRD	KBRD	-94.1375	46.397222	America/Chicago	0
764	Bremen Airport	Bremen	Germany	DE	BRE	EDDW	8.785352	53.052971	Europe/Berlin	0
765	Palese Airport	Bari	Italy	IT	BRI	LIBD	16.76391	41.133881	Europe/Rome	0
766	Bourke Airport	Bourke	Australia	AU	BRK	YBKE	145.933333	-30.083333	Australia/Sydney	0
767	Burlington Airport	Burlington	United States	US	BRL	KBRL	-91.123333	40.786111	America/Chicago	0
768	Barquisimeto Airport	Barquisimeto	Venezuela	VE	BRM	SVBM	-69.359844	10.046267	America/Caracas	0
769	Bern Airport	Berne	Switzerland	CH	BRN	LSZB	7.50356	46.911728	Europe/Zurich	0
770	South Padre Island International Airport	Brownsville	United States	US	BRO	KBRO	-97.423333	25.908889	America/Chicago	0
771	Turany Airport	Brno	Czech Republic	CZ	BRQ	LKTB	16.7	49.15	Europe/Prague	0
772	North Bay Airport	Barra	United Kingdom	GB	BRR	EGPR	-7.449343	57.025237	Europe/London	0
773	Bristol Airport	Bristol	United Kingdom	GB	BRS	EGGD	-2.710659	51.386756	Europe/London	0
774	Bathurst Island Airport	Bathurst Island	Australia	AU	BRT	YBTI	130.633333	-11.766667	Australia/Darwin	0
775	Brussels Airport	Brussels	Belgium	BE	BRU	EBBR	4.483602	50.89717	Europe/Brussels	0
776	Bremerhaven Airport	Bremerhaven	Germany	DE	BRV	EDWB	8.572528	53.503156	Europe/Berlin	0
777	Wiley Post-Will Rogers Memorial Airport	Utqiagvik Barrow	United States	US	BRW	PABR	-156.770252	71.287223	America/Anchorage	0
778	Barahona Airport	Barahona	Dominican Republic	DO	BRX	MDBH	-71.116667	18.216667	America/Santo_Domingo	0
779	Samuels Field	Bardstown	United States	US	BRY	KBRY	-85.484178	37.822034	America/New_York	0
780	Bossaso Airport	Bossaso	Somalia	SO	BSA	HCMF	49.15	11.283333	Africa/Mogadishu	0
781	Brasilia International Airport	Brasilia	Brazil	BR	BSB	SBBR	-47.921486	-15.869807	America/Sao_Paulo	0
782	Bahia Solano Airport	Bahia Solano	Colombia	CO	BSC	SKBS	-77.4	6.183333	America/Bogota	0
783	Baoshan Airport	Baoshan	China	CN	BSD	ZPBS	99.161427	25.055181	Asia/Shanghai	0
784	Bradshaw Army Air Field	Pohakuloa	United States	US	BSF	PHSF	-155.549427	19.758207	Pacific/Honolulu	0
785	Bata Airport	Bata	Equatorial Guinea	GQ	BSG	FGBT	9.802222	1.906667	Africa/Malabo	0
786	Bairnsdale Airport	Bairnsdale	Australia	AU	BSJ	YBNS	147.567993	-37.887501	Australia/Sydney	0
787	Mohamed Khider Airport	Biskra	Algeria	DZ	BSK	DAUB	5.738056	34.793333	Africa/Algiers	0
788	Bishe Kola Air Base	Amol	Iran	IR	BSM	OINJ	52.350462	36.65551	Asia/Tehran	0
789	Bossangoa Airport	Bossangoa	Central African Republic	CF	BSN	FEFS	17.5	6.583333	Africa/Bangui	0
790	Basco Airport	Basco	Philippines	PH	BSO	RPUO	121.977778	20.453056	Asia/Manila	0
791	Basra International Airport	Basra	Iraq	IQ	BSR	ORMM	47.666865	30.552695	Asia/Baghdad	0
792	Balsas Airport	Balsas	Brazil	BR	BSS	SNBS	-46.05	-7.516667	America/Belem	0
793	Bost Airport	Bost	Afghanistan	AF	BST	OABT	64.366667	31.55	Asia/Kabul	0
794	Basankusu Airport	Basankusu	The Democratic Republic of The Congo	CD	BSU	FZEN	19.788889	1.221667	Africa/Kinshasa	0
795	Pathein Airport	Pathein	Myanmar	MM	BSX	VYPN	94.774901	16.812453	Asia/Yangon	0
796	Bardera Airport	Bardera	Somalia	SO	BSY	HCMD	42.333333	2.35	Africa/Mogadishu	0
797	Bertoua Airport	Bertoua	Cameroon	CM	BTA	FKKO	13.72602	4.548878	Africa/Douala	0
798	Betou Airport	Betou	Congo	CG	BTB	FCOT	18.5	3.05	Africa/Brazzaville	0
799	Batticaloa Airport	Batticaloa	Sri Lanka	LK	BTC	VCCB	81.678544	7.704878	Asia/Colombo	0
800	Brunette Downs Airport	Brunette Downs	Australia	AU	BTD	YBRU	135.916667	-18.666667	Australia/Darwin	0
801	Bonthe Airport	Bonthe	Sierra Leone	SL	BTE	GFBN	-12.008333	7	Africa/Freetown	0
802	Bountiful Skypark	Bountiful	United States	US	BTF	KBTF	-111.927485	40.869432	America/Denver	0
803	Batangafo Airport	Batangafo	Central African Republic	CF	BTG	FEGF	18.333333	7.416667	Africa/Bangui	0
804	Hang Nadim International Airport	Batam	Indonesia	ID	BTH	WIDD	104.115279	1.123627	Asia/Jakarta	0
805	Barter Island Airport	Barter Island	United States	US	BTI	PABA	-143.578333	70.134722	America/Anchorage	0
806	Sultan Iskandar Muda International Airport	Banda Aceh	Indonesia	ID	BTJ	WITT	95.418329	5.518021	Asia/Jakarta	0
807	Bratsk Airport	Bratsk	Russian Federation	RU	BTK	UIBB	101.697998	56.370602	Asia/Irkutsk	0
808	WK Kellogg Regional Airport	Battle Creek	United States	US	BTL	KBTL	-85.252674	42.305036	America/New_York	0
809	Butte Airport	Butte	United States	US	BTM	KBTM	-112.493889	45.951111	America/Denver	0
810	Bennettsville Airport	Bennettsville	United States	US	BTN	KBBP	-79.683333	34.616667	America/New_York	0
811	Graham Field	Butler	United States	US	BTP	KBTP	-79.916667	40.85	America/New_York	0
812	Butare Airport	Butare	Rwanda	RW	BTQ	HRYI	29.733333	-2.6	Africa/Kigali	0
813	Baton Rouge Metropolitan Airport	Baton Rouge	United States	US	BTR	KBTR	-91.156907	30.532537	America/Chicago	0
814	M.R. Stefanik Airport	Bratislava	Slovakia	SK	BTS	LZIB	17.212665	48.170125	Europe/Bratislava	0
815	Bettles Airport	Bettles	United States	US	BTT	PABT	-151.526389	66.915278	America/Anchorage	0
816	Bintulu Airport	Bintulu	Malaysia	MY	BTU	WBGB	113.023112	3.123505	Asia/Kuala_Lumpur	0
817	Burlington International Airport	Burlington	United States	US	BTV	KBTV	-73.155277	44.469014	America/New_York	0
818	Batulicin Airport	Batulicin	Indonesia	ID	BTW	WAOC	116.000082	-3.41194	Asia/Makassar	0
819	Betoota Airport	Betoota	Australia	AU	BTX	YBEO	140.733333	-25.7	Australia/Brisbane	0
820	Beatty Airport	Beatty	United States	US	BTY	KBTY	-116.766667	36.9	America/Los_Angeles	0
821	Betong Airport	Yala	Thailand	TH	BTZ	VTSY	101.14694	5.78861	Asia/Bangkok	0
822	Buka Airport	Buka	Papua New Guinea	PG	BUA	AYBK	154.672885	-5.422443	Pacific/Bougainville	0
823	Cram Field	Burwell	United States	US	BUB	KBUB	-99.147158	41.775599	America/Chicago	0
824	Burketown Airport	Burketown	Australia	AU	BUC	YBKT	139.533333	-17.75	Australia/Brisbane	0
825	Budapest Ferenc Liszt International Airport	Budapest	Hungary	HU	BUD	LHBP	19.261621	47.433037	Europe/Budapest	0
826	Buffalo Niagara International Airport	Buffalo	United States	US	BUF	KBUF	-78.731804	42.933828	America/New_York	0
827	17 de Setembro Airport	Benguela	Angola	AO	BUG	FNBG	13.403714	-12.609024	Africa/Luanda	0
828	Bokondini Airport	Bokondini	Indonesia	ID	BUI	WAJB	133.583333	-2	Asia/Jayapura	0
829	Ain Eddis Airport	Boussaada	Algeria	DZ	BUJ	DAAD	4.15	35.166667	Africa/Algiers	0
830	Albuq Airport	Albuq	Republic of Yemen	YE	BUK	OYBQ	43.766667	15.833333	Asia/Aden	0
831	Bulolo Airport	Bulolo	Papua New Guinea	PG	BUL	AYBU	146.647778	-7.189722	Pacific/Port_Moresby	0
832	Butler Airport	Butler	United States	US	BUM	KBUM	-94.333333	38.266667	America/Chicago	0
833	Buenaventura Airport	Buenaventura	Colombia	CO	BUN	SKBU	-76.995833	3.825	America/Bogota	0
834	Burao Airport	Burao	Somalia	SO	BUO	HCMV	45.554167	9.5225	Africa/Mogadishu	0
835	Bathinda Airport	Bathinda	India	IN	BUP	VIBT	74.755809	30.270092	Asia/Kolkata	0
836	Bulawayo Airport	Bulawayo	Zimbabwe	ZW	BUQ	FVJN	28.622616	-20.014933	Africa/Harare	0
837	Hollywood Burbank Airport	Burbank	United States	US	BUR	KBUR	-118.354113	34.196188	America/Los_Angeles	0
838	Batumi Airport	Batumi	Georgia	GE	BUS	UGSB	41.600556	41.610833	Asia/Tbilisi	0
839	Muara Bungo Airport	Muara Bungo	Indonesia	ID	BUU	WIJB	102.179283	-1.540169	Asia/Jakarta	0
840	Bella Union Airport	Bella Union	Uruguay	UY	BUV	SUBU	-57.083333	-30.333333	America/Montevideo	0
841	Baubau Airport	Baubau	Indonesia	ID	BUW	WAWB	122.569	-5.48688	Asia/Makassar	0
842	Bunia Airport	Bunia	The Democratic Republic of The Congo	CD	BUX	FZKA	30.220833	1.565833	Africa/Lubumbashi	0
843	Bunbury Airport	Bunbury	Australia	AU	BUY	YBUN	115.678948	-33.377824	Australia/Perth	0
844	Bushehr Airport	Bushehr	Iran	IR	BUZ	OIBB	50.825425	28.958285	Asia/Tehran	0
845	Beauvais-Tille Airport	Paris	France	FR	BVA	LFOB	2.110815	49.459488	Europe/Paris	0
846	Boa Vista Airport	Boa Vista	Brazil	BR	BVB	SBBV	-60.666667	2.833333	America/Porto_Velho	0
847	Rabil Airport	Boa Vista	Cape Verde	CV	BVC	GVBA	-22.888901	16.136499	Atlantic/Cape_Verde	0
848	Vallee de la Dordogne Airport	Brive-La-Gaillarde	France	FR	BVE	LFSL	1.485556	45.039722	Europe/Paris	0
849	Berlevag Airport	Berlevag	Norway	NO	BVG	ENBV	29	70.866667	Europe/Oslo	0
850	Vilhena Airport	Vilhena	Brazil	BR	BVH	SBVH	-60.116667	-12.716667	America/Porto_Velho	0
851	Birdsville Airport	Birdsville	Australia	AU	BVI	YBDV	139.343333	-25.898333	Australia/Brisbane	0
852	Belmonte Airport	Belmonte	Brazil	BR	BVM	SNBL	-38.916667	-15.833333	America/Belem	0
853	Bartlesville Municipal Airport	Bartlesville	United States	US	BVO	KBVO	-96.010833	36.7625	America/Chicago	0
854	Breves Airport	Breves	Brazil	BR	BVS	SNVS	-50.466667	-1.666667	America/Belem	0
855	Beluga Airport	Beluga	United States	US	BVU	PABG	-151.036111	61.169444	America/Anchorage	0
856	Burevestnik Airport	Burevestnik	Russian Federation	RU	BVV	UHSB	147.613366	44.928645	Asia/Ust-Nera	0
857	Batavia Downs Airport	Batavia Downs	Australia	AU	BVW	YBTV	143.216667	-12.65	Australia/Brisbane	0
858	Batesville Regional Airport	Batesville	United States	US	BVX	KBVX	-91.65	35.766667	America/Chicago	0
859	Beverly Municipal Airport	Beverly	United States	US	BVY	KBVY	-70.915335	42.585167	America/New_York	0
860	Bhairawa Airport	Bhairawa	Nepal	NP	BWA	VNBW	83.42	27.504167	Asia/Kathmandu	0
861	Barrow Island Airport	Barrow Island	Australia	AU	BWB	YBWX	115.405998	-20.864401	Australia/Perth	0
862	Brawley Municipal Airport	Brawley	United States	US	BWC	KBWC	-115.516875	32.992865	America/Los_Angeles	0
863	Brownwood Regional Airport	Brownwood	United States	US	BWD	KBWD	-98.956667	31.794722	America/Chicago	0
864	Braunschweig-Wolfsburg Airport	Braunschweig	Germany	DE	BWE	EDVE	10.557137	52.318095	Europe/Berlin	0
865	Walney Island Airport	Barrow-In-Furness	United Kingdom	GB	BWF	EGNL	-3.233333	54.116667	Europe/London	0
866	Warren County Airport	Bowling Green	United States	US	BWG	KBWG	-86.422222	36.962222	America/Chicago	0
867	Butterworth Airport	Butterworth	Malaysia	MY	BWH	WMKB	100.3925	5.466667	Asia/Kuala_Lumpur	0
868	Baltimore/Washington Intl Thurgood Marshall Airport	Baltimore	United States	US	BWI	KBWI	-76.668941	39.179526	America/New_York	0
869	Bowman Airport	Bowman	United States	US	BWM	KBPP	-103.4	46.183333	America/Denver	0
870	Brunei International Airport	Bandar Seri Begawan	Brunei Darussalam	BN	BWN	WBSB	114.93375	4.945197	Asia/Brunei	0
871	Brewarrina Airport	Brewarrina	Australia	AU	BWQ	YBRW	146.866667	-29.95	Australia/Sydney	0
872	Burnie Wynyard Airport	Burnie	Australia	AU	BWT	YWYY	145.725074	-40.993145	Australia/Hobart	0
873	Las Brujas Airport	Cayo las Brujas	Cuba	CU	BWW	MUBR	-79.147222	22.621389	America/Havana	0
874	Blimbingsari Airport	Banyuwangi	Indonesia	ID	BWX	WADY	114.340461	-8.310229	Asia/Jakarta	0
875	George R. Carr Airport	Bogalusa	United States	US	BXA	KBXA	-89.883333	30.933333	America/Chicago	0
876	Babo Airport	Babo	Indonesia	ID	BXB	WASO	133.441147	-2.532486	Asia/Jayapura	0
877	Bade Airport	Bade	Indonesia	ID	BXD	WAKE	139.5	-7.166667	Asia/Jayapura	0
878	Bakel Airport	Bakel	Senegal	SN	BXE	GOTB	-12.467778	14.841667	Africa/Dakar	0
879	Belburn Airport	Belburn	Australia	AU	BXF	YBEB	128.307778	-17.545556	Australia/Perth	0
880	Bendigo Airport	Bendigo	Australia	AU	BXG	YBDG	144.327227	-36.737608	Australia/Sydney	0
881	Balhash Airport	Balhash	Kazakhstan	KZ	BXH	UAAH	75.004381	46.894216	Asia/Almaty	0
882	Boundiali Airport	Boundiali	Cote d'Ivoire	CI	BXI	DIBI	-6.5	8.75	Africa/Abidjan	0
883	Borolday Airport	Almaty	Kazakhstan	KZ	BXJ	UAAR	76.882627	43.351471	Asia/Almaty	0
884	Buckeye Airport	Buckeye	United States	US	BXK	KBXK	-112.583333	33.366667	America/Phoenix	0
885	Batom Airport	Batom	Indonesia	ID	BXM	WAJG	140.85	-4.116667	Asia/Jayapura	0
886	Imsik Airport	Bodrum	Turkiye	TR	BXN	LTBV	27.664951	37.138353	Europe/Istanbul	0
887	Buochs Airport	Buochs	Switzerland	CH	BXO	LSZC	8.383333	46.966667	Europe/Zurich	0
888	Bam Airport	Bam	Iran	IR	BXR	OIKM	58.449356	29.080082	Asia/Tehran	0
889	Bontang Airport	Bontang	Indonesia	ID	BXT	WALC	117.5	0.166667	Asia/Makassar	0
890	Butuan Airport	Butuan	Philippines	PH	BXU	RPME	125.481228	8.947999	Asia/Manila	0
891	Bawean Airport	Bawean	Indonesia	ID	BXW	WARW	112.676667	-5.723611	Asia/Jakarta	0
892	Yacuiba Airport	Yacuiba	Bolivia	BO	BYC	SLYA	-63.65	-21.95	America/La_Paz	0
893	Beidah Airport	Beidah	Republic of Yemen	YE	BYD	OYBD	46.55	14.133333	Asia/Aden	0
894	Buffalo Municipal Airport	Buffalo	United States	US	BYG	KBYG	-106.7	44.35	America/Denver	0
895	Arkansas International Airport	Blytheville	United States	US	BYH	KBYH	-89.945216	35.960897	America/Chicago	0
896	Burley Municipal Airport	Burley	United States	US	BYI	KBYI	-113.774167	42.541389	America/Denver	0
897	Bouake Airport	Bouake	Cote d'Ivoire	CI	BYK	DIBK	-5.069469	7.736606	Africa/Abidjan	0
898	C.M. de Cespedes Airport	Bayamo	Cuba	CU	BYM	MUBY	-76.65	20.383333	America/Havana	0
899	Bayankhongor Airport	Bayankhongor	Mongolia	MN	BYN	ZMBH	100.683333	46.1	Asia/Ulaanbaatar	0
900	Bonito Airport	Bonito	Brazil	BR	BYO	SBDB	-56.45085	-21.243866	America/Campo_Grande	0
901	Barimunya Airport	Barimunya	Australia	AU	BYP	YBRY	119.166111	-22.673889	Australia/Perth	0
902	Bunyu Airport	Bunyu	Indonesia	ID	BYQ	WAQB	117.833333	3.583333	Asia/Makassar	0
903	Laeso Airport	Laeso Island	Denmark	DK	BYR	EKLS	11.005083	57.277563	Europe/Copenhagen	0
904	Bicycle Lake Army Air Field	Fort Irwin	United States	US	BYS	KBYS	-116.566667	35.266667	America/Los_Angeles	0
905	Bantry Airport	Bantry	Ireland	IE	BYT	EIBN	-9.45	51.683333	Europe/Dublin	0
906	Bindlacher-Berg Airport	Bayreuth	Germany	DE	BYU	EDQD	11.64	49.985556	Europe/Berlin	0
907	Baniyala Airport	Baniyala	Australia	AU	BYX	YBNI	136.233333	-13.2	Australia/Darwin	0
908	San Pedro Airport	Bonanza	Nicaragua	NI	BZA	MNBZ	-84.6	13.95	America/Managua	0
909	Balranald Airport	Balranald	Australia	AU	BZD	YBRN	143.616667	-34.616667	Australia/Sydney	0
910	Belize City Philip SW Goldson Intl Airport	Belize City	Belize	BZ	BZE	MZBZ	-88.308333	17.539167	America/Belize	0
911	Ignacy Jan Paderewski Airport	Bydgoszcz	Poland	PL	BZG	EPBY	17.978611	53.096667	Europe/Warsaw	0
912	Bumi Hills Airport	Bumi Hills	Zimbabwe	ZW	BZH	FVBM	28.35	-16.816667	Africa/Harare	0
913	Balikesir Airport	Balikesir	Turkiye	TR	BZI	LTBF	27.927778	39.617222	Europe/Istanbul	0
914	Bryansk International Airport	Bryansk	Russian Federation	RU	BZK	UUBP	34.176383	53.213911	Europe/Moscow	0
915	Barisal Airport	Barisal	Bangladesh	BD	BZL	VGBR	90.301446	22.798942	Asia/Dhaka	0
916	Bozeman Yellowstone International Airport	Belgrade	United States	US	BZN	KBZN	-111.160334	45.777687	America/Denver	0
917	Bolzano Airport	Bolzano	Italy	IT	BZO	LIPB	11.330511	46.462444	Europe/Rome	0
918	Bizant Airport	Bizant	Australia	AU	BZP	YBIZ	144.633333	-15.216667	Australia/Brisbane	0
919	Beziers Vias Airport	Beziers	France	FR	BZR	LFMU	3.353485	43.321186	Europe/Paris	0
920	Buta Airport	Buta	The Democratic Republic of The Congo	CD	BZU	FZKJ	24.733333	2.8	Africa/Lubumbashi	0
921	Maya Maya Airport	Brazzaville	Congo	CG	BZV	FCBB	15.251139	-4.258899	Africa/Brazzaville	0
922	Balti International Airport	Balti	Republic of Moldova	MD	BZY	LUBL	27.778148	47.841868	Europe/Chisinau	0
923	RAF Brize Norton	Brize Norton	United Kingdom	GB	BZZ	EGVN	-1.587093	51.75	Europe/London	0
924	Catacamas Airport	Catacamas	Honduras	HN	CAA	MHCA	-85.894444	14.830556	America/Tegucigalpa	0
925	Cabinda Airport	Cabinda	Angola	AO	CAB	FNCA	12.2	-5.583333	Africa/Luanda	0
926	Cascavel Airport	Cascavel	Brazil	BR	CAC	SBCA	-53.501565	-25.001606	America/Sao_Paulo	0
927	Wexford County Airport	Cadillac	United States	US	CAD	KCAD	-85.422222	44.275833	America/New_York	0
928	Columbia Metropolitan Airport	Columbia	United States	US	CAE	KCAE	-81.119497	33.938804	America/New_York	0
929	Carauari Airport	Carauari	Brazil	BR	CAF	SWCA	-66.916667	-4.9	America/Porto_Velho	0
930	Cagliari Elmas Airport	Cagliari	Italy	IT	CAG	LIEE	9.060673	39.254333	Europe/Rome	0
931	Cairo International Airport	Cairo	Egypt	EG	CAI	HECA	31.406469	30.120106	Africa/Cairo	0
932	Canaima Airport	Canaima	Venezuela	VE	CAJ	SVCN	-62.853511	6.240634	America/Caracas	0
933	Akron-Canton Airport	Akron	United States	US	CAK	KCAK	-81.435831	40.914962	America/New_York	0
934	Machrihanish Airport	Campbeltown	United Kingdom	GB	CAL	EGEC	-5.686667	55.436389	Europe/London	0
935	Camiri Airport	Camiri	Bolivia	BO	CAM	SLCA	-63.561111	-20.011111	America/La_Paz	0
936	Guangzhou Baiyun International Airport	Guangzhou	China	CN	CAN	ZGGG	113.29734	23.387862	Asia/Shanghai	0
937	Clayton Municipal Airpark	Clayton	United States	US	CAO	KCAO	-103.153654	36.446061	America/Denver	0
938	Hugo Chavez International Airport	Cap Haitien	Haiti	HT	CAP	MTCH	-72.195	19.732778	America/Port-au-Prince	0
939	Juan H. White Airport	Caucasia	Colombia	CO	CAQ	SKCU	-75.197183	7.967905	America/Bogota	0
940	Caribou Municipal Airport	Caribou	United States	US	CAR	KCAR	-68.016667	46.866667	America/New_York	0
941	Cascais Municipal Aerodrome	Tires	Portugal	PT	CAT	LPCS	-9.355278	38.725556	Europe/Lisbon	0
942	Caruaru Airport	Caruaru	Brazil	BR	CAU	SNRU	-35.916667	-8.25	America/Belem	0
943	Bartolomeu Lisandro Airport	Campos	Brazil	BR	CAW	SBCP	-41.303481	-21.700159	America/Sao_Paulo	0
944	Carlisle Airport	Carlisle	United Kingdom	GB	CAX	EGNC	-2.809444	54.936667	Europe/London	0
945	Felix Eboue Airport	Cayenne	French Guiana	GF	CAY	SOCA	-52.366667	4.816667	America/Cayenne	0
946	Cobar Airport	Cobar	Australia	AU	CAZ	YCBA	145.796588	-31.536796	Australia/Sydney	0
947	J Wilsterman Airport	Cochabamba	Bolivia	BO	CBB	SLCB	-66.178896	-17.413954	America/La_Paz	0
948	Car Nicobar Air Force Base	Car Nicobar	India	IN	CBD	VOCX	92.821031	9.156177	Asia/Kolkata	0
949	Wiley Ford Airport	Cumberland	United States	US	CBE	KCBE	-78.766111	39.614444	America/New_York	0
950	Council Bluffs Municipal Airport	Council Bluffs	United States	US	CBF	KCBF	-95.757689	41.259926	America/Chicago	0
951	Cambridge Airport	Cambridge	United Kingdom	GB	CBG	EGSC	0.177738	52.208044	Europe/London	0
952	Leger Airport	Bechar	Algeria	DZ	CBH	DAOR	-2.259722	31.647778	Africa/Algiers	0
953	Cape Barren Island Airport	Cape Barren Island	Australia	AU	CBI	YCBN	148.01664	-40.390074	Australia/Hobart	0
954	Cabo Rojo Airport	Cabo Rojo	Dominican Republic	DO	CBJ	MDCR	-71.65	17.933333	America/Santo_Domingo	0
955	Colby Municipal Airport	Colby	United States	US	CBK	KCBK	-101.050303	39.426141	America/Chicago	0
956	Tomas de Heres Airport	Ciudad Bolivar	Venezuela	VE	CBL	SVCB	-63.534656	8.122381	America/Caracas	0
957	Columbus Air Force Base	Columbus	United States	US	CBM	KCBM	-88.444666	33.64384	America/Chicago	0
958	Penggung Airport	Cirebon	Indonesia	ID	CBN	WICD	108.533333	-6.75	Asia/Jakarta	0
959	Awang Airport	Cotabato	Philippines	PH	CBO	RPMC	124.214639	7.161412	Asia/Manila	0
960	Coimbra Airport	Coimbra	Portugal	PT	CBP	LPCO	-8.416667	40.2	Europe/Lisbon	0
961	Calabar Airport	Calabar	Nigeria	NG	CBQ	DNCA	8.347415	4.96889	Africa/Lagos	0
962	Canberra Airport	Canberra	Australia	AU	CBR	YSCB	149.190528	-35.30735	Australia/Sydney	0
963	Oro Negro Airport	Cabimas	Venezuela	VE	CBS	SVON	-71.416667	10.383333	America/Caracas	0
964	Catumbela Airport	Catumbela	Angola	AO	CBT	FNCM	13.483333	-12.483333	Africa/Luanda	0
965	Cottbus Airport	Cottbus	Germany	DE	CBU	ETHT	14.299167	51.770278	Europe/Berlin	0
966	Coban Airport	Coban	Guatemala	GT	CBV	MGCB	-90.409167	15.471667	America/Guatemala	0
967	Condobolin Airport	Condobolin	Australia	AU	CBX	YCDO	148.25	-33.866667	Australia/Sydney	0
968	Canobie Airport	Canobie	Australia	AU	CBY	YCBE	140.926111	-19.478611	Australia/Brisbane	0
969	Chimore Airport	Chimore	Bolivia	BO	CCA	SLHI	-65.1415	-16.98975	America/La_Paz	0
970	Cable Airport	Upland	United States	US	CCB	KCCB	-117.687638	34.111563	America/Los_Angeles	0
971	Jardines del Rey Airport	Cayo Coco	Cuba	CU	CCC	MUCC	-78.328611	22.461111	America/Havana	0
972	Carcassonne Airport	Carcassonne	France	FR	CCF	LFMK	2.308594	43.215476	Europe/Paris	0
973	Chile Chico Airport	Chile Chico	Chile	CL	CCH	SCCC	-71.7	-46.55	America/Santiago	0
974	Concordia Airport	Concordia	Brazil	BR	CCI	SSCK	-52.050556	-27.181389	America/Sao_Paulo	0
975	Calicut International Airport	Kozhikode	India	IN	CCJ	VOCL	75.949976	11.138782	Asia/Kolkata	0
976	Cocos Islands Airport	Cocos Islands	Cocos (Keeling) Islands	CC	CCK	YPCC	96.8339	-12.1883	Indian/Cocos	0
977	Chinchilla Airport	Chinchilla	Australia	AU	CCL	YCCA	150.61823	-26.772339	Australia/Brisbane	0
978	Criciuma Airport	Criciuma	Brazil	BR	CCM	SBCM	-49.366667	-28.7	America/Sao_Paulo	0
979	Chaghcharan Airport	Chaghcharan	Afghanistan	AF	CCN	OACC	65.265506	34.524826	Asia/Kabul	0
980	Carimagua Airport	Carimagua	Colombia	CO	CCO	SKCI	-71.333333	4.566667	America/Bogota	0
981	Carriel Sur Airport	Concepcion	Chile	CL	CCP	SCIE	-73.059444	-36.777121	America/Santiago	0
982	Buchanan Field	Concord	United States	US	CCR	KCCR	-122.055556	37.988889	America/Los_Angeles	0
983	Simon Bolivar International Airport	Caracas	Venezuela	VE	CCS	SVMI	-67.005511	10.596942	America/Caracas	0
984	Kolkata Netaji Subhas Chandra Bose Intl Airport	Kolkata	India	IN	CCU	VECC	88.447	22.655	Asia/Kolkata	0
985	Craig Cove Airport	Craig Cove	Vanuatu	VU	CCV	NVSF	167.5	-16.2	Pacific/Efate	0
986	Cowell Airport	Cowell	Australia	AU	CCW	YCWL	136.833333	-33.633333	Australia/Adelaide	0
987	Caceres Airport	Caceres	Brazil	BR	CCX	SWKC	-57.7	-16.066667	America/Campo_Grande	0
988	Charles City Municipal Airport	Charles City	United States	US	CCY	KCCY	-92.683333	43.066667	America/Chicago	0
989	Chub Cay Airport	Chub Cay	Bahamas	BS	CCZ	MYBC	-77.881389	25.4175	America/Nassau	0
990	Cooinda Airport	Cooinda	Australia	AU	CDA	YCOO	132.5225	-12.905278	Australia/Darwin	0
991	Cold Bay Airport	Cold Bay	United States	US	CDB	PACD	-162.721354	55.198716	America/Anchorage	0
992	Cedar City Airport	Cedar City	United States	US	CDC	KCDC	-113.096111	37.7025	America/Denver	0
993	Paris Charles de Gaulle Airport	Paris	France	FR	CDG	LFPG	2.567023	49.003196	Europe/Paris	0
994	Harrell Field	Camden	United States	US	CDH	KCDH	-92.833333	33.583333	America/Chicago	0
995	Conceicao Do Araguaia Airport	Conceicao Do Araguaia	Brazil	BR	CDJ	SBAA	-49.283333	-8.233333	America/Belem	0
996	Lewis Airport	Cedar Key	United States	US	CDK	KCDK	-83.033333	29.133333	America/New_York	0
997	Woodward Field	Camden	United States	US	CDN	KCDN	-80.6	34.266667	America/New_York	0
998	Cradock Airport	Cradock	South Africa	ZA	CDO	FACD	25.6467	-32.1547	Africa/Johannesburg	0
999	Kadapa Airport	Kadapa	India	IN	CDP	VOCP	78.76478	14.514583	Asia/Kolkata	0
1000	Croydon Airport	Croydon	Australia	AU	CDQ	YCRY	142.25	-18.3	Australia/Brisbane	0
1001	Chadron Airport	Chadron	United States	US	CDR	KCDR	-103.097778	42.835	America/Denver	0
1002	Childress Airport	Childress	United States	US	CDS	KCDS	-100.216667	37.416667	America/Chicago	0
1003	Castellon-Costa Azahar Airport	Benlloch	Spain and Canary Islands	ES	CDT	LECH	0.073333	40.213889	Europe/Madrid	0
1004	Camden Airport	Camden	Australia	AU	CDU	YSCN	150.687016	-34.038161	Australia/Sydney	0
1005	Mudhole Smith Airport	Cordova	United States	US	CDV	PACV	-145.4775	60.4917	America/Anchorage	0
1006	Essex County Airport	Caldwell	United States	US	CDW	KCDW	-74.28021	40.875005	America/New_York	0
1007	Cagayan De Sulu Airport	Mapun	Philippines	PH	CDY	RPMU	118.495	7.013611	Asia/Manila	0
1008	Cessna Aircraft Field	Wichita	United States	US	CEA	KCEA	-97.333333	37.7	America/Chicago	0
1009	Mactan Cebu International Airport	Cebu City	Philippines	PH	CEB	RPVM	123.982778	10.313333	Asia/Manila	0
1010	Del Norte County Regional Airport	Crescent City	United States	US	CEC	KCEC	-124.235833	41.78	America/Los_Angeles	0
1011	Ceduna Airport	Ceduna	Australia	AU	CED	YCDU	133.701218	-32.123779	Australia/Adelaide	0
1012	Cherepovets Airport	Cherepovets	Russian Federation	RU	CEE	ULWC	38.066667	59.283333	Europe/Moscow	0
1013	Westover Metropolitan Airport	Springfield	United States	US	CEF	KCEF	-72.553834	42.183377	America/New_York	0
1014	Hawarden Airport	Chester	United Kingdom	GB	CEG	EGNR	-2.970718	53.178603	Europe/London	0
1015	Chelinda Airport	Chelinda	Malawi	MW	CEH	FWCD	33.8	-10.55	Africa/Blantyre	0
1016	Chiang Rai International Airport	Chiang Rai	Thailand	TH	CEI	VTCT	99.878811	19.954608	Asia/Bangkok	0
1017	Chelyabinsk International Airport	Chelyabinsk	Russian Federation	RU	CEK	USCC	61.51235	55.297506	Asia/Yekaterinburg	0
1018	Central Airport	Central	United States	US	CEM	PACE	-144.781944	65.574722	America/Anchorage	0
1019	Ciudad Obregon Airport	Ciudad Obregon	Mexico	MX	CEN	MMCN	-109.839167	27.391944	America/Hermosillo	0
1020	Wako Kungo Airport	Wako Kungo	Angola	AO	CEO	FNWK	15.101389	-11.426389	Africa/Luanda	0
1021	Concepcion Airport	Concepcion	Bolivia	BO	CEP	SLCP	-62.083333	-16.233333	America/La_Paz	0
1022	Mandelieu Airport	Cannes	France	FR	CEQ	LFMD	6.954167	43.546389	Europe/Paris	0
1023	Cherbourg-Maupertus Airport	Cherbourg	France	FR	CER	LFRC	-1.475198	49.650812	Europe/Paris	0
1024	Cessnock Airport	Cessnock	Australia	AU	CES	YCNK	151.35	-32.833333	Australia/Sydney	0
1025	Le Pontreau Airport	Cholet	France	FR	CET	LFOU	-0.866667	47.066667	Europe/Paris	0
1026	Conklin (Leismer) Airport	Conklin	Canada	CA	CFM	CET2	-111.28084	55.696437	America/Edmonton	0
1027	Oconee County Regional Airport	Clemson	United States	US	CEU	KCEU	-82.885251	34.671263	America/New_York	0
1028	Mettle Field	Connersville	United States	US	CEV	KCEV	-85.133333	39.65	America/Indiana/Indianapolis	0
1029	Bob Sikes Airport	Crestview	United States	US	CEW	KCEW	-86.523401	30.777433	America/New_York	0
1030	Calloway County Airport	Murray	United States	US	CEY	KCEY	-88.316667	36.616667	America/Chicago	0
1031	Montezuma County Airport	Cortez	United States	US	CEZ	KCEZ	-108.627222	37.302778	America/Denver	0
1032	Cabo Frio International Airport	Cabo Frio	Brazil	BR	CFB	SBCB	-42.078611	-22.925	America/Sao_Paulo	0
1033	Cacador Airport	Cacador	Brazil	BR	CFC	SBCD	-50.941389	-26.790556	America/Sao_Paulo	0
1034	Coulter Field	Bryan	United States	US	CFD	KCFD	-96.366667	30.666667	America/Chicago	0
1035	Auvergne Airport	Clermont-Ferrand	France	FR	CFE	LFLC	3.159323	45.789051	Europe/Paris	0
1036	Jaime Gonzalez Airport	Cienfuegos	Cuba	CU	CFG	MUCF	-80.414167	22.15	America/Havana	0
1037	Clifton Hills Airport	Clifton Hills	Australia	AU	CFH	YCFH	139	-27	Australia/Adelaide	0
1038	Camfield Airport	Camfield	Australia	AU	CFI	YCFD	131.283333	-17.033333	Australia/Darwin	0
1039	Aboubakr Belkaid Airport	Chlef	Algeria	DZ	CFK	DAOI	1.331667	36.212222	Africa/Algiers	0
1040	Donegal Airport	Donegal	Ireland	IE	CFN	EIDL	-8.340278	55.041667	Europe/Dublin	0
1041	Carpentaria Downs Airport	Carpentaria Downs	Australia	AU	CFP	YCPN	144.35	-18.783333	Australia/Brisbane	0
1042	Creston Airport	Creston	Canada	CA	CFQ	CAJ3	-116.498333	49.036944	America/Vancouver	0
1043	Carpiquet Airport	Caen	France	FR	CFR	LFRK	-0.459276	49.183437	Europe/Paris	0
1044	Coffs Harbour Airport	Coffs Harbour	Australia	AU	CFS	YCFS	153.115301	-30.322862	Australia/Sydney	0
1045	Morenci Airport	Clifton	United States	US	CFT	KCFT	-109.209999	32.952801	America/Phoenix	0
1046	Ioannis Kapodistrias Airport	Kerkyra	Greece	GR	CFU	LGKR	19.914645	39.60784	Europe/Athens	0
1047	Coffeyville Municipal Airport	Coffeyville	United States	US	CFV	KCFV	-95.616667	37.033333	America/Chicago	0
1048	Marechal Rondon International Airport	Cuiaba	Brazil	BR	CGB	SBCY	-56.120266	-15.651725	America/Campo_Grande	0
1049	Changde Airport	Changde	China	CN	CGD	ZGCD	111.638863	28.924467	Asia/Shanghai	0
1050	Cambridge Airport	Cambridge	United States	US	CGE	KCGE	-76.083333	38.566667	America/New_York	0
1051	Cuyahoga County Airport	Cleveland	United States	US	CGF	KCGF	-81.488049	41.565181	America/New_York	0
1052	Sao Paulo Congonhas Airport	Sao Paulo	Brazil	BR	CGH	SBSP	-46.659556	-23.626902	America/Sao_Paulo	0
1053	Cape Girardeau Airport	Cape Girardeau	United States	US	CGI	KCGI	-89.571667	37.223611	America/Chicago	0
1054	Jakarta Soekarno-Hatta International Airport	Jakarta	Indonesia	ID	CGK	WIII	106.655526	-6.130643	Asia/Jakarta	0
1055	Camiguin Airport	Mambajao	Philippines	PH	CGM	RPMH	124.706944	9.253611	Asia/Manila	0
1056	Cologne Bonn Airport	Cologne	Germany	DE	CGN	EDDK	7.122224	50.878363	Europe/Berlin	0
1057	Zhengzhou Xinzheng International Airport	Zhengzhou	China	CN	CGO	ZHCC	113.840242	34.527519	Asia/Shanghai	0
1058	Shah Amanat International Airport	Chittagong	Bangladesh	BD	CGP	VGEG	91.815159	22.245202	Asia/Dhaka	0
1059	Changchun Longjia International Airport	Changchun	China	CN	CGQ	ZYCC	125.68528	43.99611	Asia/Shanghai	0
1060	Campo Grande International Airport	Campo Grande	Brazil	BR	CGR	SBCG	-54.668872	-20.456992	America/Campo_Grande	0
1061	College Park Airport	College Park	United States	US	CGS	KCGS	-76.922132	38.980346	America/New_York	0
1062	Caiguna Airport	Caiguna	Australia	AU	CGV	YCAG	125.466667	-32.266667	Australia/Perth	0
1063	Casa Grande Municipal Airport	Casa Grande	United States	US	CGZ	KCGZ	-111.766998	32.954899	America/Phoenix	0
1064	Chattanooga Airport	Chattanooga	United States	US	CHA	KCHA	-85.197784	35.036925	America/New_York	0
1065	Christchurch Airport	Christchurch	New Zealand	NZ	CHC	NZCH	172.538892	-43.488655	Pacific/Auckland	0
1066	Tallinn City Hall Heliport	Tallinn	Estonia	EE	CHE	EECL	24.753279	59.447989	Europe/Tallinn	0
1067	Jinhae Airport	Jinhae	Republic of Korea	KR	CHF	RKPE	128.697778	35.1375	Asia/Seoul	0
1068	Chaoyang Airport	Chaoyang	China	CN	CHG	ZYCY	120.437203	41.545081	Asia/Shanghai	0
1069	Chachapoyas Airport	Chachapoyas	Peru	PE	CHH	SPPY	-77.85617	-6.201871	America/Lima	0
1070	Chipinge Airport	Chipinge	Zimbabwe	ZW	CHJ	FVCH	32.65	-20.2	Africa/Harare	0
1071	Chickasha Municipal Airport	Chickasha	United States	US	CHK	KCHK	-97.966667	35.05	America/Chicago	0
1072	Challis Airport	Challis	United States	US	CHL	KLLJ	-114.25	44.5	America/Denver	0
1073	Chimbote Airport	Chimbote	Peru	PE	CHM	SPEO	-78.531111	-9.150556	America/Lima	0
1074	Charlottesville Albemarle Airport	Charlottesville	United States	US	CHO	KCHO	-78.449279	38.139415	America/New_York	0
1075	Chania International Airport	Chania	Greece	GR	CHQ	LGSA	24.140374	35.5402	Europe/Athens	0
1076	Deols Airport	Chateauroux	France	FR	CHR	LFLX	1.728128	46.861953	Europe/Paris	0
1077	Charleston International Airport	Charleston	United States	US	CHS	KCHS	-80.037157	32.884355	America/New_York	0
1078	Karewa Airport	Chatham Island	New Zealand	NZ	CHT	NZCI	-176.463877	-43.811551	Pacific/Chatham	0
1079	Chaves Airport	Chaves	Portugal	PT	CHV	LPCH	-7.466667	41.733333	Europe/Lisbon	0
1080	Changuinola Airport	Changuinola	Panama	PA	CHX	MPCH	-82.45	9.45	America/Panama	0
1081	Choiseul Bay Airport	Choiseul Bay	Solomon Islands	SB	CHY	AGGC	156.39856	-6.713787	Pacific/Guadalcanal	0
1082	Ciampino-G. B. Pastine International Airport	Rome	Italy	IT	CIA	LIRA	12.590987	41.799065	Europe/Rome	0
1083	Chico Municipal Airport	Chico	United States	US	CIC	KCIC	-121.856046	39.798178	America/Los_Angeles	0
1084	The Eastern Iowa Airport	Cedar Rapids	United States	US	CID	KCID	-91.700305	41.889423	America/Chicago	0
1085	Collie Airport	Collie	Australia	AU	CIE	YCOI	116.133333	-33.366667	Australia/Perth	0
1086	Yulong Airport	Chifeng	China	CN	CIF	ZBCF	118.833173	42.154523	Asia/Shanghai	0
1087	Craig-Moffat Airport	Craig	United States	US	CIG	KCAG	-107.525	40.495556	America/Denver	0
1088	Changzhi Airport	Changzhi	China	CN	CIH	ZBCZ	113.121585	36.245881	Asia/Shanghai	0
1089	E. Beltram Airport	Cobija	Bolivia	BO	CIJ	SLCO	-68.752778	-11.026389	America/La_Paz	0
1090	Chalkyitsik Airport	Chalkyitsik	United States	US	CIK	PACI	-143.729167	66.648056	America/Anchorage	0
1091	Cimitarra Airport	Cimitarra	Colombia	CO	CIM	SKCM	-74.116667	6.483333	America/Bogota	0
1092	Carroll Airport	Carroll	United States	US	CIN	KCIN	-94.866667	42.066667	America/Chicago	0
1093	Chipata Airport	Chipata	Zambia	ZM	CIP	FLCP	32.587222	-13.556944	Africa/Lusaka	0
1094	Chiquimula Airport	Chiquimula	Guatemala	GT	CIQ	MGCQ	-89.616667	14.85	America/Guatemala	0
1095	Cairo Airport	Cairo	United States	US	CIR	KCIR	-89.219597	37.064499	America/Chicago	0
1096	Canton Island Airport	Canton Island	Kiribati	KI	CIS	PCIS	-171.666667	-2.833333	Pacific/Enderbury	0
1097	Shymkent Airport	Shymkent	Kazakhstan	KZ	CIT	UAII	69.492845	42.364842	Asia/Almaty	0
1098	Chippewa County Airport	Sault Ste. Marie	United States	US	CIU	KCIU	-84.473192	46.250598	America/New_York	0
1099	Canouan Island Airport	Canouan Island	Saint Vincent and the Grenadines	VC	CIW	TVSC	-61.316667	12.7	America/St_Vincent	0
1100	Cornel Ruiz Airport	Chiclayo	Peru	PE	CIX	SPHI	-79.832222	-6.789722	America/Lima	0
1101	Comiso Airport	Comiso	Italy	IT	CIY	LICB	14.609152	36.996209	Europe/Rome	0
1102	Coari Airport	Coari	Brazil	BR	CIZ	SWKO	-63.133333	-4.083333	America/Porto_Velho	0
1103	Cajamarca Airport	Cajamarca	Peru	PE	CJA	SPJR	-78.5	-7.133333	America/Lima	0
1104	Coimbatore International Airport	Coimbatore	India	IN	CJB	VOCB	77.038931	11.031026	Asia/Kolkata	0
1105	El Loa Airport	Calama	Chile	CL	CJC	SCCF	-68.908435	-22.495084	America/Santiago	0
1106	Candilejas Airport	Candilejas	Colombia	CO	CJD	SKDJ	-74.266667	1.333333	America/Bogota	0
1107	Coondewanna Airport	Coondewanna	Australia	AU	CJF	YCWA	118.812586	-22.966573	Australia/Perth	0
1108	Cheongju Airport	Cheongju	Republic of Korea	KR	CJJ	RKTU	127.495087	36.7224	Asia/Seoul	0
1109	Chitral Airport	Chitral	Pakistan	PK	CJL	OPCH	71.794444	35.886111	Asia/Karachi	0
1110	Chumphon Airport	Chumphon	Thailand	TH	CJM	VTSE	99.361376	10.711122	Asia/Bangkok	0
1111	Cijulang Nusawiru Airport	Pangandaran	Indonesia	ID	CJN	WICN	108.488611	-7.72	Asia/Jakarta	0
1112	Abraham Gonzalez International Airport	Ciudad Juarez	Mexico	MX	CJS	MMCS	-106.436098	31.635929	America/Ciudad_Juarez	0
1113	Jeju International Airport	Jeju	Republic of Korea	KR	CJU	RKPC	126.493119	33.506698	Asia/Seoul	0
1114	Kegelman Air Field	Cherokee	United States	US	CKA	KCKA	-98.35	36.75	America/Chicago	0
1115	Benedum Airport	Clarksburg	United States	US	CKB	KCKB	-80.229444	39.295556	America/New_York	0
1116	Cherkassy Airport	Cherkasy	Ukraine	UA	CKC	UKKE	32	49.416667	Europe/Kiev	0
1117	Chongqing Jianbei International Airport	Chongqing	China	CN	CKG	ZUCK	106.641998	29.7192	Asia/Shanghai	0
1118	Chokurdah Airport	Chokurdah	Russian Federation	RU	CKH	UESO	147.883333	70.633333	Asia/Magadan	0
1119	Croker Island Airport	Croker Island	Australia	AU	CKI	YCKI	132.533333	-11.2	Australia/Darwin	0
1120	Fletcher Field	Clarksdale	United States	US	CKM	KCKM	-90.583333	34.2	America/Chicago	0
1121	Crookston Municipal Airport	Crookston	United States	US	CKN	KCKN	-96.616667	47.783333	America/Chicago	0
1122	Cornelio Procopio Airport	Cornelio Procopio	Brazil	BR	CKO	SSCP	-50.666667	-23.116667	America/Sao_Paulo	0
1123	Carajas Airport	Carajas	Brazil	BR	CKS	SBCJ	-50.001944	-6.114749	America/Belem	0
1124	Sarakhs Airport	Sarakhs	Iran	IR	CKT	OIMC	61.07	36.488056	Asia/Tehran	0
1125	Outlaw Field	Clarksville	United States	US	CKV	KCKV	-87.414444	36.620833	America/Chicago	0
1126	Christmas Creek Mine Airport	Christmas Creek Mine	Australia	AU	CKW	YCHK	119.63883	-22.3525	Australia/Perth	0
1127	Conakry Airport	Conakry	Guinea	GN	CKY	GUCY	-13.62017	9.575655	Africa/Conakry	0
1128	Canakkale Airport	Canakkale	Turkiye	TR	CKZ	LTBH	26.426943	40.137422	Europe/Istanbul	0
1129	Comilla Airport	Comilla	Bangladesh	BD	CLA	VGCM	91.192222	23.4375	Asia/Dhaka	0
1130	McClellan-Palomar Airport	Carlsbad	United States	US	CLD	KCRQ	-117.278883	33.127288	America/Los_Angeles	0
1131	Cleveland Hopkins International Airport	Cleveland	United States	US	CLE	KCLE	-81.83821	41.410856	America/New_York	0
1132	Coolah Airport	Coolah	Australia	AU	CLH	YCAH	149.7	-31.833333	Australia/Sydney	0
1133	Clintonville Airport	Clintonville	United States	US	CLI	KCLI	-88.866667	42.566667	America/Chicago	0
1134	Cluj-Napoca International Airport	Cluj-Napoca	Romania	RO	CLJ	LRCL	23.687014	46.782061	Europe/Bucharest	0
1135	Clinton Regional Airport	Clinton	United States	US	CLK	KCLK	-98.9325	35.538056	America/Chicago	0
1136	Easterwood Airport	College Station	United States	US	CLL	KCLL	-96.366818	30.593842	America/Chicago	0
1137	William R. Fairchild International Airport	Port Angeles	United States	US	CLM	KCLM	-123.497237	48.118658	America/Los_Angeles	0
1138	Carolina Airport	Carolina	Brazil	BR	CLN	SBCI	-47.45	-7.333333	America/Belem	0
1139	Alfonso B. Aragon Airport	Cali	Colombia	CO	CLO	SKCL	-76.381389	3.543056	America/Bogota	0
1140	Clarks Point Airport	Clarks Point	United States	US	CLP	PFCL	-158.528192	58.836903	America/Anchorage	0
1141	Miguel de la Madrid Airport	Colima	Mexico	MX	CLQ	MMIA	-103.577002	19.277	America/Mexico_City	0
1142	Cliff Hatfield Memorial Airport	Calipatria	United States	US	CLR	KCLR	-115.521004	33.1315	America/Los_Angeles	0
1143	Centralia Airport	Chehalis	United States	US	CLS	KCLS	-122.981111	46.673889	America/Los_Angeles	0
1144	Charlotte Douglas International Airport	Charlotte	United States	US	CLT	KCLT	-80.935833	35.219167	America/New_York	0
1145	Columbus Municipal Airport	Columbus	United States	US	CLU	KBAK	-85.896329	39.261918	America/Indiana/Indianapolis	0
1146	Nelson R. Guimaraes Airport	Caldas Novas	Brazil	BR	CLV	SBCN	-48.60746	-17.725605	America/Sao_Paulo	0
1147	Clearwater Air Park	Tampa	United States	US	CLW	KCLW	-82.758611	27.976667	America/New_York	0
1148	Clorinda Airport	Clorinda	Argentina	AR	CLX	SATC	-57.666667	-25.333333	America/Argentina/Buenos_Aires	0
1149	Sainte Catherine Airport	Calvi	France	FR	CLY	LFKC	8.791667	42.527778	Europe/Paris	0
1150	Calabozo Airport	Calabozo	Venezuela	VE	CLZ	SVCL	-67.433333	8.933333	America/Caracas	0
1151	Cunnamulla Airport	Cunnamulla	Australia	AU	CMA	YCMU	145.616111	-28.031389	Australia/Brisbane	0
1152	Bandaranaike International Airport	Colombo	Sri Lanka	LK	CMB	VCBI	79.886494	7.174112	Asia/Colombo	0
1153	Cootamundra Airport	Cootamundra	Australia	AU	CMD	YCTM	148.043333	-34.628333	Australia/Sydney	0
1154	Ciudad Del Carmen Airport	Ciudad Del Carmen	Mexico	MX	CME	MMCE	-91.802734	18.651029	America/Mexico_City	0
1155	Chambery Airport	Chambery	France	FR	CMF	LFLB	5.88437	45.637994	Europe/Paris	0
1156	Corumba Internacional Airport	Corumba	Brazil	BR	CMG	SBCR	-57.672222	-19.011111	America/Campo_Grande	0
1157	John Glenn Columbus International Airport	Columbus	United States	US	CMH	KCMH	-82.884966	39.998181	America/New_York	0
1158	University of Illinois Willard Airport	Champaign	United States	US	CMI	KCMI	-88.278056	40.039167	America/Chicago	0
1159	Qimei Airport	Qimei	Taiwan	TW	CMJ	RCCM	119.417519	23.211497	Asia/Taipei	0
1160	Club Makokola Airport	Club Makokola	Malawi	MW	CMK	FWCM	35.1325	-14.3069	Africa/Blantyre	0
1161	Camooweal Airport	Camooweal	Australia	AU	CML	YCMW	138.116667	-19.933333	Australia/Brisbane	0
1162	Casablanca Mohammed V International Airport	Casablanca	Morocco	MA	CMN	GMMN	-7.586667	33.366667	Africa/Casablanca	0
1163	Obbia Airport	Obbia	Somalia	SO	CMO	HCMO	48.516667	5.366667	Africa/Mogadishu	0
1164	Santana do Araguaia Airport	Santana do Araguaia	Brazil	BR	CMP	SNKE	-50.328492	-9.319973	America/Belem	0
1165	Clermont Airport	Clermont	Australia	AU	CMQ	YCMT	147.621888	-22.77181	Australia/Brisbane	0
1166	Colmar-Houssen Airport	Colmar	France	FR	CMR	LFGA	7.366667	48.083333	Europe/Paris	0
1167	Scusciuban Airport	Scusciuban	Somalia	SO	CMS	HCMS	50.233333	10.3	Africa/Mogadishu	0
1168	Chimbu Airport	Kundiawa	Papua New Guinea	PG	CMU	AYCH	144.972845	-6.020586	Pacific/Port_Moresby	0
1169	Coromandel Airport	Coromandel	New Zealand	NZ	CMV	NZCX	175.508453	-36.791132	Pacific/Auckland	0
1170	Ign Agramonte International Airport	Camaguey	Cuba	CU	CMW	MUCM	-77.8436	21.4247	America/Havana	0
1171	Houghton County Airport	Hancock	United States	US	CMX	KCMX	-88.486389	47.167778	America/New_York	0
1172	Fort McCoy Army Air Field	Sparta	United States	US	CMY	KCMY	-90.778972	44.033472	America/Chicago	0
1173	Cananea Airport	Cananea	Mexico	MX	CNA	MMCA	-110.333333	31	America/Hermosillo	0
1174	Coonamble Airport	Coonamble	Australia	AU	CNB	YCNM	148.378333	-30.980833	Australia/Sydney	0
1175	Coconut Island Airport	Coconut Island	Australia	AU	CNC	YCCT	143.070066	-10.049966	Australia/Brisbane	0
1176	Kogalniceanu Airport	Constanta	Romania	RO	CND	LRCK	28.483333	44.35	Europe/Bucharest	0
1177	Belo Horizonte International Airport	Belo Horizonte	Brazil	BR	CNF	SBCF	-43.963213	-19.632417	America/Sao_Paulo	0
1178	Chateaubernard Airport	Cognac	France	FR	CNG	LFBG	-0.333333	45.683333	Europe/Paris	0
1179	Claremont Municipal Airport	Claremont	United States	US	CNH	KCNH	-72.333333	43.383333	America/New_York	0
1180	Cloncurry Airport	Cloncurry	Australia	AU	CNJ	YCCY	140.508521	-20.668905	Australia/Brisbane	0
1181	Blosser Municipal Airport	Concordia	United States	US	CNK	KCNK	-97.666667	39.566667	America/Chicago	0
1182	Sindal Airport	Sindal	Denmark	DK	CNL	EKSN	10.216667	57.483333	Europe/Copenhagen	0
1183	Cavern City Air Terminal	Carlsbad	United States	US	CNM	KCNM	-104.262778	32.337222	America/Denver	0
1184	Kannur International Airport	Kannur	India	IN	CNN	VOKN	75.549919	11.920073	Asia/Kolkata	0
1185	Chino Airport	Chino	United States	US	CNO	KCNO	-117.639167	33.980833	America/Los_Angeles	0
1186	Neerlerit Inaat Airport	Neerlerit Inaat	Greenland	GL	CNP	BGCO	-22.658333	70.743056	America/Scoresbysund	0
1187	Camba Punta Airport	Corrientes	Argentina	AR	CNQ	SARC	-58.762222	-27.449722	America/Argentina/Buenos_Aires	0
1188	Chanaral Airport	Chanaral	Chile	CL	CNR	SCRA	-70.604167	-26.329167	America/Santiago	0
1189	Cairns Airport	Cairns	Australia	AU	CNS	YBCS	145.754041	-16.876538	Australia/Brisbane	0
1190	Martin Johnson Airport	Chanute	United States	US	CNU	KCNU	-95.45	37.683333	America/Chicago	0
1191	TSTC Waco Airport	Waco	United States	US	CNW	KCNW	-97.073408	31.63759	America/Chicago	0
1192	Chiang Mai International Airport	Chiang Mai	Thailand	TH	CNX	VTCC	98.968409	18.769574	Asia/Bangkok	0
1193	Canyonlands Field	Moab	United States	US	CNY	KCNY	-109.746111	38.759444	America/Denver	0
1194	Coolibah Airport	Coolibah	Australia	AU	COB	YCLI	130.933333	-15.55	Australia/Darwin	0
1195	Comodoro Pierrestegui Airport	Concordia	Argentina	AR	COC	SAAC	-57.996389	-31.297222	America/Argentina/Buenos_Aires	0
1196	Yellowstone Regional Airport	Cody	United States	US	COD	KCOD	-109.0275	44.515833	America/Denver	0
1197	Pappy Boyington Field	Coeur D'Alene	United States	US	COE	KCOE	-116.819654	47.774279	America/Los_Angeles	0
1198	Patrick Air Force Base	Cocoa	United States	US	COF	KCOF	-80.609387	28.241516	America/New_York	0
1199	Mandinga Airport	Condoto	Colombia	CO	COG	SKCD	-76.676625	5.071961	America/Bogota	0
1200	Cooch Behar Airport	Cooch Behar	India	IN	COH	VECO	89.466667	26.333333	Asia/Kolkata	0
1201	Merritt Island Airport	Cocoa	United States	US	COI	KCOI	-80.68677	28.342023	America/New_York	0
1202	Coonabarabran Airport	Coonabarabran	Australia	AU	COJ	YCBB	149.271944	-31.337222	Australia/Sydney	0
1203	Cochin International Airport	Kochi	India	IN	COK	VOCI	76.390537	10.155644	Asia/Kolkata	0
1204	Coll Island Airport	Coll Island	United Kingdom	GB	COL	EGEL	-6.616667	56.616667	Europe/London	0
1205	Coleman Airport	Coleman	United States	US	COM	KCOM	-99.433333	31.833333	America/Chicago	0
1206	Concord Municipal Airport	Concord	United States	US	CON	KCON	-71.501789	43.20463	America/New_York	0
1207	Cotonou Airport	Cotonou	Benin	BJ	COO	DBBB	2.383816	6.353869	Africa/Porto-Novo	0
1208	Choibalsan Airport	Choibalsan	Mongolia	MN	COQ	ZMCD	114.6464	48.1356	Asia/Ulaanbaatar	0
1209	Ingeniero Aeronautico Ambrosio L.V. Taravella International Airport	Cordoba	Argentina	AR	COR	SACO	-64.211904	-31.315785	America/Argentina/Buenos_Aires	0
1210	Colorado Springs Airport	Colorado Springs	United States	US	COS	KCOS	-104.700747	38.805778	America/Denver	0
1211	Cotulla Airport	Cotulla	United States	US	COT	KCOT	-99.233333	28.433333	America/Chicago	0
1212	Columbia Regional Airport	Columbia	United States	US	COU	KCOU	-92.219167	38.813611	America/Chicago	0
1213	Covilha Airport	Covilha	Portugal	PT	COV	LPCV	35.0008	36.0839	Europe/Lisbon	0
1214	Coolawanyah Airport	Coolawanyah	Australia	AU	COY	YCWY	117.75	-21.85	Australia/Perth	0
1215	Constanza Airport	Constanza	Dominican Republic	DO	COZ	MDCZ	-70.716667	18.9	America/Santo_Domingo	0
1216	A. Tubman Airport	Cape Palmas	Liberia	LR	CPA	GLCP	-7.695556	4.376667	Africa/Monrovia	0
1217	Capurgana Airport	Capurgana	Colombia	CO	CPB	SKCA	-77.333333	8.633333	America/Bogota	0
1218	Aviador Carlos Campos Airport	San Martin De Los Andes	Argentina	AR	CPC	SAZY	-71.137288	-40.075414	America/Argentina/Buenos_Aires	0
1219	Coober Pedy Airport	Coober Pedy	Australia	AU	CPD	YCBP	134.752778	-29.044444	Australia/Adelaide	0
1220	Campeche International Airport	Campeche	Mexico	MX	CPE	MMCP	-90.509444	19.835	America/Mexico_City	0
1221	Copenhagen Airport	Copenhagen	Denmark	DK	CPH	EKCH	12.647601	55.629053	Europe/Copenhagen	0
1222	Chaparral Airport	Chaparral	Colombia	CO	CPL	SKHA	-75.466667	3.716667	America/Bogota	0
1223	Compton Airport	Compton	United States	US	CPM	KCPM	-118.247778	33.894444	America/Los_Angeles	0
1224	Chamonate Airport	Copiapo	Chile	CL	CPO	SCAT	-70.414407	-27.29892	America/Santiago	0
1225	Coposa Airport	Pica	Chile	CL	CPP	SCKP	-68.682545	-20.751773	America/Santiago	0
1226	Amarais Airport	Campinas	Brazil	BR	CPQ	SDAM	-47.109435	-22.858381	America/Sao_Paulo	0
1227	Casper/Natrona County International Airport	Casper	United States	US	CPR	KCPR	-106.4625	42.908611	America/Denver	0
1228	St. Louis Downtown Airport	Saint Louis	United States	US	CPS	KCPS	-90.155989	38.574974	America/Chicago	0
1229	Cape Town International Airport	Cape Town	South Africa	ZA	CPT	FACT	18.596489	-33.968906	Africa/Johannesburg	0
1230	Joao Suassuna Airport	Campina Grande	Brazil	BR	CPV	SBKG	-35.9	-7.266667	America/Belem	0
1231	Benjamin Rivera Noriega Airport	Culebra	Puerto Rico	PR	CPX	TJCP	-65.301716	18.312074	America/Puerto_Rico	0
1232	Canarana Airport	Canarana	Brazil	BR	CQA	SWEK	-52.270278	-13.574167	America/Campo_Grande	0
1233	Shahre Kord Airport	Shahre Kord	Iran	IR	CQD	OIFS	50.842201	32.297199	Asia/Tehran	0
1234	Calais Airport	Calais	France	FR	CQF	LFAC	1.933333	50.95	Europe/Paris	0
1235	Cape Flattery Airport	Cape Flattery	Australia	AU	CQP	YCFL	147.5	-18.2	Australia/Brisbane	0
1236	Costa Marques Airport	Costa Marques	Brazil	BR	CQS	SWCQ	-64.25	-12.416667	America/Porto_Velho	0
1237	Craiova Airport	Craiova	Romania	RO	CRA	LRCV	23.886389	44.318889	Europe/Bucharest	0
1238	Collarenebri Airport	Collarenebri	Australia	AU	CRB	YCBR	148.583333	-29.55	Australia/Sydney	0
1239	Santa Ana Airport	Cartago	Colombia	CO	CRC	SKGO	-75.954674	4.760994	America/Bogota	0
1240	General E. Mosconi International Airport	Comodoro Rivadavia	Argentina	AR	CRD	SAVC	-67.469738	-45.789323	America/Argentina/Buenos_Aires	0
1241	Grand Strand Airport	Myrtle Beach	United States	US	CRE	KCRE	-78.724444	33.811389	America/New_York	0
1242	Carnot Airport	Carnot	Central African Republic	CF	CRF	FEFC	15.933333	4.983333	Africa/Bangui	0
1243	Jacksonville Executive at Craig Airport	Jacksonville	United States	US	CRG	KCRG	-81.686868	30.492078	America/New_York	0
1244	Cherribah Airport	Cherribah	Australia	AU	CRH	YCHB	152.166667	-28	Australia/Brisbane	0
1245	Crooked Island Airport	Crooked Island	Bahamas	BS	CRI	MYCI	-74.15	22.75	America/Nassau	0
1246	Coorabie Airport	Coorabie	Australia	AU	CRJ	YCRB	132.3	-31.9	Australia/Adelaide	0
1247	Clark International Airport	Angeles	Philippines	PH	CRK	RPLC	120.549789	15.187696	Asia/Manila	0
1306	Cancun International Airport	Cancun	Mexico	MX	CUN	MMUN	-86.874439	21.040457	America/Cancun	0
1248	Brussels S. Charleroi Airport	Brussels	Belgium	BE	CRL	EBCI	4.45382	50.459206	Europe/Brussels	0
1249	Catarman National Airport	Catarman	Philippines	PH	CRM	RPVF	124.63591	12.502492	Asia/Manila	0
1250	Corcoran Airport	Corcoran	United States	US	CRO	KCRO	-119.55	36.1	America/Los_Angeles	0
1251	Corpus Christi International Airport	Corpus Christi	United States	US	CRP	KCRP	-97.502489	27.774813	America/Chicago	0
1252	Caravelas Airport	Caravelas	Brazil	BR	CRQ	SBCV	-39.25	-17.75	America/Belem	0
1253	Ceres Airport	Ceres	Argentina	AR	CRR	SANW	-61.833333	-29.916667	America/Argentina/Buenos_Aires	0
1254	C. David Campbell Field	Corsicana	United States	US	CRS	KCRS	-96.400582	32.028086	America/Chicago	0
1255	Z.M. Jack Stell Field	Crossett	United States	US	CRT	KCRT	-91.880205	33.178296	America/Chicago	0
1256	Carriacou Island Airport	Carriacou Island	Grenada	GD	CRU	TGPZ	-61.472222	12.475	America/Grenada	0
1257	Crotone Airport	Crotone	Italy	IT	CRV	LIBC	17.080778	38.996305	Europe/Rome	0
1258	Yeager Airport	Charleston	United States	US	CRW	KCRW	-81.596504	38.370342	America/New_York	0
1259	Roscoe Turner Airport	Corinth	United States	US	CRX	KCRX	-88.6035	34.915001	America/Chicago	0
1260	Carlton Hill Airport	Carlton Hill	Australia	AU	CRY	YCIL	128.616667	-15.466667	Australia/Perth	0
1261	Turkmenabat Airport	Chardzhev	Turkmenistan	TM	CRZ	UTAV	63.601198	39.09258	Asia/Ashgabat	0
1262	Colonsay Island Airport	Colonsay Island	United Kingdom	GB	CSA	EGEY	-6.2	56.083333	Europe/London	0
1263	Caransebes Airport	Caransebes	Romania	RO	CSB	LRCS	22.216667	45.416667	Europe/Bucharest	0
1264	Canas Airport	Canas	Costa Rica	CR	CSC	MRMJ	-85.483333	10.766667	America/Costa_Rica	0
1265	Cresswell Downs Airport	Cresswell Downs	Australia	AU	CSD	YCWD	135.916667	-17.966667	Australia/Darwin	0
1266	Creil Airport	Creil	France	FR	CSF	LFPC	2.483333	49.25	Europe/Paris	0
1267	Columbus Airport	Columbus	United States	US	CSG	KCSG	-84.941111	32.513333	America/New_York	0
1268	Solovky Airport	Solovetsky	Russian Federation	RU	CSH	ULAS	35.733333	65.029444	Europe/Moscow	0
1269	Casino Airport	Casino	Australia	AU	CSI	YCAS	153.058333	-28.883333	Australia/Sydney	0
1270	Cap Skirring Airport	Cap Skirring	Senegal	SN	CSK	GOGS	-16.744121	12.392154	Africa/Dakar	0
1271	Sherman Airport	Clinton	United States	US	CSM	KCSM	-96.933333	35.539167	America/Chicago	0
1272	Carson City Airport	Carson City	United States	US	CSN	KCXP	-119.734722	39.191667	America/Los_Angeles	0
1273	Creston Municipal Airport	Creston	United States	US	CSQ	KCSQ	-94.366667	41.066667	America/Chicago	0
1274	Castaway Island Sea Plane Base	Castaway	Fiji	FJ	CST	NFCS	177.129061	-17.735775	Pacific/Fiji	0
1275	Santa Cruz Do Sul Airport	Santa Cruz Do Sul	Brazil	BR	CSU	SSSC	-52.416667	-29.683333	America/Sao_Paulo	0
1276	Memorial-Whitson Field	Crossville	United States	US	CSV	KCSV	-85.084722	35.951111	America/Chicago	0
1277	Changsha Huanghua International Airport	Changsha	China	CN	CSX	ZGHA	113.214592	28.193336	Asia/Shanghai	0
1278	Cheboksary Airport	Cheboksary	Russian Federation	RU	CSY	UWKS	47.347301	56.090302	Europe/Moscow	0
1279	Brigadier Hector Ruiz	Coronel Suarez	Argentina	AR	CSZ	SAZC	-61.889167	-37.446111	America/Argentina/Buenos_Aires	0
1280	Catania Fontanarossa Airport	Catania	Italy	IT	CTA	LICC	15.065877	37.470663	Europe/Rome	0
1281	Cut Bank Municipal Airport	Cut Bank	United States	US	CTB	KCTB	-112.377903	48.608624	America/Denver	0
1282	Catamarca Airport	Catamarca	Argentina	AR	CTC	SANC	-65.779722	-28.448333	America/Argentina/Buenos_Aires	0
1283	Chitre Alonso Valderrama Airport	Chitre	Panama	PA	CTD	MPCE	-80.4107	7.981562	America/Panama	0
1284	Coatepeque Airport	Coatepeque	Guatemala	GT	CTF	MGCT	-91.879523	14.694978	America/Guatemala	0
1285	Rafael Nunez International Airport	Cartagena	Colombia	CO	CTG	SKCG	-75.516585	10.445704	America/Bogota	0
1286	Chester County  G. O. Carlson Airport	Coatesville	United States	US	CTH	KMQS	-75.863395	39.979532	America/New_York	0
1287	Charleville Airport	Charleville	Australia	AU	CTL	YBCV	146.258428	-26.413333	Australia/Brisbane	0
1288	Chetumal Airport	Chetumal	Mexico	MX	CTM	MMCM	-88.326858	18.504622	America/Cancun	0
1289	Cooktown Airport	Cooktown	Australia	AU	CTN	YCKN	145.183333	-15.443333	Australia/Brisbane	0
1290	Carutapera Airport	Carutapera	Brazil	BR	CTP	SNCP	-46.016667	-1.25	America/Belem	0
1291	Cattle Creek Airport	Cattle Creek	Australia	AU	CTR	YCAC	131	-17.583333	Australia/Darwin	0
1292	New Chitose Airport	Sapporo	Japan	JP	CTS	RJCC	141.681341	42.787281	Asia/Tokyo	0
1293	Le Castellet Airport	Le Castellet	France	FR	CTT	LFMQ	5.783333	43.25	Europe/Paris	0
1294	Chengdu Shuangliu International Airport	Chengdu	China	CN	CTU	ZUUU	103.956799	30.581134	Asia/Shanghai	0
1295	Cross City Airport	Cross City	United States	US	CTY	KCTY	-83.116667	29.633333	America/New_York	0
1296	Sampson County Airport	Clinton	United States	US	CTZ	KCTZ	-78.366667	35	America/New_York	0
1297	Ciudad Constitucion Airport	Ciudad Constitucion	Mexico	MX	CUA	MMDA	-111.612782	25.050447	America/Mazatlan	0
1298	J. Hamilton-L.B. Owens Airport	Columbia	United States	US	CUB	KCUB	-80.995278	33.970556	America/New_York	0
1299	Camilo Daza International Airport	Cucuta	Colombia	CO	CUC	SKCC	-72.508149	7.927108	America/Bogota	0
1300	Caloundra Airport	Caloundra	Australia	AU	CUD	YCDR	153.15	-26.8	Australia/Brisbane	0
1301	Mariscal Lamar International Airport	Cuenca	Ecuador	EC	CUE	SECU	-78.986894	-2.889343	America/Guayaquil	0
1302	Levaldigi Airport	Cuneo	Italy	IT	CUF	LIMZ	7.6175	44.535278	Europe/Rome	0
1303	Cushing Municipal Airport	Cushing	United States	US	CUH	KCUH	-96.766667	35.983333	America/Chicago	0
1304	Culiacan International Airport	Culiacan	Mexico	MX	CUL	MMCL	-107.469585	24.766429	America/Mazatlan	0
1305	Antonio Jose de Sucre Airport	Cumana	Venezuela	VE	CUM	SVCU	-64.131742	10.449879	America/Caracas	0
1307	Caruru Airport	Caruru	Colombia	CO	CUO	SKCR	-71.233333	1.033333	America/Bogota	0
1308	Carupano Airport	Carupano	Venezuela	VE	CUP	SVCP	-63.2625	10.658889	America/Caracas	0
1309	Coen Airport	Coen	Australia	AU	CUQ	YCOE	143.119076	-13.765341	Australia/Brisbane	0
1310	Hato International Airport	Curacao	Curaçao	CW	CUR	TNCC	-68.959805	12.188858	America/Curacao	0
1311	Cutral Airport	Cutral	Argentina	AR	CUT	SAZW	-69	-38.9	America/Argentina/Buenos_Aires	0
1312	Gen Fierro Villalobos Airport	Chihuahua	Mexico	MX	CUU	MMCU	-105.969523	28.704048	America/Chihuahua	0
1313	Cue Airport	Cue	Australia	AU	CUY	YCUE	117.916667	-27.45	Australia/Perth	0
1314	Alejandro Velasco Astete International Airport	Cuzco	Peru	PE	CUZ	SPZO	-71.943714	-13.538429	America/Lima	0
1315	Cleve Airport	Cleve	Australia	AU	CVC	YCEE	136.5	-33.7	Australia/Adelaide	0
1316	Covenas Airport	Covenas	Colombia	CO	CVE	SKCV	-75.733333	9.4	America/Bogota	0
1317	Courchevel Airport	Courchevel	France	FR	CVF	LFLJ	6.634722	45.396667	Europe/Paris	0
1318	Cincinnati/Northern Kentucky International Airport	Cincinnati	United States	US	CVG	KCVG	-84.66145	39.0555	America/New_York	0
1319	General Mariano Matamoros Airport	Cuernavaca	Mexico	MX	CVJ	MMCB	-99.261139	18.831704	America/Mexico_City	0
1320	Ciudad Victoria Airport	Ciudad Victoria	Mexico	MX	CVM	MMCV	-98.965278	23.713889	America/Mexico_City	0
1321	Clovis Municipal Airport	Clovis	United States	US	CVN	KCVN	-103.078889	34.427222	America/Denver	0
1322	Corvallis Municipal Airport	Corvallis	United States	US	CVO	KCVO	-123.2857	44.501186	America/Los_Angeles	0
1323	Carnarvon Airport	Carnarvon	Australia	AU	CVQ	YCAR	113.663584	-24.883429	Australia/Perth	0
1324	Cannon Air Force Base	Clovis	United States	US	CVS	KCVS	-103.316667	34.383889	America/Denver	0
1325	Coventry Airport	Coventry	United Kingdom	GB	CVT	EGBE	-1.478611	52.369167	Europe/London	0
1326	Corvo Island (Azores) Airport	Corvo Island (Azores)	Portugal	PT	CVU	LPCR	-31.1	39.7	Atlantic/Azores	0
1327	Central Wisconsin Airport	Wausau	United States	US	CWA	KCWA	-89.672437	44.784209	America/Chicago	0
1328	Afonso Pena International Airport	Curitiba	Brazil	BR	CWB	SBCT	-49.173298	-25.535763	America/Sao_Paulo	0
1329	Chernivtsi International Airport	Chernivtsi	Ukraine	UA	CWC	UKLN	25.970101	48.266973	Europe/Kiev	0
1330	Clinton Airport	Clinton	United States	US	CWI	KCWI	-90.331944	41.829444	America/Chicago	0
1331	Cardiff Airport	Cardiff	United Kingdom	GB	CWL	EGFF	-3.339075	51.398768	Europe/London	0
1332	Cowarie Airport	Cowarie	Australia	AU	CWR	YCWI	138.333333	-27.716667	Australia/Adelaide	0
1333	Cowra Airport	Cowra	Australia	AU	CWT	YCWR	148.646667	-33.855	Australia/Sydney	0
1334	Corowa Airport	Corowa	Australia	AU	CWW	YCOR	146.35	-35.966667	Australia/Sydney	0
1335	Coxs Bazar Airport	Coxs Bazar	Bangladesh	BD	CXB	VGCB	91.966667	21.45	Asia/Dhaka	0
1336	Coldfoot Airport	Coldfoot	United States	US	CXF	PACX	-150.201896	67.253829	America/Anchorage	0
1337	Vancouver Harbour Sea Plane Base	Vancouver	Canada	CA	CXH	CYHC	-123.117966	49.290827	America/Vancouver	0
1338	Christmas Island Airport	Christmas Island	Kiribati	KI	CXI	PLCH	-157.45	1.966667	Pacific/Kiritimati	0
1339	Hugo Cantergiani Regional Airport	Caxias do Sul	Brazil	BR	CXJ	SBCX	-51.187466	-29.195077	America/Sao_Paulo	0
1340	Calexico International Airport	Calexico	United States	US	CXL	KCXL	-115.516667	32.666667	America/Los_Angeles	0
1341	Candala Airport	Candala	Somalia	SO	CXN	HCMC	49.916667	11.5	Africa/Mogadishu	0
1342	Lone Star Executive Airport	Conroe	United States	US	CXO	KCXO	-95.416957	30.352968	America/Chicago	0
1343	Tunggul Wulung Airport	Cilacap	Indonesia	ID	CXP	WAHL	109	-7.733333	Asia/Jakarta	0
1344	Christmas Creek Airport	Christmas Creek	Australia	AU	CXQ	YCRK	125.916667	-18.866667	Australia/Perth	0
1345	Cam Ranh International Airport	Nha Trang	Viet Nam	VN	CXR	VVCR	109.21695	12.006816	Asia/Ho_Chi_Minh	0
1346	Charters Towers Airport	Charters Towers	Australia	AU	CXT	YCHT	146.269167	-20.046667	Australia/Brisbane	0
1347	Cat Cays Airport	Cat Cays	Bahamas	BS	CXY	MYCC	-77.816667	25.416667	America/Nassau	0
1348	Les Cayes Airport	Les Cayes	Haiti	HT	CYA	MTCA	-73.788333	18.269722	America/Port-au-Prince	0
1349	Charles Kirkconnel International Airport	Cayman Brac Island	Cayman Islands	KY	CYB	MWCB	-79.879407	19.690192	America/Cayman	0
1350	Chefornak Sea Plane Base	Chefornak	United States	US	CYF	PACK	-164.2	60.216667	America/Anchorage	0
1351	Corryong Airport	Corryong	Australia	AU	CYG	YCRG	147.9	-36.25	Australia/Sydney	0
1352	Chiayi Airport	Chiayi	Taiwan	TW	CYI	RCKU	120.398265	23.454241	Asia/Taipei	0
1353	Cayo Largo Del Sur Airport	Cayo Largo Del Sur	Cuba	CU	CYO	MUCL	-81.516667	21.616667	America/Havana	0
1354	Calbayog Airport	Calbayog	Philippines	PH	CYP	RPVC	124.543056	12.075833	Asia/Manila	0
1355	Laguna de los Patos International Airport	Colonia del Sacramento	Uruguay	UY	CYR	SUCA	-57.767768	-34.455325	America/Montevideo	0
1356	Cheyenne Regional Airport	Cheyenne	United States	US	CYS	KCYS	-104.816667	41.155833	America/Denver	0
1357	Yakataga Intermediate Airport	Yakataga	United States	US	CYT	PACY	-142.494444	60.08	America/Anchorage	0
1358	Cuyo Airport	Cuyo	Philippines	PH	CYU	RPLO	121	10.883333	Asia/Manila	0
1359	Cherskiy Airport	Cherskiy	Russian Federation	RU	CYX	UESS	161.35	68.75	Asia/Magadan	0
1360	Cauayan Airport	Cauayan	Philippines	PH	CYZ	RPUY	121.755833	16.93	Asia/Manila	0
1361	Chichen Itza Airport	Chichen Itza	Mexico	MX	CZA	MMCT	-88.444281	20.641117	America/Mexico_City	0
1362	Coro Airport	Coro	Venezuela	VE	CZE	SVCR	-69.681944	11.415833	America/Caracas	0
1363	Cape Romanzof Airport	Cape Romanzof	United States	US	CZF	PACZ	-166.036389	61.781111	America/Anchorage	0
1364	Cascade Locks State Airport	Cascade Locks	United States	US	CZK	KCZK	-121.879011	45.676873	America/Los_Angeles	0
1365	Ain El Bey Airport	Constantine	Algeria	DZ	CZL	DABC	6.618425	36.286477	Africa/Algiers	0
1366	Cozumel Airport	Cozumel	Mexico	MX	CZM	MMCZ	-86.930462	20.5112	America/Cancun	0
1367	Campo Internacional Airport	Cruzeiro Do Sul	Brazil	BR	CZS	SBCZ	-72.783333	-7.583333	America/Rio_Branco	0
1368	Carrizo Springs Airport	Carrizo Springs	United States	US	CZT	KCZT	-99.866667	28.516667	America/Chicago	0
1369	Corozal Airport	Corozal	Colombia	CO	CZU	SKCZ	-75.282778	9.3375	America/Bogota	0
1370	Czestochowa Airport	Czestochowa	Poland	PL	CZW	EPRU	19.1	50.816667	Europe/Warsaw	0
1371	Changzhou Airport	Changzhou	China	CN	CZX	ZSCG	119.779762	31.914116	Asia/Shanghai	0
1372	Cluny Airport	Cluny	Australia	AU	CZY	YUNY	139.533333	-24.516667	Australia/Brisbane	0
1373	Davison Army Air Field	Fort Belvoir	United States	US	DAA	KDAA	-77.181	38.715	America/New_York	0
1374	Daytona Beach International Airport	Daytona Beach	United States	US	DAB	KDAB	-81.060829	29.185192	America/New_York	0
1375	Dhaka Hazrat Shahjalal International Airport	Dhaka	Bangladesh	BD	DAC	VGHS	90.405874	23.848649	Asia/Dhaka	0
1376	Da Nang International Airport	Da Nang	Viet Nam	VN	DAD	VVDN	108.202753	16.053339	Asia/Ho_Chi_Minh	0
1377	Barstow-Daggett Airport	Daggett	United States	US	DAG	KDAG	-116.787003	34.853699	America/Los_Angeles	0
1378	Dauan Island Airport	Dauan Island	Australia	AU	DAJ	YDAI	142.533333	-9.433333	Australia/Brisbane	0
1379	Dakhla Oasis Airport	Dakhla Oasis	Egypt	EG	DAK	HEDK	28.999167	25.414722	Africa/Cairo	0
1380	Dallas Love Field	Dallas	United States	US	DAL	KDAL	-96.850002	32.843909	America/Chicago	0
1381	Damascus International Airport	Damascus	Syrian Arab Republic	SY	DAM	OSDI	36.512488	33.411171	Asia/Damascus	0
1382	Danville Regional Airport	Danville	United States	US	DAN	KDAN	-79.336098	36.572899	America/New_York	0
1383	Darchula Airport	Darchula	Nepal	NP	DAP	VNDL	80.5	29.666667	Asia/Kathmandu	0
1384	Julius Nyerere International Airport	Dar Es Salaam	United Republic of Tanzania	TZ	DAR	HTDA	39.20211	-6.873533	Africa/Dar_es_Salaam	0
1385	Datong Airport	Datong	China	CN	DAT	ZBDT	113.481362	40.05554	Asia/Shanghai	0
1386	Daru Airport	Daru	Papua New Guinea	PG	DAU	AYDU	143.206062	-9.08351	Pacific/Port_Moresby	0
1387	Enrique Malek Airport	David	Panama	PA	DAV	MPDA	-82.433333	8.383333	America/Panama	0
1388	Dazhou Heshi Airport	Dazhou	China	CN	DAX	ZUDX	107.427556	31.131687	Asia/Shanghai	0
1389	James M. Cox Dayton International Airport	Dayton	United States	US	DAY	KDAY	-84.220767	39.898007	America/New_York	0
1390	Darwaz Airport	Darwaz	Afghanistan	AF	DAZ	OADZ	70.883333	38.466667	Asia/Kabul	0
1391	Dalbandin Airport	Dalbandin	Pakistan	PK	DBA	OPDB	64.403	28.874617	Asia/Karachi	0
1392	Al Alamain International Airport	Dabaa	Egypt	EG	DBB	HEAL	28.461389	30.924444	Africa/Cairo	0
1393	Dhanbad Airport	Dhanbad	India	IN	DBD	VEDB	86.45	23.783333	Asia/Kolkata	0
1394	Debra Marcos Airport	Debra Marcos	Ethiopia	ET	DBM	HADM	37.743056	10.319444	Africa/Addis_Ababa	0
1395	Dublin Municipal Airport	Dublin	United States	US	DBN	KDBN	-82.986111	32.561944	America/New_York	0
1396	Dubbo City Regional Airport	Dubbo	Australia	AU	DBO	YSDU	148.574997	-32.216702	Australia/Sydney	0
1397	Dubuque Municipal Airport	Dubuque	United States	US	DBQ	KDBQ	-90.710833	42.41	America/Chicago	0
1398	Darbhanga Airport	Darbhanga	India	IN	DBR	VEDH	85.9114	26.1933	Asia/Kolkata	0
1399	Debra Tabor Airport	Debra Tabor	Ethiopia	ET	DBT	HADT	38.025278	11.968056	Africa/Addis_Ababa	0
1400	Dubrovnik Airport	Dubrovnik	Croatia	HR	DBV	LDDU	18.260617	42.560718	Europe/Zagreb	0
1401	Dalby Airport	Dalby	Australia	AU	DBY	YDAY	151.266667	-27.15	Australia/Brisbane	0
1402	Ronald Reagan Washington National Airport	Washington	United States	US	DCA	KDCA	-77.043457	38.853434	America/New_York	0
1403	Canefield Airport	Dominica	Dominica	DM	DCF	TDCF	-61.391779	15.339047	America/Dominica	0
1404	Decimomannu Air Base	Decimomannu	Italy	IT	DCI	LIED	8.973867	39.353408	Europe/Rome	0
1405	Mazamet Airport	Castres	France	FR	DCM	LFCK	2.284167	43.555833	Europe/Paris	0
1406	Decatur Hi-Way Airport	Decatur	United States	US	DCR	KDCR	-84.933333	40.833333	America/Indiana/Indianapolis	0
1407	Duncan Town Airport	Duncan Town	Bahamas	BS	DCT	MYRD	-75.75	22.25	America/Nassau	0
1408	Pyor Airport	Decatur	United States	US	DCU	KDCU	-86.983333	34.6	America/Chicago	0
1409	Daocheng Yading Airport	Daocheng	China	CN	DCY	ZUDC	100.053333	29.323056	Asia/Shanghai	0
1410	Dodge City Regional Airport	Dodge City	United States	US	DDC	KDDC	-99.965	37.761667	America/Chicago	0
1411	Langtou Airport	Dandong	China	CN	DDG	ZYDD	124.286009	40.024701	Asia/Shanghai	0
1412	Daydream Island Airport	Daydream Island	Australia	AU	DDI	YDDI	148.816667	-20.266667	Australia/Brisbane	0
1413	Delta Downs Airport	Delta Downs	Australia	AU	DDN	YDLT	141.3	-16.916667	Australia/Brisbane	0
1414	Dera Ghazi Khan Airport	Dera Ghazi Khan	Pakistan	PK	DEA	OPDG	70.48841	29.961086	Asia/Karachi	0
1415	Debrecen Airport	Debrecen	Hungary	HU	DEB	LHDC	21.610472	47.488086	Europe/Budapest	0
1416	Decatur Airport	Decatur	United States	US	DEC	KDEC	-88.876529	39.834251	America/Chicago	0
1417	Dehra Dun Airport	Dehra Dun	India	IN	DED	VIDN	78.033333	30.316667	Asia/Kolkata	0
1418	Mendeleyevo Airport	Kunashir Island	Russian Federation	RU	DEE	UHSM	145.682999	43.958401	Asia/Ust-Nera	0
1419	Dezful Airport	Dezful	Iran	IR	DEF	OIAD	48.384683	32.438827	Asia/Tehran	0
1420	Decorah Municipal Airport	Decorah	United States	US	DEH	KDEH	-91.8	43.3	America/Chicago	0
1421	Denis Island Airport	Denis Island	Seychelles	SC	DEI	FSSD	55.666667	-3.8	Indian/Mahe	0
1422	Delhi Indira Gandhi International Airport	Delhi	India	IN	DEL	VIDP	77.099958	28.556162	Asia/Kolkata	0
1423	Dembidollo Airport	Dembidollo	Ethiopia	ET	DEM	HADD	34.860451	8.549306	Africa/Addis_Ababa	0
1424	Denver International Airport	Denver	United States	US	DEN	KDEN	-104.673098	39.851382	America/Denver	0
1425	Deparizo Airport	Deparizo	India	IN	DEP	VEDZ	94	27.35	Asia/Kolkata	0
1426	Desroches Airport	Desroches	Seychelles	SC	DES	FSDR	53.683333	-5.683333	Indian/Mahe	0
1427	Coleman A. Young Municipal Airport	Detroit	United States	US	DET	KDET	-83.005101	42.409322	America/New_York	0
1428	Nop Goliath Airport	Yahukimo	Indonesia	ID	DEX	WAVD	139.482	-4.8557	Asia/Jayapura	0
1429	Al Jafrah Airport	Deirezzor	Syrian Arab Republic	SY	DEZ	OSDZ	40.186807	35.287551	Asia/Damascus	0
1430	Defiance Memorial Airport	Defiance	United States	US	DFI	KDFI	-84.366667	41.283333	America/New_York	0
1431	Drumduff Airport	Drumduff	Australia	AU	DFP	YDDF	143.333333	-16	Australia/Brisbane	0
1432	Dallas Fort Worth International Airport	Dallas	United States	US	DFW	KDFW	-97.036128	32.897462	America/Chicago	0
1433	Degeha Bur Airport	Degeh Bur	Ethiopia	ET	DGC	HADB	43.583333	8.233333	Africa/Addis_Ababa	0
1434	Dalgaranga Airport	Dalgaranga	Australia	AU	DGD	YDGA	117.301389	-27.818056	Australia/Perth	0
1435	Mudgee Airport	Mudgee	Australia	AU	DGE	YMDG	149.615125	-32.563914	Australia/Sydney	0
1436	Douglas Lake Airport	Douglas Lake	Canada	CA	DGF	CAL3	-120.183333	50.166667	America/Vancouver	0
1437	Douglas Municipal Airport	Douglas	United States	US	DGL	KDGL	-109.566667	31.35	America/Phoenix	0
1438	Wa	Wa	Ghana	GH	WZA	DGLW	-2.5067	10.0844	Africa/Accra	0
1439	Naval Air Field	Dahlgren	United States	US	DGN	KNDY	-88.683333	38.2	America/New_York	0
1440	Guadalupe Victoria Airport	Durango	Mexico	MX	DGO	MMDO	-104.525	24.125	America/Mexico_City	0
1441	Dargaville Aerodrome	Dargaville	New Zealand	NZ	DGR	NZDA	173.893383	-35.939455	Pacific/Auckland	0
1442	Dumaguete Airport	Dumaguete	Philippines	PH	DGT	RPVD	123.296011	9.332543	Asia/Manila	0
1443	Dedougou Airport	Dedougou	Burkina Faso	BF	DGU	DFOD	-3.483333	12.466667	Africa/Ouagadougou	0
1444	Converse County Airport	Douglas	United States	US	DGW	KDGW	-105.4	42.75	America/Denver	0
1445	King Abdulaziz Air Base	Dhahran	Saudi Arabia	SA	DHA	OEDR	50.15114	26.267071	Asia/Riyadh	0
1446	Durham Downs Airport	Durham Downs	Australia	AU	DHD	YDRH	149.083333	-26.1	Australia/Brisbane	0
1447	Al Dhafra Air Base	Abu Dhabi	United Arab Emirates	AE	DHF	OMAM	54.549905	24.250185	Asia/Dubai	0
1448	Dhangarhi Airport	Dhangarhi	Nepal	NP	DHI	VNDH	80.581902	28.7533	Asia/Kathmandu	0
1449	Gaggal Airport	Dharamsala	India	IN	DHM	VIGG	76.260688	32.165481	Asia/Kolkata	0
1450	Dothan Regional Airport	Dothan	United States	US	DHN	KDHN	-85.450241	31.317943	America/Chicago	0
1451	De Kooy Airport	Den Helder	Netherlands	NL	DHR	EHKD	4.75	52.95	Europe/Amsterdam	0
1452	Dalhart Airport	Dalhart	United States	US	DHT	KDHT	-102.516667	36.066667	America/Chicago	0
1453	Doha International Airport	Doha	Qatar	QA	DIA	OTBD	51.565094	25.261058	Asia/Qatar	0
1454	Dibrugarh Airport	Dibrugarh	India	IN	DIB	VEMN	95.016474	27.483222	Asia/Kolkata	0
1455	Antsiranana/Arrachart Airport	Antsiranana	Madagascar	MG	DIE	FMNA	49.2925	-12.346111	Indian/Antananarivo	0
1456	Diqing Shangri-La Airport	Diqing	China	CN	DIG	ZPDQ	99.680584	27.795839	Asia/Shanghai	0
1457	Longvic Airport	Dijon	France	FR	DIJ	LFSD	5.088889	47.270833	Europe/Paris	0
1458	Dickinson Regional Airport	Dickinson	United States	US	DIK	KDIK	-102.793204	46.801471	America/Denver	0
1459	Comoro Airport	Dili	East Timor	TL	DIL	WPDL	125.525003	-8.549616	Asia/Dili	0
1460	Dimbokro Airport	Dimbokro	Cote d'Ivoire	CI	DIM	DIDK	-4.766667	6.75	Africa/Abidjan	0
1461	Diapaga Airport	Diapaga	Burkina Faso	BF	DIP	DFED	2.033333	12.033333	Africa/Ouagadougou	0
1462	Divinopolis Airport	Divinopolis	Brazil	BR	DIQ	SNDV	-44.872915	-20.174218	America/Sao_Paulo	0
1463	Aba Tenna D Yilma Airport	Dire Dawa	Ethiopia	ET	DIR	HADR	41.857994	9.61338	Africa/Addis_Ababa	0
1464	Ngot Nzoungou Airport	Dolisie	Congo	CG	DIS	FCPD	12.666908	-4.210988	Africa/Brazzaville	0
1465	Diu Airport	Diu	India	IN	DIU	VADU	70.916667	20.716667	Asia/Kolkata	0
1466	Divo Airport	Divo	Cote d'Ivoire	CI	DIV	DIDV	-5.25	5.8	Africa/Abidjan	0
1467	Diyarbakir Airport	Diyarbakir	Turkiye	TR	DIY	LTCC	40.197356	37.910803	Europe/Istanbul	0
1468	Djougou Airport	Djougou	Benin	BJ	DJA	DBBD	1.666667	9.7	Africa/Porto-Novo	0
1469	Sultan Thaha Airport	Jambi	Indonesia	ID	DJB	WIJJ	103.638826	-1.631628	Asia/Jakarta	0
1470	Zarsis Airport	Djerba	Tunisia	TN	DJE	DTTJ	10.775145	33.87118	Africa/Tunis	0
1471	Tiska Airport	Djanet	Algeria	DZ	DJG	DAAJ	9.451944	24.293056	Africa/Algiers	0
1472	Sentani Airport	Jayapura	Indonesia	ID	DJJ	WAJJ	140.51299	-2.569887	Asia/Jayapura	0
1473	Djambala Airport	Djambala	Congo	CG	DJM	FCBD	14.75	-2.533333	Africa/Brazzaville	0
1474	Delta Junction Airport	Delta Junction	United States	US	DJN	PABI	-145.725642	64.049829	America/Anchorage	0
1475	Daloa Airport	Daloa	Cote d'Ivoire	CI	DJO	DIDL	-6.466667	6.866944	Africa/Abidjan	0
1476	Djupivogur Airport	Djupivogur	Iceland	IS	DJU	BIDV	-14.268333	64.650278	Atlantic/Reykjavik	0
1477	Katsina Airport	Katsina	Nigeria	NG	DKA	DNKT	7.660803	13.003712	Africa/Lagos	0
1478	Dunk Island Airport	Dunk Island	Australia	AU	DKI	YDKI	146.136667	-17.941667	Australia/Brisbane	0
1479	Dunkirk Airport	Dunkirk	United States	US	DKK	KDKK	-79.333333	42.483333	America/New_York	0
1480	Leopold Sedar Senghor International Airport	Dakar	Senegal	SN	DKR	GOOY	-17.490194	14.744975	Africa/Dakar	0
1481	Dikson Airport	Dikson	Russian Federation	RU	DKS	UODD	80.38338	73.515727	Asia/Krasnoyarsk	0
1482	Docker River Airport	Docker River	Australia	AU	DKV	YDVR	129.083333	-24.866667	Australia/Darwin	0
1483	Douala Airport	Douala	Cameroon	CM	DLA	FKKD	9.717018	4.01346	Africa/Douala	0
1484	Dalian Zhoushuizi International Airport	Dalian	China	CN	DLC	ZYTL	121.539991	38.96102	Asia/Shanghai	0
1485	Dagali Airport	Geilo	Norway	NO	DLD	ENDI	8.483333	60.466667	Europe/Oslo	0
1486	Dole-Jura Airport	Dole	France	FR	DLE	LFGJ	5.428719	47.038254	Europe/Paris	0
1487	Laughlin Air Force Base	Del Rio	United States	US	DLF	KDLF	-100.778668	29.359235	America/Chicago	0
1488	Dillingham Airport	Dillingham	United States	US	DLG	PADL	-158.511113	59.04264	America/Anchorage	0
1489	Duluth International Airport	Duluth	United States	US	DLH	KDLH	-92.180192	46.838975	America/Chicago	0
1490	Lien Khuong Airport	Dalat	Viet Nam	VN	DLI	VVDL	108.376033	11.749689	Asia/Ho_Chi_Minh	0
1491	Dulkaninna Airport	Dulkaninna	Australia	AU	DLK	YDLK	139.466667	-29.016667	Australia/Adelaide	0
1492	Dillon Airport	Dillon	United States	US	DLL	KDLC	-79.366667	34.416667	America/New_York	0
1493	Dalaman Airport	Dalaman	Turkiye	TR	DLM	LTBS	28.787155	36.717336	Europe/Istanbul	0
1494	Dillon Airport	Dillon	United States	US	DLN	KDLN	-112.553001	45.255402	America/Denver	0
1495	The Dalles Airport	The Dalles	United States	US	DLS	KDLS	-121.166667	45.6	America/Los_Angeles	0
1496	Dali Airport	Dali City	China	CN	DLU	ZPDL	100.323158	25.65135	Asia/Shanghai	0
1497	Delissaville Airport	Delissaville	Australia	AU	DLV	YDLV	130.633333	-12.566667	Australia/Darwin	0
1498	Dillons Bay Airport	Dillons Bay	Vanuatu	VU	DLY	NVVD	169.15	-18.7	Pacific/Efate	0
1499	Gurvan Saikhan Airport	Dalanzadgad	Mongolia	MN	DLZ	ZMDZ	104.370329	43.606001	Asia/Ulaanbaatar	0
1500	Davis Monthan Air Force Base	Tucson	United States	US	DMA	KDMA	-110.883333	32.166667	America/Phoenix	0
1501	Jambyl Airport	Taraz	Kazakhstan	KZ	DMB	UADD	71.304595	42.855372	Asia/Almaty	0
1502	Doomadgee Airport	Doomadgee	Australia	AU	DMD	YDMG	138.821596	-17.939202	Australia/Brisbane	0
1503	Moscow Domodedovo Airport	Moscow	Russian Federation	RU	DME	UUDD	37.899494	55.414566	Europe/Moscow	0
1504	Bangkok Don Mueang International Airport	Bangkok	Thailand	TH	DMK	VTBD	100.606667	13.9125	Asia/Bangkok	0
1505	Dammam King Fahd International Airport	Dammam	Saudi Arabia	SA	DMM	OEDF	49.797778	26.471111	Asia/Riyadh	0
1506	Deming Airport	Deming	United States	US	DMN	KDMN	-107.75	32.266667	America/Denver	0
1507	Sedalia Airport	Sedalia	United States	US	DMO	KDMO	-93.180556	38.704167	America/Chicago	0
1508	Diamantino Airport	Diamantino	Brazil	BR	DMT	SWDM	-56.5	-14.5	America/Campo_Grande	0
1509	Dimapur Airport	Dimapur	India	IN	DMU	VEMR	93.772866	25.879816	Asia/Kolkata	0
1510	Kadena Air Force Base	Okinawa	Japan	JP	DNA	RODN	127.766667	26.35	Asia/Tokyo	0
1511	Dunbar Airport	Dunbar	Australia	AU	DNB	YDBR	142.390556	-16.010833	Australia/Brisbane	0
1512	Dundee Airport	Dundee	United Kingdom	GB	DND	EGPN	-3.014531	56.454091	Europe/London	0
1513	Doongan Airport	Doongan	Australia	AU	DNG	YDGN	126.3	-15.383333	Australia/Perth	0
1514	Dunhuang Airport	Dunhuang	China	CN	DNH	ZLDH	94.683333	40.2	Asia/Shanghai	0
1515	Sam Mbakwe International Airport	Imo	Nigeria	NG	QOW	DNIM	7.201676	5.427866	Africa/Lagos	0
1516	Dnepropetrovsk International Airport	Dnepropetrovsk	Ukraine	UA	DNK	UKDD	35.094461	48.368741	Europe/Kiev	0
1517	Daniel Field	Augusta	United States	US	DNL	KDNL	-82.039197	33.468096	America/New_York	0
1518	Denham Airport	Denham	Australia	AU	DNM	YDHM	113.533333	-25.916667	Australia/Perth	0
1519	Dalton Municipal Airport	Dalton	United States	US	DNN	KDNN	-84.966667	34.766667	America/New_York	0
1520	Dianopolis Airport	Dianopolis	Brazil	BR	DNO	SWDN	-46.85	-11.616667	America/Belem	0
1521	Dang Airport	Dang	Nepal	NP	DNP	VNDG	82.316667	28.116667	Asia/Kathmandu	0
1522	Deniliquin Airport	Deniliquin	Australia	AU	DNQ	YDLQ	144.951667	-35.56	Australia/Sydney	0
1523	Pleurtuit Airport	Dinard	France	FR	DNR	LFRD	-2.083611	48.587778	Europe/Paris	0
1524	Denison Municipal Airport	Denison	United States	US	DNS	KDNS	-95.35	42.016667	America/Chicago	0
1525	Vermilion Regional Airport	Danville	United States	US	DNV	KDNV	-87.596944	40.197222	America/Chicago	0
1526	Galegu Airport	Dinder	Sudan	SD	DNX	HSGG	33.066667	14.1	Africa/Khartoum	0
1527	Cardak Airport	Denizli	Turkiye	TR	DNZ	LTAY	29.703333	37.787222	Europe/Istanbul	0
1528	Rar Gwamar Airport	Dobo	Indonesia	ID	DOB	WAPD	134.209426	-5.77376	Asia/Jayapura	0
1529	Dodoma Airport	Dodoma	United Republic of Tanzania	TZ	DOD	HTDO	35.752695	-6.17044	Africa/Dar_es_Salaam	0
1530	Dongola Airport	Dongola	Sudan	SD	DOG	HSDN	30.431921	19.151995	Africa/Khartoum	0
1531	Doha Hamad International Airport	Doha	Qatar	QA	DOH	OTHH	51.613594	25.260988	Asia/Qatar	0
1532	Saint Gatien Airport	Deauville	France	FR	DOL	LFRG	0.164167	49.362778	Europe/Paris	0
1533	Melville Hall Airport	Dominica	Dominica	DM	DOM	TDPD	-61.300542	15.545895	America/Dominica	0
1534	Dolpa Airport	Dolpa	Nepal	NP	DOP	VNDP	82.818987	28.985086	Asia/Kathmandu	0
1535	Dori Airport	Dori	Burkina Faso	BF	DOR	DFEE	-0.033333	14.033333	Africa/Ouagadougou	0
1536	Dourados Airport	Dourados	Brazil	BR	DOU	SBDO	-54.925556	-22.202778	America/Campo_Grande	0
1537	Dover Air Force Base	Dover-Cheswold	United States	US	DOV	KDOV	-75.464167	39.128611	America/New_York	0
1538	Dongara Airport	Dongara	Australia	AU	DOX	YDRA	114.933333	-29.25	Australia/Perth	0
1539	Dongying Airport	Dongying	China	CN	DOY	ZSDY	118.787778	37.518333	Asia/Shanghai	0
1540	DuPage Airport	Chicago	United States	US	DPA	KDPA	-88.253748	41.906831	America/Chicago	0
1541	Pampa Guanaco Airport	Cameron	Chile	CL	DPB	SCBI	-68.808852	-54.049967	America/Argentina/Salta	0
1542	St Aubin Airport	Dieppe	France	FR	DPE	LFAB	1.080755	49.884806	Europe/Paris	0
1543	Michael Army Air Field	Dugway	United States	US	DPG	KDPG	-112.75	40.233333	America/Denver	0
1544	Dipolog Airport	Dipolog	Philippines	PH	DPL	RPMG	123.344179	8.599978	Asia/Manila	0
1545	Devonport Airport	Devonport	Australia	AU	DPO	YDPO	146.427535	-41.172056	Australia/Hobart	0
1546	Denpasar Ngurah Rai International Airport	Denpasar	Indonesia	ID	DPS	WADD	115.1675	-8.748056	Asia/Makassar	0
1547	Duqm International Airport	Duqm	Oman	OM	DQM	OODQ	57.6383	19.502323	Asia/Muscat	0
1548	Derby Airport	Derby	Australia	AU	DRB	YDBY	123.662804	-17.370488	Australia/Perth	0
1549	Dorunda Station Airport	Dorunda Station	Australia	AU	DRD	YDOR	142.333333	-16.5	Australia/Brisbane	0
1550	Deering Airport	Deering	United States	US	DRG	PADE	-162.759886	66.071194	America/Anchorage	0
1551	Dabra Airport	Dabra	Indonesia	ID	DRH	WAJC	138.566667	-3.25	Asia/Jayapura	0
1552	Beauregard Parish Airport	De Ridder	United States	US	DRI	KDRI	-93.283333	30.85	America/Chicago	0
1553	Drietabbetje Airport	Drietabbetje	Suriname	SR	DRJ	SMDA	-54.666667	4.116667	America/Paramaribo	0
1554	Drake Bay Airport	Drake Bay	Costa Rica	CR	DRK	MRDK	-83.642523	8.719173	America/Costa_Rica	0
1555	Dirranbandi Airport	Dirranbandi	Australia	AU	DRN	YDBI	148.215278	-28.586667	Australia/Brisbane	0
1556	Durango-La Plata County Airport	Durango	United States	US	DRO	KDRO	-107.751075	37.15995	America/Denver	0
1557	Bicol International Airport	Daraga	Philippines	PH	DRP	RPLK	123.681111	13.111389	Asia/Manila	0
1558	Durrie Airport	Durrie	Australia	AU	DRR	YDRI	140.216667	-25.616667	Australia/Brisbane	0
1559	Dresden International Airport	Dresden	Germany	DE	DRS	EDDC	13.766082	51.124333	Europe/Berlin	0
1560	Del Rio International Airport	Del Rio	United States	US	DRT	KDRT	-100.927142	29.374215	America/Chicago	0
1561	Drummond Airport	Drummond	United States	US	DRU	KDRU	-113.15	46.666667	America/Denver	0
1562	Dharavandhoo AIrport	Dharavandhoo Island	Maldives	MV	DRV	VRMD	73.13028	5.156111	Indian/Maldives	0
1563	Darwin International Airport	Darwin	Australia	AU	DRW	YPDN	130.877521	-12.407805	Australia/Darwin	0
1564	Drysdale River Airport	Drysdale River	Australia	AU	DRY	YDRD	126.416667	-15.666667	Australia/Perth	0
1565	Dschang Airport	Dschang	Cameroon	CM	DSC	FKKS	10.091667	5.833333	Africa/Douala	0
1566	La Desirade Airport	La Desirade	Guadeloupe	GP	DSD	TFFA	-61.016667	16.333333	America/Guadeloupe	0
1567	Kombolcha Airport	Dessie	Ethiopia	ET	DSE	HADC	39.725592	11.111318	Africa/Addis_Ababa	0
1568	Destin-Fort Walton Beach Airport	Destin	United States	US	DSI	KDTS	-86.470882	30.399591	America/Chicago	0
1569	Dera Ismail Khan Airport	Dera Ismail Khan	Pakistan	PK	DSK	OPDI	70.8875	31.9097	Asia/Karachi	0
1570	Des Moines International Airport	Des Moines	United States	US	DSM	KDSM	-93.648087	41.532434	America/Chicago	0
1571	Ordos Ejin Horo Airport	Dongsheng	China	CN	DSN	ZBDS	109.860527	39.496721	Asia/Shanghai	0
1572	Sondok Airport	Sondok	Democratic People's Republic of Korea	KP	DSO	ZKSD	127.473889	39.746389	Asia/Pyongyang	0
1573	Blaise Diagne International Airport	Dakar	Senegal	SN	DSS	GOBD	-17.070913	14.670754	Africa/Dakar	0
1574	Dansville Airport	Dansville	United States	US	DSV	KDSV	-77.7	42.566667	America/New_York	0
1575	Dongsha Island Airport	Dongsha Island	Taiwan	TW	DSX	RCLM	116.727367	20.70452	Asia/Taipei	0
1576	Delta Airport	Delta	United States	US	DTA	KDTA	-112.5	39.383333	America/Denver	0
1577	Silangit Airport	Siborong-Borong	Indonesia	ID	DTB	WIMN	98.995278	2.259722	Asia/Jakarta	0
1578	Datadawai Airport	Datadawai	Indonesia	ID	DTD	WALJ	114.5294	0.8081	Asia/Makassar	0
1579	Camarines Norte Airport	Daet	Philippines	PH	DTE	RPUD	122.983333	14.133333	Asia/Manila	0
1580	Diamantina Airport	Diamantina	Brazil	BR	DTI	SNDT	-43.647848	-18.230804	America/Sao_Paulo	0
1581	Wething Field	Detroit Lakes	United States	US	DTL	KDTL	-95.886111	46.826389	America/Chicago	0
1582	Dortmund Airport	Dortmund	Germany	DE	DTM	EDLW	7.613139	51.514826	Europe/Berlin	0
1583	Shreveport Downtown Airport	Shreveport	United States	US	DTN	KDTN	-93.744444	32.539722	America/Chicago	0
1584	Bizerte Airport	Bizerte	Tunisia	TN	QIZ	DTTB	9.791389	37.245556	Africa/Tunis	0
1585	Detroit Metropolitan Wayne County Airport	Detroit	United States	US	DTW	KDTW	-83.356048	42.207808	America/New_York	0
1586	Durant Regional Airport - Eaker Field	Durant	United States	US	DUA	KDUA	-96.394494	33.94231	America/Chicago	0
1587	Dublin Airport	Dublin	Ireland	IE	DUB	EIDW	-6.24357	53.42728	Europe/Dublin	0
1588	Halliburton Field	Duncan	United States	US	DUC	KDUC	-97.959722	34.472222	America/Chicago	0
1589	Dunedin International Airport	Dunedin	New Zealand	NZ	DUD	NZDN	170.199052	-45.923871	Pacific/Auckland	0
1590	Bisbee-Douglas International Airport	Douglas	United States	US	DUG	KDUG	-109.603611	31.468611	America/Phoenix	0
1591	Jefferson County Airport	Dubois	United States	US	DUJ	KDUJ	-78.898889	41.178333	America/New_York	0
1592	Dukuduk Airport	Dukuduk	South Africa	ZA	DUK	FADK	32.234167	-28.366667	Africa/Johannesburg	0
1593	Pinang Kampai Airport	Dumai	Indonesia	ID	DUM	WIBD	101.43373	1.61172	Asia/Jakarta	0
1594	Duncan/Quam Airport	Duncan/Quam	Canada	CA	DUQ	CAM3	-123.7	48.783333	America/Vancouver	0
1595	King Shaka International Airport	Durban	South Africa	ZA	DUR	FALE	31.116389	-29.614444	Africa/Johannesburg	0
1596	Dusseldorf Airport	Dusseldorf	Germany	DE	DUS	EDDL	6.76558	51.278327	Europe/Berlin	0
1597	Unalaska Airport	Dutch Harbor	United States	US	DUT	PADU	-166.542238	53.894458	America/Anchorage	0
1598	Devils Lake Airport	Devils Lake	United States	US	DVL	KDVL	-98.9075	48.113056	America/Chicago	0
1599	Davenport Airport	Davenport	United States	US	DVN	KDVN	-90.588611	41.610556	America/Chicago	0
1600	Francisco Bangoy Intl Airport	Davao	Philippines	PH	DVO	RPMD	125.644698	7.130696	Asia/Manila	0
1601	Davenport Downs Airport	Davenport Downs	Australia	AU	DVP	YDPD	141.116667	-24.133333	Australia/Brisbane	0
1602	Daly River Airport	Daly River	Australia	AU	DVR	YDMN	130.683333	-13.75	Australia/Darwin	0
1603	Phoenix Deer Valley Airport	Phoenix	United States	US	DVT	KDVT	-112.0825	33.688333	America/Phoenix	0
1604	Dwamawa Airport	Dwamawa	Malawi	MW	DWA	FWDW	34.133333	-13	Africa/Blantyre	0
1605	Soalala Airport	Soalala	Madagascar	MG	DWB	FMNO	45.366667	-16.1	Indian/Antananarivo	0
1606	Dubai World Central - Al Maktoum International Airport	Dubai	United Arab Emirates	AE	DWC	OMDW	55.162467	24.892845	Asia/Dubai	0
1607	Aldawadmi Airport	Dawadmi	Saudi Arabia	SA	DWD	OEDM	44.128702	24.445546	Asia/Riyadh	0
1608	David Wayne Hooks Memorial Airport	Houston	United States	US	DWH	KDWH	-95.550861	30.060468	America/Chicago	0
1609	Dwyer Air Base	Dwyer	Afghanistan	AF	DWR	OADY	64.066944	31.091389	Asia/Kabul	0
1610	Dubai International Airport	Dubai	United Arab Emirates	AE	DXB	OMDB	55.352916	25.248664	Asia/Dubai	0
1611	Dixie Airport	Dixie	Australia	AU	DXD	YDIX	143.666667	-15.166667	Australia/Brisbane	0
1612	Bruce Campbell Field	Madison	United States	US	DXE	KMBO	-90.104127	32.44107	America/Chicago	0
1613	Danbury Municipal Airport	Danbury	United States	US	DXR	KDXR	-73.48999	41.371782	America/New_York	0
1614	Dysart Airport	Dysart	Australia	AU	DYA	YDYS	148	-23.5	Australia/Brisbane	0
1615	Zhangjiajie Hehua Airport	Dayong	China	CN	DYG	ZGDY	110.445685	29.10712	Asia/Shanghai	0
1616	Doylestown Airport	Doylestown	United States	US	DYL	KDYL	-75.133333	40.316667	America/New_York	0
1617	Anadyr Airport	Anadyr	Russian Federation	RU	DYR	UHMA	177.75	64.733333	Asia/Anadyr	0
1618	Dyess Air Force Base	Abilene	United States	US	DYS	KDYS	-99.848551	32.419703	America/Chicago	0
1619	Dushanbe Airport	Dushanbe	Tajikistan	TJ	DYU	UTDD	68.817287	38.54894	Asia/Dushanbe	0
1620	Daly Waters Airport	Daly Waters	Australia	AU	DYW	YDLW	133.4	-16.25	Australia/Darwin	0
1621	Dzaoudzi Airport	Dzaoudzi	Mayotte	YT	DZA	FMCZ	45.282099	-12.804901	Indian/Mayotte	0
1622	Zhezhazgan Airport	Zhezkazgan	Kazakhstan	KZ	DZN	UAKD	67.733333	47.7	Asia/Almaty	0
1623	Durazno Airport	Durazno	Uruguay	UY	DZO	SUDU	-56.516667	-33.416667	America/Montevideo	0
1624	Dazu Airport	Dazu	China	CN	DZU	ZUDZ	105.716667	29.7	Asia/Shanghai	0
1625	Eagle Airport	Eagle	United States	US	EAA	PAEG	-141.149611	64.778083	America/Anchorage	0
1626	Abbse Airport	Abbse	Republic of Yemen	YE	EAB	OYBS	43.5	14.583333	Asia/Aden	0
1627	Emae Airport	Emae	Vanuatu	VU	EAE	NVSE	168.416667	-17.166667	Pacific/Efate	0
1628	Nejran Airport	Nejran	Saudi Arabia	SA	EAM	OENG	44.414646	17.613282	Asia/Riyadh	0
1629	Phifer Field	Wheatland	United States	US	EAN	KEAN	-104.966667	42.05	America/Denver	0
1630	Kearney Regional Airport	Kearney	United States	US	EAR	KEAR	-99.008451	40.728458	America/Chicago	0
1631	San Sebastian Airport	San Sebastian	Spain and Canary Islands	ES	EAS	LESO	-1.793538	43.356401	Europe/Madrid	0
1632	Pangborn Field	Wenatchee	United States	US	EAT	KEAT	-120.207778	47.399722	America/Los_Angeles	0
1633	Eau Claire Airport	Eau Claire	United States	US	EAU	KEAU	-91.487222	44.864444	America/Chicago	0
1634	Marina Di Campo Airport	Elba Island	Italy	IT	EBA	LIRJ	10.240409	42.763104	Europe/Rome	0
1635	Entebbe International Airport	Entebbe	Uganda	UG	EBB	HUEN	32.443183	0.045111	Africa/Kampala	0
1636	El Obeid Airport	El Obeid	Sudan	SD	EBD	HSOB	30.234167	13.159722	Africa/Khartoum	0
1637	El Bagre Airport	El Bagre	Colombia	CO	EBG	SKEB	-74.808952	7.596527	America/Bogota	0
1638	El Bayadh Airport	El Bayadh	Algeria	DZ	EBH	DAOY	1.094105	33.717803	Africa/Algiers	0
1639	Esbjerg Airport	Esbjerg	Denmark	DK	EBJ	EKEB	8.549062	55.521431	Europe/Copenhagen	0
1640	Erbil International Airport	Erbil	Iraq	IQ	EBL	ORER	43.963056	36.2375	Asia/Baghdad	0
1641	El Borma Airport	El Borma	Tunisia	TN	EBM	DTTR	9.266667	31.716667	Africa/Tunis	0
1642	Webster City Municipal Airport	Webster City	United States	US	EBS	KEBS	-93.816667	42.466667	America/Chicago	0
1643	Boutheon Airport	Saint Etienne	France	FR	EBU	LFMH	4.296944	45.541389	Europe/Paris	0
1644	Ebolowa Airport	Ebolowa	Cameroon	CM	EBW	FKKW	11.166667	2.916667	Africa/Douala	0
1645	Elizabeth City Airport	Elizabeth City	United States	US	ECG	KECG	-76.173056	36.259167	America/New_York	0
1646	Echuca Airport	Echuca	Australia	AU	ECH	YECH	144.75	-36.15	Australia/Sydney	0
1647	Costa Esmeralda Airport	Tola	Nicaragua	NI	ECI	MNCE	-86.023861	11.431209	America/Managua	0
1648	Ercan Airport	Ercan	Cyprus	CY	ECN	LCEN	33.50307	35.158118	Asia/Famagusta	0
1649	El Encanto Airport	El Encanto	Colombia	CO	ECO	SQZN	-73.233333	-1.616667	America/Bogota	0
1650	Northwest Florida Beaches International Airport	Panama City	United States	US	ECP	KECP	-85.798847	30.355819	America/Chicago	0
1651	El Charco Airport	El Charco	Colombia	CO	ECR	SKEH	-78	2.5	America/Bogota	0
1652	Mondell Field	Newcastle	United States	US	ECS	KECS	-104.318011	43.885385	America/Denver	0
1653	Austin Executive Airport	Austin	United States	US	EDC	KEDC	-97.5735	30.3999	America/Chicago	0
1654	Erlunda Airport	Erldunda	Australia	AU	EDD	YERL	133.2	-25.25	Australia/Darwin	0
1655	Northeastern Regional Airport	Edenton	United States	US	EDE	KEDE	-76.568691	36.020711	America/New_York	0
1656	Darmstadt Airport	Darmstadt	Germany	DE	ZCS	EDES	8.586667	49.854722	Europe/Berlin	0
1657	Elmendorf Air Force Base	Anchorage	United States	US	EDF	PAED	-149.802833	61.250403	America/Anchorage	0
1658	Weide Army Air Field	Edgewood Arsenal	United States	US	EDG	KEDG	-76.360917	39.465667	America/New_York	0
1659	Ludwigshafen Unfallklinik Airport	Ludwigshafen	Germany	DE	ZOE	EDGL	8.389167	49.486389	Europe/Berlin	0
1660	Hungriger Wolf Airport	Itzehoe	Germany	DE	IZE	EDHF	9.578611	53.994446	Europe/Berlin	0
1661	Edinburgh Airport	Edinburgh	United Kingdom	GB	EDI	EGPH	-3.364177	55.948143	Europe/London	0
1662	El Dorado Airport	El Dorado	United States	US	EDK	KEQA	-96.866667	37.816667	America/Chicago	0
1663	Eldoret Airport	Eldoret	Kenya	KE	EDL	HKEL	35.223599	0.4054	Africa/Nairobi	0
1664	Les Ajoncs Airport	La Roche	France	FR	EDM	LFRI	-1.383333	46.7	Europe/Paris	0
1665	Balikesir Koca Seyit Airport	Edremit	Turkiye	TR	EDO	LTFD	27.011319	39.549267	Europe/Istanbul	0
1666	Zweibrucken Airport	Zweibrucken	Germany	DE	ZQW	EDRZ	7.399708	49.215161	Europe/Berlin	0
1667	Flugplatz Goppingen Bezgenriet	Goeppingen	Germany	DE	ZES	EDSE	9.625	48.658333	Europe/Berlin	0
1668	Edwards Air Force Base	Edwards Air Force Base	United States	US	EDW	KEDW	-117.881232	34.908862	America/Los_Angeles	0
1669	Needles Airport	Needles	United States	US	EED	KEED	-114.616667	34.85	America/Los_Angeles	0
1670	Eek Airport	Eek	United States	US	EEK	PAEE	-162.043889	60.213694	America/Anchorage	0
1671	Dillant-Hopkins Airport	Keene	United States	US	EEN	KEEN	-72.270833	42.900833	America/New_York	0
1672	Ellington Field	Houston	United States	US	EFD	KEFD	-95.159708	29.609583	America/Chicago	0
1673	Newport State Airport	Newport	United States	US	EFK	KEFK	-72.23	44.889444	America/New_York	0
1674	Kefallinia Airport	Kefallinia	Greece	GR	EFL	LGKF	20.505556	38.118056	Europe/Athens	0
1675	Jefferson Municipal Airport	Jefferson	United States	US	EFW	KEFW	-94.383333	42.016667	America/Chicago	0
1676	Roumanieres Airport	Bergerac	France	FR	EGC	LFBE	0.483333	44.85	Europe/Paris	0
1677	Eagle County Airport	Vail	United States	US	EGE	KEGE	-106.913471	39.639882	America/Denver	0
1678	Duke Field	Crestview	United States	US	EGI	KEGI	-86.522905	30.650388	America/Chicago	0
1679	Neghelli Airport	Neghelli	Ethiopia	ET	EGL	HANG	39.716667	5.283333	Africa/Addis_Ababa	0
1680	Sege Airport	Sege	Solomon Islands	SB	EGM	AGGS	157.875066	-8.577956	Pacific/Guadalcanal	0
1681	Geneina Airport	Geneina	Sudan	SD	EGN	HSSG	22.469444	13.4875	Africa/Khartoum	0
1682	Belgorod Airport	Belgorod	Russian Federation	RU	EGO	UUOB	36.582226	50.644713	Europe/Moscow	0
1683	Anglesey Airport	Valley	United Kingdom	GB	VLY	EGOV	-4.529017	53.250359	Europe/London	0
1684	Egilsstadir Airport	Egilsstadir	Iceland	IS	EGS	BIEG	-14.402778	65.277778	Atlantic/Reykjavik	0
1685	Eagle River Airport	Eagle River	United States	US	EGV	KEGV	-89.265833	45.929167	America/Chicago	0
1686	Egegik Airport	Egegik	United States	US	EGX	PAII	-157.370278	58.207778	America/Anchorage	0
1687	Coltishall Ab	Coltishall	United Kingdom	GB	CLF	EGYC	1.420935	52.8	Europe/London	0
1688	El Bolson Airport	El Bolson	Argentina	AR	EHL	SAVB	-71.75	-42	America/Argentina/Buenos_Aires	0
1689	Cape Newenham Airport	Cape Newenham	United States	US	EHM	PAEH	-162.060556	58.647222	America/Anchorage	0
1690	Eniseysk Airport	Eniseysk	Russian Federation	RU	EIE	UNII	92.116667	58.466667	Asia/Krasnoyarsk	0
1691	Einasleigh Airport	Einasleigh	Australia	AU	EIH	YEIN	144.1	-18.5	Australia/Brisbane	0
1692	Eielson Air Force Base	Fairbanks	United States	US	EIL	PAEI	-147.103194	64.667753	America/Anchorage	0
1693	Eindhoven Airport	Eindhoven	Netherlands	NL	EIN	EHEH	5.391795	51.457953	Europe/Amsterdam	0
1694	Terrance B. Lettsome International Airport	Beef Island	British Virgin Islands	VG	EIS	TUPJ	-64.537146	18.444401	America/Tortola	0
1695	Ein Yahav Airport	Ein Yahav	Israel	IL	EIY	LLEY	35.183333	30.633333	Asia/Jerusalem	0
1696	Variguies Airport	Barrancabermeja	Colombia	CO	EJA	SKEJ	-73.799167	7.015833	America/Bogota	0
1697	Wedjh Airport	Wedjh	Saudi Arabia	SA	EJH	OEWJ	36.474813	26.207716	Asia/Riyadh	0
1698	Murray Field	Eureka	United States	US	EKA	KEKA	-124.115	40.805	America/Los_Angeles	0
1699	Ekibastuz Airport	Ekibastuz	Kazakhstan	KZ	EKB	UASB	75.212221	51.595408	Asia/Almaty	0
1700	Elkedra Airport	Elkedra	Australia	AU	EKD	YELK	135.55	-21.15	Australia/Darwin	0
1701	Ekereku Airport	Ekereku	Guyana	GY	EKE	SYEK	-59.883333	5.916667	America/Guyana	0
1702	Elkhart Municipal Airport	Elkhart	United States	US	EKI	KEKM	-85.992222	41.722222	America/Indiana/Indianapolis	0
1703	Randolph County Airport	Elkins	United States	US	EKN	KEKN	-79.857778	38.889444	America/New_York	0
1704	Elko Airport	Elko	United States	US	EKO	KEKO	-115.789722	40.823889	America/Los_Angeles	0
1705	Eskilstuna Airport	Eskilstuna	Sweden	SE	EKT	ESSU	16.708401	59.351101	Europe/Stockholm	0
1706	Elizabethtown Regional Airport - Addington Field	Elizabethtown	United States	US	EKX	KEKX	-85.925014	37.686001	America/New_York	0
1707	Eagle Lake Airport	Eagle Lake	United States	US	ELA	KELA	-96.333333	29.583333	America/Chicago	0
1708	San Bernado Airport	El Banco	Colombia	CO	ELB	SKBC	-73.974167	9.048889	America/Bogota	0
1709	Elcho Island Airport	Elcho Island	Australia	AU	ELC	YELD	135.5698	-12.019817	Australia/Darwin	0
1710	South Arkansas Regional Airport	El Dorado	United States	US	ELD	KELD	-92.811188	33.217963	America/Chicago	0
1711	El Real Airport	El Real	Panama	PA	ELE	MPRE	-77.729696	8.109023	America/Panama	0
1712	El Fasher Airport	El Fasher	Sudan	SD	ELF	HSFS	25.316667	13.616667	Africa/Khartoum	0
1713	El Golea Airport	El Golea	Algeria	DZ	ELG	DAUE	2.864722	30.5675	Africa/Algiers	0
1714	North Eleuthera International Airport	North Eleuthera	Bahamas	BS	ELH	MYEH	-76.681926	25.476917	America/Nassau	0
1715	Elim Airport	Elim	United States	US	ELI	PFEL	-162.270278	64.613611	America/Anchorage	0
1716	Elk City Regional Business Airport	Elk City	United States	US	ELK	KELK	-99.394289	35.432404	America/Chicago	0
1717	Elmira Corning Regional Airport	Elmira	United States	US	ELM	KELM	-76.89586	42.163042	America/New_York	0
1718	Bowers Field	Ellensburg	United States	US	ELN	KELN	-120.531969	47.033774	America/Los_Angeles	0
1719	Eldorado Airport	Eldorado	Argentina	AR	ELO	SATD	-54.733333	-26.5	America/Argentina/Buenos_Aires	0
1720	El Paso International Airport	El Paso	United States	US	ELP	KELP	-106.396003	31.798949	America/Denver	0
1721	Prince Nayef bin Abdulaziz Regional Airport	Gassim	Saudi Arabia	SA	ELQ	OEGS	43.768178	26.305029	Asia/Riyadh	0
1722	Elelim, Irian Jaya Airport	Elelim, Irian Jaya	Indonesia	ID	ELR	WAVE	140.066667	-3.816667	Asia/Jayapura	0
1723	East London Airport	East London	South Africa	ZA	ELS	FAEL	27.82892	-33.038438	Africa/Johannesburg	0
1724	Tour Sinai City Airport	Tour Sinai City	Egypt	EG	ELT	HETR	33.633333	28.216667	Africa/Cairo	0
1725	Guemar Airport	El Oued	Algeria	DZ	ELU	DAUO	6.784614	33.509497	Africa/Algiers	0
1726	Elfin Cove Sea Plane Base	Elfin Cove	United States	US	ELV	PAEL	-136.3475	58.195278	America/Anchorage	0
1727	Yelland Field	Ely	United States	US	ELY	KELY	-114.841944	39.301944	America/Los_Angeles	0
1728	Wellsville Municipal Airport	Wellsville	United States	US	ELZ	KELZ	-77.95	42.116667	America/New_York	0
1729	East Midlands Airport	Leicestershire	United Kingdom	GB	EMA	EGNX	-1.330595	52.825872	Europe/London	0
1730	Emerald Airport	Emerald	Australia	AU	EMD	YEML	148.174393	-23.568609	Australia/Brisbane	0
1731	Emden Airport	Emden	Germany	DE	EME	EDWE	7.227536	53.389291	Europe/Berlin	0
1732	Empangeni Airport	Empangeni	South Africa	ZA	EMG	FAEM	31.9	-28.75	Africa/Johannesburg	0
1733	Emmonak Airport	Emmonak	United States	US	EMK	PAEM	-164.490537	62.784856	America/Anchorage	0
1734	Emmen Airport	Emmen	Switzerland	CH	EML	LSME	8.304722	47.0925	Europe/Zurich	0
1735	Kemmerer Airport	Kemmerer	United States	US	EMM	KEMM	-110.55	41.783333	America/Denver	0
1736	Nema Airport	Nema	Mauritania	MR	EMN	GQNI	-7.283333	16.6	Africa/Nouakchott	0
1737	Emporia Airport	Emporia	United States	US	EMP	KEMP	-96.190833	38.3325	America/Chicago	0
1738	El Monte Airport	El Monte	United States	US	EMT	KEMT	-118.033333	34.083333	America/Los_Angeles	0
1739	El Maiten Airport	El Maiten	Argentina	AR	EMX	SAVD	-71.15	-42.033333	America/Argentina/Buenos_Aires	0
1740	Kenai Municipal Airport	Kenai	United States	US	ENA	PAEN	-151.246448	60.565207	America/Anchorage	0
1741	Eneabba Airport	Eneabba	Australia	AU	ENB	YEEB	114.983333	-30.083333	Australia/Perth	0
1742	Essey Airport	Nancy	France	FR	ENC	LFSN	6.231667	48.691667	Europe/Paris	0
1743	Vance Air Force Base	Enid	United States	US	END	KEND	-97.914614	36.340058	America/Chicago	0
1744	H. Hasan Aroeboesman Airport	Ende	Indonesia	ID	ENE	WATE	121.664653	-8.848239	Asia/Makassar	0
1745	Enontekio Airport	Enontekio	Finland	FI	ENF	EFET	23.421202	68.360381	Europe/Helsinki	0
1746	Enshi Airport	Enshi	China	CN	ENH	ZHES	109.482012	30.321934	Asia/Shanghai	0
1747	Jan Mayen Airport	Jan Mayen	Norway	NO	ZXB	ENJA	-8.651389	70.943889	Europe/Oslo	0
1748	Saint Angelo Airport	Enniskillen	United Kingdom	GB	ENK	EGAB	-7.633333	54.35	Europe/London	0
1749	Centralia Municipal Airport	Centralia	United States	US	ENL	KENL	-89.133333	38.516667	America/Chicago	0
1750	Nenana Municipal Airport	Nenana	United States	US	ENN	PANN	-149.116667	64.566667	America/Anchorage	0
1751	Teniente Amin Ayub Gonzalez Airport	Encarnacion	Paraguay	PY	ENO	SGEN	-55.834276	-27.221493	America/Asuncion	0
1752	Twente Airport	Enschede	Netherlands	NL	ENS	EHTW	6.878333	52.271667	Europe/Amsterdam	0
1753	Enewetak Island Airport	Enewetak Island	Marshall Islands	MH	ENT	PKMA	162.25	11.5	Pacific/Majuro	0
1754	Akanu Ibiam International Airport	Enugu	Nigeria	NG	ENU	DNEN	7.562007	6.474094	Africa/Lagos	0
1755	Wendover Airport	Wendover	United States	US	ENV	KENV	-114.033333	40.733333	America/Denver	0
1756	Kenosha Regional Airport	Kenosha	United States	US	ENW	KENW	-87.927803	42.595699	America/Chicago	0
1757	Nanniwan Airport	Yan'an	China	CN	ENY	ZLYA	109.463889	36.479722	Asia/Shanghai	0
1758	Enrique Olaya Herrera Airport	Medellin	Colombia	CO	EOH	SKMD	-75.586403	6.218666	America/Bogota	0
1759	Eday Airport	Eday	United Kingdom	GB	EOI	EGED	-2.772223	59.190596	Europe/London	0
1760	Keokuk Airport	Keokuk	United States	US	EOK	KEOK	-91.43	40.458333	America/Chicago	0
1761	El Dorado Airporr	El Dorado	Venezuela	VE	EOR	SVED	-61.883333	6.733333	America/Caracas	0
1762	Neosho Airport	Neosho	United States	US	EOS	KEOS	-94.366667	36.866667	America/Chicago	0
1763	Elorza Airport	Elorza	Venezuela	VE	EOZ	SVEZ	-69.533333	7.166667	America/Caracas	0
1764	El Palomar Airport	El Palomar	Argentina	AR	EPA	SADP	-58.6125	-34.608333	America/Argentina/Buenos_Aires	0
1765	Browns Airport	Weeping Water	United States	US	EPG	KEPG	-96.133333	40.866667	America/Chicago	0
1766	Ephrata Airport	Ephrata	United States	US	EPH	KEPH	-119.5125	47.304167	America/Los_Angeles	0
1767	Opole Airport	Opole	Poland	PL	QPM	EPKN	18.085175	50.529108	Europe/Warsaw	0
1768	Mirecourt Airport	Epinal	France	FR	EPL	LFSG	6.069444	48.325833	Europe/Paris	0
1769	Warsaw-Modlin Airport	Modlin	Poland	PL	WMI	EPMO	20.651667	52.451111	Europe/Warsaw	0
1770	Esperance Airport	Esperance	Australia	AU	EPR	YESP	121.830389	-33.682479	Australia/Perth	0
1771	Parnu Airport	Parnu	Estonia	EE	EPU	EEPU	24.472778	58.418889	Europe/Tallinn	0
1772	Esquel Airport	Esquel	Argentina	AR	EQS	SAVE	-71.1425	-42.909722	America/Argentina/Buenos_Aires	0
1773	Erigavo Airport	Erigavo	Somalia	SO	ERA	HCMU	47.4	10.616667	Africa/Mogadishu	0
1774	Ernabella Airport	Ernabella	Australia	AU	ERB	YERN	132.116667	-26.283333	Australia/Adelaide	0
1775	Erzincan Airport	Erzincan	Turkiye	TR	ERC	LTCD	39.516944	39.711667	Europe/Istanbul	0
1776	Erfurt Airport	Erfurt	Germany	DE	ERF	EDDE	10.961163	50.974914	Europe/Berlin	0
1777	Erbogachen Airport	Erbogachen	Russian Federation	RU	ERG	UIKE	108.03	61.275	Asia/Irkutsk	0
1778	Moulay Ali Cherif Airport	Errachidia	Morocco	MA	ERH	GMFK	-4.400324	31.946956	Africa/Casablanca	0
1779	Erie International Airport	Erie	United States	US	ERI	KERI	-80.18203	42.083142	America/New_York	0
1780	Comandante Kraemer Airport	Erechim	Brazil	BR	ERM	SSER	-52.275556	-27.641667	America/Sao_Paulo	0
1781	Eirunepe Airport	Eirunepe	Brazil	BR	ERN	SWEI	-69.879657	-6.639462	America/Eirunepe	0
1782	Elrose Mine Airport	Elrose Mine	Australia	AU	ERQ	YESE	141.0086	-20.976667	Australia/Brisbane	0
1783	Errol Airport	Errol	United States	US	ERR	KERR	-71.133333	44.783333	America/New_York	0
1784	Eros Airport	Windhoek	Namibia	NA	ERS	FYWE	17.083333	-22.616667	Africa/Windhoek	0
1785	Kerrville Airport	Kerrville	United States	US	ERV	KERV	-99.133333	30.05	America/Chicago	0
1786	Erzurum Airport	Erzurum	Turkiye	TR	ERZ	LTCE	41.179378	39.961346	Europe/Istanbul	0
1787	Ankara Esenboga Airport	Ankara	Turkiye	TR	ESB	LTAC	32.993145	40.114941	Europe/Istanbul	0
1788	Delta County Airport	Escanaba	United States	US	ESC	KESC	-87.086667	45.720556	America/New_York	0
1789	Orcas Island Airport	Eastsound	United States	US	ESD	KORS	-122.9125	48.708333	America/Los_Angeles	0
1790	Ensenada Airport	Ensenada	Mexico	MX	ESE	MMES	-116.602997	31.7953	America/Tijuana	0
1791	Esler Field	Alexandria	United States	US	ESF	KESF	-92.296944	31.395	America/Chicago	0
1792	Mariscal Estigarribia Airport	Mariscal Estigarribia	Paraguay	PY	ESG	SGME	-60.616667	-22.033333	America/Asuncion	0
1793	Shoreham Airport	Shoreham By Sea	United Kingdom	GB	ESH	EGKA	-0.3	50.833333	Europe/London	0
1794	Satenas Air Base	Satenas	Sweden	SE	FUP	ESIB	12.696428	58.43803	Europe/Stockholm	0
1795	Eskisehir Airport	Eskisehir	Turkiye	TR	ESK	LTBI	30.582111	39.784138	Europe/Istanbul	0
1796	Scandinavian Mountains Airport	Salen	Sweden	SE	SCR	ESKS	12.84	61.159	Europe/Stockholm	0
1797	Elista Airport	Elista	Russian Federation	RU	ESL	URWI	44.332967	46.370593	Europe/Moscow	0
1798	Esmeraldas Airport	Esmeraldas	Ecuador	EC	ESM	SETN	-79.625	0.966667	America/Guayaquil	0
1799	Newnam Field	Easton	United States	US	ESN	KESN	-76.067778	38.802778	America/New_York	0
1800	El Salvador Airport	El Salvador	Chile	CL	ESR	SCES	-69.765278	-26.315278	America/Santiago	0
1801	Essen Airport	Essen	Germany	DE	ESS	EDLE	6.941667	51.403889	Europe/Berlin	0
1802	Estherville Municipal Airport	Estherville	United States	US	EST	KEST	-94.833333	43.4	America/Chicago	0
1803	Essaouira Airport	Essaouira	Morocco	MA	ESU	GMMI	-9.681667	31.3975	Africa/Casablanca	0
1804	Easton State Airport	Easton	United States	US	ESW	KESW	-121.185989	47.254211	America/Los_Angeles	0
1805	West Bend Municipal Airport	West Bend	United States	US	ETB	KETB	-88.183333	43.416667	America/Chicago	0
1806	Etadunna Airport	Etadunna	Australia	AU	ETD	YEDA	138	-27.5	Australia/Adelaide	0
1807	Genda Wuha Airport	Metema	Ethiopia	ET	ETE	HAMM	36.166667	12.933333	Africa/Addis_Ababa	0
1808	Eilat Airport	Elat	Israel	IL	ETH	LLET	34.957443	29.55625	Asia/Jerusalem	0
1809	Ramon International Airport	Eilat	Israel	IL	ETM	LLER	35.014167	29.727222	Asia/Jerusalem	0
1810	Eastland Municipal Airport	Eastland	United States	US	ETN	KETN	-98.833333	32.383333	America/Chicago	0
1811	Enterprise Municipal Airport	Enterprise	United States	US	ETS	KEDN	-85.85	31.316667	America/Chicago	0
1812	Ingolstadt Manching Airport	Ingolstadt	Germany	DE	IGS	ETSI	11.537143	48.722247	Europe/Berlin	0
1813	Metz-Nancy-Lorraine Airport	Metz/Nancy	France	FR	ETZ	LFJL	6.243003	48.981653	Europe/Paris	0
1814	Kaufana Airport	Eua	Tonga	TO	EUA	NFTE	-174.956989	-21.377013	Pacific/Tongatapu	0
1815	Eucla Airport	Eucla	Australia	AU	EUC	YECL	128.866667	-31.716667	Australia/Perth	0
1816	Weedon Field	Eufaula	United States	US	EUF	KEUF	-85.15	31.9	America/Chicago	0
1817	Mahlon Sweet Field	Eugene	United States	US	EUG	KEUG	-123.211974	44.124591	America/Los_Angeles	0
1818	Neumuenster Airport	Neumuenster	Germany	DE	EUM	EDHN	9.966667	54.066667	Europe/Berlin	0
1819	Hassan I Airport	Laayoune	Morocco	MA	EUN	GSAI	-13.216667	27.133333	Africa/Casablanca	0
1820	Evelio Javier  Airport	Antique	Philippines	PH	EUQ	RPVS	121.932971	10.767873	Asia/Manila	0
1821	F D Roosevelt Airport	Saint Eustatius	Caribbean Netherlands	BQ	EUX	TNCE	-62.977778	17.493056	America/Curacao	0
1822	Eva Downs Airport	Eva Downs	Australia	AU	EVD	YEVA	134.866667	-18.016667	Australia/Darwin	0
1823	Harstad/Narvik Airport, Evenes	Harstad-Narvik	Norway	NO	EVE	ENEV	16.683194	68.489956	Europe/Oslo	0
1824	Sveg Airport	Sveg	Sweden	SE	EVG	ESND	14.419593	62.047076	Europe/Stockholm	0
1825	Eveleth Airport	Eveleth	United States	US	EVM	KEVM	-92.495833	47.426389	America/Chicago	0
1826	Zvartnots International Airport	Yerevan	Armenia	AM	EVN	UDYZ	44.39805	40.15272	Asia/Yerevan	0
1827	Evansville Regional Airport	Evansville	United States	US	EVV	KEVV	-87.527965	38.046164	America/Chicago	0
1828	Evanston Airport	Evanston	United States	US	EVW	KEVW	-110.966667	41.266667	America/Denver	0
1829	Evreux Airport	Evreux	France	FR	EVX	LFOE	1.15	49.016667	Europe/Paris	0
1830	New Bedford Airport	New Bedford	United States	US	EWB	KEWB	-70.959167	41.676944	America/New_York	0
1831	Ewer Airport	Ewer	Indonesia	ID	EWE	WAKG	138.083333	-5.483333	Asia/Jayapura	0
1832	Enarotali Airport	Enarotali	Indonesia	ID	EWI	WAYE	136.333333	-3.966667	Asia/Jayapura	0
1833	Newton City-County Airport	Newton	United States	US	EWK	KEWK	-97.274498	38.058201	America/Chicago	0
1834	Coastal Carolina Regional Airport	New Bern	United States	US	EWN	KEWN	-77.034622	35.078344	America/New_York	0
1835	Ewo Airport	Ewo	Congo	CG	EWO	FCOE	14.8	-0.883333	Africa/Brazzaville	0
1836	Newark Liberty International Airport	Newark	United States	US	EWR	KEWR	-74.178753	40.689071	America/New_York	0
1837	Exmouth Gulf Airport	Exmouth Gulf	Australia	AU	EXM	YEXM	114.25	-22.25	Australia/Perth	0
1838	Exeter International Airport	Exeter	United Kingdom	GB	EXT	EGTE	-3.410968	50.731109	Europe/London	0
1839	Beloyarsky Airport	Beloyarsky	Russian Federation	RU	EYK	USHQ	66.701207	63.696682	Asia/Yekaterinburg	0
1840	Yelimane Airport	Yelimane	Mali	ML	EYL	GAYE	-10.566667	15.133333	Africa/Bamako	0
1841	El Yopal Airport	El Yopal	Colombia	CO	EYP	SKYP	-72.386282	5.320729	America/Bogota	0
1842	Elive Springs Airport	Elive Springs	Kenya	KE	EYS	HKES	35.966667	3.25	Africa/Nairobi	0
1843	Key West International Airport	Key West	United States	US	EYW	KEYW	-81.75501	24.553574	America/New_York	0
1844	Ministro Pistarini Airport	Buenos Aires	Argentina	AR	EZE	SAEZ	-58.539834	-34.81273	America/Argentina/Buenos_Aires	0
1845	Elazig Airport	Elazig	Turkiye	TR	EZS	LTCA	39.26829	38.599326	Europe/Istanbul	0
1846	Beryozovo Airport	Beryozovo	Russian Federation	RU	EZV	USHB	65.044853	63.924582	Asia/Yekaterinburg	0
1847	Faranah Airport	Faranah	Guinea	GN	FAA	GUFH	-10.75	10.033333	Africa/Conakry	0
1848	Farnborough Airport	Farnborough	United Kingdom	GB	FAB	EGLF	-0.770607	51.278754	Europe/London	0
1849	Faaite Airport	Faaite	French Polynesia	PF	FAC	NTKF	-145.332572	-16.687222	Pacific/Tahiti	0
1850	Vagar Airport	Faroe Islands	Faroe Islands	FO	FAE	EKVG	-7.266667	62.066667	Atlantic/Faroe	0
1851	Felker Army Air Field	Fort Eustis	United States	US	FAF	KFAF	-76.608832	37.132548	America/New_York	0
1852	Fagurholsmyri Airport	Fagurholsmyri	Iceland	IS	FAG	BIFM	-16.65	63.883333	Atlantic/Reykjavik	0
1853	Farah Airport	Farah	Afghanistan	AF	FAH	OAFR	62.163694	32.369019	Asia/Kabul	0
1854	Fairbanks International Airport	Fairbanks	United States	US	FAI	PAFA	-147.866805	64.818214	America/Anchorage	0
1855	Diego Jimenez Torres Airport	Fajardo	Puerto Rico	PR	FAJ	TJFA	-65.65819	18.31237	America/Puerto_Rico	0
1856	Farmington Regional Airport	Farmington	United States	US	FAM	KFAM	-90.421667	37.780833	America/Chicago	0
1857	Lista Airport	Farsund	Norway	NO	FAN	ENLI	6.625556	58.101667	Europe/Oslo	0
1858	Faro Airport	Faro	Portugal	PT	FAO	LPFR	-7.968545	37.020646	Europe/Lisbon	0
1859	Hector International Airport	Fargo	United States	US	FAR	KFAR	-96.825508	46.919529	America/Chicago	0
1860	Fresno Yosemite International Airport	Fresno	United States	US	FAT	KFAT	-119.720236	36.769624	America/Los_Angeles	0
1861	Fahud Airport	Fahud	Oman	OM	FAU	OOFD	56.489113	22.348871	Asia/Muscat	0
1862	Fakarava Airport	Fakarava	French Polynesia	PF	FAV	NTGF	-145.652245	-16.053485	Pacific/Tahiti	0
1863	Fayetteville Regional Airport	Fayetteville	United States	US	FAY	KFAY	-78.887221	34.99132	America/New_York	0
1864	Fasa Airport	Fasa	Iran	IR	FAZ	OISF	53.7	28.933333	Asia/Tehran	0
1865	Fonte Boa Airport	Fonte Boa	Brazil	BR	FBA	SWOB	-66.084539	-2.531212	America/Porto_Velho	0
1866	Faizabad Airport	Faizabad	Afghanistan	AF	FBD	OAFZ	70.518136	37.121236	Asia/Kabul	0
1867	Francisco Beltrao Airport	Francisco Beltrao	Brazil	BR	FBE	SSFB	-53.066667	-26.083333	America/Sao_Paulo	0
1868	Simmons Army Airfield	Fort Bragg	United States	US	FBG	KFBG	-78.936389	35.131944	America/New_York	0
1869	Fort Wainwright Airport	Fairbanks	United States	US	FBK	PAFB	-147.611924	64.83364	America/Anchorage	0
1870	Faribault Municipal Airport	Faribault	United States	US	FBL	KFBL	-93.266667	44.3	America/Chicago	0
1871	Lubumbashi International Airport	Lubumbashi	The Democratic Republic of The Congo	CD	FBM	FZQA	27.528487	-11.58971	Africa/Lubumbashi	0
1872	Fort Bridger Airport	Fort Bridger	United States	US	FBR	KFBR	-110.383333	41.316667	America/Denver	0
1873	Fairbury Municipal Airport	Fairbury	United States	US	FBY	KFBY	-97.183333	40.133333	America/Chicago	0
1874	Glacier Park International Airport	Kalispell	United States	US	FCA	KGPI	-114.253152	48.307304	America/Denver	0
1875	Ficksburg Sentra Oes Airport	Ficksburg	South Africa	ZA	FCB	FAFB	27.908333	-28.825	Africa/Johannesburg	0
1876	Fresno-Chandler Airport	Fresno	United States	US	FCH	KFCH	-119.783333	36.733333	America/Los_Angeles	0
1877	Flying Cloud Airport	Minneapolis	United States	US	FCM	KFCM	-93.456769	44.827096	America/Chicago	0
1878	Nordholz Airport	Cuxhaven	Germany	DE	FCN	ETMN	8.665585	53.768526	Europe/Berlin	0
1879	Rome Leonardo da Vinci Fiumicino Airport	Rome	Italy	IT	FCO	LIRF	12.250346	41.794594	Europe/Rome	0
1880	Butts Army Air Field	Colorado Springs	United States	US	FCS	KFCS	-104.816667	38.833333	America/Denver	0
1881	Firing Center Army Air Field	Yakima	United States	US	FCT	KFCT	-120.516667	46.6	America/Los_Angeles	0
1882	Forrest City Municipal Airport	Forrest City	United States	US	FCY	KFCY	-90.766667	34.95	America/Chicago	0
1883	Bringeland Airport	Forde	Norway	NO	FDE	ENBL	5.762073	61.39178	Europe/Oslo	0
1884	Martinique Aime Cesaire International Airport	Fort De France	Martinique	MQ	FDF	TFFF	-60.999948	14.596061	America/Martinique	0
1885	Friedrichshafen Airport	Friedrichshafen	Germany	DE	FDH	EDNY	9.523482	47.672775	Europe/Berlin	0
1886	Frederick Municipal Airport	Frederick	United States	US	FDK	KFDK	-77.416667	39.416667	America/New_York	0
1887	Frederick Municipal Airport	Frederick	United States	US	FDR	KFDR	-99.016667	34.383333	America/Chicago	0
1888	Bandundu Airport	Bandundu	The Democratic Republic of The Congo	CD	FDU	FZBO	17.383333	-3.305556	Africa/Kinshasa	0
1889	Findlay Airport	Findlay	United States	US	FDY	KFDY	-83.668701	41.0135	America/New_York	0
1890	Sanfebagar Airport	Sanfebagar	Nepal	NP	FEB	VNSR	81.216667	29.233333	Asia/Kathmandu	0
1891	Joao Durval Carneiro Airport	Feira De Santana	Brazil	BR	FEC	SNJD	-38.906111	-12.2025	America/Belem	0
1892	Fergana Airport	Fergana	Uzbekistan	UZ	FEG	UTTF	71.733611	40.350278	Asia/Tashkent	0
1893	Feijo Airport	Feijo	Brazil	BR	FEJ	SWFJ	-70.35	-8.15	America/Rio_Branco	0
1894	Ferkessedougou Airport	Ferkessedougou	Cote d'Ivoire	CI	FEK	DIFK	-5.2	9.6	Africa/Abidjan	0
1895	Fuerstenfeldbruck Airport	Fuerstenfeldbruck	Germany	DE	FEL	ETSF	11.266667	48.2	Europe/Berlin	0
1896	Fernando De Noronha Airport	Fernando De Noronha	Brazil	BR	FEN	SBFN	-32.416667	-3.85	America/Noronha	0
1897	Albertus Airport	Freeport	United States	US	FEP	KFEP	-89.6	42.283333	America/Chicago	0
1898	Fremont Municipal Airport	Fremont	United States	US	FET	KFET	-96.519759	41.449989	America/Chicago	0
1899	Fes-Saiss Airport	Fes	Morocco	MA	FEZ	GMFF	-4.982138	33.930791	Africa/Casablanca	0
1900	First Flight Airport	Kill Devil Hills	United States	US	FFA	KFFA	-75.666667	36.016667	America/New_York	0
1901	Fairford RAF Station	Fairford	United Kingdom	GB	FFD	EGVA	-1.790026	51.682198	Europe/London	0
1902	Fairfield Municipal Airport	Fairfield	United States	US	FFL	KFFL	-91.95	40.933333	America/Chicago	0
1903	Fergus Falls Municipal Airport	Fergus Falls	United States	US	FFM	KFFM	-96.151373	46.285618	America/Chicago	0
1904	Wright-Patterson Air Force Base	Dayton	United States	US	FFO	KFFO	-84.048289	39.826093	America/New_York	0
1905	Frankfort Capital City Airport	Frankfort	United States	US	FFT	KFFT	-84.905	38.182222	America/New_York	0
1906	Futaleufu Airport	Futaleufu	Chile	CL	FFU	SCFT	-71.816667	-43.2	America/Santiago	0
1907	Fderik Airport	Fderik	Mauritania	MR	FGD	GQPF	-12.731944	22.675	Africa/Nouakchott	0
1908	Fagali I Airport	Apia	Samoa	WS	FGI	NSAP	-171.739422	-13.849282	Pacific/Apia	0
1909	Fox Glacier Heliport	Fox Glacier	New Zealand	NZ	FGL	NZFH	169.999968	-43.46314	Pacific/Auckland	0
1910	Fangatau Airport	Fangatau, Tuamoto Island	French Polynesia	PF	FGU	NTGB	-141.833333	-16.05	Pacific/Tahiti	0
1911	Sierra Vista Municipal Airport	Sierra Vista	United States	US	FHU	KFHU	-110.343056	31.588889	America/Phoenix	0
1912	Fakahina Airport	Fakahina	French Polynesia	PF	FHZ	NTKH	-140.164452	-15.99095	Pacific/Tahiti	0
1913	Fair Isle Airport	Fair Isle	United Kingdom	GB	FIE	EGEF	-1.62911	59.534301	Europe/London	0
1914	Katourou Airport	Fria	Guinea	GN	FIG	GUFA	-13.569165	10.350565	Africa/Conakry	0
1915	N'djili Airport	Kinshasa	The Democratic Republic of The Congo	CD	FIH	FZAA	15.442285	-4.387155	Africa/Kinshasa	0
1916	Finke Airport	Finke	Australia	AU	FIK	YFNE	134.583333	-25.566667	Australia/Darwin	0
1917	Fitzroy Crossing Airport	Fitzroy Crossing	Australia	AU	FIZ	YFTZ	125.560794	-18.181014	Australia/Perth	0
1918	Fujairah International Airport	Al-Fujairah	United Arab Emirates	AE	FJR	OMFJ	56.330556	25.109444	Asia/Dubai	0
1919	Baden-Airpark	Karlsruhe/Baden-Baden	Germany	DE	FKB	EDSB	8.089752	48.781031	Europe/Berlin	0
1920	Bangoka International Airport	Kisangani	The Democratic Republic of The Congo	CD	FKI	FZIC	25.338056	0.481667	Africa/Lubumbashi	0
1921	Fukui Airport	Fukui	Japan	JP	FKJ	RJNF	136.226667	36.139722	Asia/Tokyo	0
1922	Venango Regional Airport	Franklin	United States	US	FKL	KFKL	-79.859722	41.379167	America/New_York	0
1923	Franklin Municipal Airport	Franklin	United States	US	FKN	KFKN	-76.933333	36.683333	America/New_York	0
1924	Fak Fak Airport	Fak Fak	Indonesia	ID	FKQ	WASF	132.3	-2.916667	Asia/Jayapura	0
1925	Fukushima Airport	Fukushima	Japan	JP	FKS	RJSF	140.432778	37.226667	Asia/Tokyo	0
1926	Capitolio Airport	Florencia	Colombia	CO	FLA	SKFL	-75.558889	1.588889	America/Bogota	0
1927	Cangapara Airport	Floriano	Brazil	BR	FLB	SNQG	-43.033333	-6.8	America/Belem	0
1928	Falls Creek Airport	Falls Creek	Australia	AU	FLC	YFLK	143.283333	-36.833333	Australia/Sydney	0
1929	Fond Du Lac County Airport	Fond Du Lac	United States	US	FLD	KFLD	-88.488403	43.771198	America/Chicago	0
1930	Schaferhaus Airport	Flensburg	Germany	DE	FLF	EDXF	9.383333	54.772222	Europe/Berlin	0
1931	Flagstaff Pulliam Airport	Flagstaff	United States	US	FLG	KFLG	-111.671667	35.137778	America/Phoenix	0
1932	Fort Lauderdale-Hollywood International Airport	Fort Lauderdale	United States	US	FLL	KFLL	-80.144908	26.071492	America/New_York	0
1933	Hercilio Luz International Airport	Florianopolis	Brazil	BR	FLN	SBFL	-48.5452	-27.664445	America/Sao_Paulo	0
1934	Florence Airport	Florence	United States	US	FLO	KFLO	-79.724444	34.188889	America/New_York	0
1935	Flippin Airport	Flippin	United States	US	FLP	KFLP	-92.583333	36.3	America/Chicago	0
1936	Firenze-Peretola Airport	Florence	Italy	IT	FLR	LIRQ	11.201989	43.802126	Europe/Rome	0
1937	Flinders Island Airport	Flinders Island	Australia	AU	FLS	YFLI	147.993001	-40.0917	Australia/Hobart	0
1938	Sherman Army Air Field	Fort Leavenworth	United States	US	FLV	KFLV	-94.914695	39.368307	America/Chicago	0
1939	Santa Cruz Airport	Flores Island (Azores)	Portugal	PT	FLW	LPFL	-31.15	39.466667	Atlantic/Azores	0
1940	Fallon Municipal Airport	Fallon	United States	US	FLX	KFLX	-118.746038	39.500678	America/Los_Angeles	0
1941	Finley Airport	Finley	Australia	AU	FLY	YFIL	145.583333	-35.65	Australia/Sydney	0
1942	Ferdinand Lumban Tobing Airport	Sibolga	Indonesia	ID	FLZ	WIMS	98.888889	1.555833	Asia/Jakarta	0
1943	El Pucu Airport	Formosa	Argentina	AR	FMA	SARF	-58.235	-26.212778	America/Argentina/Buenos_Aires	0
1944	Otis Air Force Base	Falmouth	United States	US	FMH	KFMH	-70.55	41.666667	America/New_York	0
1945	Kalemie Airport	Kalemie	The Democratic Republic of The Congo	CD	FMI	FZRF	29.25	-5.875556	Africa/Lubumbashi	0
1946	Memmingen Allgau Airport	Memmingen	Germany	DE	FMM	EDJA	10.239444	47.988611	Europe/Berlin	0
1947	Four Corners Regional Airport	Farmington	United States	US	FMN	KFMN	-108.229167	36.741111	America/Denver	0
1948	Munster Osnabruck International Airport	Muenster	Germany	DE	FMO	EDDG	7.694928	52.130053	Europe/Berlin	0
1949	Fort Madison Municipal Airport	Fort Madison	United States	US	FMS	KFSW	-91.3275	40.658889	America/Chicago	0
1950	Page Field	Fort Myers	United States	US	FMY	KFMY	-81.860809	26.587888	America/New_York	0
1951	Lungi International Airport	Freetown	Sierra Leone	SL	FNA	GFLL	-13.199209	8.616062	Africa/Freetown	0
1952	Neubrandenburg Airport	Neubrandenburg	Germany	DE	FNB	EDBN	13.307222	53.602778	Europe/Berlin	0
1953	Madeira Airport	Funchal	Portugal	PT	FNC	LPMA	-16.775635	32.693121	Europe/Lisbon	0
1954	Fada Ngourma Airport	Fada Ngourma	Burkina Faso	BF	FNG	DFEF	0.35	12.066667	Africa/Ouagadougou	0
1955	Fincha Airport	Fincha	Ethiopia	ET	FNH	HAFN	37.433333	9.583333	Africa/Addis_Ababa	0
1956	Garons Airport	Nimes	France	FR	FNI	LFTW	4.416667	43.75	Europe/Paris	0
2015	Fukue Airport	Fukue	Japan	JP	FUJ	RJFE	128.837611	32.667826	Asia/Tokyo	0
1957	Pyongyang Sunan International Airport	Pyongyang	Democratic People's Republic of Korea	KP	FNJ	ZKPY	125.675368	39.200649	Asia/Pyongyang	0
1958	Fort Collins/Loveland Municipal Airport	Fort Collins/Loveland	United States	US	FNL	KFNL	-105.008459	40.448322	America/Denver	0
1959	Funter Bay Sea Plane Base	Funter Bay	United States	US	FNR	PANR	-134.896464	58.255284	America/Anchorage	0
1960	Bishop International Airport	Flint	United States	US	FNT	KFNT	-83.738904	42.973812	America/New_York	0
1961	Fuzhou Changle International Airport	Fuzhou	China	CN	FOC	ZSFZ	119.66923	25.931231	Asia/Shanghai	0
1962	Fort Dodge Airport	Fort Dodge	United States	US	FOD	KFOD	-94.189722	42.5525	America/Chicago	0
1963	Forbes Field	Topeka	United States	US	FOE	KFOE	-95.6625	38.9525	America/Chicago	0
1964	Gino Lisa Airport	Foggia	Italy	IT	FOG	LIBF	15.544367	41.433991	Europe/Rome	0
1965	Francis S. Gabreski Airport	Westhampton Beach	United States	US	FOK	KFOK	-72.631994	40.841888	America/New_York	0
1966	Foumban Airport	Foumban	Cameroon	CM	FOM	FKKM	10.833333	5.75	Africa/Douala	0
1967	Arenal Airport	Fortuna	Costa Rica	CR	FON	MRAN	-84.57882	10.469482	America/Costa_Rica	0
1968	Kornasoren Airfield	Noemfoor	Indonesia	ID	FOO	WABF	134.865261	-0.936162	Asia/Jayapura	0
1969	Pinto Martins Airport	Fortaleza	Brazil	BR	FOR	SBFZ	-38.540835	-3.779073	America/Belem	0
1970	Forrest Airport	Forrest	Australia	AU	FOS	YFRT	128.05	-30.816667	Australia/Perth	0
1971	Fougamou Airport	Fougamou	Gabon	GA	FOU	FOGF	10.783333	-1.2	Africa/Libreville	0
1972	Grand Bahama International Airport	Freeport	Bahamas	BS	FPO	MYGF	-78.705197	26.547292	America/Nassau	0
1973	Saint Lucie County Airport	Fort Pierce	United States	US	FPR	KFPR	-80.368301	27.4951	America/New_York	0
1974	Frankfurt Airport	Frankfurt	Germany	DE	FRA	EDDF	8.573678	50.048952	Europe/Berlin	0
1975	Forbes Airport	Forbes	Australia	AU	FRB	YFBS	148.05	-33.4	Australia/Sydney	0
1976	Franca Airport	Franca	Brazil	BR	FRC	SBFC	-47.4375	-20.551944	America/Sao_Paulo	0
1977	Friday Harbor Airport	Friday Harbor	United States	US	FRD	KFHR	-123.026499	48.524807	America/Los_Angeles	0
1978	Fera Island Airport	Fera Island	Solomon Islands	SB	FRE	AGGF	159.583333	-8.1	Pacific/Guadalcanal	0
1979	Long Island Republic Airport	Farmingdale	United States	US	FRG	KFRG	-73.413399	40.728802	America/New_York	0
1980	French Lick Municipal Airport	French Lick	United States	US	FRH	KFRH	-86.616667	38.55	America/Indiana/Indianapolis	0
1981	Marshall Army Air Field	Fort Riley	United States	US	FRI	KFRI	-96.764195	39.053192	America/Chicago	0
1982	Fregate Island Airport	Fregate Island	Seychelles	SC	FRK	FSSF	55.9467	-4.5847	Indian/Mahe	0
1983	Luigi Ridolfi Airport	Forli	Italy	IT	FRL	LIPK	12.07076	44.19857	Europe/Rome	0
1984	Fairmont Airport	Fairmont	United States	US	FRM	KFRM	-94.423611	43.647222	America/Chicago	0
1985	Bryant Army Air Field	Fort Richardson	United States	US	FRN	PAFR	-149.649116	61.270108	America/Anchorage	0
1986	Flora Airport	Floro	Norway	NO	FRO	ENFL	5.023999	61.585302	Europe/Oslo	0
1987	Front Royal-Warren County Airport	Front Royal	United States	US	FRR	KFRR	-78.2541	38.918174	America/New_York	0
1988	Santa Elena Airport	Flores	Guatemala	GT	FRS	MGMM	-89.883333	16.916667	America/Guatemala	0
1989	Frutillar Airport	Frutillar	Chile	CL	FRT	SCFR	-73.065278	-41.125	America/Santiago	0
1990	Manas International Airport	Bishkek	Kyrgyzstan	KG	FRU	UCFM	74.469449	43.053581	Asia/Bishkek	0
1991	Francistown Airport	Francistown	Botswana	BW	FRW	FBFT	27.4825	-21.16	Africa/Gaborone	0
1992	Eastern Slopes Regional Airport	Fryeburg	United States	US	FRY	KIZG	-70.941378	43.992982	America/New_York	0
1993	Fritzlar Air Base	Fritzlar	Germany	DE	FRZ	ETHF	9.286667	51.114276	Europe/Berlin	0
1994	Sud Corse Airport	Figari	France	FR	FSC	LFKF	9.098223	41.498633	Europe/Paris	0
1995	Joe Foss Field	Sioux Falls	United States	US	FSD	KFSD	-96.741849	43.58201	America/Chicago	0
1996	Post Aaf	Ft Sill	United States	US	FSI	KFSI	-98.419972	34.650722	America/Chicago	0
1997	Fort Scott Municipal Airport	Fort Scott	United States	US	FSK	KFSK	-94.7	37.833333	America/Chicago	0
1998	Fossil Downs Airport	Fossil Downs	Australia	AU	FSL	YFOS	125.8	-18.2	Australia/Perth	0
1999	Fort Smith Regional Airport	Fort Smith	United States	US	FSM	KFSM	-94.3589	35.34124	America/Chicago	0
2000	Saint Pierre Airport	Saint Pierre	St. Pierre and Miquelon	PM	FSP	LFVP	-56.1742	46.7631	America/Miquelon	0
2001	Kinloss Airport	Forres	United Kingdom	GB	FSS	EGQK	-3.566667	57.65	Europe/London	0
2002	Pecos County Airport	Fort Stockton	United States	US	FST	KFST	-102.878889	30.893889	America/Chicago	0
2003	Fort Sumner Airport	Fort Sumner	United States	US	FSU	KFSU	-104.25	34.466667	America/Denver	0
2004	Shizuoka Airport	Shizuoka	Japan	JP	FSZ	RJNS	138.189444	34.796111	Asia/Tokyo	0
2005	Futuna Airport	Futuna Island	Vanuatu	VU	FTA	NVVF	170.25	-19.416667	Pacific/Efate	0
2006	El Calafate Airport	El Calafate	Argentina	AR	FTE	SAWC	-72.053695	-50.284227	America/Argentina/Buenos_Aires	0
2007	Fitiuta Airport	Fitiuta	American Samoa	AS	FTI	NSFQ	-169.425963	-14.214877	Pacific/Pago_Pago	0
2008	Godman Army Air Field	Fort Knox	United States	US	FTK	KFTK	-85.949045	37.927708	America/Chicago	0
2009	Marillac Airport	Fort Dauphin	Madagascar	MG	FTU	FMSD	46.955556	-25.038056	Indian/Antananarivo	0
2010	Fort Worth Meacham International Airport	Fort Worth	United States	US	FTW	KFTW	-97.356687	32.816769	America/Chicago	0
2011	Owando Airport	Owando	Congo	CG	FTX	FCOO	16.008333	-0.983333	Africa/Brazzaville	0
2012	Fulton County Airport	Atlanta	United States	US	FTY	KFTY	-84.521143	33.777196	America/New_York	0
2013	Fuerteventura Airport	Puerto del Rosario	Spain and Canary Islands	ES	FUE	GCFV	-13.869893	28.450605	Atlantic/Canary	0
2014	Fuyang Airport	Fuyang	China	CN	FUG	ZSFY	115.7	32.866667	Asia/Shanghai	0
2016	Fukuoka Airport	Fukuoka	Japan	JP	FUK	RJFF	130.443891	33.584286	Asia/Tokyo	0
2017	Fullerton Municipal Airport	Fullerton	United States	US	FUL	KFUL	-117.974253	33.872626	America/Los_Angeles	0
2018	Funafuti Atol International Airport	Funafuti Atol	Tuvalu	TV	FUN	NGFU	179.208333	-8.516667	Pacific/Funafuti	0
2019	Fuoshan Airport	Fuoshan	China	CN	FUO	ZGFS	113.071443	23.081156	Asia/Shanghai	0
2020	Futuna Island Airport	Futuna Island	Wallis and Futuna Islands	WF	FUT	NLWF	-178.15	-14.25	Pacific/Wallis	0
2021	Flora Valley Airport	Flora Valley	Australia	AU	FVL	YFLO	128.416667	-18.283333	Australia/Perth	0
2022	Fuvahmulaku Island Airport	Fuvahmulah Island	Maldives	MV	FVM	VRMR	73.43278	-0.309444	Indian/Maldives	0
2023	Forrest River Airport	Forrest River	Australia	AU	FVR	YFRV	127.833333	-15.253056	Australia/Perth	0
2024	Fort Wayne International Airport	Fort Wayne	United States	US	FWA	KFWA	-85.187715	40.98666	America/Indiana/Indianapolis	0
2025	Fort Worth Naval Air Station Joint Reserve Base	Fort Worth	United States	US	FWH	KNFW	-97.427781	32.771494	America/Chicago	0
2026	Farewell Airport	Farewell	United States	US	FWL	PAFW	-153.889444	62.509722	America/Anchorage	0
2027	Fort Lauderdale Executive Airport	Fort Lauderdale	United States	US	FXE	KFXE	-80.171517	26.19659	America/New_York	0
2028	Cuamba Airport	Cuamba	Mozambique	MZ	FXO	FQCB	36.526944	-14.805278	Africa/Maputo	0
2029	Forest City Municipal Airport	Forest City	United States	US	FXY	KFXY	-93.65	43.266667	America/Chicago	0
2030	Fayetteville Municipal Airport	Fayetteville	United States	US	FYM	KFYM	-86.566667	35.15	America/Chicago	0
2031	Fuyun Koktokay Airport	Fuyun	China	CN	FYN	ZWFY	89.538333	46.801111	Asia/Shanghai	0
2032	Faya Airport	Faya	Chad	TD	FYT	FTTY	19.116667	17.916667	Africa/Ndjamena	0
2033	Fort Yukon Airport	Fort Yukon	United States	US	FYU	PFYU	-145.258136	66.567918	America/Anchorage	0
2034	Drake Field	Fayetteville	United States	US	FYV	KFYV	-94.17	36.003611	America/Chicago	0
2035	Filton Airport	Filton	United Kingdom	GB	FZO	EGTG	-2.583333	51.516667	Europe/London	0
2036	Gabbs Airport	Gabbs	United States	US	GAB	KGAB	-117.916667	38.866667	America/Los_Angeles	0
2037	Gadsden Municipal Airport	Gadsden	United States	US	GAD	KGAD	-86.087222	33.973611	America/Chicago	0
2038	Gabes - Matmata Airport	Gabes	Tunisia	TN	GAE	DTTG	9.919377	33.735691	Africa/Tunis	0
2039	Gafsa Airport	Gafsa	Tunisia	TN	GAF	DTTF	8.816667	34.416667	Africa/Tunis	0
2040	Gage Airport	Gage	United States	US	GAG	KGAG	-99.883333	36.35	America/Chicago	0
2041	Gayndah Airport	Gayndah	Australia	AU	GAH	YGAY	151.483333	-25.433333	Australia/Brisbane	0
2042	Montgomery County Airpark	Gaithersburg	United States	US	GAI	KGAI	-77.166	39.168301	America/New_York	0
2043	Yamagata Airport	Yamagata	Japan	JP	GAJ	RJSC	140.371111	38.411944	Asia/Tokyo	0
2044	Edward G. Pitka Sr. Airport	Galena	United States	US	GAL	PAGA	-156.936112	64.73609	America/Anchorage	0
2045	Gambell Airport	Gambell	United States	US	GAM	PAGM	-171.713546	63.776596	America/Anchorage	0
2046	Gan/Seenu Airport	Gan Island	Maldives	MV	GAN	VRMG	73.156538	-0.690003	Indian/Maldives	0
2047	Mariana Grajales Airport	Guantanamo	Cuba	CU	GAO	MUGT	-75.158611	20.084722	America/Havana	0
2048	Gao Airport	Gao	Mali	ML	GAQ	GAGO	-0.001389	16.248611	Africa/Bamako	0
2049	Garissa Airport	Garissa	Kenya	KE	GAS	HKGA	39.648285	-0.46351	Africa/Nairobi	0
2050	Tallard Airport	Gap	France	FR	GAT	LFNA	6.03778	44.455002	Europe/Paris	0
2051	Lokpriya Gopinath Bordoloi International Airport	Guwahati	India	IN	GAU	VEGT	91.588427	26.105185	Asia/Kolkata	0
2052	Gangaw Airport	Gangaw	Myanmar	MM	GAW	VYGG	94.133333	22.166667	Asia/Yangon	0
2053	Gaya Airport	Gaya	India	IN	GAY	VEGY	84.945833	24.746667	Asia/Kolkata	0
2054	Gabala International Airport	Gabala	Azerbaijan	AZ	GBB	UBBQ	47.719046	40.821159	Asia/Baku	0
2055	Great Bend Airport	Great Bend	United States	US	GBD	KGBD	-98.864167	38.347222	America/Chicago	0
2056	Sir Seretse Khama International Airport	Gaborone	Botswana	BW	GBE	FBSK	25.924509	-24.557982	Africa/Gaborone	0
2057	Galesburg Airport	Galesburg	United States	US	GBG	KGBG	-90.428889	40.938611	America/Chicago	0
2058	Galbraith Lake Airport	Galbraith Lake	United States	US	GBH	PAGB	-149.483333	68.466667	America/Anchorage	0
2059	Les Bases Airport	Marie Galante	Guadeloupe	GP	GBJ	TFFM	-61.272155	15.869166	America/Guadeloupe	0
2060	Gbangbatok Airport	Gbangbatok	Sierra Leone	SL	GBK	GFGK	-12.366667	7.8	Africa/Freetown	0
2061	Gamboola Airport	Gamboola	Australia	AU	GBP	YGAM	143.666667	-16.55	Australia/Brisbane	0
2062	Great Barrington Airport	Great Barrington	United States	US	GBR	KGBR	-73.366667	42.2	America/New_York	0
2063	Gorgon Airport	Gorgon	Iran	IR	GBT	OING	54.410516	36.908509	Asia/Tehran	0
2064	Gibb River Airport	Gibb River	Australia	AU	GBV	YGIB	126.633333	-15.65	Australia/Perth	0
2065	Ginbata Airport	Ginbatta	Australia	AU	GBW	YGIA	120.036254	-22.5816	Australia/Perth	0
2066	Great Barrier Aerodrome	Great Barrier Island	New Zealand	NZ	GBZ	NZGB	175.468799	-36.240003	Pacific/Auckland	0
2067	Guacamaya Airport	Guacamaya	Colombia	CO	GCA	SKYV	-75.5	2.316667	America/Bogota	0
2068	Campbell County Airport	Gillette	United States	US	GCC	KGCC	-105.532684	44.346356	America/Denver	0
2069	Gachsaran Airport	Gachsaran	Iran	IR	GCH	OIAH	50.831656	30.3364	Asia/Tehran	0
2070	Guernsey Airport	Guernsey	United Kingdom	GB	GCI	EGJB	-2.595044	49.432756	Europe/London	0
2071	Johannesburg-Grand Central Airport	Johannesburg	South Africa	ZA	GCJ	FAGC	28.143794	-25.987298	Africa/Johannesburg	0
2072	Garden City Municipal Airport	Garden City	United States	US	GCK	KGCK	-100.729722	37.928611	America/Chicago	0
2073	Owen Roberts International Airport	Grand Cayman Island	Cayman Islands	KY	GCM	MWCR	-81.357786	19.296369	America/Cayman	0
2074	Grand Canyon National Park Airport	Grand Canyon	United States	US	GCN	KGCN	-112.1475	35.951944	America/Phoenix	0
2075	Greene County Municipal Airport	Greeneville	United States	US	GCY	KGCY	-82.815047	36.192986	America/Chicago	0
2076	Donaldson Field	Greenville	United States	US	GDC	KGYH	-82.376428	34.758311	America/New_York	0
2077	Gordon Downs Airport	Gordon Downs	Australia	AU	GDD	YGDN	128.55	-18.716667	Australia/Perth	0
2078	Gode/Iddidole Airport	Gode/Iddidole	Ethiopia	ET	GDE	HAGO	43.628333	5.902222	Africa/Addis_Ababa	0
2079	Gordil Airport	Gordil	Central African Republic	CF	GDI	FEGL	21.583333	9.733333	Africa/Bangui	0
2080	Gandajika Airport	Gandajika	The Democratic Republic of The Congo	CD	GDJ	FZWC	23.966667	-6.766667	Africa/Kinshasa	0
2081	Miguel Hidalgo y Costilla Guadalajara Intl Airport	Guadalajara	Mexico	MX	GDL	MMGL	-103.311163	20.52181	America/Mexico_City	0
2082	Gardner Municipal Airport	Gardner	United States	US	GDM	KGDM	-71.983333	42.566667	America/New_York	0
2083	Gdansk Lech Walesa Airport	Gdansk	Poland	PL	GDN	EPGD	18.468654	54.380979	Europe/Warsaw	0
2084	Vare Maria Airport	Guasdualito	Venezuela	VE	GDO	SVGD	-70.8	7.233333	America/Caracas	0
2085	Guadalupe Airport	Guadalupe	Brazil	BR	GDP	SNGD	-43.581667	-6.781944	America/Belem	0
2086	Gondar Airport	Gondar	Ethiopia	ET	GDQ	HAGN	37.445556	12.514444	Africa/Addis_Ababa	0
2087	JAGS McCartney International Airport	Grand Turk Island	Turks and Caicos Islands	TC	GDT	MBGT	-71.143583	21.444914	America/Grand_Turk	0
2088	Dawson Community Airport	Glendive	United States	US	GDV	KGDV	-104.806944	47.138889	America/Denver	0
2089	Gladwin Airport	Gladwin	United States	US	GDW	KGDW	-84.483333	43.983333	America/New_York	0
2090	Magadan Airport	Magadan	Russian Federation	RU	GDX	UHMM	150.716667	59.916667	Asia/Magadan	0
2091	Noumea Magenta Airport	Noumea	New Caledonia	NC	GEA	NWWM	166.470783	-22.260536	Pacific/Noumea	0
2092	Gebe Airport	Gebe	Indonesia	ID	GEB	WAEJ	129.416667	0.083333	Asia/Jayapura	0
2093	Sussex County Airport	Georgetown	United States	US	GED	KGED	-75.3575	38.688333	America/New_York	0
2094	George Town Airport	George Town	Australia	AU	GEE	YGTO	143.55	-18.283333	Australia/Hobart	0
2095	Geva Airstrip	Geva	Solomon Islands	SB	GEF	AGEV	156.597778	-7.578333	Pacific/Guadalcanal	0
2096	Spokane International Airport	Spokane	United States	US	GEG	KGEG	-117.537638	47.625147	America/Los_Angeles	0
2097	Sepe Tiaraju Airport	Santo Angelo	Brazil	BR	GEL	SBNM	-54.168056	-28.281111	America/Sao_Paulo	0
2098	Cheddi Jagan International Airport	Georgetown	Guyana	GY	GEO	SYCJ	-58.253078	6.503833	America/Guyana	0
2099	Rafael Cabrera Airport	Nueva Gerona	Cuba	CU	GER	MUNG	-82.78	21.8375	America/Havana	0
2100	General Santos International Airport	General Santos City	Philippines	PH	GES	RPMR	125.095833	6.057778	Asia/Manila	0
2101	Geraldton Airport	Geraldton	Australia	AU	GET	YGEL	114.70205	-28.796077	Australia/Perth	0
2102	Gallivare Airport	Gallivare	Sweden	SE	GEV	ESNG	20.816667	67.134444	Europe/Stockholm	0
2103	Geelong Airport	Geelong	Australia	AU	GEX	YSMB	144.35	-38.133333	Australia/Sydney	0
2104	South Big Horn County Airport	Greybull	United States	US	GEY	KGEY	-108.05	44.5	America/Denver	0
2105	Malmstrom Air Force Base	Great Falls	United States	US	GFA	KGFA	-111.283333	47.5	America/Denver	0
2106	Pope Field	Greenfield	United States	US	GFD	KGFD	-85.766667	39.783333	America/Indiana/Indianapolis	0
2107	Grenfell Airport	Grenfell	Australia	AU	GFE	YGNF	148.183333	-33.9	Australia/Sydney	0
2108	Griffith Airport	Griffith	Australia	AU	GFF	YGTH	146.062694	-34.255434	Australia/Sydney	0
2109	Grand Forks International Airport	Grand Forks	United States	US	GFK	KGFK	-97.177132	47.949786	America/Chicago	0
2110	Floyd Bennett Memorial Airport	Glens Falls	United States	US	GFL	KGFL	-73.608812	43.341388	America/New_York	0
2111	Grafton Airport	Grafton	Australia	AU	GFN	YGFN	153.028334	-29.759522	Australia/Sydney	0
2112	Bartica Airport	Bartica	Guyana	GY	GFO	SYBT	-58.583333	6.416667	America/Guyana	0
2113	Granville Airport	Granville	France	FR	GFR	LFRF	-1.566667	48.883333	Europe/Paris	0
2114	Grootfontein Airport	Grootfontein	Namibia	NA	GFY	FYGF	18.133333	-19.6	Africa/Windhoek	0
2115	Gregory Downs Airport	Gregory Downs	Australia	AU	GGD	YGDS	139.233333	-18.633333	Australia/Brisbane	0
2116	Georgetown Airport	Georgetown	United States	US	GGE	KGGE	-79.283333	33.383333	America/New_York	0
2117	Gregg County Airport	Longview	United States	US	GGG	KGGG	-94.715278	32.386667	America/Chicago	0
2118	Guilo Airport	Guilo	Cote d'Ivoire	CI	GGO	DIGL	-7.75	6.333333	Africa/Abidjan	0
2119	Gobernador Gregores Airport	Gobernador Gregores	Argentina	AR	GGS	SAWR	-70.25	-48.766667	America/Argentina/Buenos_Aires	0
2120	Exuma International Airport	George Town	Bahamas	BS	GGT	MYEF	-75.872475	23.564018	America/Nassau	0
2121	Glasgow International Airport	Glasgow	United States	US	GGW	KGGW	-106.615556	48.212778	America/Denver	0
2122	Noumerate Airport	Ghardaia	Algeria	DZ	GHA	DAUG	3.800556	32.382222	Africa/Algiers	0
2123	Governor's Harbour Airport	Governor's Harbour	Bahamas	BS	GHB	MYEM	-76.326771	25.277398	America/Nassau	0
2124	Great Harbour Airport	Great Harbour	Bahamas	BS	GHC	MYBG	-77.840278	25.738056	America/Nassau	0
2125	Garachine Airport	Garachine	Panama	PA	GHE	MPGA	-78.25	8.033333	America/Panama	0
2126	Giebelstadt Airport	Giebelstadt	Germany	DE	GHF	EDQG	9.966667	49.65	Europe/Berlin	0
2127	Gush Katif Airport	Gush Katif	Israel	IL	GHK	LLAZ	34.29451	31.36705	Asia/Jerusalem	0
2128	Centerville Municipal Airport	Centerville	United States	US	GHM	KGHM	-87.444471	35.836367	America/Chicago	0
2129	Guanghan Airport	Guanghan	China	CN	GHN	ZUGH	104.3297	30.9481	Asia/Shanghai	0
2130	Melalan Airport	West Kutai	Indonesia	ID	GHS	WALE	115.759722	-0.203889	Asia/Makassar	0
2131	Ghat Airport	Ghat	Libya	LY	GHT	HLGT	10.147592	25.135068	Africa/Tripoli	0
2132	Gualeguaychu Airport	Gualeguaychu	Argentina	AR	GHU	SAAG	-58.612222	-33.004167	America/Argentina/Buenos_Aires	0
2133	Brasov Ghimbav Airport	Brasov	Romania	RO	GHV	LRBG	25.5233	45.7061	Europe/Bucharest	0
2134	North Front Airport	Gibraltar	Gibraltar	GI	GIB	LXGB	-5.349271	36.153763	Europe/Gibraltar	0
2135	Boigu Island Airport	Boigu Island	Australia	AU	GIC	YBOI	142.218009	-9.232806	Australia/Brisbane	0
2136	Gitega Airport	Gitega	Burundi	BI	GID	HBBE	29.916667	-3.416667	Africa/Bujumbura	0
2137	Gilbert Field Airport	Winter Haven	United States	US	GIF	KGIF	-81.75	28.066667	America/New_York	0
2138	Rio de Janeiro Galeao International Airport	Rio De Janeiro	Brazil	BR	GIG	SBGL	-43.24651	-22.814654	America/Sao_Paulo	0
2139	Siguiri Airport	Siguiri	Guinea	GN	GII	GUSI	-9.166667	11.516667	Africa/Conakry	0
2140	Gilgit Airport	Gilgit	Pakistan	PK	GIL	OPGT	74.33224	35.919721	Asia/Karachi	0
2141	Girardot Airport	Girardot	Colombia	CO	GIR	SKGI	-74.8	4.3	America/Bogota	0
2142	Gisborne Airport	Gisborne	New Zealand	NZ	GIS	NZGS	177.982283	-38.661935	Pacific/Auckland	0
2143	Sigiriya Slaf Base	Sigiriya	Sri Lanka	LK	GIU	VCCS	80.728912	7.955185	Asia/Colombo	0
2144	Jazan Regional Airport	Jazan	Saudi Arabia	SA	GIZ	OEGN	42.582344	16.898949	Asia/Riyadh	0
2145	Guanaja Airport	Guanaja	Honduras	HN	GJA	MHNJ	-85.905833	16.445	America/Tegucigalpa	0
2146	Jijel Ferhat Abbas Airport	Jijel	Algeria	DZ	GJL	DAAV	5.8763	36.793625	Africa/Algiers	0
2147	Guajara-Mirim Airport	Guajara-Mirim	Brazil	BR	GJM	SBGM	-65.284798	-10.7864	America/Porto_Velho	0
2148	Gjogur Airport	Gjogur	Iceland	IS	GJR	BIGJ	-21.35	65.983333	Atlantic/Reykjavik	0
2149	Grand Junction Regional Airport	Grand Junction	United States	US	GJT	KGJT	-108.528333	39.122666	America/Denver	0
2150	Goroka Airport	Goroka	Papua New Guinea	PG	GKA	AYGA	145.392933	-6.075244	Pacific/Port_Moresby	0
2151	Gokceada Airport	Gokceada	Turkiye	TR	GKD	LTFK	25.881667	40.2	Europe/Istanbul	0
2152	Geilenkirchen Air Base	Geilenkirchen	Germany	DE	GKE	ETNG	6.042508	50.960694	Europe/Berlin	0
2153	Gorkha Airport	Gorkha	Nepal	NP	GKH	VNGK	84.675	28	Asia/Kathmandu	0
2154	Kooddoo Island Airport	Kooddoo Island	Maldives	MV	GKK	VRMO	73.43305	0.730833	Indian/Maldives	0
2155	Great Keppel Island Airport	Great Keppel Island	Australia	AU	GKL	YGKL	150.941667	-23.183333	Australia/Brisbane	0
2156	Gulkana Airport	Gulkana	United States	US	GKN	PAGK	-145.452222	62.155278	America/Anchorage	0
2157	Gatlinburg Airport	Gatlinburg	United States	US	GKT	KGKT	-83.518611	35.851389	America/New_York	0
2158	Glasgow Airport	Glasgow	United Kingdom	GB	GLA	EGPF	-4.431782	55.864213	Europe/London	0
2159	Geladi Airport	Geladi	Ethiopia	ET	GLC	HAGL	46.416667	6.966667	Africa/Addis_Ababa	0
2160	Goodland Municipal Airport	Goodland	United States	US	GLD	KGLD	-101.699444	39.370278	America/Denver	0
2161	Gainesville Municipal Airport	Gainesville	United States	US	GLE	KGLE	-97.133333	33.633333	America/Chicago	0
2162	Golfito Airport	Golfito	Costa Rica	CR	GLF	MRGF	-83.182097	8.65409	America/Costa_Rica	0
2163	Glengyle Airport	Glengyle	Australia	AU	GLG	YGLE	139.6	-24.816667	Australia/Brisbane	0
2164	Greenville Airport	Greenville	United States	US	GLH	KGLH	-90.985	33.484444	America/Chicago	0
2165	Glen Innes Airport	Glen Innes	Australia	AU	GLI	YGLI	151.690833	-29.676667	Australia/Sydney	0
2166	Galcaio Airport	Galcaio	Somalia	SO	GLK	HCMR	47.433333	6.766667	Africa/Mogadishu	0
2167	Klanten Airport	Gol	Norway	NO	GLL	ENKL	8.95	60.7	Europe/Oslo	0
2168	Glenormiston Airport	Glenormiston	Australia	AU	GLM	YGLO	138.833333	-22.916667	Australia/Brisbane	0
2169	Goulimime Airport	Goulimime	Morocco	MA	GLN	GMAG	-10.066667	29.016667	Africa/Casablanca	0
2170	Gloucestershire Airport	Gloucester	United Kingdom	GB	GLO	EGBJ	-2.16576	51.894228	Europe/London	0
2171	Gaylord Regional Airport	Gaylord	United States	US	GLR	KGLR	-84.701407	45.014539	America/New_York	0
2172	Scholes Field	Galveston	United States	US	GLS	KGLS	-94.860278	29.2675	America/Chicago	0
2173	Gladstone Airport	Gladstone	Australia	AU	GLT	YGLA	151.223506	-23.871469	Australia/Brisbane	0
2174	Gelephu Airport	Gelephu	Bhutan	BT	GLU	VQGP	90.465966	26.883481	Asia/Thimphu	0
2175	Golovin Airport	Golovin	United States	US	GLV	PAGL	-163.007169	64.550458	America/Anchorage	0
2176	Glasgow Municipal Airport	Glasgow	United States	US	GLW	KGLW	-85.916667	37	America/Chicago	0
2177	Gamar Malamo Airport	Galela	Indonesia	ID	GLX	WAEG	127.787217	1.837815	Asia/Jayapura	0
2178	Gilze-Rijen Air Base	Breda	Netherlands	NL	GLZ	EHGR	4.932732	51.567263	Europe/Amsterdam	0
2179	Gemena Airport	Gemena	The Democratic Republic of The Congo	CD	GMA	FZFK	19.771111	3.235278	Africa/Kinshasa	0
2180	Gambela Airport	Gambela	Ethiopia	ET	GMB	HAGM	34.583333	8.283333	Africa/Addis_Ababa	0
2181	Guerima Airport	Guerima	Colombia	CO	GMC	SKUV	-2.6	49.433333	America/Bogota	0
2182	Ben Slimane Airport	Ben Slimane	Morocco	MA	GMD	GMMB	-7.225556	33.654167	Africa/Casablanca	0
2183	Gomel Airport	Gomel	Belarus	BY	GME	UMGG	31.017895	52.526073	Europe/Minsk	0
2184	Greymouth Airport	Greymouth	New Zealand	NZ	GMN	NZGM	171.2	-42.45	Pacific/Auckland	0
2185	Gombe Lawanti International Airport	Gombe	Nigeria	NG	GMO	DNGO	10.898889	10.298056	Africa/Lagos	0
2186	Seoul Gimpo International Airport	Seoul	Republic of Korea	KR	GMP	RKSS	126.803512	37.559287	Asia/Seoul	0
2187	Gambier Island Airport	Gambier Island	French Polynesia	PF	GMR	NTGJ	-134.887575	-23.083999	Pacific/Gambier	0
2188	Guimaraes Airport	Guimaraes	Brazil	BR	GMS	SNGM	-44.7	-2.15	America/Belem	0
2189	Greenville Downtown Airport	Greenville	United States	US	GMU	KGMU	-82.383333	34.85	America/New_York	0
2190	La Gomera Airport	San Sebastian de la Gomera	Spain and Canary Islands	ES	GMZ	GCGM	-17.2	28.016667	Atlantic/Canary	0
2191	Grodno Airport	Grodno	Belarus	BY	GNA	UMMG	24.053906	53.605799	Europe/Minsk	0
2192	Grenoble-Isere Airport	Grenoble	France	FR	GNB	LFLS	5.332019	45.359832	Europe/Paris	0
2193	Maurice Bishop International Airport	St. George's	Grenada	GD	GND	TGPY	-61.786111	12.004167	America/Grenada	0
2194	Ghent Airport	Ghent	Belgium	BE	GNE	EBGT	3.7175	51.0544	Europe/Brussels	0
2195	Gooding Airport	Gooding	United States	US	GNG	KGNG	-114.716667	42.933333	America/Denver	0
2196	Guanambi Airport	Guanambi	Brazil	BR	GNM	SNGI	-42.746101	-14.2082	America/Belem	0
2197	Ghinnir Airport	Ghinnir	Ethiopia	ET	GNN	HAGH	40.716667	7.15	Africa/Addis_Ababa	0
2198	General Roca Airport	General Roca	Argentina	AR	GNR	SAHR	-67.616068	-39.001659	America/Argentina/Buenos_Aires	0
2199	Gunungsitoli Airport	Gunungsitoli	Indonesia	ID	GNS	WIMB	97.5	1.25	Asia/Jakarta	0
2200	Milan Airport	Grants	United States	US	GNT	KGNT	-107.866667	35.15	America/Denver	0
2201	Gainesville Regional Airport	Gainesville	United States	US	GNV	KGNV	-82.276797	29.686142	America/New_York	0
2202	Sanliurfa GAP Airport	Golgen	Turkiye	TR	GNY	LTCS	38.900313	37.44747	Europe/Istanbul	0
2203	Ghanzi Airport	Ghanzi	Botswana	BW	GNZ	FBGZ	21.666667	-21.7	Africa/Gaborone	0
2204	Genoa Cristoforo Colombo Airport	Genoa	Italy	IT	GOA	LIMJ	8.85081	44.415066	Europe/Rome	0
2205	Robe Airport	Goba	Ethiopia	ET	GOB	HAGB	40.044148	7.117977	Africa/Addis_Ababa	0
2206	Gobabis Airport	Gobabis	Namibia	NA	GOG	FYGB	18.974722	-22.504722	Africa/Windhoek	0
2207	Nuuk Airport	Nuuk	Greenland	GL	GOH	BGGH	-51.725	64.181944	America/Godthab	0
2208	Dabolim Airport	Goa	India	IN	GOI	VOGO	73.839825	15.384534	Asia/Kolkata	0
2209	Nizhny Novgorod International Airport	Nizhniy Novgorod	Russian Federation	RU	GOJ	UWGG	43.789766	56.218611	Europe/Moscow	0
2210	Guthrie Airport	Guthrie	United States	US	GOK	KGOK	-97.416667	35.883333	America/Chicago	0
2211	Goma Airport	Goma	The Democratic Republic of The Congo	CD	GOM	FZNA	29.238349	-1.669921	Africa/Lubumbashi	0
2212	Groton-New London Airport	New London	United States	US	GON	KGON	-72.046389	41.328889	America/New_York	0
2213	Goondiwindi Airport	Goondiwindi	Australia	AU	GOO	YGDI	150.319444	-28.524444	Australia/Brisbane	0
2214	Gorakhpur Airport	Gorakhpur	India	IN	GOP	VEGK	83.443762	26.746862	Asia/Kolkata	0
2215	Golmud Airport	Golmud	China	CN	GOQ	ZLGM	94.789305	36.404633	Asia/Shanghai	0
2216	Gore Airport	Gore	Ethiopia	ET	GOR	HAGR	35.538056	8.155556	Africa/Addis_Ababa	0
2217	Goteborg Landvetter Airport	Gothenburg	Sweden	SE	GOT	ESGG	12.294878	57.666643	Europe/Stockholm	0
2218	Garoua Airport	Garoua	Cameroon	CM	GOU	FKKR	13.375556	9.336111	Africa/Douala	0
2219	Nhulunbuy Airport	Gove	Australia	AU	GOV	YPGV	136.822653	-12.269595	Australia/Darwin	0
2220	Araxos Airport	Patras	Greece	GR	GPA	LGRX	21.4256	38.1511	Europe/Athens	0
2221	Mount Gordon Mine Airport	Mount Gordon	Australia	AU	GPD	YGON	139.91777	-19.999445	Australia/Brisbane	0
2222	Juan Casiano Airport	Guapi	Colombia	CO	GPI	SKGP	-77.898022	2.569998	America/Bogota	0
2223	Guapiles Airport	Guapiles	Costa Rica	CR	GPL	MRGP	-83.8	10.2	America/Costa_Rica	0
2224	Garden Point Airport	Garden Point	Australia	AU	GPN	YGPT	130.016667	-11.766667	Australia/Darwin	0
2225	General Pico Airport	General Pico	Argentina	AR	GPO	SAZG	-63.766667	-35.633333	America/Argentina/Buenos_Aires	0
2226	Baltra Airport	Galapagos Islands	Ecuador	EC	GPS	SEGS	-90.282778	-0.434722	Pacific/Galapagos	0
2227	Gulfport-Biloxi International Airport	Gulfport	United States	US	GPT	KGPT	-89.072029	30.413284	America/Chicago	0
2228	Grand Rapids - Itsaca County Airport	Grand Rapids	United States	US	GPZ	KGPZ	-93.511111	47.214444	America/Chicago	0
2229	Galion Airport	Galion	United States	US	GQQ	KGQQ	-82.757222	40.736667	America/New_York	0
2230	Austin Straubel International Airport	Green Bay	United States	US	GRB	KGRB	-88.121896	44.492848	America/Chicago	0
2231	Greenwood County Airport	Greenwood	United States	US	GRD	KGRD	-82.159153	34.248713	America/New_York	0
2232	Greenville Municipal Airport	Greenville	United States	US	GRE	KGRE	-89.364941	38.842235	America/Chicago	0
2233	Gray Army Air Field	Tacoma	United States	US	GRF	KGRF	-122.58081	47.079226	America/Los_Angeles	0
2234	Gardez Airport	Gardez	Afghanistan	AF	GRG	OAGZ	69.2375	33.628611	Asia/Kabul	0
2235	Central Nebraska Regional Airport	Grand Island	United States	US	GRI	KGRI	-98.306667	40.967222	America/Chicago	0
2236	George Airport	George	South Africa	ZA	GRJ	FAGG	22.382235	-34.00148	Africa/Johannesburg	0
2237	Robert Gray Army Airfield	Killeen	United States	US	GRK	KGRK	-97.820914	31.061821	America/Chicago	0
2238	Devils Track Airport	Grand Marais	United States	US	GRM	KCKC	-90.38329	47.838387	America/Chicago	0
2239	Gordon Airport	Gordon	United States	US	GRN	KGRN	-102.178694	42.802229	America/Denver	0
2240	Girona-Costa Brava Airport	Girona	Spain and Canary Islands	ES	GRO	LEGE	2.766383	41.898041	Europe/Madrid	0
2241	Gurupi Airport	Gurupi	Brazil	BR	GRP	SWGI	-49.216667	-11.666667	America/Belem	0
2242	Eelde Airport	Groningen	Netherlands	NL	GRQ	EHGG	6.575556	53.120278	Europe/Amsterdam	0
2243	Gerald R. Ford International Airport	Grand Rapids	United States	US	GRR	KGRR	-85.529738	42.885009	America/New_York	0
2244	Corrado Baccarini Airport	Grosseto	Italy	IT	GRS	LIRS	11.070556	42.761944	Europe/Rome	0
2245	Sao Paulo-Guarulhos International Airport	Sao Paulo	Brazil	BR	GRU	SBGR	-46.481926	-23.425668	America/Sao_Paulo	0
2246	Groznyy Airport	Groznyy	Russian Federation	RU	GRV	URMG	45.75	43.333333	Europe/Moscow	0
2247	Graciosa Island Airport	Graciosa Island (Azores)	Portugal	PT	GRW	LPGR	-28.027958	39.090954	Atlantic/Azores	0
2248	Granada Airport	Granada	Spain and Canary Islands	ES	GRX	LEGR	-3.776954	37.184728	Europe/Madrid	0
2249	Grimsey Airport	Grimsey	Iceland	IS	GRY	BIGR	-18.020378	66.54799	Atlantic/Reykjavik	0
2250	Graz Airport	Graz	Austria	AT	GRZ	LOWG	15.443228	46.996157	Europe/Vienna	0
2251	Long Pasia Airport	Long Pasia	Malaysia	MY	GSA	WBKN	115.766667	4.416667	Asia/Kuala_Lumpur	0
2252	Seymour Johnson Air Force Base	Goldsboro	United States	US	GSB	KGSB	-77.960579	35.339393	America/New_York	0
2253	Gascoyne Junction Airport	Gascoyne Junction	Australia	AU	GSC	YGSC	115.25	-25.166667	Australia/Perth	0
2254	Goteborg City Airport	Gothenburg	Sweden	SE	GSE	ESGP	11.870377	57.774715	Europe/Stockholm	0
2255	Goshen Municipal Airport	Goshen	United States	US	GSH	KGSH	-85.7929	41.526402	America/Indiana/Indianapolis	0
2256	Puerto San Jose Airport	Puerto San Jose	Guatemala	GT	GSJ	MGSJ	-90.835896	13.93622	America/Guatemala	0
2257	Taltheilei Narrows Airport	Taltheilei Narrows	Canada	CA	GSL	CFA7	-111.544444	62.5975	America/Edmonton	0
2258	Dayrestan Airport	Qeshm Island	Iran	IR	GSM	OIKQ	55.905278	26.757778	Asia/Tehran	0
2259	Mount Gunson Airport	Mount Gunson	Australia	AU	GSN	YMGN	137.766667	-31.666667	Australia/Adelaide	0
2260	Piedmont Triad International Airport	Greensboro/High Point	United States	US	GSO	KGSO	-79.937304	36.105324	America/New_York	0
2261	Greenville-Spartanburg International Airport	Greenville	United States	US	GSP	KGSP	-82.217053	34.890569	America/New_York	0
2262	Shark Elowainat Airport	Shark Elowainat	Egypt	EG	GSQ	HEOW	28.716667	22.583333	Africa/Cairo	0
2263	Gardo Airport	Gardo	Somalia	SO	GSR	HCMG	49.05	9.5	Africa/Mogadishu	0
2264	Sabi Sabi Airport	Sabi Sabi	South Africa	ZA	GSS	FASE	31.448848	-24.947375	Africa/Johannesburg	0
2265	Gustavus Airport	Gustavus	United States	US	GST	PAGS	-135.703687	58.423275	America/Anchorage	0
2266	Gedaref Airport	Gedaref	Sudan	SD	GSU	HSGF	35.466667	14.033333	Africa/Khartoum	0
2267	Gagarin Airport	Saratov	Russian Federation	RU	GSV	UWSG	46.170238	51.712726	Europe/Saratov	0
2268	Gatokae Aerodrom	Gatokae	Solomon Islands	SB	GTA	AGOK	158.183333	-8.766667	Pacific/Guadalcanal	0
2269	Alyangula Airport	Groote Island	Australia	AU	GTE	YGTE	136.460016	-13.973887	Australia/Darwin	0
2270	Great Falls International Airport	Great Falls	United States	US	GTF	KGTF	-111.35636	47.481889	America/Denver	0
2271	Grantsburg Municipal Airport	Grantsburg	United States	US	GTG	KGTG	-92.683333	45.783333	America/Chicago	0
2272	Rugen Airport	Dreschvitz	Germany	DE	GTI	EDCG	13.325393	54.384003	Europe/Berlin	0
2273	Glentanner Airport	Mount Cook	New Zealand	NZ	GTN	NZGT	170.129387	-43.908771	Pacific/Auckland	0
2274	Tolotio Airport	Gorontalo	Indonesia	ID	GTO	WAMG	122.850876	0.639039	Asia/Makassar	0
2275	Golden Triangle Regional Airport	Columbus	United States	US	GTR	KGTR	-88.6	33.45	America/Chicago	0
2276	The Granites Airport	The Granites	Australia	AU	GTS	YTGT	130.347139	-20.548532	Australia/Darwin	0
2277	Georgetown Airport	Georgetown	Australia	AU	GTT	YGTN	143.783333	-18.416667	Australia/Brisbane	0
2278	Holesov Airport	Zlin	Czech Republic	CZ	GTW	LKZL	17.516667	49.2	Europe/Prague	0
2279	Guatemala City La Aurora Interantional Airport	Guatemala City	Guatemala	GT	GUA	MGGT	-90.530679	14.588071	America/Guatemala	0
2280	Guerrero Negro Airport	Guerrero Negro	Mexico	MX	GUB	MMGR	-114.023947	28.026022	America/Mazatlan	0
2281	Gunnison Airport	Gunnison	United States	US	GUC	KGUC	-106.938889	38.533889	America/Denver	0
2282	Goundam Airport	Goundam	Mali	ML	GUD	GAGM	-3.609722	16.3575	Africa/Bamako	0
2283	Jack Edwards Airport	Gulf Shores	United States	US	GUF	KJKA	-87.672884	30.28962	America/Chicago	0
2284	Gunnedah Airport	Gunnedah	Australia	AU	GUH	YGDH	150.233333	-30.95	Australia/Sydney	0
2285	Guiria Airport	Guiria	Venezuela	VE	GUI	SVGI	-62.3	10.566667	America/Caracas	0
2286	Guaratingueta Airport	Guaratingueta	Brazil	BR	GUJ	SBGW	-45.216667	-22.816667	America/Sao_Paulo	0
2287	Goulburn Airport	Goulburn	Australia	AU	GUL	YGLB	149.716667	-34.75	Australia/Sydney	0
2288	A.B. Won Pat International Airport	Guam	Guam	GU	GUM	PGUM	144.804849	13.492787	Pacific/Guam	0
2289	Gallup Municipal Airport	Gallup	United States	US	GUP	KGUP	-108.786667	35.511111	America/Denver	0
2290	Guanare Airport	Guanare	Venezuela	VE	GUQ	SVGU	-69.75	9.025278	America/Caracas	0
2291	Gurney Airport	Alotau	Papua New Guinea	PG	GUR	AYGN	150.338611	-10.310833	Pacific/Port_Moresby	0
2292	Grissom Air Force Base	Peru	United States	US	GUS	KGUS	-86.066667	40.75	America/Indiana/Indianapolis	0
2293	Atyrau Airport	Atyrau	Kazakhstan	KZ	GUW	UATG	51.829554	47.122815	Asia/Atyrau	0
2294	Guymon Municipal Airport	Guymon	United States	US	GUY	KGUY	-101.507778	36.682778	America/Chicago	0
2295	Geneva Airport	Geneva	Switzerland	CH	GVA	LSGG	6.105774	46.229634	Europe/Zurich	0
2296	Gordonsville Municipal Airport	Gordonsville	United States	US	GVE	KGVE	-78.2	38.133333	America/New_York	0
2297	Lee Gilmer Memorial Airport	Gainesville	United States	US	GVL	KGVL	-83.833333	34.3	America/New_York	0
2298	May-Gatka Airport	Sovetskaya Gavan	Russian Federation	RU	GVN	UHKM	140.0367	48.9253	Asia/Vladivostok	0
2299	Greenvale Airport	Greenvale	Australia	AU	GVP	YGNV	144.616667	-15.783333	Australia/Brisbane	0
2300	Governador Valadares Airport	Governador Valadares	Brazil	BR	GVR	SBGV	-41.933333	-18.850278	America/Sao_Paulo	0
2301	Majors Field	Greenville	United States	US	GVT	KGVT	-96.061667	33.066667	America/Chicago	0
2302	Gestrike Airport	Gavle	Sweden	SE	GVX	ESSK	16.954722	60.593889	Europe/Stockholm	0
2303	Gwa Airport	Gwa	Myanmar	MM	GWA	VYGW	94	21	Asia/Yangon	0
2304	Gwadar Airport	Gwadar	Pakistan	PK	GWD	OPGD	62.338889	25.230556	Asia/Karachi	0
2305	Gweru Airport	Gweru	Zimbabwe	ZW	GWE	FVGW	29.861111	-19.435833	Africa/Harare	0
2306	Gwalior Airport	Gwalior	India	IN	GWL	VIGR	78.23	26.293889	Asia/Kolkata	0
2307	Leflore Airport	Greenwood	United States	US	GWO	KGWO	-90.088889	33.495	America/Chicago	0
2308	Glenwood Springs Municipal	Glenwood Springs	United States	US	GWS	KGWS	-107.414417	39.583167	America/Denver	0
2309	Westerland - Sylt Airport	Westerland	Germany	DE	GWT	EDXW	8.343056	54.915278	Europe/Berlin	0
2310	Carnmore Airport	Galway	Ireland	IE	GWY	EICM	-9.033333	53.283333	Europe/Dublin	0
2311	Beringin Airport	Muara Teweh	Indonesia	ID	GXA	WAOM	114.894444	-0.942778	Asia/Jakarta	0
2312	Seiyun Airport	Seiyun	Republic of Yemen	YE	GXF	OYSY	48.787085	15.961794	Asia/Aden	0
2313	Negage Airport	Negage	Angola	AO	GXG	FNNG	15.45	-7.783333	Africa/Luanda	0
2314	Ten. Vidal Airport	Coyhaique	Chile	CL	GXQ	SCCY	-72.098611	-45.588889	America/Santiago	0
2315	Greeley-Weld County Airport	Greeley	United States	US	GXY	KGXY	-104.636865	40.427756	America/Denver	0
2316	Guayaramerin Airport	Guayaramerin	Bolivia	BO	GYA	SLGM	-65.361667	-10.83	America/La_Paz	0
2317	Wodgina Airport	Wodgina	Australia	AU	GYB	YWDC	118.6778	-21.1761	Australia/Perth	0
2318	Baku Heydar Aliyev International Airport	Baku	Azerbaijan	AZ	GYD	UBBB	50.05039	40.462487	Asia/Baku	0
2319	Jose Joaquin de Olmedo Airport	Guayaquil	Ecuador	EC	GYE	SEGU	-79.880321	-2.142654	America/Guayaquil	0
2320	Magan Airport	Magan	Russian Federation	RU	GYG	UEMM	129.543333	62.107222	Asia/Yakutsk	0
2321	Gisenyi Airport	Gisenyi	Rwanda	RW	GYI	HRYG	29.259062	-1.677985	Africa/Kigali	0
2322	Argyle Airport	Argyle	Australia	AU	GYL	YARG	128.449912	-16.638837	Australia/Perth	0
2323	Gen Jose Maria Yanez International Airport	Guaymas	Mexico	MX	GYM	MMGM	-110.92193	27.969717	America/Hermosillo	0
2324	Santa Genoveva Airport	Goiania	Brazil	BR	GYN	SBGO	-49.226624	-16.632631	America/Sao_Paulo	0
2325	Gympie Airport	Gympie	Australia	AU	GYP	YGYM	152.701996	-26.282801	Australia/Brisbane	0
2326	Phoenix Goodyear Airport	Goodyear	United States	US	GYR	KGYR	-112.367078	33.426837	America/Phoenix	0
2327	Panlong Airport	Guangyuan	China	CN	GYS	ZUGU	105.695681	32.390572	Asia/Shanghai	0
2328	Guyuan Liupanshan Airport	Guyuan	China	CN	GYU	ZLGY	106.216944	36.078889	Asia/Shanghai	0
2329	Mine Site Airport	Gruyere	Australia	AU	GYZ	YGRM	123.8333	-27.98333	Australia/Perth	0
2330	Yasser Arafat International Airport	Gaza	Palestinian Territory, Occupied	PS	GZA	LVGZ	34.276111	31.246389	Asia/Gaza	0
2331	Ghazni Airport	Ghazni	Afghanistan	AF	GZI	OAGN	68.416667	33.533333	Asia/Kabul	0
2332	Gozo Airport	Gozo	Malta	MT	GZM	LMMG	14.272754	36.027209	Europe/Malta	0
2333	Nusatupe Airport	Gizo	Solomon Islands	SB	GZO	AGGN	156.863752	-8.097871	Pacific/Guadalcanal	0
2334	Gazipasa Airport	Gazipasa	Turkiye	TR	GZP	LTFG	32.3014	36.2993	Europe/Istanbul	0
2335	Oguzeli International Airport	Gaziantep	Turkiye	TR	GZT	LTAJ	37.478682	36.947182	Europe/Istanbul	0
2336	Ghazvin Airport	Ghazvin	Iran	IR	GZW	OIIK	50.033333	36.233333	Asia/Tehran	0
2337	Hasvik Airport	Hasvik	Norway	NO	HAA	ENHK	22.15	70.466667	Europe/Oslo	0
2338	Marion County Airport	Hamilton	United States	US	HAB	KHAB	-88.1	34.15	America/Chicago	0
2339	Hachijo Jima Airport	Hachijo Jima	Japan	JP	HAC	RJTH	139.781226	33.117945	Asia/Tokyo	0
2340	Halmstad Airport	Halmstad	Sweden	SE	HAD	ESMT	12.815005	56.680936	Europe/Stockholm	0
2341	Half Moon Airport	Half Moon	United States	US	HAF	KHAF	-122.500999	37.513401	America/Los_Angeles	0
2342	Prince Said Ibrahim Internatonal Airport	Moroni	Comoros	KM	HAH	FMCH	43.273777	-11.535392	Indian/Comoro	0
2343	Dr. Haines Airport	Three Rivers	United States	US	HAI	KHAI	-85.633333	41.95	America/New_York	0
2344	Hannover Airport	Hanover	Germany	DE	HAJ	EDDV	9.694766	52.459254	Europe/Berlin	0
2345	Haikou Meilan International Airport	Haikou	China	CN	HAK	ZJHK	110.45896	19.934877	Asia/Shanghai	0
2346	Halali Airport	Halali	Namibia	NA	HAL	FYHI	13.066667	-19.966667	Africa/Windhoek	0
2347	Hamburg Airport	Hamburg	Germany	DE	HAM	EDDH	10.006414	53.631279	Europe/Berlin	0
2348	Hanoi Noi Bai International Airport	Hanoi	Viet Nam	VN	HAN	VVNB	105.802827	21.214184	Asia/Ho_Chi_Minh	0
2349	Butler County Regional Airport	Hamilton	United States	US	HAO	KHAO	-84.521987	39.363777	America/New_York	0
2350	Long Island Seaplane Base	Long Island	Australia	AU	HAP	YHPB	148.846872	-20.335105	Australia/Brisbane	0
2351	Hanimaadhoo Airport	Hanimaadhoo	Maldives	MV	HAQ	VRMH	73.168377	6.748433	Indian/Maldives	0
2352	Harrisburg Capital City Airport	Harrisburg	United States	US	HAR	KCXY	-76.851483	40.217089	America/New_York	0
2353	Hail Airport	Hail	Saudi Arabia	SA	HAS	OEHL	41.690483	27.438158	Asia/Riyadh	0
2354	Heathlands Airport	Heathlands	Australia	AU	HAT	YHTL	140.583333	-19.720833	Australia/Brisbane	0
2355	Haugesund Airport	Haugesund	Norway	NO	HAU	ENHD	5.215903	59.344763	Europe/Oslo	0
2356	Jose Marti International Airport	Havana	Cuba	CU	HAV	MUHA	-82.408183	22.998449	America/Havana	0
2357	Haverfordwest Airport	Haverfordwest	United Kingdom	GB	HAW	EGFE	-4.966667	51.8	Europe/London	0
2358	Hatbox Field	Muskogee	United States	US	HAX	KHAX	-95.416667	35.75	America/Chicago	0
2359	Hacaritama Airport	Aguachica	Colombia	CO	HAY	SKAG	-73.57861	8.24556	America/Bogota	0
2360	Hobart International Airport	Hobart	Australia	AU	HBA	YMHB	147.505185	-42.837257	Australia/Hobart	0
2361	Borg El Arab Airport	Alexandria	Egypt	EG	HBE	HEBA	29.696462	30.932481	Africa/Cairo	0
2362	Bobby L. Chain Municipal Airport	Hattiesburg	United States	US	HBG	KHBG	-89.266667	31.316667	America/Chicago	0
2363	Hobart Airport	Hobart	United States	US	HBR	KHBR	-99.1	35.016667	America/Chicago	0
2364	Hubli Airport	Hubli	India	IN	HBX	VOHB	75.086305	15.359573	Asia/Kolkata	0
2365	Eli Airport	Eil	Somalia	SO	HCM	HCME	49.8	7.916667	Africa/Mogadishu	0
2366	Hengchun Airport	Hengchun	Taiwan	TW	HCN	RCKW	120.733187	21.039539	Asia/Taipei	0
2367	Halls Creek Airport	Halls Creek	Australia	AU	HCQ	YHLC	127.668606	-18.232109	Australia/Perth	0
2368	Holy Cross Airport	Holy Cross	United States	US	HCR	PAHC	-159.773472	62.190694	America/Anchorage	0
2369	Heidelberg Army Air Field	Heidelberg	Germany	DE	HDB	ETIE	8.651943	49.393346	Europe/Berlin	0
2370	Hyderabad Airport	Hyderabad	Pakistan	PK	HDD	OPKD	68.363889	25.322222	Asia/Karachi	0
2371	Brewster Field	Holdrege	United States	US	HDE	KHDE	-99.383333	40.433333	America/Chicago	0
2372	Heringsdorf Airport	Heringsdorf	Germany	DE	HDF	EDAH	14.138242	53.878251	Europe/Berlin	0
2373	Handan Airport	Handan	China	CN	HDG	ZBHD	114.425	36.525833	Asia/Shanghai	0
2374	Dillingham Airfield	Oahu	United States	US	HDH	PHDH	-158.191203	21.577203	Pacific/Honolulu	0
2375	Hamadan Airport	Hamadan	Iran	IR	HDM	OIHH	48.537318	34.867146	Asia/Tehran	0
2376	Yampa Valley Airport	Hayden	United States	US	HDN	KHDN	-107.220766	40.484808	America/Denver	0
2377	Hindon Airport	Ghaziabad	India	IN	HDO	VIDX	77.3419	28.705	Asia/Kolkata	0
2378	Hoedspruit Air Force Base	Hoedspruit	South Africa	ZA	HDS	FAHT	30.94583	-24.347221	Africa/Johannesburg	0
2379	Hat Yai International Airport	Hat Yai	Thailand	TH	HDY	VTSS	100.393566	6.936764	Asia/Bangkok	0
2380	Herat International Airport	Herat	Afghanistan	AF	HEA	OAHR	62.22599	34.212696	Asia/Kabul	0
2381	Cairo Capital International Airport	Cairo	Egypt	EG	CCE	HECP	31.83333	30.07222	Africa/Cairo	0
2382	Thompson-Robbins Airport	Helena	United States	US	HEE	KHEE	-90.6	34.533333	America/Chicago	0
2383	Heho Airport	Heho	Myanmar	MM	HEH	VYHH	96.79341	20.743863	Asia/Yangon	0
2384	Heide-Buesum Airport	Heide-Buesum	Germany	DE	HEI	EDXB	8.902778	54.155556	Europe/Berlin	0
2385	Heihe Airport	Heihe	China	CN	HEK	ZYHE	127.308905	50.171662	Asia/Shanghai	0
2386	Helsinki-Vantaa Airport	Helsinki	Finland	FI	HEL	EFHK	24.966449	60.317953	Europe/Helsinki	0
2387	Helsinki-Malmi Airport	Helsinki	Finland	FI	HEM	EFHF	25.05	60.25	Europe/Helsinki	0
2388	Heraklion International Airport	Heraklion	Greece	GR	HER	LGIR	25.174193	35.33663	Europe/Athens	0
2389	State Airport	Hermiston	United States	US	HES	KHES	-119.283333	45.85	America/Los_Angeles	0
2390	Hohhot Baita International Airport	Hohhot	China	CN	HET	ZBHH	111.814157	40.854712	Asia/Shanghai	0
2391	Herrera Airport	Santo Domingo	Dominican Republic	DO	HEX	MDHE	-69.975	18.475	America/Santo_Domingo	0
2392	Hardy-Anders Airport	Natchez	United States	US	HEZ	KHEZ	-91.296389	31.614722	America/Chicago	0
2393	Haifa Airport	Haifa	Israel	IL	HFA	LLHA	35.044593	32.811465	Asia/Jerusalem	0
2394	Brainard Airport	Hartford	United States	US	HFD	KHFD	-72.65	41.733056	America/New_York	0
2395	Hefei Xinqiao International Airport	Hefei	China	CN	HFE	ZSOF	116.973333	31.992778	Asia/Shanghai	0
2396	Mackall Army Air Field	Hoffman	United States	US	HFF	KHFF	-79.497712	35.03628	America/New_York	0
2397	Hornafjordur Airport	Hornafjordur	Iceland	IS	HFN	BIHN	-15.266667	64.283333	Atlantic/Reykjavik	0
2398	Hagfors Airport	Hagfors	Sweden	SE	HFS	ESOH	13.569167	60.0175	Europe/Stockholm	0
2399	Hammerfest Airport	Hammerfest	Norway	NO	HFT	ENHF	23.675867	70.679989	Europe/Oslo	0
2400	Hargeisa Airport	Hargeisa	Somalia	SO	HGA	HCMH	44.091667	9.515833	Africa/Mogadishu	0
2401	Hughenden Airport	Hughenden	Australia	AU	HGD	YHUG	144.224444	-20.818889	Australia/Brisbane	0
2402	Higuerote Airport	Higuerote	Venezuela	VE	HGE	SVHG	-66.095095	10.463604	America/Caracas	0
2403	Hangzhou Xiaoshan International Airport	Hangzhou	China	CN	HGH	ZSHC	120.432356	30.236934	Asia/Shanghai	0
2404	Helgoland Airport	Helgoland	Germany	DE	HGL	EDXH	7.916667	54.186944	Europe/Berlin	0
2405	Mae Hong Son Airport	Mae Hong Son	Thailand	TH	HGN	VTCH	97.975227	19.29968	Asia/Bangkok	0
2406	Korhogo Airport	Korhogo	Cote d'Ivoire	CI	HGO	DIKO	-5.554251	9.389377	Africa/Abidjan	0
2407	Wash. County Regional Airport	Hagerstown	United States	US	HGR	KHGR	-77.73	39.707778	America/New_York	0
2408	Hastings Airport	Freetown	Sierra Leone	SL	HGS	GFHA	-13.13	8.393056	Africa/Freetown	0
2409	Hunter Army Air Field	Jolon	United States	US	HGT	KHGT	-121.15	35.966667	America/Los_Angeles	0
2410	Mount Hagen Airport	Mount Hagen	Papua New Guinea	PG	HGU	AYMH	144.297376	-5.828767	Pacific/Port_Moresby	0
2411	Hachinohe Air Base	Hachinohe	Japan	JP	HHE	RJSH	141.467219	40.551947	Asia/Tokyo	0
2412	Hilton Head Airport	Hilton Head	United States	US	HHH	KHXD	-80.697013	32.22263	America/New_York	0
2413	Wheeler AAF	Wahiawa	United States	US	HHI	PHHI	-158.036409	21.480308	Pacific/Honolulu	0
2414	Frankfurt - Hahn Airport	Hahn	Germany	DE	HHN	EDFH	7.264167	49.948333	Europe/Berlin	0
2415	Sheung Wan Heliport	Hong Kong	Hong Kong SAR	HK	HHP	VHSS	114.152237	22.288896	Asia/Hong_Kong	0
2416	Hua Hin Airport	Hua Hin	Thailand	TH	HHQ	VTPH	99.951533	12.636229	Asia/Bangkok	0
2417	Hawthorne Municipal Airport	Hawthorne	United States	US	HHR	KHHR	-118.335229	33.922007	America/Los_Angeles	0
2418	Huai'an Lianshui Airport	Huai'an	China	CN	HIA	ZSSH	119.12778	33.7875	Asia/Shanghai	0
2419	Chisholm Airport	Hibbing	United States	US	HIB	KHIB	-92.838611	47.388611	America/Chicago	0
2420	Horn Island Airport	Horn Island	Australia	AU	HID	YHID	142.283333	-10.583333	Australia/Brisbane	0
2421	Mount Washington Regional Airport	Whitefield	United States	US	HIE	KHIE	-71.548611	44.365833	America/New_York	0
2422	Hill Air Force Base	Ogden	United States	US	HIF	KHIF	-111.973041	41.123902	America/Denver	0
2423	Highbury Airport	Highbury	Australia	AU	HIG	YHHY	143.15	-16.416667	Australia/Brisbane	0
2424	Lake Havasu City Municipal Airport	Lake Havasu City	United States	US	HII	KHII	-114.359729	34.569693	America/Phoenix	0
2425	Hiroshima Airport	Hiroshima	Japan	JP	HIJ	RJOA	132.919444	34.436111	Asia/Tokyo	0
2426	Shillavo Airport	Shillavo	Ethiopia	ET	HIL	HASL	44.766667	6.083333	Africa/Addis_Ababa	0
2427	Hingurakgoda Airport	Hingurakgoda	Sri Lanka	LK	HIM	VCCH	80.971111	8.05	Asia/Colombo	0
2428	Sacheon Airport	Jinju	Republic of Korea	KR	HIN	RKPS	128.086765	35.092629	Asia/Seoul	0
2429	Portland Hillsboro Airport	Hillsboro	United States	US	HIO	KHIO	-122.983333	45.516667	America/Los_Angeles	0
2430	Headingly Airport	Headingly	Australia	AU	HIP	YHDY	138.283333	-21.316667	Australia/Brisbane	0
2431	Honiara International Airport	Honiara	Solomon Islands	SB	HIR	AGGH	160.048182	-9.428592	Pacific/Guadalcanal	0
2432	Hayman Island Airport	Hayman Island	Australia	AU	HIS	YHYN	148.866667	-20.066667	Australia/Brisbane	0
2433	Hiroshima West Airport	Hiroshima	Japan	JP	HIW	RJBH	132.416389	34.363611	Asia/Tokyo	0
2434	Zhijiang Airport	Huaihua	China	CN	HJJ	ZGCJ	109.699722	27.441389	Asia/Shanghai	0
2435	Khajuraho Airport	Khajuraho	India	IN	HJR	VEKO	79.916417	24.818746	Asia/Kolkata	0
2436	Blytheville Municipal Airport	Blytheville	United States	US	HKA	KHKA	-89.916667	35.933333	America/Chicago	0
2437	Hakodate Airport	Hakodate	Japan	JP	HKD	RJCH	140.815817	41.776125	Asia/Tokyo	0
2438	Hong Kong International Airport	Hong Kong	Hong Kong SAR	HK	HKG	VHHH	113.93649	22.315248	Asia/Hong_Kong	0
2439	Hokitika Airport	Hokitika	New Zealand	NZ	HKK	NZHK	170.983462	-42.714914	Pacific/Auckland	0
2440	Kakamega Airport	Kakamega	Kenya	KE	GGM	HKKG	34.784689	0.271239	Africa/Nairobi	0
2441	Hoskins Airport	Hoskins	Papua New Guinea	PG	HKN	AYHK	150.402996	-5.456876	Pacific/Port_Moresby	0
2442	Hawkins Field	Jackson	United States	US	HKS	KHKS	-90.222295	32.333676	America/Chicago	0
2443	Phuket International Airport	Phuket	Thailand	TH	HKT	VTSP	98.306436	8.107619	Asia/Bangkok	0
2444	Haskovo Airport	Haskovo	Bulgaria	BG	HKV	LBHM	25.55	41.933333	Europe/Sofia	0
2445	Hickory Airport	Hickory	United States	US	HKY	KHKY	-81.391667	35.738611	America/New_York	0
2446	Lanseria International Airport	Lanseria	South Africa	ZA	HLA	FALA	27.926212	-25.935917	Africa/Johannesburg	0
2447	Hillenbrand Airport	Batesville	United States	US	HLB	KHLB	-85.216667	39.3	America/Indiana/Indianapolis	0
2448	Hill City Airport	Hill City	United States	US	HLC	KHLC	-99.85	39.366667	America/Chicago	0
2449	Hulunbuir Hailar Airport	Hailar	China	CN	HLD	ZBLA	119.818129	49.209906	Asia/Shanghai	0
2450	Saint Helena Airport	Jamestown	St. Helena	SH	HLE	FHSH	-5.645963	-15.957714	Atlantic/St_Helena	0
2451	Hultsfred Airport	Hultsfred	Sweden	SE	HLF	ESSF	15.827778	57.526389	Europe/Stockholm	0
2452	Ohio County Airport	Wheeling	United States	US	HLG	KHLG	-80.65	40.183333	America/New_York	0
2453	Ulanhot Airport	Ulanhot	China	CN	HLH	ZBUL	122.001482	46.193488	Asia/Shanghai	0
2454	Park Township Airport	Holland	United States	US	HLM	KHLM	-86.116667	42.783333	America/New_York	0
2455	Helena Regional Airport	Helena	United States	US	HLN	KHLN	-111.990182	46.610518	America/Denver	0
2456	Halim Perdanakusuma Airport	Jakarta	Indonesia	ID	HLP	WIHH	106.890278	-6.268056	Asia/Jakarta	0
2457	Hood Army Air Field	Killeen	United States	US	HLR	KHLR	-97.714511	31.138698	America/Chicago	0
2458	St. Helens Airport	Saint Helens	Australia	AU	HLS	YSTH	148.281998	-41.3367	Australia/Hobart	0
2459	Hamilton Airport	Hamilton	Australia	AU	HLT	YHML	142.060556	-37.65	Australia/Sydney	0
2460	Houailou Airport	Houailou	New Caledonia	NC	HLU	NWWH	166.066667	-21.033333	Pacific/Noumea	0
2461	Helenvale Airport	Helenvale	Australia	AU	HLV	YHEL	145.2	-15.683333	Australia/Brisbane	0
2462	Hluhluwe Airport	Hluhluwe	South Africa	ZA	HLW	FAHL	32.25	-28.016667	Africa/Johannesburg	0
2463	Hamilton International Airport	Hamilton	New Zealand	NZ	HLZ	NZHN	175.336023	-37.86622	Pacific/Auckland	0
2464	Khanty-Mansiysk Airport	Khanty-Mansiysk	Russian Federation	RU	HMA	USHH	69.09714	61.02613	Asia/Yekaterinburg	0
2465	Mubarak International Airport	Sohag	Egypt	EG	HMB	HESG	31.737168	26.338877	Africa/Cairo	0
2466	Oued Irara Airport	Hassi Messaoud	Algeria	DZ	HME	DAUH	6.145436	31.675303	Africa/Algiers	0
2467	Hermannsburg Airport	Hermannsburg	Australia	AU	HMG	YHMB	132.75	-23.95	Australia/Darwin	0
2468	Hami Airport	Hami	China	CN	HMI	ZWHM	93.416667	42.916667	Asia/Shanghai	0
2469	Khmelnitskiy Airport	Khmelnitskiy	Ukraine	UA	HMJ	UKLH	27	49.416667	Europe/Kiev	0
2470	Holloman Air Force Base	Alamogordo	United States	US	HMN	KHMN	-106.107011	32.852489	America/Denver	0
2471	Gen Pesqueira Garcia Airport	Hermosillo	Mexico	MX	HMO	MMHO	-111.051706	29.089904	America/Hermosillo	0
2472	Hamar Airport	Hamar	Norway	NO	HMR	ENHA	11.116667	60.8	Europe/Oslo	0
2473	Ryan Field	Hemet	United States	US	HMT	KHMT	-117.025	33.733333	America/Los_Angeles	0
2474	Hemavan Airport	Hemavan	Sweden	SE	HMV	ESUT	15.082767	65.806085	Europe/Stockholm	0
2475	Hanamaki Airport	Hanamaki	Japan	JP	HNA	RJSI	141.130767	39.426926	Asia/Tokyo	0
2476	Huntingburg Municipal Airport	Huntingburg	United States	US	HNB	KHNB	-86.95	38.3	America/Indiana/Indianapolis	0
2477	Hatteras Airport	Hatteras	United States	US	HNC	KHSE	-75.617798	35.2328	America/New_York	0
2478	Tokyo Haneda International Airport	Tokyo	Japan	JP	HND	RJTT	139.781206	35.553476	Asia/Tokyo	0
2479	Hoonah Airport	Hoonah	United States	US	HNH	PAOH	-135.411807	58.098569	America/Anchorage	0
2480	Honolulu International Airport	Honolulu	United States	US	HNL	PHNL	-157.921667	21.325833	Pacific/Honolulu	0
2481	Hana Airport	Hana	United States	US	HNM	PHHN	-156.018889	20.795833	Pacific/Honolulu	0
2482	Haines Municipal Airport	Haines	United States	US	HNS	PAHN	-135.529234	59.246197	America/Anchorage	0
2483	Hengyang Nanyue Airport	Hengyang	China	CN	HNY	ZGHY	112.618333	26.723889	Asia/Shanghai	0
2484	Hola Airport	Hola	Kenya	KE	HOA	HKHO	40.00371	-1.520005	Africa/Nairobi	0
2485	Lea County Airport	Hobbs	United States	US	HOB	KHOB	-103.216944	32.688611	America/Denver	0
2486	Hodeidah Airport	Hodeidah	Republic of Yemen	YE	HOD	OYHD	42.970477	14.755638	Asia/Aden	0
2487	Ban Houeisay Airport	Houeisay	Lao People's Democratic Republic	LA	HOE	VLHS	100.436785	20.260512	Asia/Vientiane	0
2488	Al-Ahsa Airport	Hofuf	Saudi Arabia	SA	HOF	OEAH	49.487462	25.294783	Asia/Riyadh	0
2489	Frank Pais Airport	Holguin	Cuba	CU	HOG	MUHG	-76.315	20.785278	America/Havana	0
2490	Hohenems Airport	Hohenems	Austria	AT	HOH	LOIH	9.7	47.383333	Europe/Vienna	0
2491	Hao Island Airport	Hao Island	French Polynesia	PF	HOI	NTTO	-140.965292	-18.06248	Pacific/Tahiti	0
2492	Hooker Creek Airport	Hooker Creek	Australia	AU	HOK	YHOO	130.6325	-18.335	Australia/Darwin	0
2493	Homer Airport	Homer	United States	US	HOM	PAHO	-151.493161	59.643241	America/Anchorage	0
2494	Howes Airport	Huron	United States	US	HON	KHON	-98.226389	44.383611	America/Chicago	0
2495	Campbell Army Airfield	Hopkinsville	United States	US	HOP	KHOP	-87.488868	36.672079	America/Chicago	0
2496	Hof Airport	Hof	Germany	DE	HOQ	EDQM	11.862222	50.289167	Europe/Berlin	0
2497	Horta Airport	Horta (Azores)	Portugal	PT	HOR	LPHR	-28.717222	38.52	Atlantic/Azores	0
2498	Oscar Reguera Airport	Chos Malal	Argentina	AR	HOS	SAHC	-70.223056	-37.444167	America/Argentina/Buenos_Aires	0
2499	Memorial Field	Hot Springs	United States	US	HOT	KHOT	-93.096111	34.478889	America/Chicago	0
2500	Houston Hobby Airport	Houston	United States	US	HOU	KHOU	-95.279	29.645	America/Chicago	0
2501	Hovden Airport	Orsta-Volda	Norway	NO	HOV	ENOV	6.078802	62.179787	Europe/Oslo	0
2502	Homalin Airport	Homalin	Myanmar	MM	HOX	VYHL	94.914636	24.898928	Asia/Yangon	0
2503	Salote Pilolevu Airport	Ha'Apai	Tonga	TO	HPA	NFTL	-174.340885	-19.778537	Pacific/Tongatapu	0
2504	Hooper Bay Airport	Hooper Bay	United States	US	HPB	PAHP	-166.14586	61.525077	America/Anchorage	0
2505	Hope Vale Airport	Hope Vale	Australia	AU	HPE	YHPV	144.916667	-14.666667	Australia/Brisbane	0
2506	Cat Bi International Airport	Haiphong	Viet Nam	VN	HPH	VVCI	106.727325	20.823314	Asia/Ho_Chi_Minh	0
2507	Westchester County Airport	Westchester County	United States	US	HPN	KHPN	-73.703889	41.068674	America/New_York	0
2508	Hampton Municipal Airport	Hampton	United States	US	HPT	KHPT	-93.2	42.75	America/Chicago	0
2509	Princeville Airport	Kauai Island	United States	US	HPV	HI01	-159.444808	22.210378	Pacific/Honolulu	0
2510	Baytown Airport	Baytown	United States	US	HPY	KHPY	-94.958621	29.774058	America/Chicago	0
2511	Bowerman Airport	Hoquiam	United States	US	HQM	KHQM	-123.935556	46.971111	America/Los_Angeles	0
2512	Harbin Taiping International Airport	Harbin	China	CN	HRB	ZYHB	126.23644	45.620854	Asia/Shanghai	0
2513	RG Mugabe International Airport	Harare	Zimbabwe	ZW	HRE	FVHA	31.099249	-17.918631	Africa/Harare	0
2514	Hurghada International Airport	Hurghada	Egypt	EG	HRG	HEGN	33.8055	27.189156	Africa/Cairo	0
2515	Mattala Rajapaksa International Airport	Hambantota	Sri Lanka	LK	HRI	VCRI	81.123886	6.283889	Asia/Colombo	0
2516	Kharkov Airport	Kharkov	Ukraine	UA	HRK	UKHH	36.281187	49.920781	Europe/Kiev	0
2517	Valley International Airport	Harlingen	United States	US	HRL	KHRL	-97.662253	26.223483	America/Chicago	0
2518	Tilrempt Airport	Hassi R'Mel	Algeria	DZ	HRM	DAFH	3.311667	32.930556	Africa/Algiers	0
2519	Heron Island Heliport	Heron Island	Australia	AU	HRN	YHRN	151.916667	-23.433333	Australia/Brisbane	0
2520	Boone County Airport	Harrison	United States	US	HRO	KHRO	-93.154259	36.264468	America/Chicago	0
2521	Herrera Airport	Herrera	Colombia	CO	HRR	SKHB	-75.80643	3.291857	America/Bogota	0
2522	Harrismith Airport	Harrismith	South Africa	ZA	HRS	FAHR	29.1	-26.233333	Africa/Johannesburg	0
2523	Linton-On-Ouse RAF	Linton-on-Ouse	United Kingdom	GB	HRT	EGXU	-1.251643	54.045878	Europe/London	0
2524	Henbury Airport	Henbury	Australia	AU	HRY	YHBY	133.25	-24.583333	Australia/Darwin	0
2525	Raleigh Airport	Harrisburg	United States	US	HSB	KHSB	-88.533333	37.733333	America/Chicago	0
2526	Saga Airport	Saga	Japan	JP	HSG	RJFS	130.302775	33.153828	Asia/Tokyo	0
2527	Henderson Executive Airport	Las Vegas	United States	US	HSH	KHND	-115.134188	35.973171	America/Los_Angeles	0
2528	Hastings Airport	Hastings	United States	US	HSI	KHSI	-98.426944	40.605556	America/Chicago	0
2529	Huesca-Pirineos Airport	Huesca	Spain and Canary Islands	ES	HSK	LEHC	-0.323469	42.080927	Europe/Madrid	0
2530	Huslia Airport	Huslia	United States	US	HSL	PAHS	-156.351389	65.697861	America/Anchorage	0
2531	Horsham Airport	Horsham	Australia	AU	HSM	YHSM	142.166667	-36.666667	Australia/Sydney	0
2532	Rumbek Airport	Rumbek	South Sudan	SS	RBX	HJRB	29.669531	6.825243	Africa/Juba	0
2533	Putuoshan Airport	Zhoushan	China	CN	HSN	ZSZS	122.356914	29.935258	Asia/Shanghai	0
2534	Ingalls Field	Hot Springs	United States	US	HSP	KHSP	-79.833889	37.950556	America/New_York	0
2535	Hissar Airport	Hissar	India	IN	HSS	VIHR	75.8	29.166667	Asia/Kolkata	0
2536	Homestead Air Force Base	Homestead	United States	US	HST	KHST	-80.383598	25.4886	America/New_York	0
2537	Huntsville International Airport - Carl T. Jones Field	Huntsville	United States	US	HSV	KHSV	-86.774838	34.64857	America/Chicago	0
2538	Hsinchu Airport	Hsinchu	Taiwan	TW	HSZ	RCPO	120.933333	24.816667	Asia/Taipei	0
2539	Zalingei Airport	Zalingei	Sudan	SD	ZLX	HSZA	23.506332	12.937955	Africa/Khartoum	0
2540	Chita Airport	Chita	Russian Federation	RU	HTA	UIAA	113.3	52.033333	Asia/Chita	0
2541	Hatanga Airport	Hatanga	Russian Federation	RU	HTG	UOHH	102.477651	71.975681	Asia/Krasnoyarsk	0
2542	Hawthorne Airport	Hawthorne	United States	US	HTH	KHTH	-118.633333	38.533333	America/Los_Angeles	0
2543	Hamilton Island Airport	Hamilton Island	Australia	AU	HTI	YBHM	148.948474	-20.35175	Australia/Brisbane	0
2544	Roscommon County Airport	Houghton Lake	United States	US	HTL	KHTL	-84.711111	44.448056	America/New_York	0
2545	Khatgal Airport	Khatgal	Mongolia	MN	HTM	ZMHG	100.166667	50.45	Asia/Ulaanbaatar	0
2546	Mpanda Airport	Mpanda	United Republic of Tanzania	TZ	NPY	HTMP	31.084045	-6.355285	Africa/Dar_es_Salaam	0
2547	Hotan Airport	Hotan	China	CN	HTN	ZWTN	79.872449	37.040434	Asia/Shanghai	0
2548	East Hampton Airport	East Hampton	United States	US	HTO	KHTO	-72.251667	40.959444	America/New_York	0
2549	Hateruma Airport	Hateruma	Japan	JP	HTR	RORH	123.8	24.05	Asia/Tokyo	0
2550	Tri-State/Milton Airport	Huntington	United States	US	HTS	KHTS	-82.556111	38.366944	America/New_York	0
2551	Hopetown Airport	Hopetown	Australia	AU	HTU	YHPN	142.366667	-35.7	Australia/Sydney	0
2552	Huntsville Airport	Huntsville	United States	US	HTV	KUTS	-95.55	30.716667	America/Chicago	0
2553	Huntington County Airport	Chesapeake	United States	US	HTW	KHTW	-76.283333	36.833333	America/New_York	0
2554	Hatay Airport	Antakya	Turkiye	TR	HTY	LTDA	36.28057	36.364544	Europe/Istanbul	0
2555	Hato Corozal Airport	Hato Corozal	Colombia	CO	HTZ	SKHC	-72.633333	6.033333	America/Bogota	0
2556	Redstone Army Air Field	Huntsville	United States	US	HUA	KHUA	-86.684783	34.678679	America/Chicago	0
2557	Humbert River Airport	Humbert River	Australia	AU	HUB	YHBR	130.75	-16.5	Australia/Darwin	0
2558	Humera Airport	Humera	Ethiopia	ET	HUE	HAHU	36.880778	13.835854	Africa/Addis_Ababa	0
2559	Hulman Field	Terre Haute	United States	US	HUF	KHUF	-87.3075	39.454444	America/Indiana/Indianapolis	0
2560	Huehuetenango Airport	Huehuetenango	Guatemala	GT	HUG	MGHT	-91.466667	15.333333	America/Guatemala	0
2561	Huahine Airport	Huahine	French Polynesia	PF	HUH	NTTH	-151.028253	-16.689682	Pacific/Tahiti	0
2562	Phu Bai International Airport	Hue	Viet Nam	VN	HUI	VVPB	107.700871	16.398224	Asia/Ho_Chi_Minh	0
2563	Hugo Airport	Hugo	United States	US	HUJ	KHHW	-95.516667	34.016667	America/Chicago	0
2564	Houlton International Airport	Houlton	United States	US	HUL	KHUL	-67.8	46.133333	America/New_York	0
2565	Houma-Terrebonne Airport	Houma	United States	US	HUM	KHUM	-90.660833	29.566944	America/Chicago	0
2566	Hualien Airport	Hualien	Taiwan	TW	HUN	RCYU	121.613431	24.025764	Asia/Taipei	0
2567	Houn Airport	Houn	Libya	LY	HUQ	HLON	15.5	29.5	Africa/Tripoli	0
2568	Hughes Municipal Airport	Hughes	United States	US	HUS	PAHU	-154.263333	66.040556	America/Anchorage	0
2569	Hutchinson Airport	Hutchinson	United States	US	HUT	KHUT	-97.861111	38.068056	America/Chicago	0
2570	Huanuco Airport	Huanuco	Peru	PE	HUU	SPNC	-76.216667	-9.866667	America/Lima	0
2571	Hudiksvall Airport	Hudiksvall	Sweden	SE	HUV	ESNH	17.084194	61.767101	Europe/Stockholm	0
2572	Huatulco Airport	Huatulco	Mexico	MX	HUX	MMBT	-96.235556	15.768333	America/Mexico_City	0
2573	Humberside Airport	Humberside	United Kingdom	GB	HUY	EGNJ	-0.34851	53.583378	Europe/London	0
2574	Huizhou Airport	Huizhou	China	CN	HUZ	ZGHZ	114.596859	23.050418	Asia/Shanghai	0
2575	Analalava Airport	Analalava	Madagascar	MG	HVA	FMNL	47.766667	-14.633333	Indian/Antananarivo	0
2576	Hervey Bay Airport	Hervey Bay	Australia	AU	HVB	YHBA	152.885203	-25.319868	Australia/Brisbane	0
2577	Khovd Airport	Khovd	Mongolia	MN	HVD	ZMKD	91.65	48.016667	Asia/Ulaanbaatar	0
2578	Hanksville Intermediate Airport	Hanksville	United States	US	HVE	KHVE	-110.716667	38.366667	America/Denver	0
2579	Valan Airport	Honningsvag	Norway	NO	HVG	ENHV	25.983601	71.009697	Europe/Oslo	0
2580	Holmavik Airport	Holmavik	Iceland	IS	HVK	BIHK	-22.466667	65.7	Atlantic/Reykjavik	0
2581	New Haven Airport	New Haven	United States	US	HVN	KHVN	-72.888333	41.265278	America/New_York	0
2582	Havre City County Airport	Havre	United States	US	HVR	KHVR	-109.761111	48.544444	America/Denver	0
2583	Hartsville Municipal Airport	Hartsville	United States	US	HVS	KHVS	-80.066667	34.383333	America/New_York	0
2584	Hayward Executive Airport	Hayward	United States	US	HWD	KHWD	-122.122002	37.659199	America/Los_Angeles	0
2585	Wilpena Pound Airport	Hawker	Australia	AU	HWK	YHAW	138.416667	-31.716667	Australia/Adelaide	0
2586	Hwange National Park Airport	Hwange National Park	Zimbabwe	ZW	HWN	FVWN	26.5175	-18.3619	Africa/Harare	0
2587	North Perry Airport	Hollywood	United States	US	HWO	KHWO	-80.238918	26.002428	America/New_York	0
2588	Hay Airport	Hay	Australia	AU	HXX	YHAY	144.833333	-34.516667	Australia/Sydney	0
2589	Barnstable Municipal Airport	Hyannis	United States	US	HYA	KHYA	-70.280556	41.665833	America/New_York	0
2590	High Wycombe Airport	High Wycombe	United Kingdom	GB	HYC	EGUH	-0.75	51.616667	Europe/London	0
2591	Hyderabad Rajiv Gandhi International Airport	Hyderabad	India	IN	HYD	VOHS	78.430427	17.233702	Asia/Kolkata	0
2592	Hayfields Airport	Hayfields	Papua New Guinea	PG	HYF	AYHF	143.05	-3.633333	Pacific/Port_Moresby	0
2593	Hydaburg Sea Plane Base	Hydaburg	United States	US	HYG	PAHY	-132.825475	55.201734	America/Anchorage	0
2594	Luqiao Airport	Taizhou	China	CN	HYN	ZSLQ	121.428614	28.562224	Asia/Shanghai	0
2595	Hayward Municipal Airport	Hayward	United States	US	HYR	KHYR	-91.444444	46.024444	America/Chicago	0
2596	Hays Municipal Airport	Hays	United States	US	HYS	KHYS	-99.274167	38.846111	America/Chicago	0
2597	Hyvinkaa Airport	Hyvinkaa	Finland	FI	HYV	EFHV	24.884444	60.654167	Europe/Helsinki	0
2598	Merville/Calonne Airport	Hazebrouck	France	FR	HZB	LFQT	2.65	50.616667	Europe/Paris	0
2599	Hanzhong Airport	Hanzhong	China	CN	HZG	ZLHZ	107.008446	33.063443	Asia/Shanghai	0
2600	Liping Airport	Liping	China	CN	HZH	ZUNP	109.153806	26.320214	Asia/Shanghai	0
2601	Husavik Airport	Husavik	Iceland	IS	HZK	BIHU	-17.419672	65.955754	Atlantic/Reykjavik	0
2602	Hazleton Airport	Hazleton	United States	US	HZL	KHZL	-75.991111	40.986389	America/New_York	0
2603	Fort MacKay/Horizon Airport	Fort MacKay	Canada	CA	HZP	CYNR	-111.701111	57.381667	America/Edmonton	0
2604	McConnell Air Force Base	Wichita	United States	US	IAB	KIAB	-97.276167	37.681139	America/Chicago	0
2605	Washington Dulles International Airport	Dulles	United States	US	IAD	KIAD	-77.447735	38.95315	America/New_York	0
2606	Niagara Falls International Airport	Niagara Falls	United States	US	IAG	KIAG	-78.95	43.1	America/New_York	0
2607	Houston George Bush Intercontinental Airport	Houston	United States	US	IAH	KIAH	-95.34	29.983333	America/Chicago	0
2608	In Amenas Airport	In Amenas	Algeria	DZ	IAM	DAUZ	9.638056	28.051111	Africa/Algiers	0
2609	Bob Baker Memorial Airport	Kiana	United States	US	IAN	PAIK	-160.441212	66.974752	America/Anchorage	0
2610	Sayak Airport	Del Carmin	Philippines	PH	IAO	RPNS	126.013889	9.858889	Asia/Manila	0
2611	Bahregan Airport	Bahregan	Iran	IR	IAQ	OIBH	50.2756	29.8317	Asia/Tehran	0
2612	Tunoshna Airport	Yaroslavl	Russian Federation	RU	IAR	UUDL	40.160893	57.559753	Europe/Moscow	0
2613	Iasi Airport	Iasi	Romania	RO	IAS	LRIA	27.616993	47.176988	Europe/Bucharest	0
2614	Ibadan Airport	Ibadan	Nigeria	NG	IBA	DNIB	3.976361	7.360181	Africa/Lagos	0
2615	General Villamil Airport	Isabela Island	Ecuador	EC	IBB	SEII	-90.953056	-0.942778	Pacific/Galapagos	0
2616	Ibague Airport	Ibague	Colombia	CO	IBE	SKIB	-75.138579	4.423948	America/Bogota	0
2617	Iron Bridge Airport	Japal Camp	Australia	AU	IBM	YIBO	118.88146	-21.282759	Australia/Perth	0
2618	Iberia Airport	Iberia	Peru	PE	IBP	SPBR	-69.583333	-11.366667	America/Lima	0
2619	Ibaraki Airport	Omitami	Japan	JP	IBR	RJAH	140.414722	36.181667	Asia/Tokyo	0
2620	Ibiza Airport	Ibiza	Spain and Canary Islands	ES	IBZ	LEIB	1.367803	38.876595	Europe/Madrid	0
2621	Icabaru Airport	Icabaru	Venezuela	VE	ICA	SVIC	-61.733333	4.333333	America/Caracas	0
2622	Cicia Airport	Cicia	Fiji	FJ	ICI	NFCI	-179.341929	-17.743709	Pacific/Fiji	0
2623	Schenk Field	Clarinda	United States	US	ICL	KICL	-95.026542	40.721862	America/Chicago	0
2624	Seoul Incheon International Airport	Seoul	Republic of Korea	KR	ICN	RKSI	126.441961	37.458764	Asia/Seoul	0
2625	Nicaro Airport	Nicaro	Cuba	CU	ICR	MUNC	-75.975	20.983333	America/Havana	0
2626	Wichita Dwight D. Eisenhower National Airport	Wichita	United States	US	ICT	KICT	-97.428957	37.653044	America/Chicago	0
2627	Idaho Falls Regional Airport	Idaho Falls	United States	US	IDA	KIDA	-112.06751	43.514854	America/Denver	0
2628	Idre Airport	Idre	Sweden	SE	IDB	ESUE	12.683333	61.866667	Europe/Stockholm	0
2629	Idiofa Airport	Idiofa	The Democratic Republic of The Congo	CD	IDF	FZCB	19.6	-5.033333	Africa/Kinshasa	0
2630	Ida Grove Municipal Airport	Ida Grove	United States	US	IDG	KIDG	-95.466667	42.35	America/Chicago	0
2631	Indiana County Airport	Indiana	United States	US	IDI	KIDI	-79.105499	40.632198	America/New_York	0
2632	Indulkana Airport	Indulkana	Australia	AU	IDK	YIDK	133.325	-26.966667	Australia/Adelaide	0
2633	Santa Isabel do Morro Airport	Santa Isabel do Morro	Brazil	BR	IDO	SWIY	-50.666667	-11.566667	America/Belem	0
2634	Independence Airport	Independence	United States	US	IDP	KIDP	-95.7	37.233333	America/Chicago	0
2635	Devi Ahilya Bai Holkar Airport	Indore	India	IN	IDR	VAID	75.808227	22.72715	Asia/Kolkata	0
2636	Ile 'd' Yeu Airport	Ile 'd' Yeu	France	FR	IDY	LFEY	-2.388694	46.717867	Europe/Paris	0
2637	Zielona Gora-Babimost Airport	Zielona Gora	Poland	PL	IEG	EPZG	15.798611	52.138611	Europe/Warsaw	0
2638	Iejima Airport	Iejima	Japan	JP	IEJ	RORE	127.789093	26.723887	Asia/Tokyo	0
2639	Kyiv International Airport	Kiev	Ukraine	UA	IEV	UKKK	30.450833	50.401944	Europe/Kiev	0
2640	Iowa Falls Airport	Iowa Falls	United States	US	IFA	KIFA	-93.266667	42.516667	America/Chicago	0
2641	Iffley Airport	Iffley	Australia	AU	IFF	YIFY	141.216667	-18.9	Australia/Brisbane	0
2642	Isafjordur Airport	Isafjordur	Iceland	IS	IFJ	BIIS	-23.132778	66.059722	Atlantic/Reykjavik	0
2643	Innisfail Airport	Innisfail	Australia	AU	IFL	YIFL	146.016667	-17.55	Australia/Brisbane	0
2644	Isfahan International Airport	Isfahan	Iran	IR	IFN	OIFM	51.876381	32.745686	Asia/Tehran	0
2645	Ivano-Frankovsk Airport	Ivano-Frankovsk	Ukraine	UA	IFO	UKLI	24.707566	48.887535	Europe/Kiev	0
2646	Laughlin Bullhead International Airport	Bullhead City	United States	US	IFP	KIFP	-114.557624	35.157684	America/Phoenix	0
2647	Inagua Airport	Inagua	Bahamas	BS	IGA	MYIG	-73.666667	20.983333	America/Nassau	0
2648	Igdir Airport	Igdir	Turkiye	TR	IGD	LTCT	43.879723	39.974445	Europe/Istanbul	0
2649	Iguela Airport	Iguela	Gabon	GA	IGE	FOOI	9.316667	-1.916667	Africa/Libreville	0
2650	Igiugig Airport	Igiugig	United States	US	IGG	PAIG	-155.901772	59.324042	America/Anchorage	0
2651	Ingham Airport	Ingham	Australia	AU	IGH	YIGM	146.166667	-18.716667	Australia/Brisbane	0
2652	Cigli Air Base	Izmir	Turkiye	TR	IGL	LTBL	27.159444	38.318889	Europe/Istanbul	0
2653	Kingman Airport	Kingman	United States	US	IGM	KIGM	-113.94	35.256667	America/Phoenix	0
2654	Maria Cristina Airport	Iligan	Philippines	PH	IGN	RPMI	124.214167	8.131111	Asia/Manila	0
2655	Chigorodo Airport	Chigorodo	Colombia	CO	IGO	SKIG	-76.686667	7.681667	America/Bogota	0
2656	Cataratas del Iguazu International Airport	Iguazu	Argentina	AR	IGR	SARI	-54.476347	-25.731505	America/Argentina/Buenos_Aires	0
2657	Cataratas International Airport	Iguassu Falls	Brazil	BR	IGU	SBFI	-54.488822	-25.597937	America/Sao_Paulo	0
2658	Inhaca Airport	Inhaca	Mozambique	MZ	IHC	FQIA	32.933333	-26	Africa/Maputo	0
2659	Qishn Airport	Qishn	Republic of Yemen	YE	IHN	OYQN	50.05	15.05	Asia/Aden	0
2660	Ihosy Airport	Ihosy	Madagascar	MG	IHO	FMSI	46.116667	-22.416667	Indian/Antananarivo	0
2661	Iranshahr Airport	Iranshahr	Iran	IR	IHR	OIZI	60.720001	27.236099	Asia/Tehran	0
2662	Inishmaan Airport	Inishmaan	Ireland	IE	IIA	EIMN	-9.533333	53.083333	Europe/Dublin	0
2663	Nissan Island Airport	Nissan Island	Papua New Guinea	PG	IIS	AYIA	154.223999	-4.496207	Pacific/Bougainville	0
2664	Izhevsk Airport	Izhevsk	Russian Federation	RU	IJK	USII	53.456529	56.830447	Europe/Samara	0
2665	J. Batista Bos Filho Airport	Ijui	Brazil	BR	IJU	SSIJ	-53.8466	-28.3687	America/Sao_Paulo	0
2666	Jacksonville Municipal Airport	Jacksonville	United States	US	IJX	KIJX	-90.237222	39.774167	America/Chicago	0
2667	Imam Khomeini International Airport	Tehran	Iran	IR	IKA	OIIE	51.1548	35.408632	Asia/Tehran	0
2668	Wilkes County Airport	Wilkesboro	United States	US	IKB	KUKF	-81.098297	36.222801	America/New_York	0
2669	Ikerasak Heliport	Ikerasak	Greenland	GL	IKE	BGIA	-51.303084	70.498145	America/Godthab	0
2670	Iki Airport	Iki	Japan	JP	IKI	RJDB	129.788333	33.745556	Asia/Tokyo	0
2671	Greater Kankakee Airport	Kankakee	United States	US	IKK	KIKK	-88.25	41.383333	America/Chicago	0
2672	Ikela Airport	Ikela	The Democratic Republic of The Congo	CD	IKL	FZGV	23.666667	-1.666667	Africa/Kinshasa	0
2673	Nikolski Air Station	Nikolski	United States	US	IKO	PAKO	-168.85	52.941667	America/Anchorage	0
2674	Inkerman Airport	Inkerman	Australia	AU	IKP	YIKM	141.5	-16.25	Australia/Brisbane	0
2675	Tiksi Airport	Tiksi	Russian Federation	RU	IKS	UEST	128.9	71.7	Asia/Yakutsk	0
2676	Irkutsk International Airport	Irkutsk	Russian Federation	RU	IKT	UIII	104.356071	52.273309	Asia/Irkutsk	0
2677	Issyk-Kul International Airport	Tamchy	Kyrgyzstan	KG	IKU	UCFL	76.713056	42.588056	Asia/Bishkek	0
2678	Illaga Airport	Illaga	Indonesia	ID	ILA	WABL	137.6242	-3.9769	Asia/Jayapura	0
2679	Skylark Field	Killeen	United States	US	ILE	KILE	-97.686667	31.086389	America/Chicago	0
2680	Ilford Airport	Ilford	Canada	CA	ILF	CZBD	-95.616667	56.066667	America/Winnipeg	0
2681	New Castle Airport	Wilmington	United States	US	ILG	KILG	-75.6075	39.678333	America/New_York	0
2682	Illesheim Air Base	Illesheim	Germany	DE	ILH	ETIK	10.3881	49.4739	Europe/Berlin	0
2683	Iliamna Airport	Iliamna	United States	US	ILI	PAIL	-154.908568	59.755502	America/Anchorage	0
2684	Ilaka Airport	Ilaka	Madagascar	MG	ILK	FMMQ	47.166667	-20.333333	Indian/Antananarivo	0
2685	Willmar Airport	Willmar	United States	US	ILL	KILL	-95.085278	45.115278	America/Chicago	0
2686	Wilmington International Airport	Wilmington	United States	US	ILM	KILM	-77.910627	34.267052	America/New_York	0
2687	Wilmington Airpark	Wilmington	United States	US	ILN	KILN	-83.791092	39.433342	America/New_York	0
2688	Iloilo International Airport	Iloilo	Philippines	PH	ILO	RPVI	122.493366	10.833034	Asia/Manila	0
2689	Ile Des Pins Airport	Ile Des Pins	New Caledonia	NC	ILP	NWWE	167.4475	-22.589722	Pacific/Noumea	0
2690	Ilo Airport	Ilo	Peru	PE	ILQ	SPLO	-71.343938	-17.694932	America/Lima	0
2691	Ilorin International Airport	Ilorin	Nigeria	NG	ILR	DNIL	4.493616	8.436093	Africa/Lagos	0
2692	Kilaguni Airport	Kilaguni	Kenya	KE	ILU	HKKL	38.072049	-2.906443	Africa/Nairobi	0
2693	Glenegedale Airport	Islay	United Kingdom	GB	ILY	EGPI	-6.254167	55.681944	Europe/London	0
2694	Zilina Airport	Zilina	Slovakia	SK	ILZ	LZZI	18.613501	49.231499	Europe/Bratislava	0
2695	Imbaimadai Airport	Imbaimadai	Guyana	GY	IMB	SYIB	-60.283333	5.716667	America/Guyana	0
2696	Imphal Municipal Airport	Imphal	India	IN	IMF	VEIM	93.897063	24.76457	Asia/Kolkata	0
2697	Simikot Airport	Simikot	Nepal	NP	IMK	VNST	81.818705	29.970565	Asia/Kathmandu	0
2698	Imperial Airport	Imperial	United States	US	IML	KIML	-101.65	40.516667	America/Denver	0
2699	Immokalee Airport	Immokalee	United States	US	IMM	KIMM	-81.416667	26.416667	America/New_York	0
2700	Zemio Airport	Zemio	Central African Republic	CF	IMO	FEFZ	25.083333	5.033333	Africa/Bangui	0
2701	Imperatriz Airport	Imperatriz	Brazil	BR	IMP	SBIZ	-47.480556	-5.531944	America/Belem	0
2702	Maku Airport	Maku	Iran	IR	IMQ	OITU	44.925278	39.1925	Asia/Tehran	0
2703	Ford Airport	Iron Mountain	United States	US	IMT	KIMT	-88.114167	45.815556	America/Chicago	0
2704	Yinchuan Hedong International Airport	Yinchuan	China	CN	INC	ZLIC	106.388059	38.323031	Asia/Shanghai	0
2705	Indianapolis International Airport	Indianapolis	United States	US	IND	KIND	-86.292991	39.71627	America/Indiana/Indianapolis	0
2706	In Guezzam Airport	In Guezzam	Algeria	DZ	INF	DATG	5.749467	19.560488	Africa/Algiers	0
2707	Lago Argentino Airport	Lago Argentino	Argentina	AR	ING	SAWA	-72.666667	-50.583333	America/Argentina/Buenos_Aires	0
2708	Inhambane Airport	Inhambane	Mozambique	MZ	INH	FQIN	35.408333	-23.874444	Africa/Maputo	0
2709	Nis Constantine the Great Airport	Nis	Republic of Serbia	RS	INI	LYNI	21.86548	43.33717	Europe/Belgrade	0
2710	Injune Airport	Injune	Australia	AU	INJ	YINJ	148.533333	-25.883333	Australia/Brisbane	0
2711	Wink Airport	Wink	United States	US	INK	KINK	-103.15	31.75	America/Chicago	0
2712	Falls International Airport	International Falls	United States	US	INL	KINL	-93.404167	48.563056	America/Chicago	0
2713	Innamincka Airport	Innamincka	Australia	AU	INM	YINN	140.733333	-27.75	Australia/Adelaide	0
2714	Innsbruck Airport	Innsbruck	Austria	AT	INN	LOWI	11.351467	47.25745	Europe/Vienna	0
2715	Inongo Airport	Inongo	The Democratic Republic of The Congo	CD	INO	FZBA	18.279167	-1.95	Africa/Kinshasa	0
2716	Inisheer Airport	Inisheer	Ireland	IE	INQ	EIIR	-9.433333	53.033333	Europe/Dublin	0
2717	Af Aux Airport	Indian Springs	United States	US	INS	KINS	-115.666667	36.583333	America/Los_Angeles	0
2718	Smith-Reynolds Airport	Winston-Salem	United States	US	INT	KINT	-80.225556	36.135278	America/New_York	0
2719	Nauru Island International Airport	Nauru Island	Nauru	NR	INU	ANYN	166.919023	-0.547451	Pacific/Nauru	0
2720	Inverness Airport	Inverness	United Kingdom	GB	INV	EGPE	-4.063738	57.539346	Europe/London	0
2721	Winslow Airport	Winslow	United States	US	INW	KINW	-110.725	35.024167	America/Phoenix	0
2722	Inanwatan Airport	Inanwatan	Indonesia	ID	INX	WASI	132.233333	-2.166667	Asia/Jayapura	0
2723	In Salah Airport	In Salah	Algeria	DZ	INZ	DAUI	2.511885	27.250807	Africa/Algiers	0
2724	Ioannina Airport	Ioannina	Greece	GR	IOA	LGIO	20.825833	39.696667	Europe/Athens	0
2725	Isle of Man Airport	Isle Of Man	Isle of Man	IM	IOM	EGNS	-4.633191	54.086795	Europe/London	0
2726	Impfondo Airport	Impfondo	Congo	CG	ION	FCOI	18.061944	1.613333	Africa/Brazzaville	0
2727	Isortoq Heliport	Isortoq	Greenland	GL	IOQ	BGIS	-38.977981	65.54665	America/Godthab	0
2728	Kilronan Airport	Inishmore	Ireland	IE	IOR	EIIM	-9.75	53.116667	Europe/Dublin	0
2729	Ilheus/Bahia-Jorge Amado Airport	Ilheus	Brazil	BR	IOS	SBIL	-39.033268	-14.815859	America/Belem	0
2730	Illorsuit Heliport	Illorsuit	Greenland	GL	IOT	BGLL	-53.555393	71.23977	America/Godthab	0
2731	Iowa City Airport	Iowa City	United States	US	IOW	KIOW	-91.533333	41.666667	America/Chicago	0
2732	Ipota Airport	Ipota	Vanuatu	VU	IPA	NVVI	169.183333	-18.75	Pacific/Efate	0
2733	Mataveri International Airport	Easter Island	Chile	CL	IPC	SCIP	-109.366667	-27.116667	Pacific/Easter	0
2734	Ipil Airport	Ipil	Philippines	PH	IPE	RPMV	122.583333	7.783333	Asia/Manila	0
2735	Ipiranga Airport	Ipiranga	Brazil	BR	IPG	SWII	-65.95	-3.216667	America/Porto_Velho	0
2736	Ipoh Airport	Ipoh	Malaysia	MY	IPH	WMKI	101.095833	4.566944	Asia/Kuala_Lumpur	0
2737	San Luis Airport	Ipiales	Colombia	CO	IPI	SKIP	-77.676418	0.858325	America/Bogota	0
2738	Imperial County Airport	Imperial	United States	US	IPL	KIPL	-115.574054	32.834832	America/Los_Angeles	0
2739	Usiminas Airport	Ipatinga	Brazil	BR	IPN	SBIP	-42.533333	-19.5	America/Sao_Paulo	0
2740	Lycoming County Airport	Williamsport	United States	US	IPT	KIPT	-76.920556	41.242222	America/New_York	0
2741	San Isidro del General Airport	San Isidro	Costa Rica	CR	IPZ	MRSI	-83.716667	9.366667	America/Costa_Rica	0
2742	Al Asad Air Base	Al Asad	Iraq	IQ	IQA	ORAA	42.4412	33.785599	Asia/Baghdad	0
2743	Qiemo Airport	Qiemo	China	CN	IQM	ZWCM	85.531552	38.144572	Asia/Shanghai	0
2744	Qingyang Airport	Qingyang	China	CN	IQN	ZLQY	107.6044	35.8001	Asia/Shanghai	0
2745	Diego Aracena International Airport	Iquique	Chile	CL	IQQ	SCDA	-70.178481	-20.547938	America/Santiago	0
2746	C.F. Secada Vignetta International Airport	Iquitos	Peru	PE	IQT	SPQT	-73.302838	-3.785098	America/Lima	0
2747	Kirakira Airport	Kirakira	Solomon Islands	SB	IRA	AGGK	161.833333	-10.5	Pacific/Guadalcanal	0
2748	Circle City Airport	Circle	United States	US	IRC	PACR	-144.063889	65.829167	America/Anchorage	0
2749	Ishurdi Airport	Ishurdi	Bangladesh	BD	IRD	VGIS	89.048828	24.153424	Asia/Dhaka	0
2750	Irece Airport	Irece	Brazil	BR	IRE	SNIC	-41.866667	-11.3	America/Belem	0
2751	Lockhart River Airport	Lockhart River	Australia	AU	IRG	YLHR	143.305822	-12.785644	Australia/Brisbane	0
2752	Nduli Airport	Iringa	United Republic of Tanzania	TZ	IRI	HTIR	35.751589	-7.676324	Africa/Dar_es_Salaam	0
2753	La Rioja Airport	La Rioja	Argentina	AR	IRJ	SANL	-66.783333	-29.383333	America/Argentina/Buenos_Aires	0
2754	Kirksville Municipal Airport	Kirksville	United States	US	IRK	KIRK	-92.543889	40.0925	America/Chicago	0
2755	Igrim Airport	Igrim	Russian Federation	RU	IRM	USHI	64.435751	63.199993	Asia/Yekaterinburg	0
2756	Birao Airport	Birao	Central African Republic	CF	IRO	FEFI	22.713889	10.186389	Africa/Bangui	0
2757	Matari Airport	Isiro	The Democratic Republic of The Congo	CD	IRP	FZJH	27.588333	2.8275	Africa/Lubumbashi	0
2758	Kirsch Municipal	Sturgis	United States	US	IRS	KIRS	-85.435278	41.816667	America/New_York	0
2759	Mount Isa Airport	Mount Isa	Australia	AU	ISA	YBMA	139.491792	-20.667637	Australia/Brisbane	0
2760	Islamabad International Airport	Islamabad	Pakistan	PK	ISB	OPIS	72.825	33.548333	Asia/Karachi	0
2761	Isles of Scilly Airport	Isles Of Scilly	United Kingdom	GB	ISC	EGHE	-6.291667	49.913333	Europe/London	0
2762	Isparta Suleyman Demirel Airport	Isparta	Turkiye	TR	ISE	LTFC	30.382222	37.866111	Europe/Istanbul	0
2763	Painushima Ishigaki Airport	Ishigaki	Japan	JP	ISG	ROIG	124.245538	24.390349	Asia/Tokyo	0
2764	Isisford Airport	Isisford	Australia	AU	ISI	YISF	144.423333	-24.263333	Australia/Brisbane	0
2765	Isla Mujeres Airport	Isla Mujeres	Mexico	MX	ISJ	MMIM	-86.741363	21.246669	America/Mexico_City	0
2766	Istanbul Airport	Istanbul	Turkiye	TR	IST	LTFM	28.741944	41.260278	Europe/Istanbul	0
2767	Kissimmee Gateway Airport	Kissimmee	United States	US	ISM	KISM	-81.435014	28.29093	America/New_York	0
2768	Sloulin Field International Airport	Williston	United States	US	ISN	KISN	-103.631886	48.175867	America/Chicago	0
2769	Kinston Regional Jetport	Kinston	United States	US	ISO	KISO	-77.616667	35.326667	America/New_York	0
2770	Long Island MacArthur Airport	Islip	United States	US	ISP	KISP	-73.097546	40.789314	America/New_York	0
2771	Schoolcraft County Airport	Manistique	United States	US	ISQ	KISQ	-86.25	45.95	America/New_York	0
2772	Wiscasset Airport	Wiscasset	United States	US	ISS	KIWI	-69.712601	43.961399	America/New_York	0
2773	Istanbul Airport	Istanbul	Turkiye	TR	ISL	LTBA	28.815278	40.976667	Europe/Istanbul	0
2774	Sulaimaniyah International Airport	Sulaimaniyah	Iraq	IQ	ISU	ORSU	45.302424	35.572389	Asia/Baghdad	0
2775	South Wood County Airport	Wisconsin Rapids	United States	US	ISW	KISW	-89.838889	44.360278	America/Chicago	0
2776	Itacoatiara Airport	Itacoatiara	Brazil	BR	ITA	SBIC	-58.416667	-3.133333	America/Porto_Velho	0
2777	Itaituba Airport	Itaituba	Brazil	BR	ITB	SBIH	-55.983333	-4.283333	America/Belem	0
2778	Ithaca Tompkins Regional Airport	Ithaca	United States	US	ITH	KITH	-76.463593	42.490342	America/New_York	0
2779	Itambacuri Airport	Itambacuri	Brazil	BR	ITI	SNYH	-41.5	-18	America/Sao_Paulo	0
2780	Osaka Itami International Airport	Osaka	Japan	JP	ITM	RJOO	135.441719	34.790975	Asia/Tokyo	0
2781	Itabuna Airport	Itabuna	Brazil	BR	ITN	SNHA	-39.3	-14.8	America/Belem	0
2782	Hilo International Airport	Hilo	United States	US	ITO	PHTO	-155.039628	19.714565	Pacific/Honolulu	0
2783	Itaqui Airport	Itaqui	Brazil	BR	ITQ	SSIQ	-56.55	-29.133333	America/Sao_Paulo	0
2784	Hanan Airport	Niue Island	Niue	NU	IUE	NIUE	-169.933333	-19.083333	Pacific/Niue	0
2785	Innarsuit Heliport	Innarsuit	Greenland	GL	IUI	BGIN	-56.011326	73.202364	America/Godthab	0
2786	Ilu Airport	Ilu	Indonesia	ID	IUL	WAVC	138.166667	-3.733333	Asia/Jayapura	0
2787	Ambanja Airport	Ambanja	Madagascar	MG	IVA	FMNZ	48.457778	-13.642222	Indian/Antananarivo	0
2788	Invercargill Airport	Invercargill	New Zealand	NZ	IVC	NZNV	168.321743	-46.415432	Pacific/Auckland	0
2789	Ivalo Airport	Ivalo	Finland	FI	IVL	EFIV	27.415556	68.611111	Europe/Helsinki	0
2790	Inverell Airport	Inverell	Australia	AU	IVR	YIVL	151.144681	-29.887945	Australia/Sydney	0
2791	Inverway Airport	Inverway	Australia	AU	IVW	YINW	129.633333	-17.833333	Australia/Darwin	0
2792	Ivanovo Yuzhny Airport	Ivanovo	Russian Federation	RU	IWA	UUBI	40.944546	56.942956	Europe/Moscow	0
2793	Gogebic County Airport	Ironwood	United States	US	IWD	KIWD	-90.131667	46.525556	America/Chicago	0
2794	Hagi-Iwami Airport	Masuda	Japan	JP	IWJ	RJOW	131.790278	34.676389	Asia/Tokyo	0
2795	Iwoto (Iwo Jima) Air Base	Iwoto (Iwo Jima)	Japan	JP	IWO	RJAW	141.316667	24.783333	Asia/Tokyo	0
2796	West Houston Airport	Houston	United States	US	IWS	KIWS	-95.666667	29.816667	America/Chicago	0
2797	Agartala Airport	Agartala	India	IN	IXA	VEAT	91.244513	23.8926	Asia/Kolkata	0
2798	Bagdogra Airport	Bagdogra	India	IN	IXB	VEBD	88.324816	26.68488	Asia/Kolkata	0
2799	Chandigarh Airport	Chandigarh	India	IN	IXC	VICG	76.788039	30.676809	Asia/Kolkata	0
2800	Allahabad Airport	Allahabad	India	IN	IXD	VEAB	81.733876	25.440072	Asia/Kolkata	0
2801	Mangalore Airport	Mangalore	India	IN	IXE	VOML	74.890141	12.963543	Asia/Kolkata	0
2802	Belgaum Airport	Belgaum	India	IN	IXG	VOBM	74.618333	15.858611	Asia/Kolkata	0
2803	Kailashahar Airport	Kailashahar	India	IN	IXH	VEKR	92.008889	24.307222	Asia/Kolkata	0
2804	Lilabari Airport	Lilabari	India	IN	IXI	VELR	94.092061	27.288274	Asia/Kolkata	0
2805	Satwari Airport	Jammu	India	IN	IXJ	VIJU	74.842824	32.68077	Asia/Kolkata	0
2806	Keshod Airport	Keshod	India	IN	IXK	VAKS	70.270833	21.319444	Asia/Kolkata	0
2807	Leh Airport	Leh	India	IN	IXL	VILH	77.547465	34.140351	Asia/Kolkata	0
2808	Madurai Airport	Madurai	India	IN	IXM	VOMD	78.089494	9.838571	Asia/Kolkata	0
2809	Khowai Airport	Khowai	India	IN	IXN	VEKW	91.603333	24.063889	Asia/Kolkata	0
2810	Pathankot Airport	Pathankot	India	IN	IXP	VIPK	75.634631	32.233889	Asia/Kolkata	0
2811	Kamalpur Airport	Kamalpur	India	IN	IXQ	VEKM	91.815556	24.1325	Asia/Kolkata	0
2812	Birsa Munda Airport	Ranchi	India	IN	IXR	VERC	85.322851	23.318192	Asia/Kolkata	0
2813	Kumbhirgram Airport	Silchar	India	IN	IXS	VEKU	92.979255	24.916017	Asia/Kolkata	0
2814	Pasighat Airport	Pasighat	India	IN	IXT	VEPG	95.335528	28.068259	Asia/Kolkata	0
2815	Chikkalthana Airport	Aurangabad	India	IN	IXU	VAAU	75.397207	19.866464	Asia/Kolkata	0
2816	Along Airport	Along	India	IN	IXV	VEAN	94.816667	28.2	Asia/Kolkata	0
2817	Sonari Airport	Jamshedpur	India	IN	IXW	VEJS	86.168889	22.813056	Asia/Kolkata	0
2818	Bidar Airport	Bidar	India	IN	IXX	VOBR	77.487142	17.908081	Asia/Kolkata	0
2819	Kandla Airport	Kandla	India	IN	IXY	VAKE	70.104167	23.111111	Asia/Kolkata	0
2820	Port Blair Airport	Port Blair	India	IN	IXZ	VOPB	92.732267	11.650083	Asia/Kolkata	0
2821	Kern County Airport	Inyokern	United States	US	IYK	KIYK	-117.829167	35.656667	America/Los_Angeles	0
2822	Zona da Mata Regional Airport	Juiz de Fora	Brazil	BR	IZA	SBZM	-43.173056	-21.513056	America/Sao_Paulo	0
2823	Izumo Airport	Izumo	Japan	JP	IZO	RJOC	132.885751	35.41485	Asia/Tokyo	0
2824	Ixtepec Airport	Ixtepec	Mexico	MX	IZT	MMIT	-95.108333	16.569167	America/Mexico_City	0
2825	Jalalabad Airport	Jalalabad	Afghanistan	AF	JAA	OAJL	70.496824	34.401257	Asia/Kabul	0
2826	Jabiru Airport	Jabiru	Australia	AU	JAB	YJAB	132.891944	-12.659722	Australia/Darwin	0
2827	Jackson Hole Airport	Jackson	United States	US	JAC	KJAC	-110.736131	43.602807	America/Denver	0
2828	Jandakot Airport	Jandakot	Australia	AU	JAD	YPJT	115.883333	-32.083333	Australia/Perth	0
2829	Shumba Airport	Jaen	Peru	PE	JAE	SPJE	-78.773624	-5.594444	America/Lima	0
2830	Kankesanturai Airport	Jaffna	Sri Lanka	LK	JAF	VCCJ	80.075	9.791667	Asia/Colombo	0
2831	Jacobabad Airport	Jacobabad	Pakistan	PK	JAG	OPJA	68.45	28.3	Asia/Karachi	0
2832	Jaipur Airport	Jaipur	India	IN	JAI	VIJP	75.800995	26.822004	Asia/Kolkata	0
2833	Jacmel Airport	Jacmel	Haiti	HT	JAK	MTJA	-72.518611	18.240556	America/Port-au-Prince	0
2834	El Lencero Airport	Xalapa	Mexico	MX	JAL	MMJA	-96.791405	19.475468	America/Mexico_City	0
2835	Jambol Airport	Jambol	Bulgaria	BG	JAM	LBIA	26.483333	42.516667	Europe/Sofia	0
2836	Jackson-Evers International Airport	Jackson	United States	US	JAN	KJAN	-90.074955	32.309896	America/Chicago	0
2837	Jahrom Airport	Jahrom	Iran	IR	JAR	OISJ	53.579188	28.58668	Asia/Tehran	0
2838	Jasper County-Bell Field	Jasper	United States	US	JAS	KJAS	-94.034907	30.885701	America/Chicago	0
2839	Jauja Airport	Jauja	Peru	PE	JAU	SPJJ	-75.25	-11.75	America/Lima	0
2840	Ilulissat Airport	Ilulissat	Greenland	GL	JAV	BGJN	-51.059911	69.241856	America/Godthab	0
2841	Jacksonville International Airport	Jacksonville	United States	US	JAX	KJAX	-81.683053	30.491254	America/New_York	0
2842	Noto Hadinegoro Airport	Jember	Indonesia	ID	JBB	WARE	113.695324	-8.242432	Asia/Jakarta	0
2843	Dr. Joaquin Balaguer International Airport	Santo Domingo	Dominican Republic	DO	JBQ	MDJB	-69.985611	18.572517	America/Santo_Domingo	0
2844	Jonesboro Airport	Jonesboro	United States	US	JBR	KJBR	-90.646418	35.831711	America/Chicago	0
2845	Joacaba Airport	Joacaba	Brazil	BR	JCB	SSJA	-51.516667	-27.166667	America/Sao_Paulo	0
2846	Qasigiannguit Heliport	Qasigiannguit	Greenland	GL	JCH	BGCH	-51.173574	68.822755	America/Godthab	0
2847	Julia Creek Airport	Julia Creek	Australia	AU	JCK	YJLC	141.7	-20.583333	Australia/Brisbane	0
2848	Jacobina Airport	Jacobina	Brazil	BR	JCM	SNJB	-40.516667	-11.183333	America/Belem	0
2849	Jacareacanga Airport	Jacareacanga	Brazil	BR	JCR	SBEK	-57.533333	-5.983333	America/Porto_Velho	0
2850	Kimble County Airport	Junction	United States	US	JCT	KJCT	-99.766667	30.483333	America/Chicago	0
2851	Ceuta Heliport	Ceuta	Spain and Canary Islands	ES	JCU	GECE	-5.30621	35.892569	Africa/Ceuta	0
2852	Johnson Airport	Johnson	United States	US	JCY	KJCY	-98.416667	30.283333	America/Chicago	0
2853	Francisco De Assis Airport	Juiz De Fora	Brazil	BR	JDF	SBJF	-43.333333	-21.75	America/Sao_Paulo	0
2854	Jeongseok Airport	Jeongseok	Republic of Korea	KR	JDG	RKPD	126.71306	33.39833	Asia/Seoul	0
2855	Jodhpur Airport	Jodhpur	India	IN	JDH	VIJO	73.050552	26.263948	Asia/Kolkata	0
2856	Jordan Airport	Jordan	United States	US	JDN	KJDN	-106.883333	47.316667	America/Denver	0
2857	Orlando Bezerra de Menezes Airport	Juazeiro Do Norte	Brazil	BR	JDO	SBJU	-39.272404	-7.21559	America/Belem	0
2858	Heliport De Paris	Paris	France	FR	JDP	LFPI	2.283333	48.816667	Europe/Paris	0
2859	Jingdezhen Airport	Jingdezhen	China	CN	JDZ	ZSJD	117.17879	29.335489	Asia/Shanghai	0
2860	Jeddah King Abdulaziz International Airport	Jeddah	Saudi Arabia	SA	JED	OEJN	39.150579	21.670232	Asia/Riyadh	0
2861	Jeremie Airport	Jeremie	Haiti	HT	JEE	MTJE	-74.169722	18.662222	America/Port-au-Prince	0
2862	Jefferson City Memorial Airport	Jefferson City	United States	US	JEF	KJEF	-92.156389	38.592222	America/Chicago	0
2863	Aasiaat Airport	Aasiaat	Greenland	GL	JEG	BGAA	-52.75	68.7	America/Godthab	0
2864	Jeki Airstrip	Jeki	Zambia	ZM	JEK	FLJK	29.603555	-15.633121	Africa/Lusaka	0
2865	Jequie Airport	Jequie	Brazil	BR	JEQ	SNJK	-40.083333	-13.85	America/Belem	0
2866	Jersey Airport	Jersey	United Kingdom	GB	JER	EGJJ	-2.194344	49.205297	Europe/London	0
2867	New York John F. Kennedy International Airport	New York	United States	US	JFK	KJFK	-73.78817	40.642335	America/New_York	0
2868	Fremantle Heliport	Fremantle	Australia	AU	JFM	YFTL	115.75	-32.05	Australia/Perth	0
2869	Paamiut Airport	Paamiut	Greenland	GL	JFR	BGPT	-49.670949	62.014735	America/Godthab	0
2870	Govardhanpur Airport	Jamnagar	India	IN	JGA	VAJM	70.011944	22.463333	Asia/Kolkata	0
2871	Jiayuguan Airport	Jiayuguan	China	CN	JGN	ZLJQ	98.341401	39.856988	Asia/Shanghai	0
2872	Qeqertarsuaq Heliport	Qeqertarsuaq	Greenland	GL	JGO	BGGN	-53.514893	69.251163	America/Godthab	0
2873	Jinggangshan Airport	Ji'An	China	CN	JGS	ZSJA	114.737	26.856899	Asia/Shanghai	0
2874	Senai Airport	Johor Bharu	Malaysia	MY	JHB	WMKJ	103.667959	1.63668	Asia/Kuala_Lumpur	0
2875	Xishuangbanna Gasa Airport	Jinghong	China	CN	JHG	ZPJH	100.766454	21.973422	Asia/Shanghai	0
2876	Kapalua Airport	Kapalua	United States	US	JHM	PHJH	-156.675692	20.962194	Pacific/Honolulu	0
2877	Sisimiut Airport	Sisimiut	Greenland	GL	JHS	BGSS	-53.729291	66.951304	America/Godthab	0
2878	Jamestown Airport	Jamestown	United States	US	JHW	KJHW	-79.258056	42.150556	America/New_York	0
2879	Juina Airport	Juina	Brazil	BR	JIA	SWJN	-58.710139	-11.418348	America/Campo_Grande	0
2880	Djibouti-Ambouli International Airport	Djibouti	Djibouti	DJ	JIB	HDAM	43.149678	11.552361	Africa/Djibouti	0
2881	Jigiga Airport	Jijiga	Ethiopia	ET	JIJ	HAJJ	42.766667	9.366667	Africa/Addis_Ababa	0
2882	Ikaria Airport	Ikaria Island	Greece	GR	JIK	LGIK	26.333333	37.666667	Europe/Athens	0
2883	Jilin Airport	Jilin	China	CN	JIL	ZYJL	126.65	43.866667	Asia/Shanghai	0
2884	Jimma Airport	Jimma	Ethiopia	ET	JIM	HAJM	36.821111	7.654444	Africa/Addis_Ababa	0
2885	Jinja Airport	Jinja	Uganda	UG	JIN	HUJI	33.192222	0.456389	Africa/Kampala	0
2886	Jos Orno Imsula Airport	Tiakur	Indonesia	ID	JIO	WAPM	127.908115	-8.140276	Asia/Jayapura	0
2887	Jiri Airport	Jiri	Nepal	NP	JIR	VNJI	86.233333	27.633333	Asia/Kathmandu	0
2888	Jiujiang Airport	Jiujiang	China	CN	JIU	ZSJJ	115.966667	29.7	Asia/Shanghai	0
2889	Jiwani Airport	Jiwani	Pakistan	PK	JIW	OPJI	61.816667	25.083333	Asia/Karachi	0
2890	Jajao Airport	Santa Isabel Island	Solomon Islands	SB	JJA	AGJO	159.26666	-8.21666	Pacific/Guadalcanal	0
2891	Jericoacoara Airport	Cruz	Brazil	BR	JJD	SBJE	-40.358056	-2.906667	America/Belem	0
2892	Humberto Bortoluzzi Regional Airport	Jaguaruna	Brazil	BR	JJG	SBJA	-49.060278	-28.675278	America/Sao_Paulo	0
2893	Juanjui Airport	Juanjui	Peru	PE	JJI	SPJI	-76.716667	-7.15	America/Lima	0
2894	Mulika Lodge Airport	Meru	Kenya	KE	JJM	HKMK	38.195025	0.165006	Africa/Nairobi	0
2895	Quanzhou Jinjiang International Airport	Jinjiang	China	CN	JJN	ZSQZ	118.587293	24.802809	Asia/Shanghai	0
2896	Qaqortoq Heliport	Qaqortoq	Greenland	GL	JJU	BGJH	-46.033333	60.716667	America/Godthab	0
2897	Jonkoping Airport	Jonkoping	Sweden	SE	JKG	ESGJ	14.070497	57.750101	Europe/Stockholm	0
2898	Chios Airport	Chios	Greece	GR	JKH	LGHI	26.142335	38.345795	Europe/Athens	0
2899	Kalymnos Island National Airport	Kalymnos	Greece	GR	JKL	LGKY	26.940556	36.963333	Europe/Athens	0
2900	Janakpur Airport	Janakpur	Nepal	NP	JKR	VNJP	85.923889	26.708333	Asia/Kathmandu	0
2901	Landskrona Heliport	Landskrona	Sweden	SE	JLD	ESML	12.7	56.05	Europe/Stockholm	0
2902	Joplin Airport	Joplin	United States	US	JLN	KJLN	-94.497778	37.149722	America/Chicago	0
2903	Jabalpur Airport	Jabalpur	India	IN	JLR	VAJB	80.05194	23.17778	Asia/Kolkata	0
2904	Jales Airport	Jales	Brazil	BR	JLS	SDJL	-50.55	-20.166667	America/Sao_Paulo	0
2905	Marin County Airport	Sausalito	United States	US	JMC	KJMC	-122.509722	37.878611	America/Los_Angeles	0
2906	Mykonos Airport	Mykonos	Greece	GR	JMK	LGMK	25.344444	37.436111	Europe/Athens	0
2907	Jomsom Airport	Jomsom	Nepal	NP	JMO	VNJS	83.723397	28.781429	Asia/Kathmandu	0
2908	Jamestown Airport	Jamestown	United States	US	JMS	KJMS	-98.678333	46.93	America/Chicago	0
2909	Jiamusi Airport	Jiamusi	China	CN	JMU	ZYJM	130.455408	46.845396	Asia/Shanghai	0
2910	Januaria Airport	Januaria	Brazil	BR	JNA	SNJN	-44.385833	-15.474167	America/Sao_Paulo	0
2911	Johannesburg O.R. Tambo International Airport	Johannesburg	South Africa	ZA	JNB	FAOR	28.245999	-26.139164	Africa/Johannesburg	0
2912	Jining Da'an Airport	Jining	China	CN	JNG	ZSJG	116.742222	35.646944	Asia/Shanghai	0
2913	Junin Airport	Junin	Argentina	AR	JNI	SAAJ	-60.966667	-34.583333	America/Argentina/Buenos_Aires	0
2914	Duqm Jaaluni Airport	Duqm	Oman	OM	JNJ	OOJA	57.314302	19.48464	Asia/Muscat	0
2915	Nanortalik Heliport	Nanortalik	Greenland	GL	JNN	BGNN	-45.232961	60.141883	America/Godthab	0
2916	Narsaq Heliport	Narsaq	Greenland	GL	JNS	BGNS	-46.05	60.916667	America/Godthab	0
2917	Juneau International Airport	Juneau	United States	US	JNU	PAJN	-134.583395	58.359323	America/Anchorage	0
2918	Naxos Airport	Naxos, Cyclades Islands	Greece	GR	JNX	LGNX	25.383333	37.1	Europe/Athens	0
2919	Liaoning Province Airport	Jinzhou	China	CN	JNZ	ZYJZ	121.016667	41.116667	Asia/Shanghai	0
2920	Joensuu Airport	Joensuu	Finland	FI	JOE	EFJO	29.61354	62.656788	Europe/Helsinki	0
2921	Adisutjipto International Airport	Yogyakarta	Indonesia	ID	JOG	WAHH	110.43706	-7.785572	Asia/Jakarta	0
2922	Port St. Johns Airport	Port St. Johns	South Africa	ZA	JOH	FAPJ	29.533333	-31.616667	Africa/Johannesburg	0
2923	Lauro Carneiro de Loyola Airport	Joinville	Brazil	BR	JOI	SBJV	-48.797421	-26.224515	America/Sao_Paulo	0
2924	Jolo Airport	Jolo	Philippines	PH	JOL	RPMJ	121.00653	6.053552	Asia/Manila	0
2925	Njombe Airport	Njombe	United Republic of Tanzania	TZ	JOM	HTNJ	34.771389	-9.354444	Africa/Dar_es_Salaam	0
2926	Josephstaal Airport	Josephstaal	Papua New Guinea	PG	JOP	AYJS	145.005797	-4.743933	Pacific/Port_Moresby	0
2927	Jos Airport	Jos	Nigeria	NG	JOS	DNJO	8.893056	9.868056	Africa/Lagos	0
2928	Joliet Municipal Airport	Joliet	United States	US	JOT	KJOT	-88.083333	41.533333	America/Chicago	0
2929	Presidente Castro Pinto International Airport	Joao Pessoa	Brazil	BR	JPA	SBJP	-34.948159	-7.145357	America/Belem	0
2930	Pentagon Army Airport	Washington	United States	US	JPN	KJPN	-77.056079	38.874736	America/New_York	0
2931	Ji-Parana Airport	Ji-Parana	Brazil	BR	JPR	SBJI	-61.84667	-10.870556	America/Porto_Velho	0
2932	Qaarsut Airport	Qaarsut	Greenland	GL	JQA	BGUQ	-52.702778	70.731944	America/Godthab	0
2933	Jaque Airport	Jaque	Panama	PA	JQE	MPJE	-78.166667	7.5	America/Panama	0
2934	Kalaeloa Airport	Kapolei	United States	US	JRF	PHJR	-158.079899	21.310984	Pacific/Honolulu	0
2935	Rowriah Airport	Jorhat	India	IN	JRH	VEJT	94.184902	26.734483	Asia/Kolkata	0
2936	Juruena Airport	Juruena	Brazil	BR	JRN	SWJU	-58.488889	-10.305556	America/Campo_Grande	0
2937	Kilimanjaro International Airport	Kilimanjaro	United Republic of Tanzania	TZ	JRO	HTKJ	37.065475	-3.42537	Africa/Dar_es_Salaam	0
2938	Jaisalmer Airport	Jaisalmer	India	IN	JSA	VIJR	70.866864	26.891826	Asia/Kolkata	0
2939	Sitia Airport	Sitia	Greece	GR	JSH	LGST	26.116667	35.216667	Europe/Athens	0
2940	Skiathos Airport	Skiathos	Greece	GR	JSI	LGSK	23.5037	39.177101	Europe/Athens	0
2941	Jask Heliport	Jask	Iran	IR	JSK	OIZJ	57.799167	25.653611	Asia/Tehran	0
2942	Jose San de Martin Airport	Jose San de Martin	Argentina	AR	JSM	SAWS	-70.433333	-44.066667	America/Argentina/Buenos_Aires	0
2943	Jessore Airport	Jessore	Bangladesh	BD	JSR	VGJR	89.160648	23.17696	Asia/Dhaka	0
2944	Cambria County Airport	Johnstown	United States	US	JST	KJST	-78.834444	40.316667	America/New_York	0
2945	Maniitsoq Airport	Maniitsoq	Greenland	GL	JSU	BGMQ	-52.93537	65.412439	America/Godthab	0
2946	Syros Island Airport	Syros Island	Greece	GR	JSY	LGSO	24.95	37.423611	Europe/Athens	0
2947	Bauru-Arealva Airport	Baura-Arealva	Brazil	BR	JTC	SBAE	-49.07229	-22.165959	America/Sao_Paulo	0
2948	Santorini International Airport	Thira	Greece	GR	JTR	LGSR	25.475983	36.404262	Europe/Athens	0
2949	Astypalaia Airport	Astypalaia Island	Greece	GR	JTY	LGPL	26.366667	36.566667	Europe/Athens	0
2950	Juba International Airport	Juba	South Sudan	SS	JUB	HJJJ	31.602378	4.867235	Africa/Juba	0
2951	Juist Airport	Juist	Germany	DE	JUI	EDWJ	7.066667	53.683333	Europe/Berlin	0
2952	El Cadillal Airport	Jujuy	Argentina	AR	JUJ	SASJ	-65.083333	-24.4	America/Argentina/Buenos_Aires	0
2953	Ukkusissat Heliport	Ukkusissat	Greenland	GL	JUK	BGUT	-51.890016	71.049438	America/Godthab	0
2954	Juliaca Airport	Juliaca	Peru	PE	JUL	SPJL	-70.154444	-15.464167	America/Lima	0
2955	Jumla Airport	Jumla	Nepal	NP	JUM	VNJL	82.193278	29.274403	Asia/Kathmandu	0
2956	Jundah Airport	Jundah	Australia	AU	JUN	YJDA	143.066667	-24.833333	Australia/Brisbane	0
2957	Jurado Airport	Jurado	Colombia	CO	JUO	SKJU	-77.75	7.116667	America/Bogota	0
2958	Jurien Bay Airport	Jurien Bay	Australia	AU	JUR	YJUR	115.05	-30.266667	Australia/Perth	0
2959	Nuugaatsiaq Heliport	Nuugaatsiaq	Greenland	GL	JUU	BGNQ	-53.205038	71.538769	America/Godthab	0
2960	Upernavik Airport	Upernavik	Greenland	GL	JUV	BGUK	-56.130556	72.790278	America/Godthab	0
2961	Quzhou Airport	Quzhou, Zhejiang Province	China	CN	JUZ	ZSJU	118.833333	28.966667	Asia/Shanghai	0
2962	Ankavandra Airport	Ankavandra	Madagascar	MG	JVA	FMMK	45.283333	-18.8	Indian/Antananarivo	0
2963	Rock County Airport	Janesville	United States	US	JVL	KJVL	-89.016667	42.683333	America/Chicago	0
2964	Jwaneng Airport	Jwaneng	Botswana	BW	JWA	FBJW	24.666667	-24.6	Africa/Gaborone	0
2965	Zanjan Airport	Zanjan	Iran	IR	JWN	OITZ	48.369855	36.774417	Asia/Tehran	0
2966	Jixi Airport	Jixi	China	CN	JXA	ZYJX	130.996745	45.306082	Asia/Shanghai	0
2967	Jackson County Airport	Jackson	United States	US	JXN	KJXN	-84.461389	42.258889	America/New_York	0
2968	Jiroft Airport	Jiroft	Iran	IR	JYR	OIKJ	57.6703	28.7269	Asia/Tehran	0
2969	Jyvaskyla Airport	Jyvaskyla	Finland	FI	JYV	EFJY	25.681431	62.403623	Europe/Helsinki	0
2970	Kasama Airport	Kasama	Zambia	ZM	KAA	FLKS	31.13	-10.215833	Africa/Lusaka	0
2971	Kariba Airport	Kariba	Zimbabwe	ZW	KAB	FVKB	28.885278	-16.518333	Africa/Harare	0
2972	Kameshly Airport	Kameshli	Syrian Arab Republic	SY	KAC	OSKL	41.202684	37.031741	Asia/Damascus	0
2973	Kaduna Airport	Kaduna	Nigeria	NG	KAD	DNKA	7.440278	10.595833	Africa/Lagos	0
2974	Kake Sea Plane Base	Kake	United States	US	KAE	PAFE	-133.910261	56.961361	America/Anchorage	0
2975	Gangneung Air Base	Gangneung	Republic of Korea	KR	KAG	RKNN	128.943617	37.753403	Asia/Seoul	0
2976	Kaieteur Airport	Kaieteur	Guyana	GY	KAI	SYKA	-59.490468	5.169627	America/Guyana	0
2977	Kajaani Airport	Kajaani	Finland	FI	KAJ	EFKI	27.688889	64.277778	Europe/Helsinki	0
2978	Kaltag Airport	Kaltag	United States	US	KAL	PAKV	-158.736111	64.321944	America/Anchorage	0
2979	Mallam Aminu Kano International Airport	Kano	Nigeria	NG	KAN	DNKN	8.522271	12.045549	Africa/Lagos	0
2980	Sault Ste Marie Municipal Airport	Sault Ste Marie	United States	US	SSM	KANJ	-84.368275	46.479166	America/New_York	0
2981	Kuusamo Airport	Kuusamo	Finland	FI	KAO	EFKS	29.233889	65.990278	Europe/Helsinki	0
2982	Kapanga Airport	Kapanga	The Democratic Republic of The Congo	CD	KAP	FZSK	22.666667	-8.5	Africa/Lubumbashi	0
2983	Kamarang Airport	Kamarang	Guyana	GY	KAR	SYKM	-60.616292	5.869577	America/Guyana	0
2984	Karasburg Airport	Karasburg	Namibia	NA	KAS	FYKB	18.733333	-28	Africa/Windhoek	0
2985	Kaitaia Airport	Kaitaia	New Zealand	NZ	KAT	NZKT	173.285414	-35.066285	Pacific/Auckland	0
2986	Kauhava Airport	Kauhava	Finland	FI	KAU	EFKA	23.083333	63.1	Europe/Helsinki	0
2987	Kavanayen Airport	Kavanayen	Venezuela	VE	KAV	SVKA	-61.766667	5.666667	America/Caracas	0
2988	Kawthaung Airport	Kawthaung	Myanmar	MM	KAW	VYKT	98.516667	10.05	Asia/Yangon	0
2989	Kalbarri Airport	Kalbarri	Australia	AU	KAX	YKBR	114.260524	-27.691928	Australia/Perth	0
2990	Wakaya Island Airport	Wakaya Island	Fiji	FJ	KAY	NFNW	179.009933	-17.628455	Pacific/Fiji	0
2991	Kau Airport	Kau	Indonesia	ID	KAZ	WAEK	127.866667	1.166667	Asia/Jayapura	0
2992	Kabala Airport	Kabala	Sierra Leone	SL	KBA	GFKB	-12	9.333333	Africa/Freetown	0
2993	Kirkimbie Airport	Kirkimbie	Australia	AU	KBB	YKIR	129.216667	-17.766667	Australia/Darwin	0
2994	Kimberley Downs Airport	Kimberley Downs	Australia	AU	KBD	YKBS	124.35	-17.333333	Australia/Perth	0
2995	Karubaga Airport	Karubaga	Indonesia	ID	KBF	WAVG	138.4797	-3.6869	Asia/Jayapura	0
2996	Kabalega Falls Airport	Kabalega Falls	Uganda	UG	KBG	HUKF	31.500894	2.329142	Africa/Kampala	0
2997	Buzwagi Airport	Kahama	United Republic of Tanzania	TZ	KBH	HTKH	32.687081	-3.847053	Africa/Dar_es_Salaam	0
2998	Kribi Airport	Kribi	Cameroon	CM	KBI	FKKB	9.916667	2.95	Africa/Douala	0
2999	King Canyon Airport	Kings Canyon	Australia	AU	KBJ	YKCA	131.494444	-24.25	Australia/Darwin	0
3000	Kabul International Airport	Kabul	Afghanistan	AF	KBL	OAKB	69.211521	34.560692	Asia/Kabul	0
3001	Kabinda Airport	Kabinda	The Democratic Republic of The Congo	CD	KBN	FZWT	24.533333	-6.116667	Africa/Lubumbashi	0
3002	Kabalo Airport	Kabalo	The Democratic Republic of The Congo	CD	KBO	FZRM	26.916667	-6.088056	Africa/Lubumbashi	0
3003	Boryspil International Airport	Kiev/Kyiv	Ukraine	UA	KBP	UKBB	30.895207	50.341244	Europe/Kiev	0
3004	Kasungu Airport	Kasungu	Malawi	MW	KBQ	FWKG	13.016667	-33.466667	Africa/Blantyre	0
3005	Sultan Ismail Petra Airport	Kota Bharu	Malaysia	MY	KBR	WMKC	102.290915	6.17057	Asia/Kuala_Lumpur	0
3006	Bo Airport	Bo	Sierra Leone	SL	KBS	GFBO	-11.761944	7.943889	Africa/Freetown	0
3007	Gusti Syamsir Alam Airport	Kotabaru	Indonesia	ID	KBU	WAOK	116.165701	-3.295796	Asia/Makassar	0
3008	Krabi Airport	Krabi	Thailand	TH	KBV	VTSG	98.980619	8.097281	Asia/Bangkok	0
3009	Kambuaya Airport	Kambuaya	Indonesia	ID	KBX	WASU	132.25	-1	Asia/Jayapura	0
3010	Streaky Bay Airport	Streaky Bay	Australia	AU	KBY	YKBY	134	-33	Australia/Adelaide	0
3011	Kaikoura Airport	Kaikoura	New Zealand	NZ	KBZ	NZKI	173.600086	-42.42619	Pacific/Auckland	0
3012	Quici Airport	Kuqa	China	CN	KCA	ZWKC	82.98694	41.71806	Asia/Shanghai	0
3013	Kamur Airport	Kamur	Indonesia	ID	KCD	WAKM	138.716667	-6.2	Asia/Jayapura	0
3014	Collinsville Airport	Collinsville	Australia	AU	KCE	YCSV	147.866667	-20.55	Australia/Brisbane	0
3015	Kadanwari Airport	Kadanwari	Pakistan	PK	KCF	OPKW	69.152835	27.200146	Asia/Karachi	0
3016	Kuching International Airport	Kuching	Malaysia	MY	KCH	WBGG	110.340833	1.484167	Asia/Kuala_Lumpur	0
3017	Koolan Central Airport	Koolan Island	Australia	AU	KCI	YKLC	123.779946	-16.128389	Australia/Perth	0
3018	Kirensk Airport	Kirensk	Russian Federation	RU	KCK	UIKK	108.060002	57.77	Asia/Irkutsk	0
3019	Kahramanmaras Airport	Kahramanmaras	Turkiye	TR	KCM	LTCN	36.950556	37.534444	Europe/Istanbul	0
3020	Cengiz Topel Airport	Izmit	Turkiye	TR	KCO	LTBQ	30.083336	40.735028	Europe/Istanbul	0
3021	Chignik Lake Airport	Chignik	United States	US	KCQ	PAJC	-158.777778	56.261111	America/Anchorage	0
3022	Kings Creek Station Airport	Kings Creek Station	Australia	AU	KCS	YKCS	131.683333	-24.383333	Australia/Darwin	0
3023	Koggala Airport	Koggala	Sri Lanka	LK	KCT	VCCK	80.319743	5.993832	Asia/Colombo	0
3024	Masindi Airport	Masindi	Uganda	UG	KCU	HUMI	31.716667	1.683333	Africa/Kampala	0
3025	Chennault International Airport	Lake Charles	United States	US	CWF	KCWF	-93.153193	30.220827	America/Chicago	0
3026	Kochi Ryoma Airport	Kochi	Japan	JP	KCZ	RJOK	133.674852	33.547689	Asia/Tokyo	0
3027	Kolda Airport	Kolda	Senegal	SN	KDA	GOGK	-14.968835	12.898835	Africa/Dakar	0
3028	Kambalda Airport	Kambalda	Australia	AU	KDB	YKBL	120	-30	Australia/Perth	0
3029	Kandi Airport	Kandi	Benin	BJ	KDC	DBBK	2.916667	11.116667	Africa/Porto-Novo	0
3030	Khuzdar Airport	Khuzdar	Pakistan	PK	KDD	OPKH	66.630556	27.780556	Asia/Karachi	0
3031	Kandahar Airport	Kandahar	Afghanistan	AF	KDH	OAKN	65.8475	31.506944	Asia/Kabul	0
3032	Haluoleo Airport	Kendari	Indonesia	ID	KDI	WAWW	122.418851	-4.081461	Asia/Makassar	0
3033	Ndjole Airport	Ndjole	Gabon	GA	KDJ	FOGJ	10.766667	-0.15	Africa/Libreville	0
3034	Kodiak Municipal Airport	Kodiak	United States	US	KDK	PAKD	-152.37	57.807222	America/Anchorage	0
3035	Kardla Airport	Kardla	Estonia	EE	KDL	EEKA	22.824971	58.994917	Europe/Tallinn	0
3036	Kaadedhdhoo Airport	Kaadedhdhoo	Maldives	MV	KDM	VRMT	72.995613	0.488033	Indian/Maldives	0
3037	Ndende Airport	Ndende	Gabon	GA	KDN	FOGE	11.166667	-2.5	Africa/Libreville	0
3038	Kadhdhoo Airport	Kadhdhoo	Maldives	MV	KDO	VRMK	73.519787	1.858339	Indian/Maldives	0
3039	Kamphangsaen Airport	Kamphangsaen	Thailand	TH	KDT	VTBK	99.916667	14.1	Asia/Bangkok	0
3040	Skardu Airport	Skardu	Pakistan	PK	KDU	OPSD	75.538618	35.333008	Asia/Karachi	0
3041	Kandavu Airport	Kandavu	Fiji	FJ	KDV	NFKD	178.156073	-19.053969	Pacific/Fiji	0
3042	Kadugli Airport	Kadugli	Sudan	SD	KDX	HSLI	29.701099	11.38	Africa/Khartoum	0
3043	Kerki International Airport	Kerki	Turkmenistan	TM	KEA	UTAE	65.135306	37.822201	Asia/Ashgabat	0
3044	Kasenga Airport	Kasenga	The Democratic Republic of The Congo	CD	KEC	FZQG	28.75	-10.333333	Africa/Lubumbashi	0
3045	Kaedi Airport	Kaedi	Mauritania	MR	KED	GQNK	-13.507778	16.161389	Africa/Nouakchott	0
3046	Kelle Airport	Kelle	Congo	CG	KEE	FCOK	14.533333	-0.083333	Africa/Brazzaville	0
3047	Keflavik International Airport	Reykjavik	Iceland	IS	KEF	BIKF	-22.624283	63.997765	Atlantic/Reykjavik	0
3048	Kepi Airport	Kepi	Indonesia	ID	KEI	WAKP	139.333333	-6.566667	Asia/Jayapura	0
3049	Kemerovo Airport	Kemerovo	Russian Federation	RU	KEJ	UNEE	86.116226	55.280569	Asia/Novokuznetsk	0
3050	Holtenau Airport	Kiel	Germany	DE	KEL	EDHK	10.143333	54.380833	Europe/Berlin	0
3051	Kemi/Tornio Airport	Kemi/Tornio	Finland	FI	KEM	EFKE	24.57677	65.780057	Europe/Helsinki	0
3052	Kenema Airport	Kenema	Sierra Leone	SL	KEN	GFKE	-11.183333	7.883333	Africa/Freetown	0
3053	Odienne Airport	Odienne	Cote d'Ivoire	CI	KEO	DIOD	-7.563815	9.53813	Africa/Abidjan	0
3054	Nepalganj Airport	Nepalganj	Nepal	NP	KEP	VNNG	81.667	28.1036	Asia/Kathmandu	0
3055	Kebar Airport	Kebar	Indonesia	ID	KEQ	WAUK	134.833333	-5.833333	Asia/Jayapura	0
3056	Kerman Airport	Kerman	Iran	IR	KER	OIKK	56.961921	30.258778	Asia/Tehran	0
3057	Kelsey Airport	Kelsey	Canada	CA	KES	CZEE	-96.5	56.016667	America/Winnipeg	0
3058	Keng Tung Airport	Keng Tung	Myanmar	MM	KET	VYKG	99.616667	21.3	Asia/Yangon	0
3059	Keekorok Airport	Maasai Mara	Kenya	KE	KEU	HKKE	35.25746	-1.586377	Africa/Nairobi	0
3060	Halli Airport	Kuorevesi	Finland	FI	KEV	EFHA	24.75	61.583333	Europe/Helsinki	0
3061	Keewaywin Airport	Keewaywin	Canada	CA	KEW	CPV8	-92.838889	52.992222	America/Winnipeg	0
3062	Kericho Airport	Kericho	Kenya	KE	KEY	HKKR	35.283333	-0.366667	Africa/Nairobi	0
3063	Kiffa Airport	Kiffa	Mauritania	MR	KFA	GQNF	-11.405278	16.588889	Africa/Nouakchott	0
3064	Fortescue Dave Forrest Airport	Cloudbreak	Australia	AU	KFE	YFDF	119.437222	-22.291944	Australia/Perth	0
3065	Kalkurung Airport	Kalkurung	Australia	AU	KFG	YKKG	130.816667	-17.433333	Australia/Darwin	0
3066	Tipton Airport	Fort Meade	United States	US	FME	KFME	-76.759399	39.0854	America/New_York	0
3067	False Pass Airport	False Pass	United States	US	KFP	PAKF	-163.409167	54.849167	America/Anchorage	0
3068	Kastamonu Airport	Kastamonu	Turkiye	TR	KFS	LTAL	33.794951	41.306446	Europe/Istanbul	0
3069	Kukes International Airport	Kukes	Albania	AL	KFZ	LAKU	20.41722	42.03556	Europe/Tirane	0
3070	Kananga Airport	Kananga	The Democratic Republic of The Congo	CD	KGA	FZUA	22.469167	-5.922	Africa/Lubumbashi	0
3071	Kingscote Airport	Kingscote	Australia	AU	KGC	YKSC	137.523311	-35.709305	Australia/Adelaide	0
3072	Khrabrovo Airport	Kaliningrad	Russian Federation	RU	KGD	UMKK	20.586646	54.882656	Europe/Kaliningrad	0
3073	Kaghau Island Airport	Kaghau Island	Solomon Islands	SB	KGE	AGKG	157.58694	-7.33278	Pacific/Guadalcanal	0
3074	Karaganda Airport	Karaganda	Kazakhstan	KZ	KGF	UAKK	73.328364	49.675257	Asia/Almaty	0
3075	Kedougou Airport	Kedougou	Senegal	SN	KGG	GOTK	-12.217222	12.570833	Africa/Dakar	0
3076	Kalgoorlie Airport	Kalgoorlie	Australia	AU	KGI	YPKG	121.457914	-30.785246	Australia/Perth	0
3077	Karonga Airport	Karonga	Malawi	MW	KGJ	FWKA	33.892222	-9.957778	Africa/Blantyre	0
3078	Koliganek Airport	Koliganek	United States	US	KGK	PAJZ	-157.267107	59.726739	America/Anchorage	0
3079	Kigali International Airport	Kigali	Rwanda	RW	KGL	HRYR	30.135014	-1.963042	Africa/Kigali	0
3080	Kasongo Lunda Airport	Kasongo Lunda	The Democratic Republic of The Congo	CD	KGN	FZOK	16.816667	-6.583333	Africa/Kinshasa	0
3081	Kirovograd Airport	Kirovograd	Ukraine	UA	KGO	UKKG	32.3	48.55	Europe/Kiev	0
3082	Kogalym International Airport	Kogalym	Russian Federation	RU	KGP	USRK	74.533611	62.195833	Asia/Yekaterinburg	0
3083	Kangersuatsiaq Heliport	Kangersuatsiaq	Greenland	GL	KGQ	BGKS	-55.536586	72.381092	America/Godthab	0
3084	Kulgera Airport	Kulgera	Australia	AU	KGR	YKUL	133.033333	-25.833333	Australia/Darwin	0
3085	Kos Airport	Kos	Greece	GR	KGS	LGKO	27.089479	36.801002	Europe/Athens	0
3086	Kangding Airport	Kangding	China	CN	KGT	ZUKD	101.747534	30.13176	Asia/Shanghai	0
3087	Kingaroy Airport	Kingaroy	Australia	AU	KGY	YKRY	151.833333	-26.55	Australia/Brisbane	0
3088	Khorramabad Airport	Khorramabad	Iran	IR	KHD	OICK	48.280833	33.438611	Asia/Tehran	0
3089	Kherson International Airport	Kherson	Ukraine	UA	KHE	UKOH	32.507988	46.672395	Europe/Kiev	0
3090	Kashi Airport	Kashi	China	CN	KHG	ZWSH	76.010387	39.53689	Asia/Shanghai	0
3091	Kaohsiung International Airport	Kaohsiung	Taiwan	TW	KHH	RCKH	120.345278	22.5725	Asia/Taipei	0
3092	Jinnah International Airport	Karachi	Pakistan	PK	KHI	OPKC	67.16828	24.899986	Asia/Karachi	0
3093	Kauhajoki Airport	Kauhajoki	Finland	FI	KHJ	EFKJ	22.394722	62.463056	Europe/Helsinki	0
3094	Khark Airport	Khark	Iran	IR	KHK	OIBQ	50.323898	29.2603	Asia/Tehran	0
3095	Khamti Airport	Khamti	Myanmar	MM	KHM	VYKI	95.6744	25.9883	Asia/Yangon	0
3096	Nanchang Changbei International Airport	Nanchang	China	CN	KHN	ZSCN	115.907845	28.859902	Asia/Shanghai	0
3097	Kullorsuaq Heliport	Kullorsuaq	Greenland	GL	KHQ	BGKQ	-57.23544	74.579439	America/Godthab	0
3098	Kharkhorin Airport	Kharkhorin	Mongolia	MN	KHR	ZMHH	102.85	46.783333	Asia/Ulaanbaatar	0
3099	Khasab Airport	Khasab	Oman	OM	KHS	OOKB	56.23506	26.163939	Asia/Muscat	0
3100	Chapman Airport	Khost	Afghanistan	AF	KHT	OAKS	69.960068	33.336574	Asia/Kabul	0
3101	Kremenchug Airport	Kremenchug	Ukraine	UA	KHU	UKHK	33.45	49.1	Europe/Kiev	0
3102	Khabarovsk Airport	Khabarovsk	Russian Federation	RU	KHV	UHHH	135.168616	48.524564	Asia/Vladivostok	0
3103	Khwai River Lodge Airport	Khwai River Lodge	Botswana	BW	KHW	FBKR	23.5	-19	Africa/Gaborone	0
3104	Khoy Airport	Khoy	Iran	IR	KHY	OITK	44.97413	38.421558	Asia/Tehran	0
3105	Kauehi Airport	Kauehi	French Polynesia	PF	KHZ	NTKA	-145.124112	-15.781204	Pacific/Tahiti	0
3106	Mesa Del Rey Airport	King City	United States	US	KIC	KKIC	-121.122002	36.228001	America/Los_Angeles	0
3107	Kristianstad Airport	Kristianstad	Sweden	SE	KID	ESMK	14.088889	55.919444	Europe/Stockholm	0
3108	Aropa Airport	Kieta	Papua New Guinea	PG	KIE	AYIQ	155.725538	-6.30425	Pacific/Bougainville	0
3109	Kingfisher Lake Airport	Kingfisher Lake	Canada	CA	KIF	CNM5	-89.85	53.013889	America/Winnipeg	0
3110	Kish International Airport	Kish Island	Iran	IR	KIH	OIBK	53.972085	26.532277	Asia/Tehran	0
3111	Niigata Airport	Niigata	Japan	JP	KIJ	RJSN	139.11325	37.951993	Asia/Tokyo	0
3112	Kirkuk Air Base	Kirkuk	Iraq	IQ	KIK	ORKK	44.283615	35.513314	Asia/Baghdad	0
3113	Kimberley Airport	Kimberley	South Africa	ZA	KIM	FAKM	24.766389	-28.805833	Africa/Johannesburg	0
3114	Norman Manley International Airport	Kingston	Jamaica	JM	KIN	MKJP	-76.787498	17.935699	America/Jamaica	0
3115	Kerry County Airport	Kerry County	Ireland	IE	KIR	EIKY	-9.535666	52.181475	Europe/Dublin	0
3116	Kisumu Airport	Kisumu	Kenya	KE	KIS	HKKI	34.7375	-0.084946	Africa/Nairobi	0
3117	Kithira Airport	Kithira	Greece	GR	KIT	LGKC	23.025	36.291667	Europe/Athens	0
3118	Chisinau International Airport	Chisinau	Republic of Moldova	MD	RMO	LUKK	28.934967	46.935442	Europe/Chisinau	0
3119	Southdowns Airport	Kitwe	Zambia	ZM	KIW	FLSO	28.147762	-12.897945	Africa/Lusaka	0
3120	Kansai International Airport	Osaka	Japan	JP	KIX	RJBB	135.243977	34.43533	Asia/Tokyo	0
3121	New Century Aircenter	Kansas City	United States	US	JCI	KIXD	-94.892235	38.833932	America/Chicago	0
3122	Kilwa Masoko Airport	Kilwa Masoko	United Republic of Tanzania	TZ	KIY	HTKI	39.508909	-8.911243	Africa/Dar_es_Salaam	0
3123	Krasnoyarsk Airport	Krasnojarsk	Russian Federation	RU	KJA	UNKL	92.482859	56.18113	Asia/Krasnoyarsk	0
3124	Kortrijk Airport	Kortrijk	Belgium	BE	KJK	EBKT	3.201667	50.817222	Europe/Brussels	0
3125	Kerama Airport	Kerama	Japan	JP	KJP	ROKR	127.293855	26.168331	Asia/Tokyo	0
3126	Concord Regional Airport	Concord	United States	US	USA	KJQF	-80.71119	35.385139	America/New_York	0
3127	Kertajati International Airport	Majalengka	Indonesia	ID	KJT	WICA	108.166296	-6.649717	Asia/Jakarta	0
3128	Koyuk Airport	Koyuk	United States	US	KKA	PAKK	-161.15	64.939444	America/Anchorage	0
3129	Khon Kaen Airport	Khon Kaen	Thailand	TH	KKC	VTUK	102.787494	16.464671	Asia/Bangkok	0
3130	Kokoda Airport	Kokoda	Papua New Guinea	PG	KKD	AYKO	147.731221	-8.886153	Pacific/Port_Moresby	0
3131	Kerikeri Airport	Kerikeri	New Zealand	NZ	KKE	NZKK	173.912376	-35.263284	Pacific/Auckland	0
3132	Kongiganak Airport	Kongiganak	United States	US	KKH	PADY	-162.75	59.966667	America/Anchorage	0
3133	Kitakyushu Airport	Kitakyushu	Japan	JP	KKJ	RJFR	131.034936	33.846156	Asia/Tokyo	0
3134	Sa Pran Nak Airport	Lop Buri	Thailand	TH	KKM	VTBL	100.643581	14.945759	Asia/Bangkok	0
3135	Kirkenes Airport, Hoeybuktmoen	Kirkenes	Norway	NO	KKN	ENKR	29.891184	69.723503	Europe/Oslo	0
3136	Kaikohe Airport	Kaikohe	New Zealand	NZ	KKO	NZKO	173.816667	-35.452778	Pacific/Auckland	0
3137	Koolburra Airport	Koolburra	Australia	AU	KKP	YKLB	143.95	-15.583333	Australia/Brisbane	0
3138	Krasnosel'Kup Airport	Krasnosel'Kup	Russian Federation	RU	KKQ	USDP	82.456055	65.70796	Asia/Yekaterinburg	0
3139	Kashan Airport	Kashan	Iran	IR	KKS	OIFK	51.577053	33.895327	Asia/Tehran	0
3140	Kikwit Airport	Kikwit	The Democratic Republic of The Congo	CD	KKW	FZCA	18.780278	-5.036111	Africa/Kinshasa	0
3141	Kikaiga Shima Airport	Kikaiga Shima	Japan	JP	KKX	RJKI	129.928056	28.321389	Asia/Tokyo	0
3142	Kilkenny Airport	Kilkenny	Ireland	IE	KKY	EIKK	-7.25	52.65	Europe/Dublin	0
3143	Koh Kong Airport	Koh Kong	Cambodia	KH	KKZ	VDKK	102.966667	11.633333	Asia/Phnom_Penh	0
3144	Kalabo Airport	Kalabo	Zambia	ZM	KLB	FLKL	22.646713	-14.998512	Africa/Lusaka	0
3145	Kaolack Airport	Kaolack	Senegal	SN	KLC	GOOK	-16.5	14.083333	Africa/Dakar	0
3146	Lake City Gateway Airport	Lake City	United States	US	LCQ	KLCQ	-82.57529	30.181882	America/New_York	0
3147	Grabtsevo Airport	Kaluga	Russian Federation	RU	KLF	UUBC	36.368112	54.548019	Europe/Moscow	0
3148	Kalskag Municipal Airport	Kalskag	United States	US	KLG	PALG	-160.346503	61.532582	America/Anchorage	0
3149	Kolhapur Airport	Kolhapur	India	IN	KLH	VAKP	74.333333	16.666667	Asia/Kolkata	0
3150	Kota Koli Airport	Kota Koli	The Democratic Republic of The Congo	CD	KLI	FZFP	21.75	-4.166667	Africa/Kinshasa	0
3151	Ferguson's Gulf Airport	Kalokol	Kenya	KE	KLK	HKFG	35.838011	-3.49139	Africa/Nairobi	0
3152	Kalaleh Airport	Kalaleh	Iran	IR	KLM	OINE	55.452033	37.383272	Asia/Tehran	0
3153	Kalibo International Airport	Kalibo	Philippines	PH	KLO	RPVK	122.381832	11.687152	Asia/Manila	0
3154	Kelp Bay Airport	Kelp Bay	United States	US	KLP	WAGF	-134.866667	57.55	America/Anchorage	0
3155	Kalmar Oland Airport	Kalmar	Sweden	SE	KLR	ESMQ	16.287222	56.685	Europe/Stockholm	0
3156	Longview Airport	Kelso	United States	US	KLS	KKLS	-122.9	46.15	America/Los_Angeles	0
3157	Klagenfurt Airport	Klagenfurt	Austria	AT	KLU	LOWK	14.324192	46.650122	Europe/Vienna	0
3158	Karlovy Vary Airport	Karlovy Vary	Czech Republic	CZ	KLV	LKKV	12.916667	50.2	Europe/Prague	0
3159	Klawock Airport	Klawock	United States	US	KLW	PAKW	-133.1	55.555	America/Anchorage	0
3160	Kalamata Airport	Kalamata	Greece	GR	KLX	LGKL	22.027778	37.069444	Europe/Athens	0
3161	Kalima Airport	Kalima	The Democratic Republic of The Congo	CD	KLY	FZOD	26.533333	-2.55	Africa/Lubumbashi	0
3162	Kleinzee Airport	Kleinzee	South Africa	ZA	KLZ	FAKZ	17.066667	-29.683333	Africa/Johannesburg	0
3163	Kerema Airport	Kerema	Papua New Guinea	PG	KMA	AYKM	145.77155	-7.961702	Pacific/Port_Moresby	0
3164	King Khaled Military City Airport	King Khalid Military City	Saudi Arabia	SA	KMC	OEKK	45.528202	27.90092	Asia/Riyadh	0
3165	Mooreland Municipal	Mooreland	United States	US	MDF	KMDF	-99.291583	36.497583	America/Chicago	0
3166	Kamembe Airport	Kamembe	Rwanda	RW	KME	HRZA	28.908972	-2.459348	Africa/Kigali	0
3167	Kunming Changshui International Airport	Kunming	China	CN	KMG	ZPPP	102.929167	25.101944	Asia/Shanghai	0
3168	Kuruman Airport	Kuruman	South Africa	ZA	KMH	FAKU	23.466667	-27.466667	Africa/Johannesburg	0
3169	Miyazaki Airport	Miyazaki	Japan	JP	KMI	RJFM	131.441466	31.872497	Asia/Tokyo	0
3170	Kumamoto Airport	Kumamoto	Japan	JP	KMJ	RJFT	130.85799	32.834132	Asia/Tokyo	0
3171	Makabana Airport	Makabana	Congo	CG	KMK	FCPA	12.595687	-3.482116	Africa/Brazzaville	0
3172	Kamileroi Airport	Kamileroi	Australia	AU	KML	YKML	140.05	-19.366667	Australia/Brisbane	0
3173	Kiman Airport	Kiman	Indonesia	ID	KMM	WAKJ	136.166667	-3.666667	Asia/Jayapura	0
3174	Kamina Airport	Kamina	The Democratic Republic of The Congo	CD	KMN	FZSA	25.25	-8.641111	Africa/Lubumbashi	0
3175	Manokotak Airport	Manokotak	United States	US	KMO	PAMB	-159.05002	58.990197	America/Anchorage	0
3176	J.G.H. Van Der Wath Airport	Keetmanshoop	Namibia	NA	KMP	FYKT	18.1	-26.533611	Africa/Windhoek	0
3177	Komatsu Airport	Komatsu	Japan	JP	KMQ	RJNK	136.413428	36.402369	Asia/Tokyo	0
3178	Kumasi Airport	Kumasi	Ghana	GH	KMS	DGSI	-1.591111	6.7125	Africa/Accra	0
3179	Kismayu Airport	Kismayu	Somalia	SO	KMU	HCMK	42.459202	-0.377353	Africa/Mogadishu	0
3180	King Khalid Air Base	Khamis Mushait	Saudi Arabia	SA	KMX	OEKM	42.803495	18.297283	Asia/Riyadh	0
3181	Kaoma Airport	Kaoma	Zambia	ZM	KMZ	FLKO	24.803333	-14.798889	Africa/Lusaka	0
3182	Vina del Mar Airport	Vina del Mar	Chile	CL	KNA	SCVM	-71.4786	-32.9496	America/Santiago	0
3183	Kanab Airport	Kanab	United States	US	KNB	KKNB	-112.533333	37.05	America/Denver	0
3184	Kindu Airport	Kindu	The Democratic Republic of The Congo	CD	KND	FZOA	25.915278	-2.919167	Africa/Lubumbashi	0
3185	Kaimana Airport	Kaimana	Indonesia	ID	KNG	WASK	133.75	-3.65	Asia/Jayapura	0
3186	Kinmen Airport	Kinmen	Taiwan	TW	KNH	RCBS	118.368581	24.435001	Asia/Taipei	0
3187	Katanning Airport	Katanning	Australia	AU	KNI	YKNG	117.55	-33.7	Australia/Perth	0
3188	Kindamba Airport	Kindamba	Congo	CG	KNJ	FCBK	14.516667	-3.95	Africa/Brazzaville	0
3189	Kaniama Airport	Kaniama	The Democratic Republic of The Congo	CD	KNM	FZTK	24.183333	-7.516667	Africa/Lubumbashi	0
3190	Kankan Airport	Kankan	Guinea	GN	KNN	GUXN	-9.305556	10.3975	Africa/Conakry	0
3191	Kuala Namu International Airport	Kuala Namu	Indonesia	ID	KNO	WIMM	98.879016	3.635369	Asia/Jakarta	0
3192	Kone Airport	Kone	New Caledonia	NC	KNQ	NWWD	164.837778	-21.053333	Pacific/Noumea	0
3193	Jam Airport	Kangan	Iran	IR	KNR	OIBJ	52.350833	27.818056	Asia/Tehran	0
3194	King Island Airport	King Island	Australia	AU	KNS	YKII	143.881683	-39.879775	Australia/Hobart	0
3195	Kennett Municipal Airport	Kennett	United States	US	KNT	KTKX	-90.034722	36.230556	America/Chicago	0
3196	Kanpur Airport	Kanpur	India	IN	KNU	VIKA	80.40989	26.404278	Asia/Kolkata	0
3197	New Stuyahok Airport	New Stuyahok	United States	US	KNW	PANW	-157.374302	59.456321	America/Anchorage	0
3198	Kununurra Airport	Kununurra	Australia	AU	KNX	YPKU	128.712674	-15.784031	Australia/Perth	0
3199	Kenieba Airport	Kenieba	Mali	ML	KNZ	GAKA	-11.2525	12.843333	Africa/Bamako	0
3200	Kona International Airport at Keahole	Kailua-Kona	United States	US	KOA	PHKO	-156.041077	19.736174	Pacific/Honolulu	0
3201	Koumac Airport	Koumac	New Caledonia	NC	KOC	NWWK	164.416667	-20.5	Pacific/Noumea	0
3202	El Tari Airport	Kupang	Indonesia	ID	KOE	WATT	123.667254	-10.168536	Asia/Makassar	0
3203	Komatipoort Airport	Komatipoort	South Africa	ZA	KOF	FAKP	31.933333	-25.433333	Africa/Johannesburg	0
3204	Khong Airport	Khong	Lao People's Democratic Republic	LA	KOG	VLKG	105.816667	15.566667	Asia/Vientiane	0
3205	Koolatah Airport	Koolatah	Australia	AU	KOH	YKLA	142.416667	-15.966667	Australia/Brisbane	0
3206	Kirkwall Airport	Kirkwall	United Kingdom	GB	KOI	EGPA	-2.900556	58.958056	Europe/London	0
3207	Kagoshima Airport	Kagoshima	Japan	JP	KOJ	RJFK	130.715616	31.801224	Asia/Tokyo	0
3208	Kruunupyy Airport	Kokkola/Pietarsaari	Finland	FI	KOK	EFKK	23.133069	63.718838	Europe/Helsinki	0
3209	Komo Airport	Komo	Papua New Guinea	PG	KOM	AYXM	142.8598	-6.0682	Pacific/Port_Moresby	0
3210	Kongolo Airport	Kongolo	The Democratic Republic of The Congo	CD	KOO	FZRQ	26.990874	-5.394122	Africa/Lubumbashi	0
3211	Nakhon Phanom Airport	Nakhon Phanom	Thailand	TH	KOP	VTUW	104.75	17.4	Asia/Bangkok	0
3212	Sihanouk International Airport	Sihanoukville	Cambodia	KH	KOS	VDSV	103.639079	10.580739	Asia/Phnom_Penh	0
3213	Koulamoutou Airport	Koulamoutou	Gabon	GA	KOU	FOGK	12.441104	-1.184532	Africa/Libreville	0
3214	Kokshetau Airport	Kokshetau	Kazakhstan	KZ	KOV	UACK	69.591593	53.333268	Asia/Almaty	0
3215	Ganzhou Airport	Ganzhou	China	CN	KOW	ZSGZ	114.777786	25.849628	Asia/Shanghai	0
3216	Kokonao Airport	Kokonao	Indonesia	ID	KOX	WABN	136.416667	-4.716667	Asia/Jayapura	0
3217	Pike County Airport	Pikeville	United States	US	PVL	KPBX	-82.564639	37.559214	America/New_York	0
3218	Port Clarence Coast Guard Station	Port Clarence	United States	US	KPC	PAPC	-166.857533	65.25745	America/Anchorage	0
3219	Kapit Airport	Kapit	Malaysia	MY	KPI	WBGP	112.929444	2.010556	Asia/Kuala_Lumpur	0
3220	Kipnuk Sea Plane Base	Kipnuk	United States	US	KPN	PAKI	-164.05	59.933333	America/Anchorage	0
3221	Ralph Wenz Field	Pinedale	United States	US	PWY	KPNA	-109.805519	42.796127	America/Denver	0
3222	Pohang Airport	Pohang	Republic of Korea	KR	KPO	RKTH	129.433743	35.983713	Asia/Seoul	0
3223	Kalpowar Airport	Kalpowar	Australia	AU	KPP	YKPR	143.933333	-19.966667	Australia/Brisbane	0
3224	Kempsey Airport	Kempsey	Australia	AU	KPS	YKMP	152.766667	-31.083333	Australia/Sydney	0
3225	Perryville Airport	Perryville	United States	US	KPV	PAPE	-159.159249	55.909003	America/Anchorage	0
3226	Keperveyem Airport	Keperveyem	Russian Federation	RU	KPW	UHMK	166.138889	67.846944	Asia/Anadyr	0
3227	Ajmer Airport	Kishangarh	India	IN	KQH	VIKG	74.813277	26.591219	Asia/Kolkata	0
3228	Qurghonteppa International Airport	Kurgon-Tyube	Tajikistan	TJ	KQT	UTDT	68.865131	37.865622	Asia/Dushanbe	0
3229	Kerang Airport	Kerang	Australia	AU	KRA	YKER	143.938995	-35.7514	Australia/Sydney	0
3230	Karumba Airport	Karumba	Australia	AU	KRB	YKMB	140.831664	-17.454991	Australia/Brisbane	0
3231	Kerinci Airport	Kerinci	Indonesia	ID	KRC	WIJI	101.25	-1.716667	Asia/Jakarta	0
3232	Kurundi Airport	Kurundi	Australia	AU	KRD	YKUR	134.666667	-20.516667	Australia/Darwin	0
3233	Kirundo Airport	Kirundo	Burundi	BI	KRE	HBBO	29	-3.333333	Africa/Bujumbura	0
3234	Kramfors Airport	Kramfors	Sweden	SE	KRF	ESNK	17.768067	63.048888	Europe/Stockholm	0
3235	Karasabai Airport	Karasabai	Guyana	GY	KRG	SYKS	-59.516667	4.016667	America/Guyana	0
3236	Redhill	Redhill	United Kingdom	GB	KRH	EGKR	-0.138611	51.2136	Europe/London	0
3237	Kikori Airport	Kikori	Papua New Guinea	PG	KRI	AYKK	144.266667	-7.483333	Pacific/Port_Moresby	0
3238	J. Paul II International Airport Krakow-Balice	Krakow	Poland	PL	KRK	EPKK	19.793744	50.075491	Europe/Warsaw	0
3239	Korla Airport	Korla	China	CN	KRL	ZWKL	86.143123	41.616399	Asia/Shanghai	0
3240	Karanambo Airport	Karanambo	Guyana	GY	KRM	SYKR	-59.316667	3.75	America/Guyana	0
3241	Kiruna Airport	Kiruna	Sweden	SE	KRN	ESNQ	20.345833	67.822222	Europe/Stockholm	0
3242	Kurgan Airport	Kurgan	Russian Federation	RU	KRO	USUU	65.413184	55.474229	Asia/Yekaterinburg	0
3243	Midtjyllands Airport	Karup	Denmark	DK	KRP	EKKA	9.116667	56.3	Europe/Copenhagen	0
3244	Krasnodar International Airport	Krasnodar	Russian Federation	RU	KRR	URKK	39.139002	45.034138	Europe/Moscow	0
3245	Kristiansand Airport	Kristiansand	Norway	NO	KRS	ENCN	8.073732	58.202549	Europe/Oslo	0
3246	Khartoum International Airport	Khartoum	Sudan	SD	KRT	HSSK	32.549697	15.592217	Africa/Khartoum	0
3247	Turkmanbashi Airport	Turkmanbashi	Turkmenistan	TM	KRW	UTAK	53.012671	40.056157	Asia/Ashgabat	0
3248	Rexburg-Madison County Airport	Rexburg	United States	US	RXE	KRXE	-111.80542	43.833825	America/Denver	0
3249	Karamay Airport	Karamay	China	CN	KRY	ZWKM	84.883333	45.616667	Asia/Shanghai	0
3250	Kosrae Airport	Kosrae, Caroline Islands	Micronesia	FM	KSA	PTSA	162.956603	5.352478	Pacific/Pohnpei	0
3251	Barca Airport	Kosice	Slovakia	SK	KSC	LZKZ	21.25	48.666667	Europe/Bratislava	0
3252	Karlstad Airport	Karlstad	Sweden	SE	KSD	ESOK	13.3374	59.444698	Europe/Stockholm	0
3253	Kasese Airport	Kasese	Uganda	UG	KSE	HUKS	30.100833	0.185556	Africa/Kampala	0
3254	Kassel-Calden Airport	Kassel	Germany	DE	KSF	EDVK	9.376578	51.40568	Europe/Berlin	0
3255	Kermanshah Airport	Kermanshah	Iran	IR	KSH	OICC	47.145128	34.355916	Asia/Tehran	0
3256	Kissidougou Airport	Kissidougou	Guinea	GN	KSI	GUKU	-10.1	9.183333	Africa/Conakry	0
3257	Kasos Island Airport	Kasos Island	Greece	GR	KSJ	LGKS	26.910895	35.421267	Europe/Athens	0
3258	Karlskoga Airport	Karlskoga	Sweden	SE	KSK	ESKK	14.55	59.316667	Europe/Stockholm	0
3259	Kassala Airport	Kassala	Sudan	SD	KSL	HSKA	36.342222	15.390278	Africa/Khartoum	0
3260	Saint Mary's Airport	Saint Mary's	United States	US	KSM	PASM	-163.294894	62.058667	America/Anchorage	0
3261	Kostanay Airport	Kostanay	Kazakhstan	KZ	KSN	UAUU	63.550049	53.206083	Asia/Qostanay	0
3262	Aristoteles Airport	Kastoria	Greece	GR	KSO	LGKA	21.273333	40.450833	Europe/Athens	0
3263	Karshi Airport	Karshi	Uzbekistan	UZ	KSQ	UTSK	65.7739	38.8111	Asia/Tashkent	0
3264	H. Aroeppala Airport	Sulawesi Island	Indonesia	ID	KSR	WAWH	120.437222	-6.178611	Asia/Makassar	0
3265	Sikasso Airport	Sikasso	Mali	ML	KSS	GASO	-5.583333	11.3	Africa/Bamako	0
3266	Kosti Airport	Kosti	Sudan	SD	KST	HSKI	32.716667	13.133333	Africa/Khartoum	0
3267	Kristiansund Airport, Kvernberget	Kristiansund	Norway	NO	KSU	ENKB	7.826021	63.113446	Europe/Oslo	0
3268	Kiryat Shmona Airport	Kiryat Shmona	Israel	IL	KSW	LLKS	35.566667	33.216667	Asia/Jerusalem	0
3269	Kars Airport	Kars	Turkiye	TR	KSY	LTCF	43.085833	40.551667	Europe/Istanbul	0
3270	Kotlas Airport	Kotlas	Russian Federation	RU	KSZ	ULKK	46.698347	61.236353	Europe/Moscow	0
3271	Karratha Airport	Karratha	Australia	AU	KTA	YPKA	116.770058	-20.70826	Australia/Perth	0
3272	Kitadaito Airport	Kitadaito	Japan	JP	KTD	RORK	131.325167	25.944371	Asia/Tokyo	0
3273	Kerteh Airport	Kerteh	Malaysia	MY	KTE	WMKE	103.428333	4.538333	Asia/Kuala_Lumpur	0
3274	Takaka Airport	Takaka	New Zealand	NZ	KTF	NZTK	172.775305	-40.814536	Pacific/Auckland	0
3275	Ketapang Airport	Ketapang	Indonesia	ID	KTG	WIOK	109.983333	-1.833333	Asia/Jakarta	0
3276	Kichwa Tembo Airport	Maasai Mara	Kenya	KE	KTJ	HKTB	35.027596	-1.263508	Africa/Nairobi	0
3277	Kitale Airport	Kitale	Kenya	KE	KTL	HKKT	34.959246	0.974111	Africa/Nairobi	0
3278	Kathmandu Tribhuvan International Airport	Kathmandu	Nepal	NP	KTM	VNKT	85.35657	27.699906	Asia/Kathmandu	0
3279	Ketchikan International Airport	Ketchikan	United States	US	KTN	PAKT	-131.708694	55.35655	America/Anchorage	0
3280	Kato Airport	Kato	Guyana	GY	KTO	SYKT	-59.816667	4.65	America/Guyana	0
3281	Tinson Airport	Kingston	Jamaica	JM	KTP	MKTP	-76.823333	17.9875	America/Jamaica	0
3282	Kitee Airport	Kitee	Finland	FI	KTQ	EFIT	30.076667	62.165833	Europe/Helsinki	0
3283	RAAF Base Tindal	Katherine	Australia	AU	KTR	YPTN	132.37184	-14.512409	Australia/Darwin	0
3284	Brevig Mission Airport	Teller Mission	United States	US	KTS	PFKT	-166.471667	65.329444	America/Anchorage	0
3285	Kittila Airport	Kittila	Finland	FI	KTT	EFKT	24.859027	67.695949	Europe/Helsinki	0
3286	Kota Airport	Kota	India	IN	KTU	VIKO	76.5	25	Asia/Kolkata	0
3287	Kamarata Airport	Kamarata	Venezuela	VE	KTV	SVKM	-62.416667	5.75	America/Caracas	0
3288	Katowice International Airport	Katowice	Poland	PL	KTW	EPKT	19.074029	50.470833	Europe/Warsaw	0
3289	Koutiala Airport	Koutiala	Mali	ML	KTX	GAKO	-5.383333	12.416667	Africa/Bamako	0
3290	Katukurunda Airport	Katukurunda	Sri Lanka	LK	KTY	VCCN	79.973889	6.552778	Asia/Colombo	0
3291	Sultan Haji Ahmad Shah Airport	Kuantan	Malaysia	MY	KUA	WMKD	103.215182	3.780765	Asia/Kuala_Lumpur	0
3292	Kuria Airport	Kuria	Kiribati	KI	KUC	NGKT	173.383333	0.233333	Pacific/Tarawa	0
3293	Kudat Airport	Kudat	Malaysia	MY	KUD	WBKT	116.834167	6.925	Asia/Kuala_Lumpur	0
3294	Kukundu Airport	Kukundu	Solomon Islands	SB	KUE	AGKU	156	-8.016667	Pacific/Guadalcanal	0
3295	Kurumoch International Airport	Samara	Russian Federation	RU	KUF	UWWW	50.14742	53.507819	Europe/Samara	0
3296	Kubin Airport	Kubin Island	Australia	AU	KUG	YKUB	142.219782	-10.226403	Australia/Brisbane	0
3297	Kushiro Airport	Kushiro	Japan	JP	KUH	RJCK	144.196819	43.045651	Asia/Tokyo	0
3298	Kuala Lumpur International Airport	Kuala Lumpur	Malaysia	MY	KUL	WMKK	101.717259	2.744344	Asia/Kuala_Lumpur	0
3299	Yakushima Airport	Yakushima	Japan	JP	KUM	RJFC	130.659167	30.385556	Asia/Tokyo	0
3300	Kaunas Airport	Kaunas	Lithuania	LT	KUN	EYKA	24.0733	54.9675	Europe/Vilnius	0
3301	Kuopio Airport	Kuopio	Finland	FI	KUO	EFKU	27.788696	63.008908	Europe/Helsinki	0
3302	Kulusuk Airport	Kulusuk	Greenland	GL	KUS	BGKK	-37.116667	65.566667	America/Godthab	0
3303	Kutaisi International Airport	Kutaisi	Georgia	GE	KUT	UGKO	42.4825	42.176389	Asia/Tbilisi	0
3304	Bhuntar Airport	Kulu	India	IN	KUU	VIBR	77.1	31.983333	Asia/Kolkata	0
3305	Gunsan Airport	Gunsan	Republic of Korea	KR	KUV	RKJK	126.615997	35.903801	Asia/Seoul	0
3306	Kuummiit Heliport	Kuummiit	Greenland	GL	KUZ	BGKM	-36.998001	65.864128	America/Godthab	0
3307	Kavala International Airport	Kavala	Greece	GR	KVA	LGKV	24.619675	40.912994	Europe/Athens	0
3308	Skovde Airport	Skovde	Sweden	SE	KVB	ESGR	13.966667	58.45	Europe/Stockholm	0
3309	King Cove Airport	King Cove	United States	US	KVC	PAVC	-162.266247	55.116347	America/Anchorage	0
3310	Ganja Airport	Gyandzha	Azerbaijan	AZ	GNJ	UBBG	46.316667	40.733333	Asia/Baku	0
3311	Kavieng Airport	Kavieng	Papua New Guinea	PG	KVG	AYKV	150.80653	-2.58075	Pacific/Port_Moresby	0
3312	Kivalina Airport	Kivalina	United States	US	KVL	PAVL	-164.547222	67.731667	America/Anchorage	0
3313	Markovo Airport	Markovo	Russian Federation	RU	KVM	UHMO	170.419722	64.666667	Asia/Anadyr	0
3314	Moreva Airport	Kraljevo	Republic of Serbia	RS	KVO	LYKV	20.5858	43.8181	Europe/Belgrade	0
3315	Kirov Airport	Kirov	Russian Federation	RU	KVX	USKK	49.35	58.5	Europe/Moscow	0
3316	Kwajalein Airport	Kwajalein	Marshall Islands	MH	KWA	PKWA	167.721953	8.720843	Pacific/Majuro	0
3317	Dewadaru Airport	Karimunjawa	Indonesia	ID	KWB	WAHU	110.478396	-5.802206	Asia/Jakarta	0
3318	Guiyang Longdongbao International Airport	Guiyang	China	CN	KWE	ZUGY	106.79598	26.544217	Asia/Shanghai	0
3319	Krivoy Rog Airport	Krivoy Rog	Ukraine	UA	KWG	UKDR	33.216667	48.05	Europe/Kiev	0
3320	Khwahan Airport	Khwahan	Afghanistan	AF	KWH	OAHN	66.333333	33.916667	Asia/Kabul	0
3321	Kuwait International Airport	Kuwait	Kuwait	KW	KWI	OKKK	47.971251	29.240116	Asia/Kuwait	0
3322	Gwangju Airport	Gwangju	Republic of Korea	KR	KWJ	RKJJ	126.810208	35.140176	Asia/Seoul	0
3323	Kwigillingok Airport	Kwigillingok	United States	US	KWK	PAGG	-163.168036	59.875583	America/Anchorage	0
3324	Guilin Liangjiang International Airport	Guilin	China	CN	KWL	ZGKL	110.046839	25.217585	Asia/Shanghai	0
3325	Kowanyama Airport	Kowanyama	Australia	AU	KWM	YKOW	141.748333	-15.4875	Australia/Brisbane	0
3326	Kwinhagak Airport	Quinhagak	United States	US	KWN	PAQH	-161.840523	59.751235	America/Anchorage	0
3327	Kwailibesi Airport	Kwailibesi	Solomon Islands	SB	KWS	AGKW	160.775127	-8.360508	Pacific/Guadalcanal	0
3328	Kwethluk Airport	Kwethluk	United States	US	KWT	PFKW	-161.4375	60.808889	America/Anchorage	0
3329	Kolwezi Airport	Kolwezi	The Democratic Republic of The Congo	CD	KWZ	FZQM	25.506944	-10.766667	Africa/Lubumbashi	0
3330	Sangia Nibandera Airport	Kolaka	Indonesia	ID	KXB	WAWP	121.523888	-4.341744	Asia/Makassar	0
3331	Klerksdorp Airport	Klerksdorp	South Africa	ZA	KXE	FAKD	26.716667	-26.866667	Africa/Johannesburg	0
3332	Koro Island Airport	Koro Island	Fiji	FJ	KXF	NFNO	179.421997	-17.3458	Pacific/Fiji	0
3333	Khurba Airport	Komsomolsk Na Amure	Russian Federation	RU	KXK	UHKK	136.933604	50.403117	Asia/Vladivostok	0
3334	Katiu Airport	Katiu	French Polynesia	PF	KXU	NTKT	-144.403056	-16.339444	Pacific/Tahiti	0
3335	Konya Airport	Konya	Turkiye	TR	KYA	LTAN	32.562222	37.979167	Europe/Istanbul	0
3336	Kleyate Airport	Tripoli	Lebanon	LB	KYE	OLKA	36.002778	34.586111	Asia/Beirut	0
3337	Yalata Mission Airport	Yalata Mission	Australia	AU	KYI	YYTA	131.866667	-31.483333	Australia/Adelaide	0
3338	Karluk Airport	Karluk	United States	US	KYK	PAKY	-154.45	57.566111	America/Anchorage	0
3339	Kyaukpyu Airport	Kyaukpyu	Myanmar	MM	KYP	VYKP	93.535166	19.429139	Asia/Yangon	0
3340	Kayes Airport	Kayes	Mali	ML	KYS	GAKD	-11.439444	14.431944	Africa/Bamako	0
3341	Kyaukhtu Airport	Kyaukhtu	Myanmar	MM	KYT	VYKU	94.144109	21.414576	Asia/Yangon	0
3342	Koyukuk Airport	Koyukuk	United States	US	KYU	PFKU	-157.713056	64.878056	America/Anchorage	0
3343	Kyzyl Airport	Kyzyl	Russian Federation	RU	KYZ	UNKY	94.4082	51.673115	Asia/Krasnoyarsk	0
3344	Kompong-Chhna Airport	Kompong-Chhna	Cambodia	KH	KZC	VDKH	104.583333	12.333333	Asia/Phnom_Penh	0
3345	Kitzingen Airport	Kitzingen	Germany	DE	KZG	EDGY	10.15	49.733333	Europe/Berlin	0
3346	Philippos Airport	Kozani	Greece	GR	KZI	LGKZ	21.841944	40.288611	Europe/Athens	0
3347	Kazan International Airport	Kazan	Russian Federation	RU	KZN	UWKD	49.29824	55.608439	Europe/Moscow	0
3348	Kzyl-Orda Airport	Kzyl-Orda	Kazakhstan	KZ	KZO	UAOO	65.592248	44.70727	Asia/Qyzylorda	0
3349	Zafer Airport	Kutahya	Turkiye	TR	KZR	LTBZ	30.116945	39.120277	Europe/Istanbul	0
3350	Kastellorizo Airport	Kastellorizo	Greece	GR	KZS	LGKJ	29.576376	36.14167	Europe/Athens	0
3351	Lamar Municipal Airport	Lamar	United States	US	LAA	KLAA	-102.690278	38.068611	America/Denver	0
3352	Quatro de Fevereiro Airport	Luanda	Angola	AO	LAD	FNLU	13.234862	-8.847951	Africa/Luanda	0
3353	Nadzab Airport	Lae	Papua New Guinea	PG	LAE	AYNZ	146.728205	-6.566117	Pacific/Port_Moresby	0
3354	Purdue University Airport	Lafayette	United States	US	LAF	KLAF	-86.933611	40.411944	America/Indiana/Indianapolis	0
3355	Oesman Sadik Airport	Labuha	Indonesia	ID	LAH	WAEL	127.500265	-0.636548	Asia/Jayapura	0
3356	Servel Airport	Lannion	France	FR	LAI	LFRO	-3.481944	48.754167	Europe/Paris	0
3357	Correia Pinto Airport	Lages	Brazil	BR	LAJ	SBLJ	-50.279757	-27.782115	America/Sao_Paulo	0
3358	Freddie Carmichael Airport	Aklavik	Canada	CA	LAK	CYKD	-135.005889	68.223286	America/Edmonton	0
3359	Lakeland Municipal Airport	Lakeland	United States	US	LAL	KLAL	-82.014722	27.988889	America/New_York	0
3360	Los Alamos Airport	Los Alamos	United States	US	LAM	KLAM	-106.269054	35.880135	America/Denver	0
3361	Lansing Capital Region International Airport	Lansing	United States	US	LAN	KLAN	-84.587348	42.778689	America/New_York	0
3362	Laoag Airport	Laoag	Philippines	PH	LAO	RPLI	120.534123	18.182408	Asia/Manila	0
3363	Manuel Marquez de Leon International Airport	La Paz	Mexico	MX	LAP	MMLP	-110.367834	24.076088	America/Mazatlan	0
3364	La Braq Airport	Beida	Libya	LY	LAQ	HLLQ	21.964167	32.788611	Africa/Tripoli	0
3365	General Brees Field	Laramie	United States	US	LAR	KLAR	-105.673056	41.313611	America/Denver	0
3366	Las Vegas Harry Reid International Airport	Las Vegas	United States	US	LAS	KLAS	-115.147599	36.081	America/Los_Angeles	0
3367	Lamu Airport	Lamu	Kenya	KE	LAU	HKLU	40.911667	-2.25	Africa/Nairobi	0
3368	Lawton-Fort Sill Regional Airport	Lawton	United States	US	LAW	KLAW	-98.416111	34.569722	America/Chicago	0
3369	Los Angeles International Airport	Los Angeles	United States	US	LAX	KLAX	-118.408279	33.943399	America/Los_Angeles	0
3370	Ladysmith Airport	Ladysmith	South Africa	ZA	LAY	FALY	29.75	-28.566667	Africa/Johannesburg	0
3371	Bom Jesus Da Lapa Airport	Bom Jesus Da Lapa	Brazil	BR	LAZ	SBLP	-43.4125	-13.256944	America/Belem	0
3372	Leeds Bradford International Airport	Leeds	United Kingdom	GB	LBA	EGNM	-1.659985	53.869339	Europe/London	0
3373	Lubbock Preston Smith International Airport	Lubbock	United States	US	LBB	KLBB	-101.8223	33.656221	America/Chicago	0
3374	Luebeck-Blankensee Airport	Hamburg	Germany	DE	LBC	EDHL	10.701162	53.805273	Europe/Berlin	0
3375	Khujand Airport	Khujand	Tajikistan	TJ	LBD	UTDL	69.6965	40.219887	Asia/Dushanbe	0
3376	Westmoreland County Airport	Latrobe	United States	US	LBE	KLBE	-79.40855	40.272927	America/New_York	0
3377	North Platte Regional Airport (Lee Bird Field)	North Platte	United States	US	LBF	KLBF	-100.683984	41.126198	America/Chicago	0
3378	Le Bourget Airport	Paris	France	FR	LBG	LFPB	2.441525	48.964426	Europe/Paris	0
3379	Palm Beach Sea Plane Base	Sydney	Australia	AU	LBH	YPLB	151.324087	-33.586929	Australia/Sydney	0
3380	Le Sequestre Airport	Albi	France	FR	LBI	LFCI	2.15	43.933333	Europe/Paris	0
3381	Komodo Airport	Labuan Bajo	Indonesia	ID	LBJ	WATO	119.889281	-8.486215	Asia/Makassar	0
3382	Mid-America Regional Airport	Liberal	United States	US	LBL	KLBL	-100.960556	37.044444	America/Chicago	0
3383	Lusambo Airport	Lusambo	The Democratic Republic of The Congo	CD	LBO	FZVI	23.45	-4.966667	Africa/Lubumbashi	0
3384	Lambarene Airport	Lambarene	Gabon	GA	LBQ	FOGR	10.239444	-0.714722	Africa/Libreville	0
3385	Labrea Airport	Labrea	Brazil	BR	LBR	SWLB	-64.85	-7.25	America/Porto_Velho	0
3386	Labasa Airport	Labasa	Fiji	FJ	LBS	NFNL	179.337659	-16.466215	Pacific/Fiji	0
3387	Lumberton Airport	Lumberton	United States	US	LBT	KLBT	-79.06011	34.614039	America/New_York	0
3388	Labuan Airport	Labuan	Malaysia	MY	LBU	WBKL	115.249164	5.294355	Asia/Kuala_Lumpur	0
3389	Libreville Airport	Libreville	Gabon	GA	LBV	FOOL	9.409852	0.456963	Africa/Libreville	0
3390	Long Bawan Airport	Long Bawan	Indonesia	ID	LBW	WAQJ	115.6921	3.9028	Asia/Makassar	0
3391	Lubang Airport	Lubang	Philippines	PH	LBX	RPLU	120.105	13.865556	Asia/Manila	0
3392	La Baule-Escoublac Airport	La Baule Escoublac	France	FR	LBY	LFRE	-2.346783	47.288136	Europe/Paris	0
3393	Larnaca International Airport	Larnaca	Cyprus	CY	LCA	LCLK	33.607975	34.870871	Asia/Nicosia	0
3394	Galatina Airport	Lecce	Italy	IT	LCC	LIBN	18.133333	40.242778	Europe/Rome	0
3395	Louis Trichardt Airport	Louis Trichardt	South Africa	ZA	LCD	FALO	29.716667	-23.016667	Africa/Johannesburg	0
3396	Goloson International Airport	La Ceiba	Honduras	HN	LCE	MHLC	-86.857222	15.740556	America/Tegucigalpa	0
3397	Las Vegas Airport	Rio Dulce	Guatemala	GT	LCF	MGRD	-88.947778	15.667778	America/Guatemala	0
3398	A Coruna Airport	La Coruna	Spain and Canary Islands	ES	LCG	LECO	-8.381923	43.30236	Europe/Madrid	0
3399	Lake Charles Regional Airport	Lake Charles	United States	US	LCH	KLCH	-93.22105	30.123227	America/Chicago	0
3400	Laconia Municipal Airport	Laconia	United States	US	LCI	KLCI	-71.421111	43.571389	America/New_York	0
3401	Lodz Lublinek Airport	Lodz	Poland	PL	LCJ	EPLL	19.398333	51.721944	Europe/Warsaw	0
3402	Rickenbacker International Airport	Columbus	United States	US	LCK	KLCK	-82.935508	39.817957	America/New_York	0
3403	La Coloma Airport	La Coloma	Cuba	CU	LCL	MULM	-83.640206	22.337485	America/Havana	0
3404	La Cumbre Airport	La Cumbre	Argentina	AR	LCM	SACC	-64.5	-30.966667	America/Argentina/Buenos_Aires	0
3405	Balcanoona Airport	Balcanoona	Australia	AU	LCN	YBLC	139.35	-30.516667	Australia/Adelaide	0
3406	Lague Airport	Lague	Congo	CG	LCO	FCBL	14.533333	-2.45	Africa/Brazzaville	0
3407	Lucca Airport	Lucca	Italy	IT	LCV	LIQL	10.583333	43.833333	Europe/Rome	0
3408	Liancheng Airport	Longyan	China	CN	LCX	ZBSZ	116.745556	25.675556	Asia/Shanghai	0
3409	London City Airport	London	United Kingdom	GB	LCY	EGLC	0.049365	51.50438	Europe/London	0
3410	Malda Airport	Malda	India	IN	LDA	VEMH	88.15	25.033333	Asia/Kolkata	0
3411	Londrina Airport	Londrina	Brazil	BR	LDB	SBLO	-51.137715	-23.328456	America/Sao_Paulo	0
3412	Lindeman Island Airport	Lindeman Island	Australia	AU	LDC	YLIN	149	-21	Australia/Brisbane	0
3413	Tarbes Ossun Lourdes Airport	Lourdes	France	FR	LDE	LFBT	0.003368	43.186508	Europe/Paris	0
3414	Leshukonskoye Airport	Leshukonskoye	Russian Federation	RU	LDG	ULAL	45.75	64.9	Europe/Moscow	0
3415	Lord Howe Island Airport	Lord Howe Island	Australia	AU	LDH	YLHI	159.078148	-31.540807	Australia/Sydney	0
3416	Kikwetu Airport	Lindi	United Republic of Tanzania	TZ	LDI	HTLI	39.759444	-9.845833	Africa/Dar_es_Salaam	0
3417	Linden Airport	Linden	United States	US	LDJ	KLDJ	-74.25	40.616667	America/New_York	0
3418	Hovby Airport	Lidkoping	Sweden	SE	LDK	ESGL	13.166667	58.5	Europe/Stockholm	0
3419	Mason Co	Ludington	United States	US	LDM	KLDM	-86.479167	44.075333	America/New_York	0
3420	Lamidanda Airport	Lamidanda	Nepal	NP	LDN	VNLD	86.716667	27.25	Asia/Kathmandu	0
3421	Yichun Shi Airport	Yichun	China	CN	LDS	ZYLD	129.017988	47.751828	Asia/Shanghai	0
3422	Lahad Datu Airport	Lahad Datu	Malaysia	MY	LDU	WBKD	118.326111	5.035278	Asia/Kuala_Lumpur	0
3423	Landivisiau Airport	Landivisiau	France	FR	LDV	LFRJ	-4.1	48.5	Europe/Paris	0
3424	Saint Laurent du Maroni Airport	Saint Laurent du Maroni	French Guiana	GF	LDX	SOOM	-54.05	5.483333	America/Cayenne	0
3425	City of Derry Airport	Derry	United Kingdom	GB	LDY	EGAE	-7.156924	55.040986	Europe/London	0
3426	Londolozi Airport	Londolozi	South Africa	ZA	LDZ	FALD	31.505367	-24.809691	Africa/Johannesburg	0
3427	Learmonth Airport	Learmonth	Australia	AU	LEA	YPLM	114.094265	-22.239883	Australia/Perth	0
3428	Lebanon Municipal Airport	Lebanon	United States	US	LEB	KLEB	-72.310007	43.629359	America/New_York	0
3429	Villafria Airport	Burgos	Spain and Canary Islands	ES	RGS	LEBG	-3.613573	42.357451	Europe/Madrid	0
3430	Coronel Horacio de Mattos Airport	Lencois	Brazil	BR	LEC	SBLE	-41.274079	-12.486064	America/Belem	0
3431	Saint Petersburg Pulkovo Airport	Saint Petersburg	Russian Federation	RU	LED	ULLI	30.270505	59.799847	Europe/Moscow	0
3432	Lleida-Alguaire Airport	Alguaire	Spain and Canary Islands	ES	ILD	LEDA	0.539164	41.726926	Europe/Madrid	0
3433	Leesburg International Airport	Leesburg	United States	US	LEE	KLEE	-81.808701	28.823099	America/New_York	0
3434	Lebakeng Airport	Lebakeng	Lesotho	LS	LEF	FXLK	28.583333	-29.783333	Africa/Maseru	0
3435	Octeville Airport	Le Havre	France	FR	LEH	LFOH	0.088063	49.53391	Europe/Paris	0
3436	Almeria Airport	Almeria	Spain and Canary Islands	ES	LEI	LEAM	-2.371873	36.847984	Europe/Madrid	0
3437	Leipzig/Halle Airport	Leipzig/Halle	Germany	DE	LEJ	EDDP	12.221202	51.420262	Europe/Berlin	0
3438	Labe Airport	Labe	Guinea	GN	LEK	GULB	-12.297222	11.333333	Africa/Conakry	0
3439	Lake Evella Airport	Lake Evella	Australia	AU	LEL	YLEV	135.8	-12.508333	Australia/Darwin	0
3440	Lemmon Airport	Lemmon	United States	US	LEM	KLEM	-102.158889	45.940833	America/Denver	0
3441	Leon Airport	Leon	Spain and Canary Islands	ES	LEN	LELN	-5.64629	42.590569	Europe/Madrid	0
3442	Leopoldina Airport	Leopoldina	Brazil	BR	LEP	SNDN	-42.666667	-21.466667	America/Sao_Paulo	0
3443	Lands End Airport	Lands End	United Kingdom	GB	LEQ	EGHC	-5.670205	50.102792	Europe/London	0
3444	Leinster Airport	Leinster	Australia	AU	LER	YLST	120.704372	-27.839283	Australia/Perth	0
3445	Lesobeng Airport	Lesobeng	Lesotho	LS	LES	FXLS	27.666667	-29.666667	Africa/Maseru	0
3446	Gen. A.V. Cobo Airport	Leticia	Colombia	CO	LET	SKLT	-69.939444	-4.196389	America/Bogota	0
3447	Aeroport De La Seu	Seo De Urgel	Spain and Canary Islands	ES	LEU	LESU	1.409573	42.341306	Europe/Madrid	0
3448	Levuka Airfield	Bureta	Fiji	FJ	LEV	NFNB	178.833333	-17.683333	Pacific/Fiji	0
3449	Auburn Lewiston Municipal Airport	Auburn	United States	US	LEW	KLEW	-70.283501	44.0485	America/New_York	0
3450	Blue Grass Airport	Lexington	United States	US	LEX	KLEX	-84.597921	38.037622	America/New_York	0
3451	Lelystad Airport	Lelystad	Netherlands	NL	LEY	EHLE	5.533333	52.466667	Europe/Amsterdam	0
3452	La Esperanza Airport	La Esperanza	Honduras	HN	LEZ	MHLE	-88.166667	14.25	America/Tegucigalpa	0
3453	Albert Bray Airport	Albert	France	FR	BYF	LFAQ	2.699448	49.970389	Europe/Paris	0
3454	Lumbo Airport	Lumbo	Mozambique	MZ	LFB	FQLU	40.67248	-15.032044	Africa/Maputo	0
3455	En Mer Airport	Belle Ile	France	FR	BIC	LFEA	-3.19833	47.326698	Europe/Paris	0
3456	Ouessant Airport	Ouessant	France	FR	OUI	LFEC	-5.06358	48.4632	Europe/Paris	0
3457	Langley Air Force Base	Hampton	United States	US	LFI	KLFI	-76.36109	37.078971	America/New_York	0
3458	Lufkin Angelina County Airport	Nacogdoches	United States	US	LFK	KLFK	-94.750278	31.234167	America/Chicago	0
3459	Lamerd Airport	Lamerd	Iran	IR	LFM	OISR	53.195354	27.369393	Asia/Tehran	0
3460	Triangle North Executive Airport	Louisburg	United States	US	LFN	KLHZ	-78.325418	36.024947	America/New_York	0
3461	Valframbert	Alencon	France	FR	XAN	LFOF	0.0833	48.4333	Europe/Paris	0
3462	Lakefield Airport	Lakefield	Australia	AU	LFP	YLFD	144.200465	-14.922242	Australia/Brisbane	0
3463	Linfen Qiaoli Airport	Qiaoli	China	CN	LFQ	ZBLF	111.494936	36.043525	Asia/Shanghai	0
3464	La Fria Airport	La Fria	Venezuela	VE	LFR	SVLF	-72.272222	8.240556	America/Caracas	0
3465	Lafayette Regional Airport	Lafayette	United States	US	LFT	KLFT	-91.99327	30.20851	America/Chicago	0
3466	Lome Airport	Lome	Togo	TG	LFW	DXXX	1.250347	6.167103	Africa/Lome	0
3467	New York LaGuardia Airport	New York	United States	US	LGA	KLGA	-73.871617	40.774252	America/New_York	0
3468	Long Beach Airport	Long Beach	United States	US	LGB	KLGB	-118.144494	33.818194	America/Los_Angeles	0
3469	Calloway Airport	La Grange	United States	US	LGC	KLGC	-85.070833	33.0075	America/New_York	0
3470	La Grande/Union County Airport	La Grande	United States	US	LGD	KLGD	-118.005	45.289722	America/Los_Angeles	0
3471	Lake Gregory Airport	Lake Gregory	Australia	AU	LGE	YUAN	127.566667	-20.133333	Australia/Perth	0
3472	Laguna Army Air Field	Yuma	United States	US	LGF	KLGF	-114.398003	32.861859	America/Phoenix	0
3473	Liege Airport	Liege	Belgium	BE	LGG	EBLG	5.460149	50.643334	Europe/Brussels	0
3474	Leigh Creek Airport	Leigh Creek	Australia	AU	LGH	YLEC	138.416667	-30.466667	Australia/Adelaide	0
3475	Deadmans Cay Airport	Deadmans Cay	Bahamas	BS	LGI	MYLD	-75.090556	23.179444	America/Nassau	0
3476	Langkawi International Airport	Langkawi	Malaysia	MY	LGK	WMKL	99.731403	6.342174	Asia/Kuala_Lumpur	0
3477	Long Lellang Airport	Long Lellang	Malaysia	MY	LGL	WBGF	115.15361	3.42139	Asia/Kuala_Lumpur	0
3478	Langeoog Airport	Langeoog	Germany	DE	LGO	EDWL	7.533333	53.766667	Europe/Berlin	0
3479	Legaspi Airport	Legaspi	Philippines	PH	LGP	RPLP	123.730204	13.15213	Asia/Manila	0
3480	Lago Agrio Airport	Lago Agrio	Ecuador	EC	LGQ	SENL	-76.883333	0.1	America/Guayaquil	0
3481	Cochrane Airport	Cochrane	Chile	CL	LGR	SCHR	-72	-47.166667	America/Santiago	0
3482	Comodoro D.R. Salomon Airport	Malargue	Argentina	AR	LGS	SAMM	-69.574566	-35.49324	America/Argentina/Buenos_Aires	0
3483	Las Gaviotas Airport	Las Gaviotas	Colombia	CO	LGT	SKGA	-74.5	9.166667	America/Bogota	0
3484	Cache Airport	Logan	United States	US	LGU	KLGU	-111.855	41.7875	America/Denver	0
3485	London Gatwick Airport	London	United Kingdom	GB	LGW	EGKK	-0.177416	51.150836	Europe/London	0
3486	Lugh Ganane Airport	Lugh Ganane	Somalia	SO	LGX	HCMJ	42.05	3.8	Africa/Mogadishu	0
3487	Black Forest Airport	Lahr	Germany	DE	LHA	EDTL	7.827674	48.369304	Europe/Berlin	0
3488	Allama Iqbal International Airport	Lahore	Pakistan	PK	LHE	OPLA	74.402778	31.520833	Asia/Karachi	0
3489	Lightning Ridge Airport	Lightning Ridge	Australia	AU	LHG	YLRD	147.983333	-29.458333	Australia/Sydney	0
3490	Lereh Airport	Lereh	Indonesia	ID	LHI	WAJL	139.9	-3.133333	Asia/Jayapura	0
3491	Guanghua Airport	Guanghua	China	CN	LHK	ZHGH	111.633333	32.266667	Asia/Shanghai	0
3492	London Heathrow Airport	London	United Kingdom	GB	LHR	EGLL	-0.453566	51.469603	Europe/London	0
3493	Las Heras Airport	Las Heras	Argentina	AR	LHS	SAVH	-68.966111	-46.538333	America/Argentina/Buenos_Aires	0
3494	Szombathely Airfield	Hungary	Hungary	HU	ZBX	LHSY	16.62	47.28	Europe/Budapest	0
3495	Lianshulu Airport	Caprivi	Namibia	NA	LHU	FYLS	23.391667	-18.116389	Africa/Windhoek	0
3496	W T Piper Memorial Airport	Lock Haven	United States	US	LHV	KLHV	-77.45	41.133333	America/New_York	0
3497	Lanzhou Zhongchuan International Airport	Lanzhou	China	CN	LHW	ZLLL	103.61756	36.509497	Asia/Shanghai	0
3498	Liangping Airport	Liangping	China	CN	LIA	ZULP	107.7	30.816667	Asia/Shanghai	0
3499	Limbunya Airport	Limbunya	Australia	AU	LIB	YLIM	129.8	-17.2	Australia/Darwin	0
3500	Campobasso Airport	Campobasso	Italy	IT	QPB	LIBS	14.65	41.566667	Europe/Rome	0
3501	Potenza Airport	Potenza	Italy	IT	QPO	LIBZ	15.8	40.633333	Europe/Rome	0
3502	Limon Municipal Airport	Limon	United States	US	LIC	KLIC	-103.683333	39.266667	America/Denver	0
3503	Valkenburg Airport	Leiden	Netherlands	NL	LID	EHVB	4.5	52.15	Europe/Amsterdam	0
3504	Libenge Airport	Libenge	The Democratic Republic of The Congo	CD	LIE	FZFA	18.638889	3.623611	Africa/Kinshasa	0
3505	Lifou Airport	Lifou	New Caledonia	NC	LIF	NWWL	167.25	-20.766667	Pacific/Noumea	0
3506	Bellegarde Airport	Limoges	France	FR	LIG	LFBL	1.176245	45.862179	Europe/Paris	0
3507	Lihue Airport	Kauai Island	United States	US	LIH	PHLI	-159.349445	21.978204	Pacific/Honolulu	0
3508	Mulia Airport	Mulia	Indonesia	ID	LII	WAVA	137.966667	-3.733333	Asia/Jayapura	0
3509	Lille Airport	Lille	France	FR	LIL	LFQQ	3.106067	50.572047	Europe/Paris	0
3510	Como Airport	Como	Italy	IT	QCM	LILY	9.069722	45.814722	Europe/Rome	0
3511	Lima Jorge Chavez International Airport	Lima	Peru	PE	LIM	SPJC	-77.10879	-12.024763	America/Lima	0
3512	Milano Linate Airport	Milan	Italy	IT	LIN	LIML	9.279157	45.460958	Europe/Rome	0
3513	Limon International Airport	Limon	Costa Rica	CR	LIO	MRLM	-83.025518	9.962695	America/Costa_Rica	0
3514	Lins Airport	Lins	Brazil	BR	LIP	SBLN	-49.75	-21.666667	America/Sao_Paulo	0
3515	Lisala Airport	Lisala	The Democratic Republic of The Congo	CD	LIQ	FZGA	21.496667	2.170556	Africa/Kinshasa	0
3516	Guanacaste Airport	Guanacaste	Costa Rica	CR	LIR	MRLB	-85.538394	10.600005	America/Costa_Rica	0
3517	Salerno Costa d'Amalfi Airport	Salerno	Italy	IT	QSR	LIRI	14.92084	40.620146	Europe/Rome	0
3518	Lisbon Humberto Delgado Airport	Lisbon	Portugal	PT	LIS	LPPT	-9.128165	38.770043	Europe/Lisbon	0
3519	Bill and Hillary Clinton National Airport	Little Rock	United States	US	LIT	KLIT	-92.221374	34.727431	America/Chicago	0
3520	Loikaw Airport	Loikaw	Myanmar	MM	LIW	VYLK	97.214384	19.689546	Asia/Yangon	0
3521	Likoma Island Airport	Likoma Island	Malawi	MW	LIX	FWLK	34.737195	-12.075532	Africa/Blantyre	0
3522	Wright Army Air Field	Hinesville	United States	US	LIY	KLHW	-81.6	31.85	America/New_York	0
3523	Lodja Airport	Lodja	The Democratic Republic of The Congo	CD	LJA	FZVA	23.618839	-3.46296	Africa/Lubumbashi	0
3524	Lijiang Sanyi Airport	Lijiang	China	CN	LJG	ZPLJ	100.245768	26.679975	Asia/Shanghai	0
3525	Brazoria County Airport	Lake Jackson	United States	US	LJN	KLBX	-95.462097	29.108601	America/Chicago	0
3526	Ljubljana Joze Pucnik Airport	Ljubljana	Slovenia	SI	LJU	LJLJ	14.454972	46.23102	Europe/Ljubljana	0
3527	Gewayenta Airport	Larantuka	Indonesia	ID	LKA	WATL	123.001315	-8.274301	Asia/Makassar	0
3528	Lakeba Island Airport	Lakeba	Fiji	FJ	LKB	NFNK	-178.816461	-18.199565	Pacific/Fiji	0
3529	Lakeland Downs Airport	Lakeland Downs	Australia	AU	LKD	YLND	144.95	-15.816667	Australia/Brisbane	0
3530	Lokichogio Airport	Lokichogio	Kenya	KE	LKG	HKLK	34.349976	4.203645	Africa/Nairobi	0
3531	Long Akah Airport	Long Akah	Malaysia	MY	LKH	WBGA	114.785657	3.312934	Asia/Kuala_Lumpur	0
3532	Lasikin Airport	Sinabang	Indonesia	ID	LKI	WIML	96.326766	2.410916	Asia/Jakarta	0
3533	Kulik Lake Airport	Kulik Lake	United States	US	LKK	PAKL	-155.098514	58.965564	America/Anchorage	0
3534	Banak Airport	Lakselv	Norway	NO	LKL	ENNA	24.973611	70.067778	Europe/Oslo	0
3535	Leknes Airport	Leknes	Norway	NO	LKN	ENLK	13.614864	68.154216	Europe/Oslo	0
3536	Chaudhary Charan Singh International Airport	Lucknow	India	IN	LKO	VILK	80.884186	26.764257	Asia/Kolkata	0
3537	Lake Placid Airport	Lake Placid	United States	US	LKP	KLKP	-73.961899	44.2645	America/New_York	0
3538	Lake County Airport	Lakeview	United States	US	LKV	KLKV	-120.4	42.166667	America/Los_Angeles	0
3539	Lake Manyara Airport	Lake Manyara	United Republic of Tanzania	TZ	LKY	HTLM	35.816626	-3.374524	Africa/Dar_es_Salaam	0
3540	Lakenheath RAF	Brandon	United Kingdom	GB	LKZ	EGUL	0.67609	52.491667	Europe/London	0
3541	Lulea Airport	Lulea	Sweden	SE	LLA	ESPA	22.121523	65.548278	Europe/Stockholm	0
3542	Cagayan North International Airport	Lal-lo	Philippines	PH	LLC	RPLH	121.7458	18.1819	Asia/Manila	0
3543	Malelane Airport	Malelane	South Africa	ZA	LLE	FAMN	31.566667	-25.466667	Africa/Johannesburg	0
3544	Lingling Airport	Yongzhou	China	CN	LLF	ZGLG	111.612222	26.345556	Asia/Shanghai	0
3545	Chillagoe Airport	Chillagoe	Australia	AU	LLG	YCGO	144.527967	-17.14084	Australia/Brisbane	0
3546	Lalibela Airport	Lalibela	Ethiopia	ET	LLI	HALL	39.066667	12.016667	Africa/Addis_Ababa	0
3547	Lankaran International Airport	Lankaran	Azerbaijan	AZ	LLK	UBBL	48.824093	38.74203	Asia/Baku	0
3548	Lissadell Airport	Lissadell	Australia	AU	LLL	YLDL	128.633333	-16.566667	Australia/Perth	0
3549	Lomlom Airport	Lomlom	Solomon Islands	SB	LLM	AGLM	166.33	-10.2975	Pacific/Guadalcanal	0
3550	Kelila Airport	Kelila	Indonesia	ID	LLN	WAVL	138.666667	-3.75	Asia/Jayapura	0
3551	Linda Downs Airport	Linda Downs	Australia	AU	LLP	YLDS	138.7	-23.166667	Australia/Brisbane	0
3552	Alluitsup Paa Heliport	Alluitsup Paa	Greenland	GL	LLU	BGAP	-45.588847	60.464529	America/Godthab	0
3553	Lilongwe International Airport	Lilongwe	Malawi	MW	LLW	FWKI	33.780199	-13.780039	Africa/Blantyre	0
3554	Burlington County Airport	Mount Holly	United States	US	LLY	KVAY	-74.75	39.916667	America/New_York	0
3555	Salima Airport	Salima	Malawi	MW	LMB	FWSM	34.583333	-13.75	Africa/Blantyre	0
3556	Arnage Airport	Le Mans	France	FR	LME	LFRM	0.201667	47.948601	Europe/Paris	0
3557	Federal Airport	Los Mochis	Mexico	MX	LMM	MMLM	-109.081001	25.6852	America/Mazatlan	0
3558	Limbang Airport	Limbang	Malaysia	MY	LMN	WBGJ	115	4.666667	Asia/Kuala_Lumpur	0
3559	Lossiemouth Royal Air Force Station	Lossiemouth	United Kingdom	GB	LMO	EGQS	-3.339777	57.705527	Europe/London	0
3560	Lampedusa Airport	Lampedusa	Italy	IT	LMP	LICD	12.616667	35.5	Europe/Rome	0
3561	Marsa el Brega Airport	Marsa el Brega	Libya	LY	LMQ	HLMB	19.579444	30.379444	Africa/Tripoli	0
3562	Lima Acres Airport	Lima Acres	South Africa	ZA	LMR	FALC	23.45	-28.366667	Africa/Johannesburg	0
3563	Winston County Airport	Louisville	United States	US	LMS	KLMS	-89.05	33.116667	America/Chicago	0
3564	Crater Lake Klamath Regional Airport	Klamath Falls	United States	US	LMT	KLMT	-121.735833	42.163056	America/Los_Angeles	0
3565	Letung Airport	Jemaja Island	Indonesia	ID	LMU	WIDL	105.754444	2.963056	Asia/Jakarta	0
3566	Lopez De Micay Airport	Lopez De Micay	Colombia	CO	LMX	SKZI	-77.55	3.05	America/Bogota	0
3567	Palm Beach County Airport	West Palm Beach	United States	US	LNA	KLNA	-80.084477	26.592477	America/New_York	0
3568	Lamen Bay Airport	Lamen Bay	Vanuatu	VU	LNB	NVSM	168.183333	-16.583333	Pacific/Efate	0
3569	Hunt Field	Lander	United States	US	LND	KLND	-108.733333	42.833333	America/Denver	0
3570	Lonorore Airport	Lonorore	Vanuatu	VU	LNE	NVSO	168.170072	-15.860106	Pacific/Efate	0
3571	Lake Nash Airport	Lake Nash	Australia	AU	LNH	YLKN	138	-20.95	Australia/Darwin	0
3572	Lincang Airport	Lincang	China	CN	LNJ	ZPLC	100.026244	23.744107	Asia/Shanghai	0
3573	Lincoln Airport	Lincoln	United States	US	LNK	KLNK	-96.754707	40.846176	America/Chicago	0
3574	Lost Nation Airport	Willoughby	United States	US	LNN	KLNN	-81.391396	41.683646	America/New_York	0
3575	Leonora Airport	Leonora	Australia	AU	LNO	YLEO	121.316924	-28.879344	Australia/Perth	0
3576	Wise Airport	Wise	United States	US	LNP	KLNP	-82.566667	36.983333	America/New_York	0
3577	Tri County Regional Airport	Lone Rock	United States	US	LNR	KLNR	-90.182116	43.211908	America/Chicago	0
3578	Lancaster Airport	Lancaster	United States	US	LNS	KLNS	-76.299722	40.121111	America/New_York	0
3579	Kolonel RA Bessing Airport	Malinau	Indonesia	ID	LNU	WALM	116.618333	3.576389	Asia/Makassar	0
3580	Lihir Island Airport	Lihir Island	Papua New Guinea	PG	LNV	AYKY	152.627191	-3.043223	Pacific/Port_Moresby	0
3581	Lanai Airport	Lanai	United States	US	LNY	PHNY	-156.950481	20.790084	Pacific/Honolulu	0
3582	Linz Airport	Linz	Austria	AT	LNZ	LOWL	14.193345	48.239868	Europe/Vienna	0
3583	Lorraine Airport	Lorraine	Australia	AU	LOA	YLOR	139.9	-19	Australia/Brisbane	0
3584	Los Andes Airport	Los Andes	Chile	CL	LOB	SCAN	-71.533333	-29.966667	America/Santiago	0
3585	Lock Airport	Lock	Australia	AU	LOC	YLOK	135.75	-33.55	Australia/Adelaide	0
3586	Longana Airport	Longana	Vanuatu	VU	LOD	NVSG	167.966667	-15.316667	Pacific/Efate	0
3587	Loei Airport	Loei	Thailand	TH	LOE	VTUL	101.72187	17.437847	Asia/Bangkok	0
3588	Ciudad de Catamayo Airport	Loja	Ecuador	EC	LOH	SECA	-79.37193	-3.995881	America/Guayaquil	0
3589	Lodwar Airport	Lodwar	Kenya	KE	LOK	HKLO	35.6	3.15	Africa/Nairobi	0
3590	Derby Field	Lovelock	United States	US	LOL	KLOL	-118.566667	40.058333	America/Los_Angeles	0
3591	L'Mekrareg Airport	Laghouat	Algeria	DZ	LOO	DAUL	2.934811	33.761019	Africa/Algiers	0
3592	Lombok International Airport	Praya	Indonesia	ID	LOP	WADL	116.273838	-8.761611	Asia/Makassar	0
3593	Lagos Murtala Muhammed International Airport	Lagos	Nigeria	NG	LOS	DNMM	3.321156	6.57737	Africa/Lagos	0
3594	Lewis University Airport	Romeoville	United States	US	LOT	KLOT	-88.09617	41.607476	America/Chicago	0
3595	Bowman Field	Louisville	United States	US	LOU	KLOU	-85.656879	38.227275	America/New_York	0
3596	Venustiano Carranza International Airport	Monclova	Mexico	MX	LOV	MMMV	-101.466072	26.955455	America/Mexico_City	0
3597	Louisa Airport	Louisa	United States	US	LOW	KLKU	-77.966667	38	America/New_York	0
3598	Loyangalani Airport	Loyangalani	Kenya	KE	LOY	HKLY	36.716667	2.75	Africa/Nairobi	0
3599	Magee Field	London	United States	US	LOZ	KLOZ	-84.076944	37.087222	America/New_York	0
3600	Gran Canaria Airport	Las Palmas	Spain and Canary Islands	ES	LPA	GCLP	-15.384626	27.932398	Atlantic/Canary	0
3601	Alverca Airport	Alverca	Portugal	PT	AVR	LPAR	-9.033106	38.885271	Europe/Lisbon	0
3602	El Alto International Airport	La Paz	Bolivia	BO	LPB	SLLP	-68.176903	-16.508891	America/La_Paz	0
3603	Beja International Airport	Beja	Portugal	PT	BYJ	LPBJ	-7.926813	38.090242	Europe/Lisbon	0
3604	Lompoc Airport	Lompoc	United States	US	LPC	KLPC	-120.466196	34.664642	America/Los_Angeles	0
3605	La Pedrera Airport	La Pedrera	Colombia	CO	LPD	SKLP	-69.716667	-1.3	America/Bogota	0
3606	La Primavera Airport	La Primavera	Colombia	CO	LPE	SKIM	-76.216667	3.733333	America/Bogota	0
3607	La Plata Airport	La Plata	Argentina	AR	LPG	SADL	-57.892334	-34.974952	America/Argentina/Buenos_Aires	0
3608	Linkoping City Airport	Linkoping	Sweden	SE	LPI	ESSL	15.656944	58.406944	Europe/Stockholm	0
3609	Pijiguaos Airport	Pijiguaos	Venezuela	VE	LPJ	SVAS	-67.666667	7	America/Caracas	0
3610	Lipetsk Airport	Lipetsk	Russian Federation	RU	LPK	UUOL	39.53822	52.703411	Europe/Moscow	0
3611	Liverpool John Lennon Airport	Liverpool	United Kingdom	GB	LPL	EGGP	-2.854905	53.337616	Europe/London	0
3612	Lamap Airport	Lamap	Vanuatu	VU	LPM	NVSL	167.816667	-16.466667	Pacific/Efate	0
3613	Monte Real Airport	Monte Real	Portugal	PT	QLR	LPMR	-8.8875	39.828333	Europe/Lisbon	0
3614	Laporte Municipal Airport	Laporte	United States	US	LPO	KPPO	-86.716667	41.6	America/Chicago	0
3615	Lappeenranta Airport	Lappeenranta	Finland	FI	LPP	EFLP	28.155163	61.044114	Europe/Helsinki	0
3616	Luang Prabang International Airport	Luang Prabang	Lao People's Democratic Republic	LA	LPQ	VLLB	102.163709	19.897055	Asia/Vientiane	0
3617	Lampang Airport	Lampang	Thailand	TH	LPT	VTCL	99.507222	18.274167	Asia/Bangkok	0
3618	Long Apung Airport	Long Apung	Indonesia	ID	LPU	WALP	114.969985	1.707091	Asia/Makassar	0
3619	Liepaya Airport	Liepaya	Latvia	LV	LPX	EVLA	21.1	56.516667	Europe/Riga	0
3620	Loudes Airport	Le Puy	France	FR	LPY	LFHP	3.766667	45.083333	Europe/Paris	0
3621	Pickens Airport	Pickens	United States	US	LQK	KLQK	-82.7	34.883333	America/New_York	0
3622	Puerto Leguizamo Airport	Puerto Leguizamo	Colombia	CO	LQM	SKLG	-74.583333	-0.3	America/Bogota	0
3623	Qala i Naw Airport	Qala i Naw	Afghanistan	AF	LQN	OAQN	63.119055	34.986638	Asia/Kabul	0
3624	Larisa Airport	Larisa	Greece	GR	LRA	LGLR	22.463889	39.651111	Europe/Athens	0
3625	Leribe Airport	Leribe	Lesotho	LS	LRB	FXLR	28	-28.966667	Africa/Maseru	0
3626	Bistrita Nasaud Airport	Bistrita/Nasaud	Romania	RO	QBY	LRBN	24.551667	47.158333	Europe/Bucharest	0
3627	Laredo International Airport	Laredo	United States	US	LRD	KLRD	-99.455122	27.543667	America/Chicago	0
3628	Longreach Airport	Longreach	Australia	AU	LRE	YLRE	144.271464	-23.439475	Australia/Brisbane	0
3629	Little Rock Air Force Base	Jacksonville	United States	US	LRF	KLRF	-92.15	34.916667	America/Chicago	0
3630	Laleu Airport	La Rochelle	France	FR	LRH	LFBH	-1.185833	46.180556	Europe/Paris	0
3631	Lemars Municipal Airport	Lemars	United States	US	LRJ	KLRJ	-96.166667	42.8	America/Chicago	0
3632	Niamtougou Airport	Niamtougou	Togo	TG	LRL	DXNG	1.091265	9.767359	Africa/Lome	0
3633	La Romana Airport	La Romana	Dominican Republic	DO	LRM	MDLR	-68.9	18.416667	America/Santo_Domingo	0
3634	Lar Airport	Lar	Iran	IR	LRR	OISL	54.38276	27.669689	Asia/Tehran	0
3635	Leros Airport	Leros	Greece	GR	LRS	LGLE	26.783333	37.516667	Europe/Athens	0
3636	Lann Bihoue Airport	Lorient	France	FR	LRT	LFRH	-3.436394	47.753739	Europe/Paris	0
3637	Las Cruces Municipal Airport	Las Cruces	United States	US	LRU	KLRU	-106.921667	32.290833	America/Denver	0
3638	Los Roques Airport	Los Roques	Venezuela	VE	LRV	SVRS	-66.750117	11.857591	America/Caracas	0
3639	Losuia Airport	Losuia	Papua New Guinea	PG	LSA	AYKA	151.081501	-8.506888	Pacific/Port_Moresby	0
3640	Lordsburg Airport	Lordsburg	United States	US	LSB	KLSB	-108.666667	32.416667	America/Denver	0
3641	La Florida Airport	La Serena	Chile	CL	LSC	SCSE	-71.203688	-29.917297	America/Santiago	0
3642	La Crosse Regional Airport	La Crosse	United States	US	LSE	KLSE	-91.264334	43.875245	America/Chicago	0
3643	Lawson Army Air Field - Ft Benning	Columbus	United States	US	LSF	KLSF	-84.990074	32.335278	America/New_York	0
3644	Lashio Airport	Lashio	Myanmar	MM	LSH	VYLS	97.75	22.966667	Asia/Yangon	0
3645	Sumburgh Airport	Shetland Islands	United Kingdom	GB	LSI	EGPB	-1.287111	59.877889	Europe/London	0
3646	Lusk Municipal	Lusk	United States	US	LSK	KLSK	-104.445528	42.788083	America/Denver	0
3647	Los Chiles Airport	Los Chiles	Costa Rica	CR	LSL	MRLC	-84.7	11.033333	America/Costa_Rica	0
3648	Lawas Airport	Long Semado	Malaysia	MY	LSM	WBGD	118.008333	4.002778	Asia/Kuala_Lumpur	0
3649	Los Banos Airport	Los Banos	United States	US	LSN	KLSN	-120.85	37.066667	America/Los_Angeles	0
3650	Josefa Camejo Airport	Las Piedras	Venezuela	VE	LSP	SVJC	-70.14961	11.777155	America/Caracas	0
3651	Los Angeles Airport	Los Angeles	Chile	CL	LSQ	SCGE	-72.422778	-37.3975	America/Santiago	0
3652	Les Saintes Airport	Terre-de-Haut	Guadeloupe	GP	LSS	TFFS	-61.580187	15.864594	America/Guadeloupe	0
3653	Launceston Airport	Launceston	Australia	AU	LST	YMLT	147.205328	-41.543511	Australia/Hobart	0
3654	Nellis Air Force Base	Las Vegas	United States	US	LSV	KLSV	-115.035953	36.23297	America/Los_Angeles	0
3655	Malikus Saleh Airport	Lhoksumawe	Indonesia	ID	LSW	WIMA	96.950278	5.226667	Asia/Jakarta	0
3656	Lhok Sukon Airport	Lhok Sukon	Indonesia	ID	LSX	WITL	97.316667	5.066667	Asia/Jakarta	0
3657	Lismore Airport	Lismore	Australia	AU	LSY	YLIS	153.263362	-28.836652	Australia/Sydney	0
3658	Losinj Airport	Mali Losinj	Croatia	HR	LSZ	LDLO	14.3931	44.5658	Europe/Zagreb	0
3659	Letaba Airport	Tzaneen	South Africa	ZA	LTA	FATZ	30.15	-23.833333	Africa/Johannesburg	0
3660	Lai Airport	Lai	Chad	TD	LTC	FTTH	16.3	9.416667	Africa/Ndjamena	0
3661	Ghadames Airport	Ghadames	Libya	LY	LTD	HLTD	9.509722	30.129167	Africa/Tripoli	0
3662	Langtang Airport	Langtang	Nepal	NP	LTG	VNLT	85.6	28.233333	Asia/Kathmandu	0
3663	Altai Airport	Altai	Mongolia	MN	LTI	ZMAT	96.221008	46.376184	Asia/Ulaanbaatar	0
3664	Bassel al-Assad International Airport	Latakia	Syrian Arab Republic	SY	LTK	OSLK	35.943994	35.407353	Asia/Damascus	0
3665	Lastourville Airport	Lastourville	Gabon	GA	LTL	FOOR	12.716667	-0.833333	Africa/Libreville	0
3666	Lethem Airport	Lethem	Guyana	GY	LTM	SYLT	-59.79	3.371667	America/Guyana	0
3667	London Luton Airport	London	United Kingdom	GB	LTN	EGGW	-0.376232	51.879768	Europe/London	0
3668	Loreto Airport	Loreto	Mexico	MX	LTO	MMLT	-111.35	25.983333	America/Mazatlan	0
3669	Lyndhurst Airport	Lyndhurst	Australia	AU	LTP	YLHS	138.35	-30.283333	Australia/Brisbane	0
3670	Le Touquet Airport	Le Touquet	France	FR	LTQ	LFAT	1.627071	50.514775	Europe/Paris	0
3671	Letterkenny Airport	Letterkenny	Ireland	IE	LTR	EILT	-7.733333	54.95	Europe/Dublin	0
3672	Altus Air Force Base	Altus	United States	US	LTS	KLTS	-99.269343	34.658354	America/Chicago	0
3673	La Mole Airport	Saint Tropez	France	FR	LTT	LFTZ	6.483263	43.205651	Europe/Paris	0
3674	Lotusvale Airport	Lotusvale	Australia	AU	LTV	YLOV	141.383333	-17.05	Australia/Brisbane	0
3675	Cotapaxi International Airport	Latacunga	Ecuador	EC	LTX	SELT	-78.616089	-0.918468	America/Guayaquil	0
3676	Tenzing-Hillary Airport	Lukla	Nepal	NP	LUA	VNLK	86.731753	27.687637	Asia/Kathmandu	0
3677	Lumid Pau Airport	Lumid Pau	Guyana	GY	LUB	SYLP	-59.433333	2.4	America/Guyana	0
3678	Laucala Island Airport	Laucala Island	Fiji	FJ	LUC	NFNH	179.667273	-16.74889	Pacific/Fiji	0
3679	Luderitz Airport	Luderitz	Namibia	NA	LUD	FYLZ	15.243889	-26.686389	Africa/Windhoek	0
3680	Lucenec Airport	Lucenec	Slovakia	SK	LUE	LZLU	19.666667	48.333333	Europe/Bratislava	0
3681	Luke Air Force Base	Phoenix	United States	US	LUF	KLUF	-112.372838	33.536394	America/Phoenix	0
3682	Lugano Airport	Lugano	Switzerland	CH	LUG	LSZA	8.909827	46.002393	Europe/Zurich	0
3683	Ludhiana Airport	Ludhiana	India	IN	LUH	VILD	75.85	30.9	Asia/Kolkata	0
3684	Lusikisiki Airport	Lusikisiki	South Africa	ZA	LUJ	FALK	29.583333	-31.366667	Africa/Johannesburg	0
3685	Cincinnati Municipal Airport -  Lunken Field	Cincinnati	United States	US	LUK	KLUK	-84.418596	39.103297	America/New_York	0
3686	Hesler-Noble Field	Laurel	United States	US	LUL	KLUL	-89.172207	31.672604	America/Chicago	0
3687	Dehong Mangshi Airport	Mangshi	China	CN	LUM	ZPMS	98.531897	24.405279	Asia/Shanghai	0
3688	Kenneth Kaunda International Airport	Lusaka	Zambia	ZM	LUN	FLKK	28.44567	-15.326256	Africa/Lusaka	0
3689	Luena Airport	Luena	Angola	AO	LUO	FNUE	19.89778	-11.76806	Africa/Luanda	0
3690	Kalaupapa Airport	Kalaupapa	United States	US	LUP	PHLU	-156.974444	21.211111	Pacific/Honolulu	0
3691	San Luis Airport	San Luis	Argentina	AR	LUQ	SAOU	-66.358611	-33.274444	America/Argentina/Buenos_Aires	0
3692	Cape Lisburne Airport	Cape Lisburne	United States	US	LUR	PALU	-166.106944	68.875833	America/Anchorage	0
3693	Lusanga Airport	Lusanga	The Democratic Republic of The Congo	CD	LUS	FZCE	18.718886	-4.804654	Africa/Kinshasa	0
3694	Laura Station Airport	Laura Station	Australia	AU	LUT	YLRS	144.816667	-15.433333	Australia/Brisbane	0
3695	Laura Airport	Laura	Australia	AU	LUU	YLRA	144.166667	-15.666667	Australia/Brisbane	0
3696	Langgur Airport	Langgur	Indonesia	ID	LUV	WAPL	132.716667	-5.666667	Asia/Jayapura	0
3697	S. Aminuddin Amir Airport	Luwuk	Indonesia	ID	LUW	WAFW	122.771611	-1.039336	Asia/Makassar	0
3698	Luxembourg Airport	Luxembourg	Luxembourg	LU	LUX	ELLX	6.209539	49.631113	Europe/Luxembourg	0
3699	Lublin Airport	Swidnik	Poland	PL	LUZ	EPLB	22.690278	51.231944	Europe/Warsaw	0
3700	Entrammes Airport	Laval	France	FR	LVA	LFOV	-0.766667	48.066667	Europe/Paris	0
3701	Dos Galpoes Airport	Livramento	Brazil	BR	LVB	SSLI	-55.616667	-30.833333	America/Sao_Paulo	0
3702	Livingstone Airport	Livingstone	Zambia	ZM	LVI	FLHN	25.822222	-17.820556	Africa/Lusaka	0
3703	Livermore Municipal Airport	Livermore	United States	US	LVK	KLVK	-121.817222	37.693889	America/Los_Angeles	0
3704	Lawrenceville Airport	Lawrenceville	United States	US	LVL	KLVL	-77.833333	36.75	America/New_York	0
3705	Mission Field	Livingston	United States	US	LVM	KLVM	-110.566667	45.666667	America/Denver	0
3706	Laverton Airport	Laverton	Australia	AU	LVO	YLTN	122.423112	-28.614391	Australia/Perth	0
3707	Lavan Island Airport	Lavan	Iran	IR	LVP	OIBV	53.356111	26.810278	Asia/Tehran	0
3708	Las Vegas Airport	Las Vegas	United States	US	LVS	KLVS	-105.216667	35.6	America/Denver	0
3709	Greenbrier Valley Airport	Lewisburg	United States	US	LWB	KLWB	-80.398611	37.859722	America/New_York	0
3710	Lawrence Airport	Lawrence	United States	US	LWC	KLWC	-95.2175	39.009167	America/Chicago	0
3711	Wunopito Airport	Lewoleba	Indonesia	ID	LWE	WATW	123.43778	-8.36278	Asia/Makassar	0
3712	Lawn Hill Airport	Lawn Hill	Australia	AU	LWH	YLAH	138.584282	-18.576637	Australia/Brisbane	0
3713	Lerwick/Tingwall Airport	Shetland Islands	United Kingdom	GB	LWK	EGET	-1.245291	60.189061	Europe/London	0
3714	Wells Municipal Airport-Harriet Field	Wells	United States	US	LWL	KLWL	-114.922214	41.117098	America/Los_Angeles	0
3715	Lawrence Municipal Airport	Lawrence	United States	US	LWM	KLWM	-71.1225	42.7175	America/New_York	0
3716	Leninakan Airport	Gyoumri	Armenia	AM	LWN	UDSG	43.859444	40.750556	Asia/Yerevan	0
3717	Lviv International Airport	Lviv	Ukraine	UA	LWO	UKLL	23.959311	49.812296	Europe/Kiev	0
3718	Leeuwarden Air Base	Leeuwarden	Netherlands	NL	LWR	EHLW	5.760549	53.228594	Europe/Amsterdam	0
3719	Lewiston-Nez Perce County Regional Airport	Lewiston	United States	US	LWS	KLWS	-117.014444	46.374722	America/Los_Angeles	0
3720	Lewistown Municipal Airport	Lewistown	United States	US	LWT	KLWT	-109.471111	47.051111	America/Denver	0
3721	Lawrenceville Municipal Airport	Lawrenceville	United States	US	LWV	KLWV	-87.683333	38.733333	America/Chicago	0
3722	Lawas Airport	Lawas	Malaysia	MY	LWY	WBGW	115.406995	4.846565	Asia/Kuala_Lumpur	0
3723	Lhasa Gonggar Airport	Lhasa/Lasa	China	CN	LXA	ZULS	90.911903	29.2978	Asia/Shanghai	0
3724	Luang Namtha Airport	Luang Namtha	Lao People's Democratic Republic	LA	LXG	VLLN	101.466667	21.05	Asia/Vientiane	0
3725	Jim Kelly Field	Lexington	United States	US	LXN	KLXN	-99.777288	40.791002	America/Chicago	0
3726	Luxor International Airport	Luxor	Egypt	EG	LXR	HELX	32.699683	25.674919	Africa/Cairo	0
3727	Limnos Airport	Limnos	Greece	GR	LXS	LGLM	25.233446	39.923906	Europe/Athens	0
3728	Lukulu Airport	Lukulu	Zambia	ZM	LXU	FLLK	23.2	-14.416667	Africa/Lusaka	0
3729	Leadville Airport	Leadville	United States	US	LXV	KLXV	-106.316111	39.220278	America/Denver	0
3730	Luoyang Beijiao Airport	Luoyang	China	CN	LYA	ZHLY	112.385406	34.736361	Asia/Shanghai	0
3731	Little Cayman Airport	Little Cayman	Cayman Islands	KY	LYB	MWCL	-80.084715	19.6592	America/Cayman	0
3732	Lycksele Airport	Lycksele	Sweden	SE	LYC	ESNL	18.716216	64.548308	Europe/Stockholm	0
3733	Lyneham Royal Air Force Station	Lyneham	United Kingdom	GB	LYE	EGDL	-1.99318	51.505741	Europe/London	0
3734	Lianyungang Airport	Lianyungang	China	CN	LYG	ZSLG	118.876986	34.565938	Asia/Shanghai	0
3735	Preston-Glenn Field	Lynchburg	United States	US	LYH	KLYH	-79.201111	37.326944	America/New_York	0
3736	Linyi Airport	Linyi	China	CN	LYI	ZSLY	118.407068	35.047477	Asia/Shanghai	0
3737	Lunyuk Airport	Lunyuk	Indonesia	ID	LYK	WADU	117.266667	-9	Asia/Makassar	0
3738	Bron Airport	Lyon	France	FR	LYN	LFLY	4.943333	45.730833	Europe/Paris	0
3739	Novi Sad Airport	Novi Sad	Republic of Serbia	RS	QND	LYNS	19.833844	45.385731	Europe/Belgrade	0
3740	Rice County Municipal Airport	Lyons	United States	US	LYO	KLYO	-98.2	38.35	America/Chicago	0
3741	Faisalabad Airport	Faisalabad	Pakistan	PK	LYP	OPFA	72.987572	31.363042	Asia/Karachi	0
3742	Pancevo Airport	Pancevo	Republic of Serbia	RS	QBG	LYPA	20.642181	44.899317	Europe/Belgrade	0
3743	Svalbard Airport	Longyearbyen	Svalbard & Jan Mayen Island	SJ	LYR	ENSB	15.461952	78.246315	Arctic/Longyearbyen	0
3744	Lyon Saint Exupery Airport	Lyon	France	FR	LYS	LFLL	5.080334	45.721426	Europe/Paris	0
3745	Lady Elliot Island Airport	Lady Elliot Island	Australia	AU	LYT	YLTT	152.7	-24.116667	Australia/Brisbane	0
3746	Ely Airport	Ely	United States	US	LYU	KELO	-91.829167	47.823889	America/Chicago	0
3747	Valjevo Airport	Valjevo	Republic of Serbia	RS	QWV	LYVA	20.021558	44.297972	Europe/Belgrade	0
3748	Lydd International Airport	Lydd	United Kingdom	GB	LYX	EGMD	0.938414	50.955333	Europe/London	0
3749	Luiza Airport	Luiza	The Democratic Republic of The Congo	CD	LZA	FZUG	22.5	-7.666667	Africa/Kinshasa	0
3750	Lazaro Cardenas Airport	Lazaro Cardenas	Mexico	MX	LZC	MMLC	-102.216667	18	America/Mexico_City	0
3751	Liuzhou Airport	Liuzhou	China	CN	LZH	ZGZH	109.398427	24.206155	Asia/Shanghai	0
3752	Luozi Airport	Luozi	The Democratic Republic of The Congo	CD	LZI	FZAL	14	-4.9	Africa/Kinshasa	0
3753	Matsu Nangan Airport	Nangan	China	CN	LZN	RCFG	119.958333	26.159444	Asia/Shanghai	0
3754	Yunlong Airport	Luzhou	China	CN	LZO	ZULZ	105.46889	29.030556	Asia/Shanghai	0
3755	Lizard Island Airport	Lizard Island	Australia	AU	LZR	YLZI	145.451358	-14.670046	Australia/Brisbane	0
3756	Nyingchi Mainling Airport	Nyingchi	China	CN	LZY	ZUNZ	94.335883	29.309076	Asia/Shanghai	0
3757	Chennai International Airport	Chennai	India	IN	MAA	VOMM	80.163782	12.982267	Asia/Kolkata	0
3758	Maraba Airport	Maraba	Brazil	BR	MAB	SBMA	-49.166667	-5.366667	America/Belem	0
3759	Macon Downtown Airport	Macon	United States	US	MAC	KMAC	-83.562019	32.822158	America/New_York	0
3760	Adolfo Suarez Madrid-Barajas Airport	Madrid	Spain and Canary Islands	ES	MAD	LEMD	-3.564479	40.49027	Europe/Madrid	0
3761	Madera Airport	Madera	United States	US	MAE	KMAE	-120.066667	36.95	America/Los_Angeles	0
3762	Midland International Airport	Midland	United States	US	MAF	KMAF	-102.208167	31.937145	America/Chicago	0
3763	Madang Airport	Madang	Papua New Guinea	PG	MAG	AYMD	145.787849	-5.210852	Pacific/Port_Moresby	0
3764	Menorca Airport	Menorca	Spain and Canary Islands	ES	MAH	LEMH	4.224099	39.86503	Europe/Madrid	0
3765	Mangochi Airport	Mangochi	Malawi	MW	MAI	FWMG	35.25	-14.5	Africa/Blantyre	0
3766	Amata Kabua International Airport	Majuro	Marshall Islands	MH	MAJ	PKMJ	171.282508	7.068717	Pacific/Majuro	0
3767	Malakal Airport	Malakal	South Sudan	SS	MAK	HJMK	31.644444	9.555556	Africa/Juba	0
3768	Mangole Airport	Mangole	Indonesia	ID	MAL	WAEO	125.916667	-1.833333	Asia/Jayapura	0
3769	Matamoros Airport	Matamoros	Mexico	MX	MAM	MMMA	-97.523611	25.770278	America/Matamoros	0
3770	Manchester Airport	Manchester	United Kingdom	GB	MAN	EGCC	-2.273354	53.362908	Europe/London	0
3771	Eduardo Gomes International Airport	Manaus	Brazil	BR	MAO	SBEG	-60.046092	-3.031327	America/Porto_Velho	0
3772	Mae Sot Airport	Mae Sot	Thailand	TH	MAQ	VTPM	98.543474	16.701422	Asia/Bangkok	0
3773	La Chinita Airport	Maracaibo	Venezuela	VE	MAR	SVMC	-71.723508	10.555564	America/Caracas	0
3774	Momote Airport	Manus Island	Papua New Guinea	PG	MAS	AYMO	147.424444	-2.056667	Pacific/Port_Moresby	0
3775	Matadi Airport	Matadi	The Democratic Republic of The Congo	CD	MAT	FZAM	13.441667	-5.798333	Africa/Kinshasa	0
3776	Maupiti Airport	Maupiti	French Polynesia	PF	MAU	NTTP	-152.242351	-16.427386	Pacific/Tahiti	0
3777	Malden Airport	Malden	United States	US	MAW	KMAW	-89.988889	36.605556	America/Chicago	0
3778	Matam Airport	Matam	Senegal	SN	MAX	GOSM	-13.323611	15.593056	Africa/Dakar	0
3779	Mangrove Cay Airport	Mangrove Cay	Bahamas	BS	MAY	MYAB	-77.677867	24.288322	America/Nassau	0
3780	Eugenio M. De Hostos Airport	Mayaguez	Puerto Rico	PR	MAZ	TJMZ	-67.148889	18.257778	America/Puerto_Rico	0
3781	Moi International Airport	Mombasa	Kenya	KE	MBA	HKMO	39.603247	-4.0327	Africa/Nairobi	0
3782	Marble Bar Airport	Marble Bar	Australia	AU	MBB	YMBL	119.583333	-21.25	Australia/Perth	0
3783	Mbigou Airport	Mbigou	Gabon	GA	MBC	FOGG	12	-2	Africa/Libreville	0
3784	Mmabatho International Airport	Mmabatho	South Africa	ZA	MBD	FAMM	25.543468	-25.804892	Africa/Johannesburg	0
3785	Monbetsu Airport	Monbetsu	Japan	JP	MBE	RJEB	143.383333	44.266667	Asia/Tokyo	0
3786	Mount Buffalo Airport	Mount Buffalo	Australia	AU	MBF	YPOK	146.75	-36.75	Australia/Sydney	0
3787	Mobridge Municipal Airport	Mobridge	United States	US	MBG	KMBG	-100.406877	45.544733	America/Chicago	0
3788	Maryborough Airport	Maryborough	Australia	AU	MBH	YMYB	152.713333	-25.516667	Australia/Brisbane	0
3789	Mbeya Airport	Mbeya	United Republic of Tanzania	TZ	MBI	HTMB	33.458858	-8.916634	Africa/Dar_es_Salaam	0
3790	Sangster International Airport	Montego Bay	Jamaica	JM	MBJ	MKJS	-77.916632	18.498464	America/Jamaica	0
3791	Blacker Airport	Manistee	United States	US	MBL	KMBL	-86.253333	44.273889	America/New_York	0
3792	Mt. Barnett Airport	Mount Barnett	Australia	AU	MBN	YBAN	125	-15	Australia/Perth	0
3793	Mamburao Airport	Mamburao	Philippines	PH	MBO	RPUM	120.603333	13.211389	Asia/Manila	0
3794	Moyobamba Airport	Moyobamba	Peru	PE	MBP	SPBB	-77.166667	-6.2	America/Lima	0
3795	Mbarara Airport	Mbarara	Uganda	UG	MBQ	HUMA	30.65	-0.616667	Africa/Kampala	0
3796	Mbout Airport	Mbout	Mauritania	MR	MBR	GQNU	-12.583333	16.033333	Africa/Nouakchott	0
3797	MBS International Airport	Saginaw	United States	US	MBS	KMBS	-84.090742	43.53339	America/New_York	0
3798	Moises R. Espinosa Airport	Masbate	Philippines	PH	MBT	RPVJ	123.62917	12.36944	Asia/Manila	0
3799	Mbambanakira Airport	Mbambanakira	Solomon Islands	SB	MBU	AGGI	159.8394	-9.7461	Pacific/Guadalcanal	0
3800	Moorabbin Airport	Moorabbin	Australia	AU	MBW	YMMB	145.102222	-37.975833	Australia/Sydney	0
3801	Maribor Edvard Rusjan Airport	Maribor	Slovenia	SI	MBX	LJMB	15.686741	46.478502	Europe/Ljubljana	0
3802	Moberly Airport	Moberly	United States	US	MBY	KMBY	-92.426667	39.463889	America/Chicago	0
3803	Maues Airport	Maues	Brazil	BR	MBZ	SWMW	-57.7	-3.4	America/Porto_Velho	0
3804	Macenta Airport	Macenta	Guinea	GN	MCA	GUMA	-9.466667	8.55	Africa/Conakry	0
3805	Pike County Airport	Mc Comb	United States	US	MCB	KMCB	-90.469444	31.175556	America/Chicago	0
3806	McClellan Air Force Base	Sacramento	United States	US	MCC	KMCC	-121.398388	38.662617	America/Los_Angeles	0
3807	Mackinac Island Airport	Mackinac Island	United States	US	MCD	KMCD	-84.637299	45.864899	America/New_York	0
3808	Merced Municipal Airport	Merced	United States	US	MCE	KMCE	-120.512778	37.284722	America/Los_Angeles	0
3809	MacDill Air Force Base	Tampa	United States	US	MCF	KMCF	-82.49993	27.848473	America/New_York	0
3810	McGrath Airport	McGrath	United States	US	MCG	PAMC	-155.601923	62.950732	America/Anchorage	0
3811	Machala Airport	Machala	Ecuador	EC	MCH	SEMH	-79.983333	-3.266667	America/Guayaquil	0
3812	Kansas City International Airport	Kansas City	United States	US	MCI	KMCI	-94.719925	39.293807	America/Chicago	0
3813	Jorge Isaacs Airport	Maicao	Colombia	CO	MCJ	SKMJ	-72.241795	11.389458	America/Bogota	0
3814	Mc Cook Airport	McCook	United States	US	MCK	KMCK	-100.592003	40.206299	America/Chicago	0
3815	Mount Mckinley Airport	Mount McKinley	United States	US	MCL	PAIN	-149.006389	63.875972	America/Anchorage	0
3816	Fontvielle Heliport	Monte Carlo	Monaco	MC	MCM	LNMC	7.419722	43.725833	Europe/Monaco	0
3817	Middle Georgia Regional Airport	Macon	United States	US	MCN	KMCN	-83.648651	32.701987	America/New_York	0
3818	Orlando International Airport	Orlando	United States	US	MCO	KMCO	-81.308301	28.432177	America/New_York	0
3819	Macapa International Airport	Macapa	Brazil	BR	MCP	SBMQ	-51.068384	0.049895	America/Belem	0
3820	Miskolc Airport	Miskolc	Hungary	HU	MCQ	LHMC	20.833333	48.116667	Europe/Budapest	0
3821	Monte Caseros Airport	Monte Caseros	Argentina	AR	MCS	SARM	-57.641111	-30.270833	America/Argentina/Buenos_Aires	0
3822	Muscat International Airport	Muscat	Oman	OM	MCT	OOMS	58.284042	23.600739	Asia/Muscat	0
3823	Gueret (Lepaud) Airport	Montlucon	France	FR	MCU	LFBK	2.36396	46.222599	Europe/Paris	0
3824	Mcarthur River Airport	Mcarthur River	Australia	AU	MCV	YMHU	136.095	-16.466667	Australia/Darwin	0
3825	Mason City Airport	Mason City	United States	US	MCW	KMCW	-93.329444	43.156944	America/Chicago	0
3826	Makhachkala Airport	Makhachkala	Russian Federation	RU	MCX	URML	47.652302	42.816799	Europe/Moscow	0
3827	Sunshine Coast Airport	Sunshine Coast	Australia	AU	MCY	YBSU	153.088208	-26.60538	Australia/Brisbane	0
3828	Maceio-Zumbi dos Palmares International Airport	Maceio	Brazil	BR	MCZ	SBMO	-35.792114	-9.514027	America/Belem	0
3829	Martindale Army Air Field	San Antonio	United States	US	MDA	KMDA	-98.376758	29.43279	America/Chicago	0
3830	Sam Ratulangi International Airport	Manado	Indonesia	ID	MDC	WAMM	124.922029	1.543533	Asia/Makassar	0
3831	Midland Airpark	Midland	United States	US	MDD	KMDD	-102.098865	32.033175	America/Chicago	0
3832	Medellin Jose Maria Cordova International Airport	Medellin	Colombia	CO	MDE	SKRG	-75.428206	6.171382	America/Bogota	0
3833	Mudanjiang Airport	Mudanjiang	China	CN	MDG	ZYMD	129.58384	44.534943	Asia/Shanghai	0
3834	Southern Illinois Airport	Carbondale	United States	US	MDH	KMDH	-89.246944	37.781389	America/Chicago	0
3835	Makurdi Airport	Makurdi	Nigeria	NG	MDI	DNMK	8.533333	7.75	Africa/Lagos	0
3836	Mbandaka Airport	Mbandaka	The Democratic Republic of The Congo	CD	MDK	FZEA	18.288611	0.0225	Africa/Kinshasa	0
3837	Mandalay International Airport	Mandalay	Myanmar	MM	MDL	VYMD	95.977893	21.702169	Asia/Yangon	0
3838	Middleton Island Intermediate Airport	Middleton Island	United States	US	MDO	PAMD	-146.3	59.453056	America/Anchorage	0
3839	Mindiptana Airport	Mindiptana	Indonesia	ID	MDP	WAKD	140.833333	-5.833333	Asia/Jayapura	0
3840	Mar Del Plata Airport	Mar Del Plata	Argentina	AR	MDQ	SAZM	-57.572222	-37.934722	America/Argentina/Buenos_Aires	0
3841	Middle Caicos Airport	Middle Caicos	Turks and Caicos Islands	TC	MDS	MBMC	-71.716667	21.783333	America/Grand_Turk	0
3842	Harrisburg International Airport	Middletown	United States	US	MDT	KMDT	-76.756057	40.196008	America/New_York	0
3843	Mendi Airport	Mendi	Papua New Guinea	PG	MDU	AYMN	143.65	-6.158611	Pacific/Port_Moresby	0
3844	Chicago Midway International Airport	Chicago	United States	US	MDW	KMDW	-87.740871	41.788136	America/Chicago	0
3845	Mercedes Airport	Mercedes	Argentina	AR	MDX	SATM	-58.075556	-29.167222	America/Argentina/Buenos_Aires	0
3846	Henderson Field	Sand Island	US Minor Outlying Islands	UM	MDY	PMDY	-177.38057	28.201878	Pacific/Midway	0
3847	El Plumerillo International Airport	Mendoza	Argentina	AR	MDZ	SAME	-68.798909	-32.827888	America/Argentina/Buenos_Aires	0
3848	Macae Airport	Macae	Brazil	BR	MEA	SBME	-41.764049	-22.341842	America/Sao_Paulo	0
3849	Essendon Airport	Melbourne	Australia	AU	MEB	YMEN	144.900813	-37.730423	Australia/Sydney	0
3850	Manta Airport	Manta	Ecuador	EC	MEC	SEMT	-80.683999	-0.953035	America/Guayaquil	0
3851	Prince Mohammad Bin Abdulaziz International Airport	Madinah	Saudi Arabia	SA	MED	OEMA	39.698966	24.544369	Asia/Riyadh	0
3852	Mare Airport	Mare	New Caledonia	NC	MEE	NWWR	168.036082	-21.482312	Pacific/Noumea	0
3853	Malanje Airport	Malanje	Angola	AO	MEG	FNMA	16.318961	-9.526404	Africa/Luanda	0
3854	Mehamn Airport	Mehamn	Norway	NO	MEH	ENMH	27.833333	71.033333	Europe/Oslo	0
3855	Meridian Regional (Key Field) Airport	Meridian	United States	US	MEI	KMEI	-88.749167	32.337222	America/Chicago	0
3856	Meadville Airport	Meadville	United States	US	MEJ	KGKJ	-80.166667	41.633333	America/New_York	0
3857	Melbourne Tullamarine Airport	Melbourne	Australia	AU	MEL	YMML	144.843013	-37.673295	Australia/Sydney	0
3858	Memphis International Airport	Memphis	United States	US	MEM	KMEM	-89.982258	35.044579	America/Chicago	0
3859	Brenoux Airport	Mende	France	FR	MEN	LFNB	3.527748	44.504157	Europe/Paris	0
3860	Dare County Regional Airport	Manteo	United States	US	MEO	KMQI	-75.695278	35.919167	America/New_York	0
3861	Mersing Airport	Mersing	Malaysia	MY	MEP	WMAU	103.833333	2.416667	Asia/Kuala_Lumpur	0
3862	Seunagan Airport	Meulaboh	Indonesia	ID	MEQ	WITC	96.116667	4.15	Asia/Jakarta	0
3863	Castle Air Force Base	Merced	United States	US	MER	KMER	-120.568001	37.380501	America/Los_Angeles	0
3864	Soewondo Air Force Base	Medan	Indonesia	ID	MES	WIMK	98.677374	3.56587	Asia/Jakarta	0
3865	Moreton Airport	Moreton	Australia	AU	MET	YMOT	142.766667	-12.75	Australia/Brisbane	0
3866	Monte Dourado Airport	Monte Dourado	Brazil	BR	MEU	SBMD	-52.583333	-0.883333	America/Belem	0
3867	Douglas County Airport	Minden	United States	US	MEV	KMEV	-119.75	39	America/Los_Angeles	0
3868	Mweka Airport	Mweka	The Democratic Republic of The Congo	CD	MEW	FZVM	21.566667	-4.85	Africa/Lubumbashi	0
3869	Mexico City Benito Juarez International Airport	Mexico City	Mexico	MX	MEX	MMMX	-99.072778	19.435278	America/Mexico_City	0
3870	Meghauli Airport	Meghauli	Nepal	NP	MEY	VNMG	84.231389	27.576389	Asia/Kathmandu	0
3871	Messina Airport	Messina	South Africa	ZA	MEZ	FAMH	29.833333	-22.366667	Africa/Johannesburg	0
3872	Mafia Island Airport	Mafia Island	United Republic of Tanzania	TZ	MFA	HTMA	39.668576	-7.917577	Africa/Dar_es_Salaam	0
3873	Monfort Airport	Monfort	Colombia	CO	MFB	SKNF	-69.75	0.616667	America/Bogota	0
3874	Mafeteng Airport	Mafeteng	Lesotho	LS	MFC	FXMF	27.3	-29.75	Africa/Maseru	0
3875	Lahm Municipal Airport	Mansfield	United States	US	MFD	KMFD	-82.512778	40.82	America/New_York	0
3876	McAllen International Airport	McAllen	United States	US	MFE	KMFE	-98.239775	26.181295	America/Chicago	0
3877	Moanda Airport	Moanda	Gabon	GA	MFF	FOOD	13.270833	-1.536944	Africa/Libreville	0
3878	Muzaffarabad Airport	Muzaffarabad	Pakistan	PK	MFG	OPMF	73.466667	34.366667	Asia/Karachi	0
3879	Marshfield Municipal Airport	Marshfield	United States	US	MFI	KMFI	-90.186667	44.633889	America/Chicago	0
3880	Moala Airport	Moala	Fiji	FJ	MFJ	NFMO	179.933333	-18.566667	Pacific/Fiji	0
3881	Matsu Beigan Airport	Matsu	Taiwan	TW	MFK	RCMT	120.000507	26.224018	Asia/Taipei	0
3882	Mount Full Stop Airport	Mount Full Stop	Australia	AU	MFL	YWDV	144.9	-19.666667	Australia/Brisbane	0
3883	Macau International Airport	Macau	Macau SAR	MO	MFM	VMMC	113.57285	22.156587	Asia/Macau	0
3884	Milford Sound Airport	Milford Sound	New Zealand	NZ	MFN	NZMF	167.911111	-44.669444	Pacific/Auckland	0
3885	Manguna Airport	Manguna	Papua New Guinea	PG	MFO	HERN	151.783333	-5.566667	Pacific/Port_Moresby	0
3886	Manners Creek Airport	Manners Creek	Australia	AU	MFP	YMCR	137.983333	-22.1	Australia/Darwin	0
3887	Maradi Airport	Maradi	Niger	NE	MFQ	DRRM	7.125278	13.5025	Africa/Niamey	0
3888	Rogue Valley International-Medford Airport	Medford	United States	US	MFR	KMFR	-122.87312	42.369025	America/Los_Angeles	0
3889	Miraflores Airport	Miraflores	Colombia	CO	MFS	SKMF	-73.25	5.166667	America/Bogota	0
3890	Mfuwe Airport	Mfuwe	Zambia	ZM	MFU	FLMF	31.933333	-13.266667	Africa/Lusaka	0
3891	Accomack County Airport	Melfa	United States	US	MFV	KMFV	-75.783333	37.633333	America/New_York	0
3892	Meribel Airport	Meribel	France	FR	MFX	LFKX	6.566667	45.416667	Europe/Paris	0
3893	Augusto C Sandino International Airport	Managua	Nicaragua	NI	MGA	MNMG	-86.171263	12.144838	America/Managua	0
3894	Mount Gambier Airport	Mount Gambier	Australia	AU	MGB	YMTG	140.782715	-37.744072	Australia/Adelaide	0
3895	Michigan City Airport	Michigan City	United States	US	MGC	KMGC	-86.816667	41.7	America/Chicago	0
3896	Magdalena Airport	Magdalena	Bolivia	BO	MGD	SLMG	-64.124722	-13.325278	America/La_Paz	0
3897	Dobbins Air Force Base	Marietta	United States	US	MGE	KMGE	-84.510918	33.912954	America/New_York	0
3898	Regional De Maringa	Maringa	Brazil	BR	MGF	SBMG	-52.012222	-23.479445	America/Sao_Paulo	0
3899	Margate Airport	Margate	South Africa	ZA	MGH	FAMG	30.344464	-30.858344	Africa/Johannesburg	0
3900	Orange County Airport	Montgomery	United States	US	MGJ	KMGJ	-74.266667	41.516667	America/New_York	0
3901	Mong Ton Airport	Mong Ton	Myanmar	MM	MGK	VYMT	98.9	20.283333	Asia/Yangon	0
3902	Monchengladbach Airport	Dusseldorf	Germany	DE	MGL	EDLN	6.51097	51.22972	Europe/Berlin	0
3903	Montgomery Regional Airport-Dannelly Field	Montgomery	United States	US	MGM	KMGM	-86.393997	32.300596	America/Chicago	0
3904	Baracoa Airport	Magangue	Colombia	CO	MGN	SKMG	-74.845	9.288056	America/Bogota	0
3905	Mogadishu International Airport	Mogadishu	Somalia	SO	MGQ	HCMM	45.313333	2.013333	Africa/Mogadishu	0
3906	Thomasville Airport	Moultrie	United States	US	MGR	KMGR	-83.802778	31.069444	America/New_York	0
3907	Mangaia Island Airport	Mangaia Island	Cook Islands	CK	MGS	NCGO	-157.933333	-21.933333	Pacific/Rarotonga	0
3908	Milingimbi Airport	Milingimbi	Australia	AU	MGT	YMGB	134.893518	-12.093703	Australia/Darwin	0
3909	Manaung Airport	Manaung	Myanmar	MM	MGU	VYMN	93.684923	18.84453	Asia/Yangon	0
3910	Margaret River Station Airport	Margaret River Station	Australia	AU	MGV	YMGR	126.866667	-18.616667	Australia/Perth	0
3911	Morgantown Airport	Morgantown	United States	US	MGW	KMGW	-79.915833	39.642778	America/New_York	0
3912	Moabi Airport	Moabi	Gabon	GA	MGX	FOGI	11	-2.25	Africa/Libreville	0
3913	Myeik Airport	Myeik	Myanmar	MM	MGZ	VYME	98.616667	12.45	Asia/Yangon	0
3914	Mahdia Airport	Mahdia	Guyana	GY	MHA	SYMD	-59.15	5.25	America/Guyana	0
3915	Mechanics Bay Heliport	Auckland	New Zealand	NZ	MHB	NZMB	174.788358	-36.846584	Pacific/Auckland	0
3916	Mocopulli Airport	Castro	Chile	CL	MHC	SCPQ	-73.71389	-42.34611	America/Santiago	0
3917	Shahid Hashemi Nejad Airport	Mashad	Iran	IR	MHD	OIMM	59.640996	36.235207	Asia/Tehran	0
3918	Mitchell Municipal Airport	Mitchell	United States	US	MHE	KMHE	-98.038056	43.775278	America/Chicago	0
3919	Mannheim Airport	Mannheim	Germany	DE	MHG	EDFM	8.521081	49.476577	Europe/Berlin	0
3920	Marsh Harbour International Airport	Marsh Harbour	Bahamas	BS	MHH	MYAM	-77.077119	26.513428	America/Nassau	0
3921	Manhattan Municipal Airport	Manhattan	United States	US	MHK	KMHK	-96.668889	39.142222	America/Chicago	0
3922	Memorial Municipal Airport	Marshall	United States	US	MHL	KMHL	-93.2	39.116667	America/Chicago	0
3923	Mullen Airport	Mullen	United States	US	MHN	KMHN	-101.016667	42.05	America/Denver	0
3924	Mount House Airport	Mount House	Australia	AU	MHO	YMHO	125.766667	-17.133333	Australia/Perth	0
3925	Minsk International 1 Airport	Minsk	Belarus	BY	MHP	UMMM	27.539686	53.864473	Europe/Minsk	0
3926	Mariehamn Airport	Mariehamn	Aland	AX	MHQ	EFMA	19.896667	60.123333	Europe/Helsinki	0
3927	Mather Airport	Sacramento	United States	US	MHR	KMHR	-121.297996	38.553902	America/Los_Angeles	0
3928	Manchester Boston Regional Airport	Manchester	United States	US	MHT	KMHT	-71.438439	42.927862	America/New_York	0
3929	Mojave Air and Space Port	Mojave	United States	US	MHV	KMHV	-118.147815	35.057904	America/Los_Angeles	0
3930	Monteagudo Airport	Monteagudo	Bolivia	BO	MHW	SLAG	-63.960999	-19.827	America/La_Paz	0
3931	Manihiki Island Airport	Manihiki Island	Cook Islands	CK	MHX	KMHX	-161	-10.366667	Pacific/Rarotonga	0
3932	Mildenhall RAF Station	Mildenhall	United Kingdom	GB	MHZ	EGUN	0.486411	52.361902	Europe/London	0
3933	Miami International Airport	Miami	United States	US	MIA	KMIA	-80.278234	25.796	America/New_York	0
3934	Minot Air Force Base	Minot	United States	US	MIB	KMIB	-101.35787	48.415781	America/Chicago	0
3935	Crystal Airport	Minneapolis	United States	US	MIC	KMIC	-93.353889	45.061944	America/Chicago	0
3936	Manuel Crescencio Rejon International Airport	Merida	Mexico	MX	MID	MMMD	-89.663748	20.933822	America/Mexico_City	0
3937	Delaware County Regional Airport	Muncie	United States	US	MIE	KMIE	-85.394444	40.239722	America/Indiana/Indianapolis	0
3938	Mianyang Nanjiao Airport	Mian Yang	China	CN	MIG	ZUMY	104.747139	31.427633	Asia/Shanghai	0
3939	Mitchell Plateau Airport	Mitchell Plateau	Australia	AU	MIH	YMIP	147.966667	-26.483333	Australia/Perth	0
3940	Dr Gastao Vidigal Airport	Marilia	Brazil	BR	MII	SBML	-49.933333	-22.2	America/Sao_Paulo	0
3941	Mikkeli Airport	Mikkeli	Finland	FI	MIK	EFMI	27.213056	61.683889	Europe/Helsinki	0
3942	Merimbula Airport	Merimbula	Australia	AU	MIM	YMER	149.902029	-36.910044	Australia/Sydney	0
3943	Minnipa Airport	Minnipa	Australia	AU	MIN	YMPA	134.833333	-32.833333	Australia/Adelaide	0
3944	Miami Airport	Miami	United States	US	MIO	KMIO	-94.9	36.883333	America/Chicago	0
3945	Mitspeh Ramon Airport	Mitspeh Ramon	Israel	IL	MIP	LLMR	34.666698	30.7761	Asia/Jerusalem	0
3946	Millard Airport	Omaha	United States	US	MIQ	KMLE	-96.112097	41.195123	America/Chicago	0
3947	Habib Bourguiba International Airport	Monastir	Tunisia	TN	MIR	DTMB	10.753155	35.761083	Africa/Tunis	0
3948	Misima Island Airport	Misima Island	Papua New Guinea	PG	MIS	AYMS	152.841667	-10.5	Pacific/Port_Moresby	0
3949	Minter Field	Shafter	United States	US	MIT	KMIT	-119.192002	35.507387	America/Los_Angeles	0
3950	Maiduguri International Airport	Maiduguri	Nigeria	NG	MIU	DNMA	13.082928	11.855487	Africa/Lagos	0
3951	Millville Municipal Airport	Millville	United States	US	MIV	KMIV	-75.079292	39.364644	America/New_York	0
3952	Marshalltown Municipal Airport	Marshalltown	United States	US	MIW	KMIW	-92.916667	42.166667	America/Chicago	0
3953	Mainoru Airport	Mainoru	Australia	AU	MIZ	YMNU	134.1	-14	Australia/Darwin	0
3954	Manja Airport	Manja	Madagascar	MG	MJA	FMSJ	44.316667	-21.416667	Indian/Antananarivo	0
3955	Man Airport	Man	Cote d'Ivoire	CI	MJC	DIMN	-7.589494	7.272002	Africa/Abidjan	0
3956	Mohenjo Daro Airport	Mohenjo Daro	Pakistan	PK	MJD	OPMJ	68.141667	27.336389	Asia/Karachi	0
3957	Kjaerstad Airport	Mosjoen	Norway	NO	MJF	ENMS	13.218328	65.78439	Europe/Oslo	0
3958	Mitiga, Tripoli Airport	Mitiga, Tripoli	Libya	LY	MJI	HLLM	13.277778	32.897222	Africa/Tripoli	0
3959	Shark Bay Airport	Monkey Mia	Australia	AU	MJK	YSHK	113.576952	-25.888158	Australia/Perth	0
3960	Mouila Airport	Mouila	Gabon	GA	MJL	FOGM	10.924167	-1.817778	Africa/Libreville	0
3961	Mbuji Mayi Airport	Mbuji Mayi	The Democratic Republic of The Congo	CD	MJM	FZWA	23.633333	-6.15	Africa/Lubumbashi	0
3962	Amborovy Airport	Majunga	Madagascar	MG	MJN	FMNM	46.353056	-15.665833	Indian/Antananarivo	0
3963	Manjimup Airport	Manjimup	Australia	AU	MJP	YMJM	116.1	-34.233333	Australia/Perth	0
3964	Jackson Airport	Jackson	United States	US	MJQ	KMJQ	-95.016667	43.616667	America/Chicago	0
3965	Miramar Airport	Miramar	Argentina	AR	MJR	SAEM	-57.870833	-38.226111	America/Argentina/Buenos_Aires	0
3966	Mytilene International Airport	Mytilene	Greece	GR	MJT	LGMT	26.603171	39.053867	Europe/Athens	0
3967	Tampa Padang Airport	Mamuju	Indonesia	ID	MJU	WAFJ	119.029065	-2.587331	Asia/Makassar	0
3968	Murcia-San Javier Airport	Murcia	Spain and Canary Islands	ES	MJV	LELC	-0.81904	37.775213	Europe/Madrid	0
3969	Mahenye Airfield	Mahenye	Zimbabwe	ZW	MJW	FVMH	32.333333	-21.233333	Africa/Harare	0
3970	Robert J. Miller Air Park	Toms River	United States	US	MJX	KMJX	-74.293055	39.928092	America/New_York	0
3971	Mirnyj Airport	Mirnyj	Russian Federation	RU	MJZ	UERR	114.033333	62.533333	Asia/Yakutsk	0
3972	Marianske Lazne Airport	Marianske Lazne	Czech Republic	CZ	MKA	LKMR	12.716667	49.983333	Europe/Prague	0
3973	Mekambo Airport	Mekambo	Gabon	GA	MKB	FOOE	13.833333	1.05	Africa/Libreville	0
3974	Charles B. Wheeler Downtown Airport	Kansas City	United States	US	MKC	KMKC	-94.591944	39.124167	America/Chicago	0
3975	Milwaukee Mitchell International Airport	Milwaukee	United States	US	MKE	KMKE	-87.902668	42.948095	America/Chicago	0
3976	Muskegon Airport	Muskegon	United States	US	MKG	KMKG	-86.2375	43.170556	America/New_York	0
3977	Mokhotlong Airport	Mokhotlong	Lesotho	LS	MKH	FXMK	29.166667	-29.166667	Africa/Maseru	0
3978	M'boki Airport	M'Boki	Central African Republic	CF	MKI	FEGE	25.95	5.316667	Africa/Bangui	0
3979	Makoua Airport	Makoua	Congo	CG	MKJ	FCOM	15.576667	-0.020278	Africa/Brazzaville	0
3980	Molokai Airport	Hoolehua	United States	US	MKK	PHMK	-157.092927	21.155184	Pacific/Honolulu	0
3981	Mckellar-Sipes Regional Airport	Jackson	United States	US	MKL	KMKL	-88.915097	35.599778	America/Chicago	0
3982	Mukah Airport	Mukah	Malaysia	MY	MKM	WBGK	112.079722	2.906944	Asia/Kuala_Lumpur	0
3983	Davis Field	Muskogee	United States	US	MKO	KMKO	-95.366667	35.660556	America/Chicago	0
3984	Makemo Airport	Makemo	French Polynesia	PF	MKP	NTGM	-143.654364	-16.587921	Pacific/Tahiti	0
3985	Mopah Airport	Merauke	Indonesia	ID	MKQ	WAKK	140.41894	-8.519837	Asia/Jayapura	0
3986	Meekatharra Airport	Meekatharra	Australia	AU	MKR	YMEK	118.545959	-26.61113	Australia/Perth	0
3987	Mekane Selam Airport	Mekane Selam	Ethiopia	ET	MKS	HAMA	38.15	11.683333	Africa/Addis_Ababa	0
3988	Mankato Municipal Airport	Mankato	United States	US	MKT	KMKT	-93.918333	44.223611	America/Chicago	0
3989	Makokou Airport	Makokou	Gabon	GA	MKU	FOOK	12.861111	0.559167	Africa/Libreville	0
3990	Mt. Cavenagh Airport	Mount Cavenagh	Australia	AU	MKV	YMVG	133.25	-25.966667	Australia/Darwin	0
3991	Rendani Airport	Manokwari	Indonesia	ID	MKW	WAUU	134.052778	-0.893056	Asia/Jayapura	0
3992	Mackay Airport	Mackay	Australia	AU	MKY	YBMK	149.181789	-21.176284	Australia/Brisbane	0
3993	Malacca International Airport	Malacca	Malaysia	MY	MKZ	WMKM	102.252464	2.262959	Asia/Kuala_Lumpur	0
3994	Malta International Airport	Malta	Malta	MT	MLA	LMML	14.495401	35.849776	Europe/Malta	0
3995	Melbourne Orlando International Airport	Melbourne	United States	US	MLB	KMLB	-80.630278	28.1025	America/New_York	0
3996	McAlester Regional Airport	McAlester	United States	US	MLC	KMLC	-95.785	34.880278	America/Chicago	0
3997	Malad City Airport	Malad City	United States	US	MLD	KMLD	-112.45	42.2	America/Denver	0
3998	Male Velana International Airport	Male	Maldives	MV	MLE	VRMM	73.529108	4.19183	Indian/Maldives	0
3999	Milford Airport	Milford	United States	US	MLF	KMLF	-113.016667	38.433333	America/Denver	0
4000	Abdul Rachman Saleh Airport	Malang	Indonesia	ID	MLG	WARA	112.71449	-7.926611	Asia/Jakarta	0
4001	EuroAirport Basel-Mulhouse-Freiburg	Mulhouse, France/Basel	Switzerland	CH	MLH	LFSB	7.532864	47.599324	Europe/Zurich	0
4002	Quad City International Airport	Moline	United States	US	MLI	KMLI	-90.506111	41.453897	America/Chicago	0
4003	Baldwin County Airport	Milledgeville	United States	US	MLJ	KMLJ	-83.233333	33.083333	America/New_York	0
4004	Malta	Malta	United States	US	MLK	KMLK	-107.9095	48.494417	America/Denver	0
4005	Marshall Don Hunter Sr. Airport	Marshall	United States	US	MLL	PADM	-162.026166	61.864187	America/Anchorage	0
4006	Morelia Airport	Morelia	Mexico	MX	MLM	MMMM	-101.026932	19.843509	America/Mexico_City	0
4007	Melilla Airport	Melilla	Spain and Canary Islands	ES	MLN	GEML	-2.957473	35.277078	Europe/Madrid	0
4008	Milos Airport	Milos	Greece	GR	MLO	LGML	24.475	36.69611	Europe/Athens	0
4009	Malabang Airport	Malabang	Philippines	PH	MLP	RPMM	124.0575	7.618333	Asia/Manila	0
4010	Millicent Airport	Millicent	Australia	AU	MLR	YMCT	140.365997	-37.583599	Australia/Adelaide	0
4011	Frank Wiley Field	Miles City	United States	US	MLS	KMLS	-105.884503	46.428325	America/Denver	0
4012	Millinocket Municipal Airport	Millinocket	United States	US	MLT	KMLT	-68.6856	45.6478	America/New_York	0
4013	Monroe Regional Airport	Monroe	United States	US	MLU	KMLU	-92.043659	32.511842	America/Chicago	0
4014	Merluna Airport	Merluna	Australia	AU	MLV	YMEU	142.983333	-13.016667	Australia/Brisbane	0
4015	Spriggs Payne Airport	Monrovia	Liberia	LR	MLW	GLMR	-10.758333	6.289444	Africa/Monrovia	0
4016	Malatya Airport	Malatya	Turkiye	TR	MLX	LTAT	38.253611	38.354444	Europe/Istanbul	0
4017	Manley Hot Springs Airport	Manley Hot Springs	United States	US	MLY	PAML	-150.643056	64.996667	America/Anchorage	0
4018	Melo Airport	Melo	Uruguay	UY	MLZ	SUMO	-54.2	-32.333333	America/Montevideo	0
4019	Memanbetsu Airport	Memanbetsu	Japan	JP	MMB	RJCM	144.160012	43.881084	Asia/Tokyo	0
4020	Ciudad Mante Airport	Ciudad Mante	Mexico	MX	MMC	MMDM	-99	22.833333	America/Mexico_City	0
4021	Celaya	Celaya	Mexico	MX	CYW	MMCY	-100.9	20.55	America/Mexico_City	0
4022	Minamidaito Airport	Minami Daito	Japan	JP	MMD	ROMD	131.263668	25.846431	Asia/Tokyo	0
4023	Teesside International Airport	Durham Tees Valley	United Kingdom	GB	MME	EGNV	-1.434013	54.512226	Europe/London	0
4024	Mamfe Airport	Mamfe	Cameroon	CM	MMF	FKKF	9.3	5.716667	Africa/Douala	0
4025	Mount Magnet Airport	Mount Magnet	Australia	AU	MMG	YMOG	117.842955	-28.116412	Australia/Perth	0
4026	Mammoth Lakes Airport	Mammoth Lakes	United States	US	MMH	KMMH	-118.851389	37.631111	America/Los_Angeles	0
4027	McMinn County Airport	Athens	United States	US	MMI	KMMI	-84.675694	35.523028	America/New_York	0
4028	Matsumoto Airport	Matsumoto	Japan	JP	MMJ	RJAF	137.923004	36.166801	Asia/Tokyo	0
4029	Murmansk Airport	Murmansk	Russian Federation	RU	MMK	ULMM	32.759155	68.785092	Europe/Moscow	0
4030	Southwest Minnesota Regional Airport	Marshall	United States	US	MML	KMML	-95.8175	44.447222	America/Chicago	0
4031	Middlemount Airport	Middlemount	Australia	AU	MMM	YMMU	148.706619	-22.802474	Australia/Brisbane	0
4032	Vila Do Maio Airport	Maio	Cape Verde	CV	MMO	GVMA	-23.166667	15.25	Atlantic/Cape_Verde	0
4033	San Bernardo Airport	Mompos	Colombia	CO	MMP	SKMP	-74.436095	9.262399	America/Bogota	0
4034	Mbala Airport	Mbala	Zambia	ZM	MMQ	FLBA	31.336367	-8.859409	Africa/Lusaka	0
4035	Selfs Airport	Marks	United States	US	MMS	KMMS	-90.266667	34.266667	America/Chicago	0
4036	McEntire Joint National Guard Base	Columbia	United States	US	MMT	KMMT	-80.806428	33.92465	America/New_York	0
4037	Morristown Municipal Airport	Morristown	United States	US	MMU	KMMU	-74.421112	40.795183	America/New_York	0
4038	Malmo Airport	Malmo	Sweden	SE	MMX	ESMS	13.363727	55.538759	Europe/Stockholm	0
4039	Miyako Airport	Miyakojima	Japan	JP	MMY	ROMY	125.297786	24.779198	Asia/Tokyo	0
4040	Maimana Airport	Maimana	Afghanistan	AF	MMZ	OAMN	64.766352	35.925463	Asia/Kabul	0
4041	Melangguane Airport	Melangguane	Indonesia	ID	MNA	WAMN	126.673257	4.006202	Asia/Makassar	0
4042	Moanda Airport	Moanda	The Democratic Republic of The Congo	CD	MNB	FZAG	12.352778	-5.926944	Africa/Kinshasa	0
4043	Nacala Airport	Nacala	Mozambique	MZ	MNC	FQNC	40.708218	-14.49363	Africa/Maputo	0
4044	Medina Airport	Medina	Colombia	CO	MND	SQMW	-73.283333	4.516667	America/Bogota	0
4045	Mungerannie Airport	Mungerannie	Australia	AU	MNE	YMUG	138.6	-28	Australia/Adelaide	0
4046	Mana Island Airstrip	Mana Island	Fiji	FJ	MNF	NFMA	177.116667	-17.633333	Pacific/Fiji	0
4047	Maningrida Airport	Maningrida	Australia	AU	MNG	YMGD	134.232266	-12.05492	Australia/Darwin	0
4048	Rustaq Airport	Al Masnaah	Oman	OM	MNH	OORQ	57.48639	23.64111	Asia/Muscat	0
4049	Bramble Airport	Montserrat	Montserrat	MS	MNI	TRPG	-62.233333	16.75	America/Montserrat	0
4050	Mananjary Airport	Mananjary	Madagascar	MG	MNJ	FMSM	48.356779	-21.207066	Indian/Antananarivo	0
4051	Maiana Airport	Maiana	Kiribati	KI	MNK	NGMA	173	1	Pacific/Tarawa	0
4052	Manila Ninoy Aquino International Airport	Manila	Philippines	PH	MNL	RPLL	121.019208	14.511205	Asia/Manila	0
4053	Menominee-Marinette Twin County Airport	Menominee	United States	US	MNM	KMNM	-87.636111	45.121667	America/Chicago	0
4054	Marion Municipal Airport	Marion	United States	US	MNN	KMNN	-83.133333	40.583333	America/New_York	0
4055	Manono Airport	Manono	The Democratic Republic of The Congo	CD	MNO	FZRA	27.393889	-7.288056	Africa/Lubumbashi	0
4056	Monto Airport	Monto	Australia	AU	MNQ	YMTO	151.1	-24.883333	Australia/Brisbane	0
4057	Mongu Airport	Mongu	Zambia	ZM	MNR	FLMG	23.16233	-15.254778	Africa/Lusaka	0
4058	Mansa Airport	Mansa	Zambia	ZM	MNS	FLMA	28.866667	-11.125	Africa/Lusaka	0
4059	Mawlamyine Airport	Mawlamyine	Myanmar	MM	MNU	VYMM	97.660669	16.444747	Asia/Yangon	0
4060	Mountain Valley Airport	Mountain Valley	Australia	AU	MNV	YMVY	133.833333	-14.116667	Australia/Darwin	0
4061	Macdonald Downs Airport	Macdonald Downs	Australia	AU	MNW	YMDS	135.216667	-22.45	Australia/Darwin	0
4062	Manicore Airport	Manicore	Brazil	BR	MNX	SBMY	-61.283333	-5.816667	America/Porto_Velho	0
4063	Mono Airport	Mono	Solomon Islands	SB	MNY	AGGO	155.564628	-7.417428	Pacific/Guadalcanal	0
4064	Manassas Regional Airport	Manassas	United States	US	MNZ	KHEF	-77.518056	38.721944	America/New_York	0
4065	Orestes Acosta Airport	Moa	Cuba	CU	MOA	MUMO	-74.883333	20.5	America/Havana	0
4066	Mobile Regional Airport	Mobile	United States	US	MOB	KMOB	-88.244753	30.681085	America/Chicago	0
4067	Montes Claros Airport	Montes Claros	Brazil	BR	MOC	SBMK	-43.817222	-16.707778	America/Sao_Paulo	0
4068	Modesto Municipal Airport	Modesto	United States	US	MOD	KMOD	-120.955278	37.626944	America/Los_Angeles	0
4069	Momeik Airport	Momeik	Myanmar	MM	MOE	VYMO	96.65	23.1	Asia/Yangon	0
4070	Wai Oti Airport	Maumere	Indonesia	ID	MOF	WATC	122.238255	-8.637726	Asia/Makassar	0
4071	Mong Hsat Airport	Mong Hsat	Myanmar	MM	MOG	VYMS	99.256952	20.518667	Asia/Yangon	0
4072	Molde Airport, Aro	Molde	Norway	NO	MOL	ENML	7.261039	62.745714	Europe/Oslo	0
4073	Moudjeria Airport	Moudjeria	Mauritania	MR	MOM	GQNL	-12.5	17.75	Africa/Nouakchott	0
4074	Mount Cook Airport	Mount Cook	New Zealand	NZ	MON	NZMC	170.135337	-43.765018	Pacific/Auckland	0
4075	Moomba Airport	Moomba	Australia	AU	MOO	YOOM	140.199106	-28.100822	Australia/Adelaide	0
4076	Mount Pleasant Municipal Airport	Mount Pleasant	United States	US	MOP	KMOP	-84.737792	43.620642	America/New_York	0
4077	Morondava Airport	Morondava	Madagascar	MG	MOQ	FMMV	44.318333	-20.283611	Indian/Antananarivo	0
4078	Moore-Murrell Airport	Morristown	United States	US	MOR	KMOR	-83.3	36.216667	America/New_York	0
4079	Minot International Airport	Minot	United States	US	MOT	KMOT	-101.291519	48.256328	America/Chicago	0
4080	Mountain Village Airport	Mountain Village	United States	US	MOU	PAMO	-163.716667	62.089444	America/Anchorage	0
4081	Moranbah Airport	Moranbah	Australia	AU	MOV	YMRB	148.074417	-22.06057	Australia/Brisbane	0
4082	Morris Municipal Airport	Morris	United States	US	MOX	KMOX	-95.916667	45.583333	America/Chicago	0
4083	Monterrey Airport	Monterrey	Colombia	CO	MOY	SKNY	-72.895278	4.884167	America/Bogota	0
4084	Temae Airport	Moorea	French Polynesia	PF	MOZ	NTTM	-149.764138	-17.490432	Pacific/Tahiti	0
4085	Mpacha Airport	Mpacha	Namibia	NA	MPA	FYKM	24.266667	-17.5	Africa/Windhoek	0
4086	Muko-Muko Airport	Muko-Muko	Indonesia	ID	MPC	WIGM	101.1	-2.55	Asia/Jakarta	0
4087	Godofredo P. Ramos Airport	Caticlan	Philippines	PH	MPH	RPVE	121.954003	11.924497	Asia/Manila	0
4088	Mokpo Airport	Mokpo	Republic of Korea	KR	MPK	RKJM	126.385	34.756667	Asia/Seoul	0
4089	Montpellier Mediterranee Airport	Montpellier	France	FR	MPL	LFMT	3.959174	43.57843	Europe/Paris	0
4090	Maputo International Airport	Maputo	Mozambique	MZ	MPM	FQMA	32.57429	-25.924388	Africa/Maputo	0
4091	Mount Pleasant RAF Station	Mount Pleasant	Falkland Islands	FK	MPN	EGYP	-58.44598	-51.822711	Atlantic/Stanley	0
4092	Mount Pocono Airport	Mount Pocono	United States	US	MPO	KMPO	-75.366667	41.133333	America/New_York	0
4093	McPherson Airport	McPherson	United States	US	MPR	KMPR	-97.763306	38.374361	America/Chicago	0
4094	Mount Pleasant Airport	Mount Pleasant	United States	US	MPS	KMSA	-94.983333	33.166667	America/Chicago	0
4095	Edward F. Knapp State Airport	Berlin	United States	US	MPV	KMPV	-72.563806	44.202842	America/New_York	0
4096	Maripasoula Airport	Maripasoula	French Guiana	GF	MPY	SOOA	-54.033333	3.666667	America/Cayenne	0
4097	Mount Pleasant Municipal Airport	Mount Pleasant	United States	US	MPZ	KMPZ	-91.55	40.966667	America/Chicago	0
4098	Mandora Airport	Mandora	Australia	AU	MQA	YMDI	120.833333	-19.75	Australia/Perth	0
4099	Macomb Municipal Airport	Macomb	United States	US	MQB	KMQB	-90.621389	40.4525	America/Chicago	0
4100	Miquelon Airport	Miquelon	St. Pierre and Miquelon	PM	MQC	LFVM	-56.333333	47.05	America/Miquelon	0
4101	Maquinchao Airport	Maquinchao	Argentina	AR	MQD	SAVQ	-68.733333	-41.25	America/Argentina/Buenos_Aires	0
4102	Marqua Airport	Marqua	Australia	AU	MQE	YMQA	137.35	-22.816667	Australia/Darwin	0
4103	Magnitogorsk Airport	Magnitogorsk	Russian Federation	RU	MQF	USCM	58.755257	53.391881	Asia/Yekaterinburg	0
4104	Midgard Airport	Midgard	Namibia	NA	MQG	FYMG	17.366667	-22.083333	Africa/Windhoek	0
4105	Moma Airport	Khonu	Russian Federation	RU	MQJ	UEMA	143.253056	66.455833	Asia/Srednekolymsk	0
4106	San Matias Airport	San Matias	Bolivia	BO	MQK	SLTI	-58.385556	-16.334444	America/La_Paz	0
4107	Mildura Airport	Mildura	Australia	AU	MQL	YMIA	142.084548	-34.230834	Australia/Sydney	0
4108	Mardin Airport	Mardin	Turkiye	TR	MQM	LTCR	40.6317	37.2233	Europe/Istanbul	0
4109	Mo i Rana Airport	Mo i Rana	Norway	NO	MQN	ENRA	14.302748	66.364646	Europe/Oslo	0
4110	Kruger Mpumalanga International Airport	Nelspruit	South Africa	ZA	MQP	FAKN	31.098132	-25.384946	Africa/Johannesburg	0
4111	Moundou Airport	Moundou	Chad	TD	MQQ	FTTD	16.073333	8.625	Africa/Ndjamena	0
4112	Mosquera Airport	Mosquera	Colombia	CO	MQR	SKSQ	-78.416667	2.5	America/Bogota	0
4113	Mustique Airport	Mustique Island	Saint Vincent and the Grenadines	VC	MQS	TVSM	-61.181944	12.888333	America/St_Vincent	0
4114	Sawyer International Airport	Marquette	United States	US	MQT	KSAW	-87.395278	46.353611	America/New_York	0
4115	Mariquita Airport	Mariquita	Colombia	CO	MQU	SKQU	-74.883333	5.216667	America/Bogota	0
4116	Mostaganem Airport	Mostaganem	Algeria	DZ	MQV	DAOG	0.139167	35.904689	Africa/Algiers	0
4117	Telfair-Wheeler Airport	McRae	United States	US	MQW	KMQW	-83.000278	32.207778	America/New_York	0
4118	Alula Aba Nega Airport	Makale	Ethiopia	ET	MQX	HAMK	39.53346	13.467388	Africa/Addis_Ababa	0
4119	Smyrna Airport	Smyrna	United States	US	MQY	KMQY	-86.510593	36.006745	America/Chicago	0
4120	Margaret River Airport	Margaret River	Australia	AU	MQZ	YMGT	115.100337	-33.928014	Australia/Perth	0
4121	Misurata Airport	Misurata	Libya	LY	MRA	HLMS	15.061	32.325001	Africa/Tripoli	0
4122	Eastern West Virginia Regional Airport	Martinsburg	United States	US	MRB	KMRB	-77.985	39.401667	America/New_York	0
4123	Maury County Airport	Columbia	United States	US	MRC	KMRC	-87.177436	35.553375	America/Chicago	0
4124	Alberto Carnevalli Airport	Merida	Venezuela	VE	MRD	SVMD	-71.160504	8.582471	America/Caracas	0
4125	Mara Serena Airport	Maasai Mara	Kenya	KE	MRE	HKMS	35.008236	-1.404931	Africa/Nairobi	0
4126	Marfa Municipal Airport	Marfa	United States	US	MRF	KMRF	-104.017997	30.371099	America/Chicago	0
4127	Mareeba Airport	Mareeba	Australia	AU	MRG	YMBA	145.419006	-17.069201	Australia/Brisbane	0
4128	Merrill Field	Anchorage	United States	US	MRI	PAMR	-149.855652	61.221681	America/Anchorage	0
4129	Marco Island Airport	Marco Island	United States	US	MRK	KMKY	-81.674172	25.999664	America/New_York	0
4130	Lenoir Airport	Morganton	United States	US	MRN	KMRN	-81.683333	35.75	America/New_York	0
4131	Masterton Airport	Masterton	New Zealand	NZ	MRO	NZMS	175.633333	-40.975	Pacific/Auckland	0
4132	Marla Airport	Marla	Australia	AU	MRP	YALA	135	-27	Australia/Adelaide	0
4133	Marinduque Airport	Marinduque	Philippines	PH	MRQ	RPUW	121.823611	13.363056	Asia/Manila	0
4134	Macara Airport	Macara	Ecuador	EC	MRR	SEMA	-79.933333	-4.383333	America/Guayaquil	0
4135	Marseille Provence Airport	Marseille	France	FR	MRS	LFML	5.222137	43.44178	Europe/Paris	0
4136	Moroak Airport	Moroak	Australia	AU	MRT	YORO	133.416667	-14.483333	Australia/Darwin	0
4137	Sir Seewoosagur Ramgoolam International Airport	Mauritius	Mauritius	MU	MRU	FIMP	57.676629	-20.431998	Indian/Mauritius	0
4138	Mineralnye Vody Airport	Mineralnye Vody	Russian Federation	RU	MRV	URMM	43.088178	44.218354	Europe/Moscow	0
4139	Maribo Airport	Maribo	Denmark	DK	MRW	EKMB	11.435	54.685833	Europe/Copenhagen	0
4140	Mahshahr Airport	Bandar Mahshahr	Iran	IR	MRX	OIAM	49.149379	30.553822	Asia/Tehran	0
4141	Monterey Regional Airport	Monterey	United States	US	MRY	KMRY	-121.850813	36.587294	America/Los_Angeles	0
4142	Moree Airport	Moree	Australia	AU	MRZ	YMOR	149.850186	-29.496345	Australia/Sydney	0
4143	Muskrat Dam Airport	Muskrat Dam	Canada	CA	MSA	CZMD	-91.76306	53.44111	America/Winnipeg	0
4144	Mesa Falcon Field Airport	Mesa	United States	US	MSC	KFFZ	-111.728631	33.460689	America/Phoenix	0
4145	Manston Airport	Manston	United Kingdom	GB	MSE	EGMH	1.357335	51.346396	Europe/London	0
4146	Mount Swan Airport	Mount Swan	Australia	AU	MSF	YMNS	135	-22.516667	Australia/Darwin	0
4147	Matsaile Airport	Matsaile	Lesotho	LS	MSG	FXMA	28.75	-29.733333	Africa/Maseru	0
4148	Masirah Air Force Base	Masirah	Oman	OM	MSH	OOMA	58.890696	20.669335	Asia/Muscat	0
4149	Misawa Airport	Misawa	Japan	JP	MSJ	RJSM	141.386897	40.696315	Asia/Tokyo	0
4150	Morelia Airport	Puerto Gaitan	Colombia	CO	MSK	SKMO	-71.458056	3.754722	America/Bogota	0
4151	Northwest Alabama Regional Airport	Muscle Shoals	United States	US	MSL	KMSL	-87.616111	34.748611	America/Chicago	0
4152	Masi Manimba Airport	Masi Manimba	The Democratic Republic of The Congo	CD	MSM	FZCV	17.916667	-4.766667	Africa/Kinshasa	0
4153	Dane County Regional Airport	Madison	United States	US	MSN	KMSN	-89.346497	43.136377	America/Chicago	0
4154	Missoula International Airport	Missoula	United States	US	MSO	KMSO	-114.083216	46.918965	America/Denver	0
4155	Minneapolis-Saint Paul International Airport	Minneapolis	United States	US	MSP	KMSP	-93.210922	44.883016	America/Chicago	0
4156	Minsk National Airport	Minsk	Belarus	BY	MSQ	UMMS	28.032442	53.889725	Europe/Minsk	0
4157	Mus Airport	Mus	Turkiye	TR	MSR	LTCK	41.625	38.725	Europe/Istanbul	0
4158	Richards Field	Massena	United States	US	MSS	KMSS	-74.846667	44.937778	America/New_York	0
4159	Ilopango Airport	San Salvador	El Salvador	SV	ILS	MSSS	-89.119781	13.699471	America/El_Salvador	0
4160	Maastricht Aachen Airport	Maastricht	Netherlands	NL	MST	EHBK	5.768827	50.915619	Europe/Amsterdam	0
4161	Moshoeshoe International Airport	Maseru	Lesotho	LS	MSU	FXMM	27.505556	-29.301389	Africa/Maseru	0
4162	Sullivan County International Airport	Monticello	United States	US	MSV	KMSV	-74.795	41.701389	America/New_York	0
4163	Massawa Airport	Massawa	Eritrea	ER	MSW	HHMS	39.441111	15.603333	Africa/Asmara	0
4164	Mossendjo Airport	Mossendjo	Congo	CG	MSX	FCMM	12.733333	-2.95	Africa/Brazzaville	0
4165	Louis Armstrong New Orleans Intl Airport	New Orleans	United States	US	MSY	KMSY	-90.256391	29.984564	America/Chicago	0
4166	Yuri Gagarin Airport	Namibe	Angola	AO	MSZ	FNMO	12.150872	-15.258293	Africa/Luanda	0
4167	Matamata Glider Airport	Matamata	New Zealand	NZ	MTA	NZMA	175.743368	-37.737414	Pacific/Auckland	0
4168	Montelibano Airport	Montelibano	Colombia	CO	MTB	SKML	-75.432769	7.97538	America/Bogota	0
4169	Selfridge Air National Guard Base	Mount Clemens	United States	US	MTC	KMTC	-82.836492	42.610445	America/New_York	0
4170	Mount Sanford Airport	Mount Sanford	Australia	AU	MTD	YMSF	130.566667	-17	Australia/Darwin	0
4171	Monte Alegre Airport	Monte Alegre	Brazil	BR	MTE	SNMA	-54.066667	-1.983333	America/Porto_Velho	0
4172	Mizan Teferi Airport	Mizan Teferi	Ethiopia	ET	MTF	HAMT	35.533333	6.966667	Africa/Addis_Ababa	0
4173	The Florida Keys Marathon Airport	Marathon	United States	US	MTH	KMTH	-81.050937	24.726206	America/New_York	0
4174	Montrose Regional Airport	Montrose	United States	US	MTJ	KMTJ	-107.896955	38.510287	America/Denver	0
4175	Makin Island Airport	Makin Island	Kiribati	KI	MTK	NGMN	174	3	Pacific/Tarawa	0
4176	Maitland Airport	Maitland	Australia	AU	MTL	YMND	151.55	-32.733333	Australia/Sydney	0
4177	Metlakatla Sea Plane Base	Metlakatla	United States	US	MTM	PAMM	-131.578047	55.131522	America/Anchorage	0
4178	Martin State Airport	Baltimore	United States	US	MTN	KMTN	-76.411667	39.321667	America/New_York	0
4179	Coles County Memorial Airport	Mattoon	United States	US	MTO	KMTO	-88.278333	39.478611	America/Chicago	0
4180	Montauk Airport	Montauk Point	United States	US	MTP	KMTP	-71.923611	41.074444	America/New_York	0
4181	Mitchell Airport	Mitchell	Australia	AU	MTQ	YMIT	147.966667	-26.583333	Australia/Brisbane	0
4182	Los Garzones Airport	Monteria	Colombia	CO	MTR	SKMR	-75.823923	8.825035	America/Bogota	0
4183	Matsapha International Airport	Manzini	Eswatini	SZ	MTS	FDMS	31.314132	-26.520331	Africa/Mbabane	0
4184	Minatitlan Airport	Minatitlan	Mexico	MX	MTT	MMMT	-94.516667	17.983333	America/Mexico_City	0
4185	Mota Lava Airport	Mota Lava Island	Vanuatu	VU	MTV	NVSA	167.666667	-13.666667	Pacific/Efate	0
4186	Manitowoc Municipal Airport	Manitowoc	United States	US	MTW	KMTW	-87.682222	44.129722	America/Chicago	0
4187	Monterrey International Airport	Monterrey	Mexico	MX	MTY	MMMY	-100.114395	25.776569	America/Mexico_City	0
4188	Munda Airport	Munda	Solomon Islands	SB	MUA	AGGM	157.269712	-8.32794	Pacific/Guadalcanal	0
4189	Maun Airport	Maun	Botswana	BW	MUB	FBMN	23.430556	-19.970833	Africa/Gaborone	0
4190	Munich Franz Joseph Strauss Airport	Munich	Germany	DE	MUC	EDDM	11.790143	48.353005	Europe/Berlin	0
4191	Mueda Airport	Mueda	Mozambique	MZ	MUD	FQMD	39.516667	-11.666667	Africa/Maputo	0
4192	Kamuela Airport	Kamuela	United States	US	MUE	PHMU	-155.651457	20.002464	Pacific/Honolulu	0
4193	Mersa Matruh Airport	Mersa Matruh	Egypt	EG	MUH	HEMM	27.221652	31.325123	Africa/Cairo	0
4194	Muir Aaf	Ft Indiantown Gap	United States	US	MUI	KMUI	-76.596611	40.447583	America/New_York	0
4195	Mui Airport	Mui	Ethiopia	ET	MUJ	HAMR	35	6.333333	Africa/Addis_Ababa	0
4196	Mauke Island Airport	Mauke Island	Cook Islands	CK	MUK	NCMK	-158.5	-19.333333	Pacific/Rarotonga	0
4197	Spence Airport	Moultrie	United States	US	MUL	KMUL	-83.783333	31.183333	America/New_York	0
4198	Jose Tadeo Monagas International Airport	Maturin	Venezuela	VE	MUN	SVMT	-63.156931	9.749384	America/Caracas	0
4199	Mountain Home Air Force Base	Mountain Home	United States	US	MUO	KMUO	-115.872417	43.043598	America/Denver	0
4200	Mulga Park Airport	Mulga Park	Australia	AU	MUP	YMUP	141.05	-31.133333	Australia/Darwin	0
4201	Muccan Airport	Muccan	Australia	AU	MUQ	YMUC	120	-20.666667	Australia/Perth	0
4202	Marudi Airport	Marudi	Malaysia	MY	MUR	WBGM	114.316667	4.183333	Asia/Kuala_Lumpur	0
4203	Muscatine Airport	Muscatine	United States	US	MUT	KMUT	-91.145	41.366667	America/Chicago	0
4204	marau barra grande	Mount Union	United States	US	MUU	KMUU	-77.883333	40.383333	America/New_York	0
4205	Ghriss Airport	Ghriss	Algeria	DZ	MUW	DAOV	0.147669	35.208533	Africa/Algiers	0
4206	Multan Airport	Multan	Pakistan	PK	MUX	OPMT	71.414978	30.199507	Asia/Karachi	0
4207	Mouyondzi Airport	Mouyondzi	Congo	CG	MUY	FCBM	13.919444	-3.983333	Africa/Brazzaville	0
4208	Musoma Airport	Musoma	United Republic of Tanzania	TZ	MUZ	HTMU	33.802545	-1.497311	Africa/Dar_es_Salaam	0
4209	Reykiahlid Airport	Myvatn	Iceland	IS	MVA	BIRL	-16.966667	65.616667	Atlantic/Reykjavik	0
4210	M'Vengue El Hadj Omar Bongo Ondimba Intl Airport	Franceville	Gabon	GA	MVB	FOON	13.433333	-1.65	Africa/Libreville	0
4211	Monroe County Airport	Monroeville	United States	US	MVC	KMVC	-87.333333	31.516667	America/Chicago	0
4212	Carrasco International Airport	Montevideo	Uruguay	UY	MVD	SUMU	-56.026466	-34.841154	America/Montevideo	0
4213	Montevideo Municipal Airport	Montevideo	United States	US	MVE	KMVE	-95.716667	44.95	America/Chicago	0
4214	Dix-Sept Rosado Airport	Mossoro	Brazil	BR	MVF	SBMS	-37.364147	-5.201949	America/Belem	0
4215	Mulka Airport	Mulka	Australia	AU	MVK	YMUK	138	-27.25	Australia/Adelaide	0
4216	Morrisville-Stowe Airport	Stowe	United States	US	MVL	KMVL	-72.615433	44.537403	America/New_York	0
4217	Mount Vernon Airport	Mount Vernon	United States	US	MVN	KMVN	-88.858611	38.323056	America/Chicago	0
4218	Mongo Airport	Mongo	Chad	TD	MVO	FTTM	18.783333	12.2	Africa/Ndjamena	0
4219	Mitu Airport	Mitu	Colombia	CO	MVP	SKMU	-70.05	1.133333	America/Bogota	0
4220	Mogilev Airport	Mogilev	Belarus	BY	MVQ	UMOO	30.096425	53.957457	Europe/Minsk	0
4221	Salak Airport	Maroua	Cameroon	CM	MVR	FKKL	14.256389	10.452222	Africa/Douala	0
4222	Mataiva Airport	Mataiva	French Polynesia	PF	MVT	NTGV	-148.416667	-14.833333	Pacific/Tahiti	0
4223	Musgrave Airport	Musgrave	Australia	AU	MVU	YMGV	143.683333	-14.166667	Australia/Brisbane	0
4224	Megeve Airport	Megeve	France	FR	MVV	LFHM	6.65	45.816667	Europe/Paris	0
4225	Skagit Regional Airport	Mount Vernon	United States	US	MVW	KBVS	-122.417975	48.472747	America/Los_Angeles	0
4226	Minvoul Airport	Minvoul	Gabon	GA	MVX	FOGV	12.133333	2.15	Africa/Libreville	0
4227	Martha's Vineyard Airport	Martha's Vineyard	United States	US	MVY	KMVY	-70.61182	41.389335	America/New_York	0
4228	Masvingo Airport	Masvingo	Zimbabwe	ZW	MVZ	FVMV	30.860556	-20.054167	Africa/Harare	0
4229	Veterans Airport of Southern Illinois	Marion	United States	US	MWA	KMWA	-89.016389	37.751944	America/Chicago	0
4230	Morawa Airport	Morawa	Australia	AU	MWB	YMRW	116.0225	-29.204167	Australia/Perth	0
4231	Lawrence J. Timmerman Airport	Milwaukee	United States	US	MWC	KMWC	-88.033293	43.110636	America/Chicago	0
4232	Merowe Airport	Merowe	Sudan	SD	MWE	HSMN	31.840898	18.442416	Africa/Khartoum	0
4233	Maewo Airport	Maewo	Vanuatu	VU	MWF	NVSN	168.166667	-15.166667	Pacific/Efate	0
4234	Grant County International Airport	Moses Lake	United States	US	MWH	KMWH	-119.315556	47.205	America/Los_Angeles	0
4235	Matthews Ridge Airport	Matthews Ridge	Guyana	GY	MWJ	SYMR	-59.9	6.55	America/Guyana	0
4236	Tarempa Airport	Matak	Indonesia	ID	MWK	WIOM	106.258179	3.349249	Asia/Jakarta	0
4237	Mineral Wells Airport	Mineral Wells	United States	US	MWL	KMWL	-98.066667	32.783333	America/Chicago	0
4238	Windom Municipal Airport	Windom	United States	US	MWM	KMWM	-95.1	43.916667	America/Chicago	0
4239	Mwadui Airport	Mwadui	United Republic of Tanzania	TZ	MWN	HTTF	33.6	-3.55	Africa/Dar_es_Salaam	0
4240	Middletown Regional Airport	Middletown	United States	US	MWO	KMWO	-84.394168	39.529251	America/New_York	0
4241	Magwe Airport	Magwe	Myanmar	MM	MWQ	VYMW	94.941111	20.166667	Asia/Yangon	0
4242	Muan International Airport	Gwangju	Republic of Korea	KR	MWX	RKJB	126.382814	34.991406	Asia/Seoul	0
4243	Miranda Downs Airport	Miranda Downs	Australia	AU	MWY	YMIR	141.516667	-25.783333	Australia/Brisbane	0
4244	Mwanza Airport	Mwanza	United Republic of Tanzania	TZ	MWZ	HTMW	32.923225	-2.441221	Africa/Dar_es_Salaam	0
4245	Manila Municipal Airport	Manila	United States	US	MXA	KMXA	-90.183333	35.883333	America/Chicago	0
4246	Maxton Airport	Maxton	United States	US	MXE	KMEB	-79.333333	34.716667	America/New_York	0
4247	Maxwell Air Force Base	Montgomery	United States	US	MXF	KMXF	-86.365684	32.382266	America/Chicago	0
4248	Moro Airport	Moro	Papua New Guinea	PG	MXH	AYMR	143.250556	-6.3525	Pacific/Port_Moresby	0
4249	Mati Airport	Mati	Philippines	PH	MXI	RPMQ	126.25	6.916667	Asia/Manila	0
4250	Minna Airport	Minna	Nigeria	NG	MXJ	DNMN	6.533333	9.616667	Africa/Lagos	0
4251	Mexicali Airport	Mexicali	Mexico	MX	MXL	MMML	-115.248215	32.6282	America/Tijuana	0
4252	Morombe Airport	Morombe	Madagascar	MG	MXM	FMSR	43.375739	-21.751706	Indian/Antananarivo	0
4253	Morlaix Airport	Morlaix	France	FR	MXN	LFRU	-3.816667	48.6	Europe/Paris	0
4254	Monticello Municipal Airport	Monticello	United States	US	MXO	KMXO	-91.2	42.25	America/Chicago	0
4255	Milan Malpensa Airport	Milan	Italy	IT	MXP	LIMC	8.71237	45.627405	Europe/Rome	0
4256	Maota Savall Island Airport	Maota Savall Island	Samoa	WS	MXS	NSMA	-172.233333	-13.716667	Pacific/Apia	0
4257	Maintirano Airport	Maintirano	Madagascar	MG	MXT	FMMO	44.032778	-18.047778	Indian/Antananarivo	0
4258	Mullewa Airport	Mullewa	Australia	AU	MXU	YMWA	115.516667	-28.55	Australia/Perth	0
4259	Moron Airport	Moron	Mongolia	MN	MXV	ZMMN	100.095329	49.663244	Asia/Ulaanbaatar	0
4260	Mandalgobi Airport	Mandalgobi	Mongolia	MN	MXW	ZMMG	106.283333	45.766667	Asia/Ulaanbaatar	0
4261	Mora Airport	Mora	Sweden	SE	MXX	ESKM	14.504529	60.958119	Europe/Stockholm	0
4262	Mei Xian Airport	Mei Xian	China	CN	MXZ	ZGMX	116.104491	24.266812	Asia/Shanghai	0
4263	Moruya Airport	Moruya	Australia	AU	MYA	YMRY	150.147172	-35.90251	Australia/Sydney	0
4264	Mayoumba Airport	Mayoumba	Gabon	GA	MYB	FOOY	10.683333	-3.45	Africa/Libreville	0
4265	Malindi Airport	Malindi	Kenya	KE	MYD	HKML	40.100479	-3.230755	Africa/Nairobi	0
4266	Miyake Jima Airport	Miyake Jima	Japan	JP	MYE	RJTQ	139.5625	34.069444	Asia/Tokyo	0
4267	Montgomery-Gibbs Executive Airport	San Diego	United States	US	MYF	KMYF	-117.135633	32.815449	America/Los_Angeles	0
4268	Mayaguana Airport	Mayaguana	Bahamas	BS	MYG	MYMM	-73.018333	22.376667	America/Nassau	0
4269	Murray Island Airport	Murray Island	Australia	AU	MYI	YMAE	144.054344	-9.914758	Australia/Brisbane	0
4270	Matsuyama Airport	Matsuyama	Japan	JP	MYJ	RJOM	132.704058	33.829102	Asia/Tokyo	0
4271	Mc Call Airport	Mc Call	United States	US	MYL	KMYL	-116.1	44.916667	America/Denver	0
4272	Monkey Mountain Airport	Monkey Mountain	Guyana	GY	MYM	SYMM	-59.633333	4.6	America/Guyana	0
4273	Mareb Airport	Mareb	Republic of Yemen	YE	MYN	OYMB	45.333333	15.483333	Asia/Aden	0
4274	Myroodah Airport	Myroodah	Australia	AU	MYO	YMYR	124.266667	-18.116667	Australia/Perth	0
4275	Mary Airport	Mary	Turkmenistan	TM	MYP	UTAM	61.829644	37.664034	Asia/Ashgabat	0
4276	Mysore Airport	Mysore	India	IN	MYQ	VOMY	76.657727	12.22886	Asia/Kolkata	0
4277	Myrtle Beach International Airport	Myrtle Beach	United States	US	MYR	KMYR	-78.922944	33.682676	America/New_York	0
4278	Myitkyina Airport	Myitkyina	Myanmar	MM	MYT	VYMK	97.356922	25.384256	Asia/Yangon	0
4279	Ellis Field	Mekoryuk	United States	US	MYU	PAMY	-166.268056	60.372778	America/Anchorage	0
4280	Yuba County Airport	Marysville	United States	US	MYV	KMYV	-121.569722	39.098056	America/Los_Angeles	0
4281	Mtwara Airport	Mtwara	United Republic of Tanzania	TZ	MYW	HTMT	40.193611	-10.338889	Africa/Dar_es_Salaam	0
4282	Miri Airport	Miri	Malaysia	MY	MYY	WBGR	113.988106	4.324112	Asia/Kuala_Lumpur	0
4283	Monkey Bay Airport	Monkey Bay	Malawi	MW	MYZ	FWMY	34.533333	-14.1	Africa/Blantyre	0
4284	Manuel Prado Airport	Mazamari	Peru	PE	MZA	SPMF	-74.535599	-11.3254	America/Lima	0
4285	Mocimboa da Praia Airport	Mocimboa da Praia	Mozambique	MZ	MZB	FQMP	40.356075	-11.360261	Africa/Maputo	0
4286	Mitzic Airport	Mitzic	Gabon	GA	MZC	FOOM	11.566667	0.783333	Africa/Libreville	0
4287	Penghu Airport	Magong	Taiwan	TW	MZG	RCQC	119.6295	23.560451	Asia/Taipei	0
4288	Merzifon Airport	Merzifon	Turkiye	TR	MZH	LTAP	35.533333	40.883333	Europe/Istanbul	0
4289	Ambodedjo Airport	Mopti	Mali	ML	MZI	GAMB	-4.079561	14.512805	Africa/Bamako	0
4290	Pinal Airpark	Marana	United States	US	MZJ	KMZJ	-111.322337	32.510705	America/Phoenix	0
4291	Marakei Airport	Marakei	Kiribati	KI	MZK	NGMK	173.666667	1.983333	Pacific/Tarawa	0
4292	La Nubia Airport	Manizales	Colombia	CO	MZL	SKMZ	-75.468782	5.029005	America/Bogota	0
4293	Frescaty Airport	Metz	France	FR	MZM	LFSF	6.134444	49.0725	Europe/Paris	0
4294	Sierra Maestra Airport	Manzanillo	Cuba	CU	MZO	MUMZ	-77.128889	20.325	America/Havana	0
4295	Motueka Airport	Motueka	New Zealand	NZ	MZP	NZMK	172.991693	-41.122883	Pacific/Auckland	0
4296	Mkuze Airport	Mkuze	South Africa	ZA	MZQ	FAMU	32.045906	-27.623335	Africa/Johannesburg	0
4297	Mazar-I-Sharif Airport	Mazar-I-Sharif	Afghanistan	AF	MZR	OAMS	67.208485	36.709192	Asia/Kabul	0
4298	Mazatlan International Airport	Mazatlan	Mexico	MX	MZT	MMMZ	-106.270148	23.167314	America/Mazatlan	0
4299	Muzaffarpur Airport	Muzaffarpur	India	IN	MZU	VEMZ	85.383333	26.116667	Asia/Kolkata	0
4300	Mulu Airport	Mulu	Malaysia	MY	MZV	WBMU	114.8	4.033333	Asia/Kuala_Lumpur	0
4301	Mechria Airport	Mechria	Algeria	DZ	MZW	DAAY	-0.242177	33.5354	Africa/Algiers	0
4302	Mena Airport	Mena	Ethiopia	ET	MZX	HAML	39.716667	6.35	Africa/Addis_Ababa	0
4303	Mossel Bay Airport	Mossel Bay	South Africa	ZA	MZY	FAMO	22.083333	-34.183333	Africa/Johannesburg	0
4304	Marion Airport	Marion	United States	US	MZZ	KMZZ	-85.679444	40.490833	America/Indiana/Indianapolis	0
4305	Narrabri Airport	Narrabri	Australia	AU	NAA	YNBR	149.82912	-30.31829	Australia/Sydney	0
4306	Naracoorte Airport	Naracoorte	Australia	AU	NAC	YNRC	140.72714	-36.979112	Australia/Adelaide	0
4307	Natitingou Airport	Natitingou	Benin	BJ	NAE	DBBN	1.366667	10.383333	Africa/Porto-Novo	0
4308	Dr. Babasaheb Ambedkar International Airport	Nagpur	India	IN	NAG	VANP	79.05636	21.090037	Asia/Kolkata	0
4309	Naha Airport	Naha	Indonesia	ID	NAH	WAMH	125.366667	3.716667	Asia/Makassar	0
4310	Annai Airport	Annai	Guyana	GY	NAI	SYAN	-59	3.75	America/Guyana	0
4311	Nakhichevan Airport	Nakhichevan	Azerbaijan	AZ	NAJ	UBBN	45.458889	39.190278	Asia/Baku	0
4312	Nakhon Ratchasima Airport	Nakhon Ratchasima	Thailand	TH	NAK	VTUQ	102.314112	14.950625	Asia/Bangkok	0
4313	Nalchik Airport	Nalchik	Russian Federation	RU	NAL	URMN	43.7	43.533333	Europe/Moscow	0
4314	Namlea Airport	Namlea	Indonesia	ID	NAM	WAPR	127.100235	-3.237134	Asia/Jayapura	0
4315	Nadi International Airport	Nadi	Fiji	FJ	NAN	NFFN	177.451607	-17.75327	Pacific/Fiji	0
4316	Nanchong Airport	Nanchong	China	CN	NAO	ZUNC	106.066667	30.8	Asia/Shanghai	0
4317	Naples-Capodichino International Airport	Naples	Italy	IT	NAP	LIRN	14.291667	40.886111	Europe/Rome	0
4318	Nare Airport	Nare	Colombia	CO	NAR	SKPN	-74.583333	6.2	America/Bogota	0
4319	Nassau Lynden Pindling International Airport	Nassau	Bahamas	BS	NAS	MYNN	-77.466499	25.050419	America/Nassau	0
4320	Sao Goncalo do Amarante-Governador Aluizio Alves Intl Airport	Natal	Brazil	BR	NAT	SBSG	-35.372976	-5.76339	America/Belem	0
4321	Napuka Island Airport	Napuka Island	French Polynesia	PF	NAU	NTGN	-141.583333	-14.166667	Pacific/Tahiti	0
4322	Nevsehir Airport	Nevsehir	Turkiye	TR	NAV	LTAZ	34.716667	38.633333	Europe/Istanbul	0
4323	Narathiwat Airport	Narathiwat	Thailand	TH	NAW	VTSC	101.75	6.516667	Asia/Bangkok	0
4324	Beijing Nanyuan Airport	Beijing	China	CN	NAY	ZBNY	116.387778	39.7825	Asia/Shanghai	0
4325	Barrancominas Airport	Barrancominas	Colombia	CO	NBB	SKBM	-70.333333	3.333333	America/Bogota	0
4326	Begishevo Airport	Naberezhnye Chelny	Russian Federation	RU	NBC	UWKE	52.101637	55.565785	Europe/Moscow	0
4327	Enfidha - Hammamet International Airport	Enfidha	Tunisia	TN	NBE	DTNH	10.438738	36.08326	Africa/Tunis	0
4328	Naval Air Station/Alvin Callendar	New Orleans	United States	US	NBG	KNBG	-90.02336	29.830831	America/Chicago	0
4329	Nambucca Heads Airport	Nambucca Heads	Australia	AU	NBH	YNAA	152.983333	-30.633333	Australia/Sydney	0
4330	Annobon Airport	Annobon	Equatorial Guinea	GQ	NBN	FGAN	5.621944	-1.410277	Africa/Malabo	0
4331	Nairobi Jomo Kenyatta International Airport	Nairobi	Kenya	KE	NBO	HKJK	36.925781	-1.319167	Africa/Nairobi	0
4332	Guantanamo Bay Naval Station	Guantanamo	Cuba	CU	NBW	MUGM	-75.209294	19.909212	America/Havana	0
4333	Nabire Airport	Nabire	Indonesia	ID	NBX	WABI	135.433333	-3.366667	Asia/Jayapura	0
4334	North Caicos Airport	North Caicos	Turks and Caicos Islands	TC	NCA	MBNC	-71.983333	21.933333	America/Grand_Turk	0
4335	Nice Cote d'Azur Airport	Nice	France	FR	NCE	LFMN	7.205232	43.660488	Europe/Paris	0
4336	Nueva Casas Grandes Airport	Nueva Casas Grandes	Mexico	MX	NCG	MMCG	-107.916667	30.416667	America/Mexico_City	0
4337	Nachingwea Airport	Nachingwea	United Republic of Tanzania	TZ	NCH	HTNA	38.775	-10.363889	Africa/Dar_es_Salaam	0
4338	Necocli Airport	Necocli	Colombia	CO	NCI	SKNC	-76.75	8.483333	America/Bogota	0
4339	Sunchales Aeroclub Airport	Sunchales	Argentina	AR	NCJ	SAFS	-61.533459	-30.956625	America/Argentina/Cordoba	0
4340	Newcastle International Airport	Newcastle	United Kingdom	GB	NCL	EGNT	-1.710629	55.037062	Europe/London	0
4341	San Carlos Airport	San Carlos	Nicaragua	NI	NCR	MNSC	-84.769973	11.133423	America/Managua	0
4342	Newcastle Airport	Newcastle	South Africa	ZA	NCS	FANC	29.99	-27.774167	Africa/Johannesburg	0
4343	Guanacaste Airport	Nicoya	Costa Rica	CR	NCT	MRNC	-85.445	10.138889	America/Costa_Rica	0
4344	Nukus Airport	Nukus	Uzbekistan	UZ	NCU	UTNN	59.633333	42.483333	Asia/Tashkent	0
4345	Annecy-Meythet Airport	Annecy	France	FR	NCY	LFLP	6.100833	45.930556	Europe/Paris	0
4346	Bandanaira Airport	Bandanaira	Indonesia	ID	NDA	WAPC	129.9	-4.533333	Asia/Jayapura	0
4347	Nouadhibou Airport	Nouadhibou	Mauritania	MR	NDB	GQPP	-17.028333	20.934167	Africa/Nouakchott	0
4348	Nanded Airport	Nanded	India	IN	NDC	VOND	77.316667	19.183333	Asia/Kolkata	0
4349	Sumbe Airport	Sumbe	Angola	AO	NDD	FNSU	13.866667	-11.166667	Africa/Luanda	0
4350	Mandera Airport	Mandera	Kenya	KE	NDE	HKMA	41.866667	3.933333	Africa/Nairobi	0
4351	Qiqihar Airport	Qiqihar	China	CN	NDG	ZYQQ	123.916667	47.316667	Asia/Shanghai	0
4352	Ndjamena Airport	Ndjamena	Chad	TD	NDJ	FTTJ	15.034215	12.129056	Africa/Ndjamena	0
4353	Ndele Airport	Ndele	Central African Republic	CF	NDL	FEFN	20.6	8.416667	Africa/Bangui	0
4354	Mendi Airport	Mendi	Ethiopia	ET	NDM	HAMN	35.083333	9.816667	Africa/Addis_Ababa	0
4355	Nador International Airport	Nador	Morocco	MA	NDR	GMMW	-3.026172	34.992863	Africa/Casablanca	0
4356	Sandstone Airport	Sandstone	Australia	AU	NDS	YSAN	119.3	-27.983333	Australia/Perth	0
4357	Rundu Airport	Rundu	Namibia	NA	NDU	FYRU	19.723513	-17.955779	Africa/Windhoek	0
4358	Cuxhaven Airport	Nordholz-Spieka	Germany	DE	NDZ	EDXN	8.644722	53.768611	Europe/Berlin	0
4359	Necochea Airport	Necochea	Argentina	AR	NEC	SAZO	-58.75	-38.566667	America/Argentina/Buenos_Aires	0
4360	Negril Airport	Negril	Jamaica	JM	NEG	MKNG	-78.333333	18.308333	America/Jamaica	0
4361	Nejjo Airport	Nejjo	Ethiopia	ET	NEJ	HANJ	35.466667	9.5	Africa/Addis_Ababa	0
4362	Nekemt Airport	Nekemt	Ethiopia	ET	NEK	HANK	36.5	9.066667	Africa/Addis_Ababa	0
4363	Naec Airport	Lakehurst	United States	US	NEL	KNEL	-74.316667	40.016667	America/New_York	0
4364	Neryungri Airport	Neryungri	Russian Federation	RU	NER	UELL	124.914001	56.913898	Asia/Yakutsk	0
4365	Sam Neua Airport	Sam Neua	Lao People's Democratic Republic	LA	NEU	VLSN	104.067893	20.419033	Asia/Vientiane	0
4366	Newcastle Airport	Nevis	St. Kitts and Nevis	KN	NEV	TKPN	-62.5925	17.205	America/St_Kitts	0
4367	Lakefront Airport	New Orleans	United States	US	NEW	KNEW	-90.028297	30.0424	America/Chicago	0
4368	Naval Air Station	Fallon	United States	US	NFL	KNFL	-118.700996	39.416599	America/Los_Angeles	0
4369	Mata'aho Airport	Niuafo'ou	Tonga	TO	NFO	NFTO	-175.632804	-15.570655	Pacific/Tongatapu	0
4370	Young Airport	Young	Australia	AU	NGA	YYNG	148.25	-34.25	Australia/Sydney	0
4371	Ningbo Lishe International Airport	Ningbo	China	CN	NGB	ZSNB	121.462002	29.826696	Asia/Shanghai	0
4372	Auguste George Airport	Anegada	British Virgin Islands	VG	NGD	TUPA	-64.330057	18.727395	America/Tortola	0
4373	Ngaoundere Airport	Ngaoundere	Cameroon	CM	NGE	FKKN	13.561862	7.359071	Africa/Douala	0
4374	Ngau Island Airport	Ngau Island	Fiji	FJ	NGI	NFNG	179.333333	-18	Pacific/Fiji	0
4375	Nogliki Airport	Nogliki	Russian Federation	RU	NGK	UHSN	143.142505	51.784636	Asia/Sakhalin	0
4376	Ngala Airfield	Ngala	South Africa	ZA	NGL	FANG	31.324125	-24.38705	Africa/Johannesburg	0
4377	Nagoya Chubu Centrair International Airport	Nagoya	Japan	JP	NGO	RJGG	136.805278	34.858333	Asia/Tokyo	0
4378	Corpus Christi Naval Air Station (Truax Field)	Corpus Christi	United States	US	NGP	KNGP	-97.283333	27.7	America/Chicago	0
4379	Ngari Gunsa/Ali Kunsha Airport	Shi Quan He	China	CN	NGQ	ZUAL	80.054276	32.103817	Asia/Shanghai	0
4380	Nagasaki Airport	Nagasaki	Japan	JP	NGS	RJFU	129.92257	32.914398	Asia/Tokyo	0
4381	Naval Station Norfolk	Norfolk	United States	US	NGU	KNGU	-76.29248	36.940781	America/New_York	0
4382	Manang Airport	Manang	Nepal	NP	NGX	VNMA	84.088033	28.64121	Asia/Kathmandu	0
4383	Nha Trang Airport	Nha Trang	Viet Nam	VN	NHA	VVNT	109.196662	12.227912	Asia/Ho_Chi_Minh	0
4384	Minhad Air Base	Minhad	United Arab Emirates	AE	NHD	OMDM	55.367591	25.026895	Asia/Dubai	0
4385	New Halfa Airport	New Halfa	Sudan	SD	NHF	HSNW	35.733333	15.35	Africa/Khartoum	0
4386	Naval Air Station	Patuxent River	United States	US	NHK	KNHK	-76.433333	38.3	America/New_York	0
4387	Northolt Airport	Northolt	United Kingdom	GB	NHT	EGWU	-0.41452	51.547257	Europe/London	0
4388	Nuku Hiva Airport	Nuku Hiva	French Polynesia	PF	NHV	NTMD	-140.222224	-8.795214	Pacific/Marquesas	0
4389	Brunswick Executive Airport	Brunswick	United States	US	NHZ	KNHZ	-69.937591	43.892289	America/New_York	0
4390	Nimba Airport	Nimba	Liberia	LR	NIA	GLNA	-8.591667	7.491111	Africa/Monrovia	0
4391	Nikolai Airport	Nikolai	United States	US	NIB	PAFS	-154.358436	63.018558	America/Anchorage	0
4392	Nifty Airport	Nifty	Australia	AU	NIF	YCNF	121.588067	-21.670777	Australia/Perth	0
4393	Nikunau Airport	Nikunau	Kiribati	KI	NIG	NGNU	176.416667	-1.333333	Pacific/Tarawa	0
4394	Niamey Airport	Niamey	Niger	NE	NIM	DRRN	2.177158	13.476534	Africa/Niamey	0
4395	Nioki Airport	Nioki	The Democratic Republic of The Congo	CD	NIO	FZBI	17.7	-2.75	Africa/Kinshasa	0
4396	NAS (Towers Field)	Jacksonville	United States	US	NIP	KNIP	-81.675612	30.234314	America/New_York	0
4397	Niaqornat Heliport	Niaqornat	Greenland	GL	NIQ	BGNT	-53.656142	70.789442	America/Godthab	0
4398	Simberi Island Airport	Simberi Island	Papua New Guinea	PG	NIS	AYSE	151.998447	-2.661889	Pacific/Port_Moresby	0
4399	Niort Airport	Niort	France	FR	NIT	LFBN	-0.45	46.316667	Europe/Paris	0
4400	Niau Airport	Fakarava Niau	French Polynesia	PF	NIU	NTKN	-146.3683	-16.119094	Pacific/Tahiti	0
4401	Nioro Airport	Nioro	Mali	ML	NIX	GANR	-9.577222	15.239167	Africa/Bamako	0
4402	Atsugi Naval Air Field	Atsugi	Japan	JP	NJA	RJTA	139.450174	35.454603	Asia/Tokyo	0
4403	Nizhnevartovsk Airport	Nizhnevartovsk	Russian Federation	RU	NJC	USNN	76.491447	60.947603	Asia/Yekaterinburg	0
4404	Al-Ashraf International Airport	Al-Najaf	Iraq	IQ	NJF	ORNI	44.404576	31.989792	Asia/Baghdad	0
4405	Navy Air Facility El Centro	El Centro	United States	US	NJK	KNJK	-115.661315	32.822125	America/Los_Angeles	0
4406	Noonkanbah Airport	Noonkanbah	Australia	AU	NKB	YNKA	124.85	-18.55	Australia/Perth	0
4407	Nouakchott International Airport	Nouakchott	Mauritania	MR	NKC	GQNO	-15.967166	18.305687	Africa/Nouakchott	0
4408	Sinak, Irian Jaya Airport	Sinak, Irian Jaya	Indonesia	ID	NKD	WABS	110.466667	-5.85	Asia/Jayapura	0
4409	Nanjing Lukou International Airport	Nanjing	China	CN	NKG	ZSNJ	118.86652	31.735737	Asia/Shanghai	0
4410	Nagoya Airport	Nagoya	Japan	JP	NKM	RJNA	136.919572	35.253892	Asia/Tokyo	0
4411	Nukutepipi Airport	Nukutepipi	French Polynesia	PF	NKP	NTKU	-143.045556	-20.700278	Pacific/Tahiti	0
4412	Sirnak Airport	Cizre	Turkiye	TR	NKT	LTCV	42.059722	37.363333	Europe/Istanbul	0
4413	Nkaus Airport	Nkaus	Lesotho	LS	NKU	FXNK	28	-29.5	Africa/Maseru	0
4414	MCAS Miramar	San Diego	United States	US	NKX	KNKX	-117.134429	32.867945	America/Los_Angeles	0
4415	Nkayi Airport	Nkayi	Congo	CG	NKY	FCBY	13.3	-4.216667	Africa/Brazzaville	0
4416	Ndola Simon Mwansa Kapwepwe International Airport	Ndola	Zambia	ZM	NLA	FLND	28.516111	-12.961667	Africa/Lusaka	0
4417	Naval Air Station/Reeves Field	Lemoore	United States	US	NLC	KNLC	-119.766667	36.3	America/Los_Angeles	0
4418	Quetzalcoatl International Airport	Nuevo Laredo	Mexico	MX	NLD	MMNL	-99.570128	27.443702	America/Matamoros	0
4419	Darnley Island Airport	Darnley Island	Australia	AU	NLF	YDNI	143.780203	-9.579122	Australia/Brisbane	0
4420	Nelson Lagoon Airport	Nelson Lagoon	United States	US	NLG	PAOU	-161.160367	56.007536	America/Anchorage	0
4421	Nikolayevsk-na-Amure Airport	Nikolayevsk-na-Amure	Russian Federation	RU	NLI	UHNN	140.651111	53.154167	Asia/Vladivostok	0
4422	Norfolk Island Airport	Norfolk Island	Norfolk Island	NF	NLK	YSNF	167.939444	-29.0425	Pacific/Norfolk	0
4423	Nullagine Airport	Nullagine	Australia	AU	NLL	YNUL	120.2	-21.75	Australia/Perth	0
4424	N'Dolo Airport	Kinshasa	The Democratic Republic of The Congo	CD	NLO	FZAB	15.326389	-4.325	Africa/Kinshasa	0
4425	Nelspruit Airport	Nelspruit	South Africa	ZA	NLP	FANS	30.913889	-25.500833	Africa/Johannesburg	0
4426	Nicholson Airport	Nicholson	Australia	AU	NLS	YNIC	128.895833	-18.050833	Australia/Perth	0
4427	Nalati Airport	Xinyuan	China	CN	NLT	ZWNL	83.382225	43.43222	Asia/Shanghai	0
4428	Felipe Angeles International Airport	Mexico City	Mexico	MX	NLU	MMSM	-99.01651	19.755351	America/Mexico_City	0
4429	Nikolaev Airport	Nikolaev	Ukraine	UA	NLV	UKON	31.916667	47.05	Europe/Kiev	0
4430	Namangan Airport	Namangan	Uzbekistan	UZ	NMA	UTFN	71.6	40.983333	Asia/Tashkent	0
4431	Daman Airport	Daman	India	IN	NMB	VADN	72.95	20.416667	Asia/Kolkata	0
4432	Norman's Cay Airport	Norman's Cay	Bahamas	BS	NMC	MYEN	-76.82	24.593611	America/Nassau	0
4433	Nightmute Airport	Nightmute	United States	US	NME	PAGT	-164.700838	60.471047	America/Anchorage	0
4434	San Miguel Airport	San Miguel	Panama	PA	NMG	MPMI	-78.283333	8.366667	America/Panama	0
4435	New Moon Airport	New Moon	Australia	AU	NMP	YNMN	143.966667	-20.166667	Australia/Brisbane	0
4436	Nappamerry Airport	Nappamerry	Australia	AU	NMR	YNAP	141.116667	-27.6	Australia/Brisbane	0
4437	Namsang Airport	Namsang	Myanmar	MM	NMS	VYNS	97.735926	20.890685	Asia/Yangon	0
4438	Namtu Airport	Namtu	Myanmar	MM	NMT	VYNU	97.4	23.083333	Asia/Yangon	0
4439	Santa Ana Airport	Santa Ana	Solomon Islands	SB	NNB	AGGT	162.5	-10.833333	Pacific/Guadalcanal	0
4440	Nanning Wuxu International Airport	Nanning	China	CN	NNG	ZGNN	108.167501	22.61321	Asia/Shanghai	0
4441	Namutoni Airport	Namutoni	Namibia	NA	NNI	FYNA	16.916667	-18.816667	Africa/Windhoek	0
4442	Naryan-Mar Airport	Naryan-Mar	Russian Federation	RU	NNM	ULAM	53.15	67.616667	Europe/Moscow	0
4443	Connemara Airport	Spiddal	Ireland	IE	NNR	EICA	-9.466667	53.216667	Europe/Dublin	0
4444	Nan Airport	Nan	Thailand	TH	NNT	VTCN	100.783333	18.8	Asia/Bangkok	0
4445	Nanuque Airport	Nanuque	Brazil	BR	NNU	SNNU	-40.333333	-17.816667	America/Sao_Paulo	0
4446	Nunukan Airport	Nunukan	Indonesia	ID	NNX	WALF	117.667141	4.136772	Asia/Makassar	0
4447	Nanyang Airport	Nanyang	China	CN	NNY	ZHNY	112.613056	32.9837	Asia/Shanghai	0
4448	Nowra Airport	Nowra	Australia	AU	NOA	YSNW	150.5375	-34.950556	Australia/Sydney	0
4449	Nosara Beach Airport	Nosara Beach	Costa Rica	CR	NOB	MRNS	-85.653057	9.976398	America/Costa_Rica	0
4450	Ireland West Airport Knock	Knock	Ireland	IE	NOC	EIKN	-8.810468	53.914002	Europe/Dublin	0
4451	Norden Airport	Norden	Germany	DE	NOD	EDWS	7.2	53.583333	Europe/Berlin	0
4452	Nogales Airport	Nogales	Mexico	MX	NOG	MMNG	-110.933333	31.333333	America/Hermosillo	0
4453	Nojabrxsk Airport	Nojabrxsk	Russian Federation	RU	NOJ	USRO	75.294596	63.176731	Asia/Yekaterinburg	0
4454	Nova Xavantina Airport	Nova Xavantina	Brazil	BR	NOK	SWXV	-52.348611	-14.690278	America/Campo_Grande	0
4455	Nonouti Airport	Nonouti	Kiribati	KI	NON	NGTO	174.35	-0.680556	Pacific/Tarawa	0
4456	Sinop Airport - Turkey	Sinop	Turkiye	TR	NOP	LTCM	35.068889	42.0175	Europe/Istanbul	0
4457	Nordfjordur Airport	Nordfjordur	Iceland	IS	NOR	BINF	-13.746385	65.131883	Atlantic/Reykjavik	0
4458	Fascene Airport	Nossi-be	Madagascar	MG	NOS	FMNN	48.313889	-13.311111	Indian/Antananarivo	0
4459	Marin County Airport	Novato	United States	US	NOT	KDVO	-122.555833	38.143333	America/Los_Angeles	0
4460	Tontouta Airport	Noumea	New Caledonia	NC	NOU	NWWW	166.216111	-22.016389	Pacific/Noumea	0
4461	Huambo Airport	Huambo	Angola	AO	NOV	FNHU	15.757222	-12.805556	Africa/Luanda	0
4462	Novokuznetsk Airport	Novokuznetsk	Russian Federation	RU	NOZ	UNWW	86.877197	53.811401	Asia/Novokuznetsk	0
4463	Naval Air Station Pensacola	Pensacola	United States	US	NPA	KNPA	-87.314051	30.353596	America/Chicago	0
4464	Hawkes Bay Airport	Napier	New Zealand	NZ	NPE	NZNR	176.872261	-39.466672	Pacific/Auckland	0
4465	New Plymouth Airport	New Plymouth	New Zealand	NZ	NPL	NZNP	174.179325	-39.010132	Pacific/Auckland	0
4466	Nangapinoh Airport	Nangapinoh	Indonesia	ID	NPO	WIOG	111.733333	-0.333333	Asia/Makassar	0
4467	Napperby Airport	Napperby	Australia	AU	NPP	YNPB	132.683333	-22.5	Australia/Darwin	0
4468	Newport State Airport	Newport	United States	US	NPT	KUUU	-71.281362	41.532423	America/New_York	0
4469	San Pedro Uraba Airport	San Pedro Uraba	Colombia	CO	NPU	SQNQ	-71.916667	4.95	America/Bogota	0
4470	Naval Air Station	Memphis	United States	US	NQA	KNQA	-90.05	35.133333	America/Chicago	0
4471	Naval Air Station	Kingsville	United States	US	NQI	KNQI	-97.866667	27.516667	America/Chicago	0
4472	Niquelandia Airport	Niquelandia	Brazil	BR	NQL	SWNQ	-48.983333	-14	America/Sao_Paulo	0
4473	Presidente Peron International Airport	Neuquen	Argentina	AR	NQN	SAZN	-68.140082	-38.952503	America/Argentina/Buenos_Aires	0
4474	Nottingham Airport	Nottingham	United Kingdom	GB	NQT	EGBN	-1.0799	52.918793	Europe/London	0
4475	Nuqui Airport	Nuqui	Colombia	CO	NQU	SKNQ	-77.2793	5.695137	America/Bogota	0
4476	Naval Air Station Key West	Key West	United States	US	NQX	KNQX	-81.688479	24.576032	America/New_York	0
4477	Newquay Cornwall Airport	Newquay	United Kingdom	GB	NQY	EGHQ	-4.997922	50.43745	Europe/London	0
4478	Narrandera Airport	Narrandera	Australia	AU	NRA	YNAR	146.511702	-34.705644	Australia/Sydney	0
4479	Mayport Naval Station	Mayport	United States	US	NRB	KNRB	-81.418771	30.39151	America/New_York	0
4480	Norderney Airport	Norderney	Germany	DE	NRD	EDWY	7.23	53.706944	Europe/Berlin	0
4481	Namrole Airport	Namrole	Indonesia	ID	NRE	WAPG	126.703082	-3.854102	Asia/Jayapura	0
4482	Narrogin Airport	Narrogin	Australia	AU	NRG	YNRG	117.166667	-32.933333	Australia/Perth	0
4483	Kungsangen Airport	Norrkoping	Sweden	SE	NRK	ESSP	16.232393	58.583296	Europe/Stockholm	0
4484	North Ronaldsay Airport	North Ronaldsay	United Kingdom	GB	NRL	EGEN	-2.434444	59.367491	Europe/London	0
4485	Nara Airport	Nara	Mali	ML	NRM	GANK	-7.283333	15.25	Africa/Bamako	0
4486	Weeze Airport	Dusseldorf	Germany	DE	NRN	EDLV	6.150168	51.599286	Europe/Berlin	0
4487	Jose Aponte de la Torre Airport	Ceiba	Puerto Rico	PR	NRR	TJNR	-65.638889	18.25	America/Puerto_Rico	0
4488	NOLF Imperial Beach	Imperial Beach	United States	US	NRS	KNRS	-117.113811	32.564201	America/Los_Angeles	0
4489	Tokyo Narita International Airport	Tokyo	Japan	JP	NRT	RJAA	140.387443	35.773213	Asia/Tokyo	0
4490	Whiting Field Naval Air Station	Milton	United States	US	NSE	KNDZ	-87.05	30.633333	America/New_York	0
4491	Nsimalen Airport	Yaounde	Cameroon	CM	NSI	FKYS	11.550278	3.702222	Africa/Douala	0
4492	Noril'sk Airport	Noril'sk	Russian Federation	RU	NSK	UOOO	87.339807	69.323123	Asia/Krasnoyarsk	0
4493	Norseman Airport	Norseman	Australia	AU	NSM	YNSM	121.75	-32.2	Australia/Perth	0
4494	Nelson Airport	Nelson	New Zealand	NZ	NSN	NZNS	173.224227	-41.299122	Pacific/Auckland	0
4495	Scone Airport	Scone	Australia	AU	NSO	YSCO	150.8325	-32.036111	Australia/Sydney	0
4496	Nuussuaq Heliport	Nuussuaq	Greenland	GL	NSQ	BGNU	-57.065037	74.109853	America/Godthab	0
4497	Nakhon Si Thammarat Airport	Nakhon Si Thammarat	Thailand	TH	NST	VTSF	99.957527	8.467457	Asia/Bangkok	0
4498	Noosa Airport	Noosaville	Australia	AU	NSV	YNSH	153.06736	-26.421684	Australia/Brisbane	0
4499	Sigonella Naval Air Field	Sigonella	Italy	IT	NSY	LICZ	14.914698	37.40702	Europe/Rome	0
4500	Notodden Airport	Notodden	Norway	NO	NTB	ENNO	9.215656	59.564869	Europe/Oslo	0
4501	Naval Base Ventura County	Oxnard	United States	US	NTD	KNTD	-119.119432	34.119199	America/Los_Angeles	0
4502	Nantes Atlantique Airport	Nantes	France	FR	NTE	LFRS	-1.601402	47.157623	Europe/Paris	0
4503	Nantong Xingdong Airport	Nantong	China	CN	NTG	ZSNT	120.975605	32.072921	Asia/Shanghai	0
4504	Bintuni Airport	Bintuni	Indonesia	ID	NTI	WASB	133.25	-2.333333	Asia/Jayapura	0
4505	Newcastle Airport	Newcastle	Australia	AU	NTL	YWLM	151.84005	-32.804594	Australia/Sydney	0
4506	Normanton Airport	Normanton	Australia	AU	NTN	YNTN	141.073071	-17.685399	Australia/Brisbane	0
4507	Agostinho Neto Airport	Santo Antao Island	Cape Verde	CV	NTO	GVAN	-25.090392	17.202718	Atlantic/Cape_Verde	0
4508	Noto Airport	Wajima	Japan	JP	NTQ	RJNW	136.956803	37.294677	Asia/Tokyo	0
4509	Del Norte International Airport	Monterrey	Mexico	MX	NTR	MMAN	-100.238216	25.86456	America/Mexico_City	0
4510	Kuini Lavenia Airport	Niuatoputapu	Tonga	TO	NTT	NFTP	-174	-15.5	Pacific/Tongatapu	0
4511	Naval Air Station	Oceana	United States	US	NTU	KNTU	-76.033333	36.816667	America/New_York	0
4512	Natuna Ranai Airport	Natuna Ranai	Indonesia	ID	NTX	WIDO	108.383333	3.95	Asia/Jakarta	0
4513	Pilanesberg International Airport	Sun City	South Africa	ZA	NTY	FAPN	27.173401	-25.333799	Africa/Johannesburg	0
4514	Numbulwar Airport	Numbulwar	Australia	AU	NUB	YNUM	135.716389	-14.271667	Australia/Darwin	0
4515	En Nahud Airport	En Nahud	Sudan	SD	NUD	HSNH	28.416667	12.75	Africa/Khartoum	0
4516	Nuremberg Airport	Nuremberg	Germany	DE	NUE	EDDN	11.077062	49.494168	Europe/Berlin	0
4517	Nunchia Airport	Nunchia	Colombia	CO	NUH	SQHB	-72.216667	5.616667	America/Bogota	0
4518	Nuiqsut Airport	Nuiqsut	United States	US	NUI	PAQT	-151.005556	70.209722	America/Anchorage	0
4519	Nojeh Airport	Nojeh	Iran	IR	NUJ	OIHS	48.666667	35.2	Asia/Tehran	0
4520	Nukutavake Airport	Nukutavake, Tuamoto Island	French Polynesia	PF	NUK	NTGW	-138.7	-19.183333	Pacific/Tahiti	0
4521	Nulato Airport	Nulato	United States	US	NUL	PANU	-158.076667	64.727778	America/Anchorage	0
4522	Neom Bay Airport	Neom Bay	Saudi Arabia	SA	NUM	OENN	35.291935	27.927838	Asia/Riyadh	0
4523	Saufley Naval Air Station	Pensacola	United States	US	NUN	KNUN	-87.334118	30.468549	America/Chicago	0
4524	Moffett Federal Field	Mountain View	United States	US	NUQ	KNUQ	-122.049245	37.413874	America/Los_Angeles	0
4525	Norsup Airport	Norsup	Vanuatu	VU	NUS	NVSP	167.4	-16.058333	Pacific/Efate	0
4526	Nakuru Airport	Nakuru	Kenya	KE	NUU	HKNK	36.159241	-0.29812	Africa/Nairobi	0
4527	Ault Field	Whidbey Island	United States	US	NUW	KNUW	-122.655833	48.351944	America/Los_Angeles	0
4528	Benito Salas Airport	Neiva	Colombia	CO	NVA	SKNV	-75.293548	2.946896	America/Bogota	0
4529	Nevada Airport	Nevada	United States	US	NVD	KNVD	-94.303889	37.851389	America/Chicago	0
4530	Navoi Airport	Navoi	Uzbekistan	UZ	NVI	UTSA	65.159167	40.115	Asia/Tashkent	0
4531	Novo Aripuana Airport	Novo Aripuana	Brazil	BR	NVP	SWNA	-60.366667	-5.133333	America/Porto_Velho	0
4532	Nevers Airport	Nevers	France	FR	NVS	LFQG	3.15	47	Europe/Paris	0
4533	Navegantes Airport	Navegantes	Brazil	BR	NVT	SBNF	-48.64937	-26.879914	America/Sao_Paulo	0
4534	Neyveli Airport	Neyveli	India	IN	NVY	VONV	79.433333	11.6	Asia/Kolkata	0
4535	Bandar Es Eslam Airport	Moheli	Comoros	KM	NWA	FMCI	43.767155	-12.298664	Indian/Comoro	0
4536	Norwich International Airport	Norwich	United Kingdom	GB	NWI	EGSH	1.276782	52.669534	Europe/London	0
4537	Willow Grove Naval Air Station	Willow Grove	United States	US	NXX	KNXX	-75.133333	40.2	America/New_York	0
4538	Nyagan Airport	Nyagan	Russian Federation	RU	NYA	USHN	65.605627	62.101076	Asia/Yekaterinburg	0
4539	Nyeri Airport	Nyeri	Kenya	KE	NYE	HKNI	36.95	-0.416667	Africa/Nairobi	0
4540	Quantico Naval Air Station	Quantico	United States	US	NYG	KNYG	-77.283333	38.516667	America/New_York	0
4541	Sunyani Airport	Sunyani	Ghana	GH	NYI	DGSN	-2.329254	7.360586	Africa/Accra	0
4542	Nanyuki Airport	Nanyuki	Kenya	KE	NYK	HKNL	37.032026	0.039907	Africa/Nairobi	0
4543	Nadym Airport	Nadym	Russian Federation	RU	NYM	USMM	72.716667	65.483333	Asia/Yekaterinburg	0
4544	Nyngan Airport	Nyngan	Australia	AU	NYN	YNYN	147.183333	-31.566667	Australia/Sydney	0
4545	Stockholm Skavsta Airport	Stockholm	Sweden	SE	NYO	ESKN	16.922866	58.784247	Europe/Stockholm	0
4546	Nyurba Airport	Nyurba	Russian Federation	RU	NYR	UENN	118.346944	63.297222	Asia/Yakutsk	0
4547	Nay Pyi Taw Airport	Naypyidaw	Myanmar	MM	NYT	VYNT	96.201385	19.6225	Asia/Yangon	0
4548	Nyaung U Airport	Nyaung-u	Myanmar	MM	NYU	VYBG	94.928321	21.175342	Asia/Yangon	0
4549	Monywa Airport	Monywa	Myanmar	MM	NYW	VYMY	95.093978	22.22151	Asia/Yangon	0
4550	Cecil Airport	Jacksonville	United States	US	VQQ	KVQQ	-81.874156	30.220195	America/New_York	0
4551	Nzerekore Airport	Nzerekore	Guinea	GN	NZE	GUNZ	-8.702778	7.808333	Africa/Conakry	0
4552	Manzhouli Airport	Manzhouli	China	CN	NZH	ZBMZ	117.331627	49.570592	Asia/Shanghai	0
4553	North Island Naval Air Station	San Diego	United States	US	NZY	KNZY	-117.202708	32.700555	America/Los_Angeles	0
4554	Shank Air Base	Shank	Afghanistan	AF	OAA	OASH	69.071737	33.925597	Asia/Kabul	0
4555	Orange Airport	Orange	Australia	AU	OAG	YORG	149.124473	-33.381601	Australia/Sydney	0
4556	Shindand Air Base	Shindand	Afghanistan	AF	OAH	OASD	62.261111	33.392222	Asia/Kabul	0
4557	Bagram Airport	Bagram	Afghanistan	AF	OAI	OAIX	69.264969	34.946141	Asia/Kabul	0
4558	Albert J Ellis Airport	Richlands	United States	US	OAJ	KOAJ	-77.605834	34.830441	America/New_York	0
4559	San Francisco Bay Oakland International Airport	Oakland	United States	US	OAK	KOAK	-122.212011	37.71188	America/Los_Angeles	0
4560	Oamaru Airport	Oamaru	New Zealand	NZ	OAM	NZOU	171.081889	-44.970281	Pacific/Auckland	0
4561	Sharana Air Base	Sharana	Afghanistan	AF	OAS	OASA	68.83861	33.12583	Asia/Kabul	0
4562	Xoxocotlan Airport	Oaxaca	Mexico	MX	OAX	MMOX	-96.721635	17.000884	America/Mexico_City	0
4563	Camp Bastion	Lashkar Gah	Afghanistan	AF	OAZ	OAZI	64.224722	31.863889	Asia/Kabul	0
4564	Obock Airport	Obock	Djibouti	DJ	OBC	HDOB	43.266667	11.983333	Africa/Djibouti	0
4565	Obano Airport	Obano	Indonesia	ID	OBD	WAYO	136.2	-3.9	Asia/Jayapura	0
4566	Okeechobee County Airport	Okeechobee	United States	US	OBE	KOBE	-80.833333	27.25	America/New_York	0
4567	Oberpfaffenhofen Airport	Oberpfaffenhofen	Germany	DE	OBF	EDMO	11.283333	48.083333	Europe/Berlin	0
4568	Obidos Airport	Obidos	Brazil	BR	OBI	SNTI	-55.516667	-1.916667	America/Porto_Velho	0
4569	North Connel Airport	Oban	United Kingdom	GB	OBN	EGEO	-5.39967	56.463501	Europe/London	0
4570	Tokachi-Obihiro Airport	Obihiro	Japan	JP	OBO	RJCB	143.212437	42.732003	Asia/Tokyo	0
4571	Vals-Lanas Airport	Aubenas	France	FR	OBS	LFHO	4.7	44.666667	Europe/Paris	0
4572	Kobuk/Wien Airport	Kobuk	United States	US	OBU	PAOB	-156.883333	66.910556	America/Anchorage	0
4573	Ittoqqortoormiit Heliport	Ittoqqortoormiit	Greenland	GL	OBY	BGSC	-21.971944	70.488333	America/Scoresbysund	0
4574	Coca Airport	Coca	Ecuador	EC	OCC	SECO	-76.985962	-0.462171	America/Guayaquil	0
4575	Ocean City Municipal Airport	Ocean City	United States	US	OCE	KOXB	-75.124001	38.310398	America/New_York	0
4576	Ocala International Airport	Ocala	United States	US	OCF	KOCF	-82.221597	29.174091	America/New_York	0
4577	A.L. Mangham Jr. Regional Airport	Nacogdoches	United States	US	OCH	KOCH	-94.709503	31.577999	America/Chicago	0
4578	Boscobel Airport	Ocho Rios	Jamaica	JM	OCJ	MKBS	-76.969722	18.400556	America/Jamaica	0
4579	Boolgeeda Airport	Boolgeeda	Australia	AU	OCM	YBGD	117.275	-22.54	Australia/Perth	0
4580	Oceanside Municipal Airport	Oceanside	United States	US	OCN	KOKB	-117.353333	33.218611	America/Los_Angeles	0
4581	Aguasclaras Airport	Ocana	Colombia	CO	OCV	SKOC	-73.333333	8.25	America/Bogota	0
4582	Warren Field	Washington	United States	US	OCW	KOCW	-77.05	35.55	America/New_York	0
4583	Ouadda Airport	Ouadda	Central African Republic	CF	ODA	FEFW	22.401667	8.003889	Africa/Bangui	0
4584	Cordoba Airport	Cordoba	Spain and Canary Islands	ES	ODB	LEBA	-4.847222	37.841111	Europe/Madrid	0
4585	Oodnadatta Airport	Oodnadatta	Australia	AU	ODD	YOOD	135.45	-27.550278	Australia/Adelaide	0
4586	Beldringe Airport	Odense	Denmark	DK	ODE	EKOD	10.328814	55.47356	Europe/Copenhagen	0
4587	Odiham RAF Station	Odiham	United Kingdom	GB	ODH	EGVO	-0.943024	51.234232	Europe/London	0
4588	Ouanda Djalle Airport	Ouanda Djalle	Central African Republic	CF	ODJ	FEGO	22.883333	8.916667	Africa/Bangui	0
4589	Cordillo Downs Airport	Cordillo Downs	Australia	AU	ODL	YCOD	140.633333	-26.716667	Australia/Adelaide	0
4590	Long Seridan Airport	Long Seridan	Malaysia	MY	ODN	WBGI	115.066667	4.033333	Asia/Kuala_Lumpur	0
4591	Ord River Airport	Ord River	Australia	AU	ODR	YORV	128.8	-17.5	Australia/Perth	0
4592	Odessa International Airport	Odessa	Ukraine	UA	ODS	UKOO	30.676718	46.441008	Europe/Kiev	0
4593	Oudomxai Airport	Muang Xay	Lao People's Democratic Republic	LA	ODY	VLOS	101.994003	20.682699	Asia/Vientiane	0
4594	Oneal Airport	Vincennes	United States	US	OEA	KOEA	-87.533333	38.683333	America/Indiana/Indianapolis	0
4595	Ocussi Airport	Ocussi	Indonesia	ID	OEC	WPOC	124.341667	-9.205	Asia/Jayapura	0
4596	Vincent Fayks Airport	Paloemeu	Suriname	SR	OEM	SMPA	-55.45	3.35	America/Paramaribo	0
4597	Osceola Municipal Airport	Osceola	United States	US	OEO	KOEO	-92.7	45.3	America/Chicago	0
4598	Ornskoldsvik Airport	Ornskoldsvik	Sweden	SE	OER	ESNO	18.992074	63.412583	Europe/Stockholm	0
4599	Red Sea International Airport	Red Sea Project	Saudi Arabia	SA	RSI	OERS	37.078333	25.630278	Asia/Riyadh	0
4600	San Antonio Oeste Airport	San Antonio Oeste	Argentina	AR	OES	SAVN	-65.035278	-40.750556	America/Argentina/Buenos_Aires	0
4601	Offutt Air Force Base	Omaha	United States	US	OFF	KOFF	-95.913037	41.118376	America/Chicago	0
4602	Ouango Fitini Airport	Ouango Fitini	Cote d'Ivoire	CI	OFI	DIOF	-4.04991	9.600119	Africa/Abidjan	0
4603	Stefan Field	Norfolk	United States	US	OFK	KOFK	-97.434167	41.984167	America/Chicago	0
4604	Ofu Airport	Ofu Island	American Samoa	AS	OFU	NSAS	-169.669464	-14.18432	Pacific/Pago_Pago	0
4605	Searle Field	Ogallala	United States	US	OGA	KOGA	-101.716667	41.133333	America/Denver	0
4606	Orangeburg Municipal Airport	Orangeburg	United States	US	OGB	KOGB	-80.866667	33.5	America/New_York	0
4607	Ogden Municipal Airport	Ogden	United States	US	OGD	KOGD	-112.010833	41.196389	America/Denver	0
4608	Kahului Airport	Kahului	United States	US	OGG	PHOG	-156.438629	20.892883	Pacific/Honolulu	0
4609	Ogle Airport	Georgetown	Guyana	GY	OGL	SYEC	-58.105211	6.807733	America/Guyana	0
4610	Yonaguni Airport	Yonaguni	Japan	JP	OGN	ROYN	122.979684	24.465925	Asia/Tokyo	0
4611	Abengourou Airport	Abengourou	Cote d'Ivoire	CI	OGO	DIAU	-3.45	6.7	Africa/Abidjan	0
4612	Bongor Airport	Bongor	Chad	TD	OGR	FTTB	15.383333	10.289444	Africa/Ndjamena	0
4613	Ogdensburg Airport	Ogdensburg	United States	US	OGS	KOGS	-75.465833	44.681667	America/New_York	0
4614	Ordu Giresun Airport	Gulyali	Turkiye	TR	OGU	LTCB	38.08142	40.967565	Europe/Istanbul	0
4615	Ongava Airport	Ongava	Namibia	NA	OGV	FYNG	15.915	-19.328889	Africa/Windhoek	0
4616	Ain Beida Airport	Ouargla	Algeria	DZ	OGX	DAUU	5.4	31.916667	Africa/Algiers	0
4617	Vladikavkaz Airport	Vladikavkaz	Russian Federation	RU	OGZ	URMO	44.6	43.2	Europe/Moscow	0
4618	Royal Air Force Base	Ohakea	New Zealand	NZ	OHA	NZOH	175.386667	-40.208333	Pacific/Auckland	0
4619	Ohrid Airport	Ohrid	Macedonia (FYROM)	MK	OHD	LWOH	20.743216	41.180231	Europe/Skopje	0
4620	Mohe Airport	Mohe	China	CN	OHE	ZYMH	122.420595	52.921132	Asia/Shanghai	0
4621	Novostroyka Airport	Okha	Russian Federation	RU	OHH	UHSH	142.88333	53.516666	Asia/Sakhalin	0
4622	Oshakati Airport	Oshakati	Namibia	NA	OHI	FYOS	15.8	-17.783333	Africa/Windhoek	0
4623	Okhotsk Airport	Okhotsk	Russian Federation	RU	OHO	UHOO	143.064436	59.413672	Asia/Vladivostok	0
4624	Wyk Airport	Wyk	Germany	DE	OHR	EDXY	8.529167	54.685833	Europe/Berlin	0
4625	Sohar Airport	Sohar	Oman	OM	OHS	OOSH	56.617474	24.395722	Asia/Muscat	0
4626	Eaton Airport	Norwich	United States	US	OIC	KOIC	-75.533333	42.533333	America/New_York	0
4627	Semnan Airport	Semnan	Iran	IR	SNX	OIIS	53.494444	35.590833	Asia/Tehran	0
4628	Oshima Airport	Oshima	Japan	JP	OIM	RJTO	139.365	34.779167	Asia/Tokyo	0
4629	Okushiri Airport	Okushiri	Japan	JP	OIR	RJEO	139.43488	42.071984	Asia/Tokyo	0
4630	Oita Airport	Oita	Japan	JP	OIT	RJFO	131.732362	33.477237	Asia/Tokyo	0
4631	Johnson Executive Airport	Kansas City	United States	US	OJC	KOJC	-94.733333	38.85	America/Chicago	0
4632	Naha Airport	Okinawa	Japan	JP	OKA	ROAH	127.645842	26.204954	Asia/Tokyo	0
4633	Fraser Island Airport	Orchid Beach	Australia	AU	OKB	YORC	153.166667	-25.25	Australia/Brisbane	0
4634	Will Rogers World Airport	Oklahoma City	United States	US	OKC	KOKC	-97.59609	35.395629	America/Chicago	0
4635	Okadama Airport	Sapporo	Japan	JP	OKD	RJCO	141.381998	43.110374	Asia/Tokyo	0
4636	Okino Erabu Airport	Wadomari	Japan	JP	OKE	RJKB	128.705556	27.431667	Asia/Tokyo	0
4637	Okaukuejo Airport	Okaukuejo	Namibia	NA	OKF	FYOO	15.9117	-19.1494	Africa/Windhoek	0
4638	Oki Island Airport	Oki Island	Japan	JP	OKI	RJNO	133.316667	36.166667	Asia/Tokyo	0
4639	Okayama Airport	Okayama	Japan	JP	OKJ	RJOB	133.85277	34.760218	Asia/Tokyo	0
4640	Kokomo Municipal Airport	Kokomo	United States	US	OKK	KOKK	-86.058056	40.529722	America/Indiana/Indianapolis	0
4641	Gunung Bintang Airport	Oksibil	Indonesia	ID	OKL	WAJO	140.630456	-4.908143	Asia/Jayapura	0
4642	Okmulgee Airport	Okmulgee	United States	US	OKM	KOKM	-95.966667	35.616667	America/Chicago	0
4643	Okondja Airport	Okondja	Gabon	GA	OKN	FOGQ	14.008333	-1	Africa/Libreville	0
4644	Yokota Air Force Base	Tokyo	Japan	JP	OKO	RJTY	139.35	35.75	Asia/Tokyo	0
4645	Okaba Airport	Okaba	Indonesia	ID	OKQ	WAKO	139.7	-8.1	Asia/Jayapura	0
4646	Yorke Island Airport	Yorke Island	Australia	AU	OKR	YYKI	143.405625	-9.752783	Australia/Brisbane	0
4647	Oshkosh Airport	Oshkosh	United States	US	OKS	KOKS	-102.35	41.4	America/Chicago	0
4648	Oktiabrskij Airport	Oktiabrskij	Russian Federation	RU	OKT	UWUK	53.383333	54.433333	Asia/Yekaterinburg	0
4649	Mokuti Lodge Airport	Mokuti Lodge	Namibia	NA	OKU	FYMO	17.05	-18.808333	Africa/Windhoek	0
4650	Oakey Airport	Oakey	Australia	AU	OKY	YBOK	151.735	-27.406667	Australia/Brisbane	0
4651	Orland Airport	Orland	Norway	NO	OLA	ENOL	9.604094	63.698789	Europe/Oslo	0
4652	Olbia Costa Smeralda Airport	Olbia	Italy	IT	OLB	LIEO	9.514823	40.903143	Europe/Rome	0
4653	Old Town Airport	Old Town	United States	US	OLD	KOLD	-68.65	44.933333	America/New_York	0
4654	Cattaraugus County Airport	Olean	United States	US	OLE	KOLE	-78.371399	42.241199	America/New_York	0
4655	Wolf Point International Airport	Wolf Point	United States	US	OLF	KOLF	-105.566389	48.094722	America/Denver	0
4656	Rif Airport	Olafsvik	Iceland	IS	OLI	BIRF	-23.983333	65	Atlantic/Reykjavik	0
4657	West Cost Santo Airport	Olpoi	Vanuatu	VU	OLJ	NVSZ	166.560021	-14.884605	Pacific/Efate	0
4658	Fuerte Olimpo Airport	Fuerte Olimpo	Paraguay	PY	OLK	SGOL	-57.883056	-21.996944	America/Asuncion	0
4659	Oyo Ollombo Airport	Oyo	Congo	CG	OLL	FCOD	15.91465	-1.222408	Africa/Brazzaville	0
4660	Olympia Regional Airport	Olympia	United States	US	OLM	KOLM	-122.903333	46.973611	America/Los_Angeles	0
4661	Olomouc Airport	Olomouc	Czech Republic	CZ	OLO	LKOL	17.2	49.633333	Europe/Prague	0
4662	Olympic Dam Airport	Olympic Dam	Australia	AU	OLP	YOLD	136.884111	-30.483898	Australia/Adelaide	0
4663	Salerno Air Base	Salerno	Afghanistan	AF	OLR	OASL	69.957138	33.363415	Asia/Kabul	0
4664	Nogales International Airport	Nogales	United States	US	OLS	KOLS	-110.85	31.416667	America/Phoenix	0
4665	Columbus Airport	Columbus	United States	US	OLU	KOLU	-97.341667	41.447222	America/Chicago	0
4666	Olive Branch Airport	Olive Branch	United States	US	OLV	KOLV	-89.788449	34.978307	America/Chicago	0
4667	Olkiombo Airport	Maasai Mara	Kenya	KE	OLX	HKOK	35.109912	-1.408695	Africa/Nairobi	0
4668	Olney Airport	Olney	United States	US	OLY	KOLY	-88.083333	38.716667	America/Chicago	0
4669	Olokminsk Airport	Olokminsk	Russian Federation	RU	OLZ	UEMO	120.464167	60.399167	Asia/Yakutsk	0
4670	Omaha Eppley Airfield	Omaha	United States	US	OMA	KOMA	-95.899717	41.29957	America/Chicago	0
4671	Omboue Airport	Omboue	Gabon	GA	OMB	FOOH	9.266667	-1.6	Africa/Libreville	0
4672	Ormoc Airport	Ormoc	Philippines	PH	OMC	RPVO	124.565485	11.055482	Asia/Manila	0
4673	Oranjemund Airport	Oranjemund	Namibia	NA	OMD	FYOG	16.45	-28.583333	Africa/Windhoek	0
4674	Nome Airport	Nome	United States	US	OME	PAOM	-165.431055	64.510601	America/Anchorage	0
4675	Omega Airport	Omega	Namibia	NA	OMG	FYOE	22.066667	-18	Africa/Windhoek	0
4676	Urmia Airport	Nazluy-ye Jonubi	Iran	IR	OMH	OITR	45.065648	37.664954	Asia/Tehran	0
4677	Omidiyeh Air Base	Omidiyeh	Iran	IR	OMI	OIAJ	49.533333	30.833333	Asia/Tehran	0
4678	Omura Airport	Omura	Japan	JP	OMJ	RJDU	129.934457	32.930172	Asia/Tokyo	0
4679	Omak Municipal Airport	Omak	United States	US	OMK	KOMK	-119.517174	48.461576	America/Los_Angeles	0
4680	Marmul Airport	Marmul	Oman	OM	OMM	OOMX	55.181691	18.139893	Asia/Muscat	0
4681	Mostar Airport	Mostar	Bosnia and Herzegovina	BA	OMO	LQMO	17.846667	43.285556	Europe/Sarajevo	0
4682	Oradea Airport	Oradea	Romania	RO	OMR	LROD	21.903056	47.0275	Europe/Bucharest	0
4683	Omsk Airport	Omsk	Russian Federation	RU	OMS	UNOO	73.316707	54.957455	Asia/Omsk	0
4684	Oddor Meanche Airport	Oddor Meanche	Cambodia	KH	OMY	VDPV	104.966667	13.816667	Asia/Phnom_Penh	0
4685	Winona Municipal Airport	Winona	United States	US	ONA	KONA	-91.706111	44.076667	America/Chicago	0
4686	Ondangwa Airport	Ondangwa	Namibia	NA	OND	FYOA	15.942233	-17.885496	Africa/Windhoek	0
4687	Mornington Airport	Mornington	Australia	AU	ONG	YMTI	139.170047	-16.662558	Australia/Brisbane	0
4688	Moanamani Airport	Moanamani	Indonesia	ID	ONI	WABD	135.5	-3.333333	Asia/Jayapura	0
4689	Odate Noshiro Airport	Odate Noshiro	Japan	JP	ONJ	RJSR	140.373826	40.196414	Asia/Tokyo	0
4690	O'Neill Municipal Airport	O'Neill	United States	US	ONL	KONL	-98.686259	42.466414	America/Chicago	0
4691	Socorro Airport	Socorro	United States	US	ONM	KONM	-106.9	34.066667	America/Denver	0
4692	Ontario Airport	Ontario	United States	US	ONO	KONO	-117.013889	44.022778	America/Los_Angeles	0
4693	Newport Airport	Newport	United States	US	ONP	KONP	-124.057999	44.580399	America/Los_Angeles	0
4694	Zonguldak Airport	Zonguldak	Turkiye	TR	ONQ	LTAS	32.089599	41.506141	Europe/Istanbul	0
4695	Monkira Airport	Monkira	Australia	AU	ONR	YMNK	140.566667	-24.816667	Australia/Brisbane	0
4696	Onslow Airport	Onslow	Australia	AU	ONS	YOLW	115.111987	-21.668927	Australia/Perth	0
4697	Ontario International Airport	Ontario	United States	US	ONT	KONT	-117.601193	34.056001	America/Los_Angeles	0
4698	Ono I Lau Airport	Ono I Lau	Fiji	FJ	ONU	NFOL	179	-16.333333	Pacific/Fiji	0
4699	Colon Airport	Colon	Panama	PA	ONX	MPEJ	-79.9	9.35	America/Panama	0
4700	Olney Airport	Olney	United States	US	ONY	KONY	-98.75	33.366667	America/Chicago	0
4701	Oskaloosa Municipal Airport	Oskaloosa	United States	US	OOA	KOOA	-92.65	41.3	America/Chicago	0
4702	Koodaideri Mine Airport	Koodaideri Mine	Australia	AU	OOD	YKDD	119.0761	-22.5053	Australia/Perth	0
4703	Toksook Bay Airport	Toksook Bay	United States	US	OOK	PAOO	-165.108333	60.531944	America/Anchorage	0
4704	Gold Coast Airport	Coolangatta (Gold Coast)	Australia	AU	OOL	YBCG	153.513137	-28.166164	Australia/Brisbane	0
4705	Snowy Mountains Airport	Cooma	Australia	AU	OOM	YCOM	148.971479	-36.29273	Australia/Sydney	0
4706	Mooraberree Airport	Mooraberree	Australia	AU	OOR	YMOO	141.233333	-25.05	Australia/Brisbane	0
4707	Onotoa Airport	Onotoa	Kiribati	KI	OOT	NGON	175.566667	-1.916667	Pacific/Tarawa	0
4708	Kopasker Airport	Kopasker	Iceland	IS	OPA	BIKP	-16.483333	66.416667	Atlantic/Reykjavik	0
4709	Miami-Opa Locka Executive Airport	Miami	United States	US	OPF	KOPF	-80.274424	25.90856	America/New_York	0
4710	Oenpelli Airport	Oenpelli	Australia	AU	OPI	YOEN	133.066667	-12.333333	Australia/Darwin	0
4711	St Landry Parish Airport	Opelousas	United States	US	OPL	KOPL	-92.083333	30.533333	America/Chicago	0
4712	Porto Airport	Porto	Portugal	PT	OPO	LPPR	-8.670272	41.237774	Europe/Lisbon	0
4713	Sinop Airport	Sinop	Brazil	BR	OPS	SBSI	-55.58156	-11.878573	America/Campo_Grande	0
4714	Opuwa Airport	Opuwa	Namibia	NA	OPW	FYOP	13.833333	-18.066667	Africa/Windhoek	0
4715	Oran Airport	Oran	Argentina	AR	ORA	SASO	-64.166667	-23.333333	America/Argentina/Buenos_Aires	0
4716	Orebro-Bofors Airport	Orebro	Sweden	SE	ORB	ESOE	15.047543	59.225756	Europe/Stockholm	0
4717	Orocue Airport	Orocue	Colombia	CO	ORC	SKOE	-71.333333	4.9	America/Bogota	0
4718	Chicago O'Hare International Airport	Chicago	United States	US	ORD	KORD	-87.904876	41.976912	America/Chicago	0
4719	Orleans Airport	Orleans	France	FR	ORE	LFOJ	1.9	47.916667	Europe/Paris	0
4720	Norfolk International Airport	Norfolk	United States	US	ORF	KORF	-76.206295	36.898583	America/New_York	0
4721	Zorg En Hoop Airport	Paramaribo	Suriname	SR	ORG	SMZO	-55.190965	5.811089	America/Paramaribo	0
4722	Worcester Regional Airport	Worcester	United States	US	ORH	KORH	-71.874444	42.269167	America/New_York	0
4723	Orinduik Airport	Orinduik	Guyana	GY	ORJ	SYOR	-60.033333	4.716667	America/Guyana	0
4724	Cork Airport	Cork	Ireland	IE	ORK	EICK	-8.489847	51.849107	Europe/Dublin	0
4725	Orlando Executive Airport	Orlando	United States	US	ORL	KORL	-81.335556	28.544167	America/New_York	0
4726	Northampton Airport	Northampton	United Kingdom	GB	ORM	EGBK	-0.793056	52.305302	Europe/London	0
4727	Es Senia Airport	Oran	Algeria	DZ	ORN	DAOO	-0.606108	35.620019	Africa/Algiers	0
4728	Orapa Airport	Orapa	Botswana	BW	ORP	FBOR	25.3167	-21.266701	Africa/Gaborone	0
4729	Yorktown Airport	Yorktown	Australia	AU	ORR	YYOR	137.583333	-35.033333	Australia/Adelaide	0
4730	Waterport Airport	Orpheus Island	Australia	AU	ORS	YOPH	146.493	-18.634667	Australia/Brisbane	0
4731	Tikrit Airport	Tikrit	Iraq	IQ	XTV	ORSH	43.543056	34.673333	Asia/Baghdad	0
4732	Northway Airport	Northway	United States	US	ORT	PAOR	-141.923889	62.961944	America/Anchorage	0
4733	Juan Mendoza Airport	Oruro	Bolivia	BO	ORU	SLOR	-67.07796	-17.962283	America/La_Paz	0
4734	Robert (Bob) Curtis Memorial Airport	Noorvik	United States	US	ORV	PFNO	-161.029281	66.817428	America/Anchorage	0
4735	Ormara Airport	Ormara	Pakistan	PK	ORW	OPOR	64.583333	25.3	Asia/Karachi	0
4736	Oriximina Airport	Oriximina	Brazil	BR	ORX	SNOX	-55.866667	-1.75	America/Porto_Velho	0
4737	Paris Orly Airport	Paris	France	FR	ORY	LFPO	2.3597	48.728283	Europe/Paris	0
4738	Wurtsmith Air Force Base	Oscoda	United States	US	OSC	KOSC	-83.384978	44.453811	America/New_York	0
4739	Are Ostersund Airport	Ostersund	Sweden	SE	OSD	ESNZ	14.494444	63.198611	Europe/Stockholm	0
4740	Ostafyevo International Airport	Moscow	Russian Federation	RU	OSF	UUMO	37.5025	55.5075	Europe/Moscow	0
4741	Wittman Regional Airport	Oshkosh	United States	US	OSH	KOSH	-88.556944	43.983889	America/Chicago	0
4742	Osijek Airport	Osijek	Croatia	HR	OSI	LDOS	18.807212	45.465883	Europe/Zagreb	0
4743	Oskarshamn Airport	Oskarshamn	Sweden	SE	OSK	ESMO	16.433333	57.266667	Europe/Stockholm	0
4744	Oslo Gardermoen Airport	Oslo	Norway	NO	OSL	ENGM	11.100411	60.194192	Europe/Oslo	0
4745	Mosul Airport	Mosul	Iraq	IQ	OSM	ORBM	43.149444	36.3075	Asia/Baghdad	0
4746	Osan Air Base	Osan	Republic of Korea	KR	OSN	RKSO	127.030015	37.088688	Asia/Seoul	0
4747	Osborne Mine Airport	Osborne Mine	Australia	AU	OSO	YOSB	140.560884	-22.08573	Australia/Brisbane	0
4748	Redzikowo Airport	Slupsk	Poland	PL	OSP	EPSK	17.016667	54.466667	Europe/Warsaw	0
4749	Mosnov Airport	Ostrava	Czech Republic	CZ	OSR	LKMT	18.121285	49.695517	Europe/Prague	0
4750	Osh Airport	Osh	Kyrgyzstan	KG	OSS	UCFO	72.786482	40.60769	Asia/Bishkek	0
4751	Ostend-Bruges International Airport	Ostend	Belgium	BE	OST	EBOS	2.863611	51.199722	Europe/Brussels	0
4752	Ohio State University Airport	Columbus	United States	US	OSU	KOSU	-83.074769	40.075696	America/New_York	0
4753	Orsk Airport	Orsk	Russian Federation	RU	OSW	UWOR	58.5956	51.072498	Asia/Yekaterinburg	0
4754	Attala County Airport	Kosciusko	United States	US	OSX	KOSX	-89.583333	33.066667	America/Chicago	0
4755	Namsos Airport	Namsos	Norway	NO	OSY	ENNM	11.570002	64.47273	Europe/Oslo	0
4756	Mota Airport	Mota	Ethiopia	ET	OTA	HAMO	37.883333	11.066667	Africa/Addis_Ababa	0
4757	Bol Airport	Bol	Chad	TD	OTC	FTTL	14.733333	13.433333	Africa/Ndjamena	0
4758	Contadora Airport	Contadora	Panama	PA	OTD	MPRA	-79.034698	8.62876	America/Panama	0
4759	Worthington Airport	Worthington	United States	US	OTG	KOTG	-95.583611	43.652222	America/Chicago	0
4760	Southwest Oregon Regional Airport	North Bend	United States	US	OTH	KOTH	-124.245908	43.416235	America/Los_Angeles	0
4761	Pitu Airport	Morotai Island	Indonesia	ID	OTI	WAEW	128.324997	2.04599	Asia/Jayapura	0
4762	Otjiwarongo Airport	Otjiwarongo	Namibia	NA	OTJ	FYOW	16.6625	-20.430556	Africa/Windhoek	0
4763	Boutilimit Airport	Boutilimit	Mauritania	MR	OTL	GQNB	-14.666667	17.75	Africa/Nouakchott	0
4764	Industrial Airport	Ottumwa	United States	US	OTM	KOTM	-92.449167	41.106389	America/Chicago	0
4765	Bucharest Henri Coanda International Airport	Bucharest	Romania	RO	OTP	LROP	26.077063	44.571155	Europe/Bucharest	0
4766	Coto 47 Airport	Coto 47	Costa Rica	CR	OTR	MRCC	-82.933333	8.566667	America/Costa_Rica	0
4767	Otu Airport	Otu	Colombia	CO	OTU	SKOT	-74.716667	7	America/Bogota	0
4768	Ontong Java Airport	Ontong Java	Solomon Islands	SB	OTV	AGGQ	159.522778	-5.513889	Pacific/Guadalcanal	0
4769	Ralph Wien Memorial Airport	Kotzebue	United States	US	OTZ	PAOT	-162.602699	66.890613	America/Anchorage	0
4770	Ouagadougou International Airport	Ouagadougou	Burkina Faso	BF	OUA	DFFD	-1.514283	12.355019	Africa/Ouagadougou	0
4771	Les Angades Airport	Oujda	Morocco	MA	OUD	GMFO	-1.933333	34.783333	Africa/Casablanca	0
4772	Ouesso Airport	Ouesso	Congo	CG	OUE	FCOU	16.048611	1.616667	Africa/Brazzaville	0
4773	Ouahigouya Airport	Ouahigouya	Burkina Faso	BF	OUG	DFCC	-2.333333	13.516667	Africa/Ouagadougou	0
4774	Oudtshoorn Airport	Oudtshoorn	South Africa	ZA	OUH	FAOH	22.188333	-33.603333	Africa/Johannesburg	0
4775	Oulu Airport	Oulu	Finland	FI	OUL	EFOU	25.375425	64.93012	Europe/Helsinki	0
4776	Max Westheimer Airport	Norman	United States	US	OUN	KOUN	-97.471223	35.24507	America/Chicago	0
4777	Batouri Airport	Batouri	Cameroon	CM	OUR	FKKI	14.363611	4.473056	Africa/Douala	0
4778	Ourinhos Airport	Ourinhos	Brazil	BR	OUS	SDOU	-49.916667	-22.966667	America/Sao_Paulo	0
4779	Bousso Airport	Bousso	Chad	TD	OUT	FTTS	16.716667	10.483333	Africa/Ndjamena	0
4780	Tazadit Airport	Zouerate	Mauritania	MR	OUZ	GQPZ	-12.481762	22.757367	Africa/Nouakchott	0
4781	Bekily Airport	Bekily	Madagascar	MG	OVA	FMSL	45.305	-24.2325	Indian/Antananarivo	0
4782	Novosibirsk Tolmachevo Airport	Novosibirsk	Russian Federation	RU	OVB	UNNT	82.666999	55.009011	Asia/Novosibirsk	0
4783	Asturias Airport	Asturias	Spain and Canary Islands	ES	OVD	LEAS	-6.032094	43.55891	Europe/Madrid	0
4784	Oroville Airport	Oroville	United States	US	OVE	KOVE	-121.616667	39.5	America/Los_Angeles	0
4785	Overberg Air Force Base	Overberg	South Africa	ZA	OVG	FAOB	20.250728	-34.554736	Africa/Johannesburg	0
4786	Ovalle Airport	Ovalle	Chile	CL	OVL	SCOV	-71	-30.566667	America/Santiago	0
4787	Sovetsky Airport	Sovetsky	Russian Federation	RU	OVS	USHS	63.603381	61.325288	Asia/Yekaterinburg	0
4788	Owatonna Airport	Owatonna	United States	US	OWA	KOWA	-93.166667	44.1	America/Chicago	0
4789	Daviess County Airport	Owensboro	United States	US	OWB	KOWB	-87.165833	37.740833	America/Chicago	0
4790	Norwood Memorial Airport	Norwood	United States	US	OWD	KOWD	-71.176789	42.192124	America/New_York	0
4791	Central Maine Airport	Norridgewock	United States	US	OWK	KOWK	-69.8	44.716667	America/New_York	0
4792	Osvaldo Vieira Airport	Bissau	Guinea-Bissau	GW	OXB	GGOV	-15.657222	11.888889	Africa/Bissau	0
4793	Waterbury-Oxford Airport	Oxford	United States	US	OXC	KOXC	-73.136389	41.479167	America/New_York	0
4794	Miami University Airport	Oxford	United States	US	OXD	KOXD	-84.761111	39.860278	America/New_York	0
4795	London Oxford Airport	Oxford	United Kingdom	GB	OXF	EGTK	-1.32	51.836944	Europe/London	0
4796	Oxnard Airport	Oxnard	United States	US	OXR	KOXR	-119.206389	34.201111	America/Los_Angeles	0
4797	Morney Airport	Morney	Australia	AU	OXY	YMNY	141.366667	-25.35	Australia/Brisbane	0
4798	Goya Airport	Goya	Argentina	AR	OYA	SATG	-59.216667	-29.103333	America/Argentina/Buenos_Aires	0
4799	Oyem Airport	Oyem	Gabon	GA	OYE	FOGO	11.578365	1.536975	Africa/Libreville	0
4800	Moyo Airport	Moyo	Uganda	UG	OYG	HUMY	31.716667	3.65	Africa/Kampala	0
4801	Oiapoque Airport	Oiapoque	Brazil	BR	OYK	SBOI	-51.783333	3.883333	America/Belem	0
4802	Moyale Airport	Moyale	Kenya	KE	OYL	HKMY	39.099871	3.471859	Africa/Nairobi	0
4803	Ouyen Airport	Ouyen	Australia	AU	OYN	YOUY	142.333333	-35.066667	Australia/Sydney	0
4804	Tres Arroyos Airport	Tres Arroyos	Argentina	AR	OYO	SAZH	-60.25	-38.366667	America/Argentina/Buenos_Aires	0
4805	St. Georges de L/Oyapock Airport	Saint Georges de L/Oyapock	French Guiana	GF	OYP	SOOG	-51.8	3.9	America/Cayenne	0
4806	Ozona Airport	Ozona	United States	US	OZA	KOZA	-101.216667	30.716667	America/Chicago	0
4807	Labo Airport	Ozamiz	Philippines	PH	OZC	RPMO	123.845414	8.181967	Asia/Manila	0
4808	Zagora Airport	Zagora	Morocco	MA	OZG	GMAZ	-5.852456	30.267143	Africa/Casablanca	0
4809	Zaporozhye Airport	Zaporozhye	Ukraine	UA	OZH	UKDE	35.315833	47.8675	Europe/Kiev	0
4810	Moron Air Base	Moron	Spain and Canary Islands	ES	OZP	LEMO	-5.611906	37.169797	Europe/Madrid	0
4811	Cairns Army Air Field	Ozark	United States	US	OZR	KOZR	-85.710038	31.276799	America/Chicago	0
4812	Ouarzazate Airport	Ouarzazate	Morocco	MA	OZZ	GMMZ	-6.916667	30.916667	Africa/Casablanca	0
4813	Pa-an Airport	Hpa-an	Myanmar	MM	PAA	VYPA	97.678333	16.892778	Asia/Yangon	0
4814	Bilaspur Airport	Bilaspur	India	IN	PAB	VEBU	76.833333	31.316667	Asia/Kolkata	0
4815	Marcos A. Gelabert International Airport	Panama City	Panama	PA	PAC	MPMG	-79.555613	8.971004	America/Panama	0
4816	Paderborn Lippstadt Airport	Paderborn	Germany	DE	PAD	EDLP	8.619832	51.610332	Europe/Berlin	0
4817	Snohomish County Airport	Everett	United States	US	PAE	KPAE	-122.285618	47.909744	America/Los_Angeles	0
4818	Pakuba Airport	Pakuba	Uganda	UG	PAF	HUPA	31.554146	2.203072	Africa/Kampala	0
4819	Pagadian Airport	Pagadian	Philippines	PH	PAG	RPMP	123.4575	7.826667	Asia/Manila	0
4820	Barkley Regional Airport	Paducah	United States	US	PAH	KPAH	-88.7725	37.061111	America/Chicago	0
4821	Para Chinar Airport	Para Chinar	Pakistan	PK	PAJ	OPPC	70.1	33.9	Asia/Karachi	0
4822	Ugnu-Kuparuk Airport	Ugnu Kuparuk	United States	US	UUK	PAKU	-149.597556	70.330819	America/Anchorage	0
4823	Palanquero Airport	Palanquero	Colombia	CO	PAL	SKPQ	-74.6574	5.48361	America/Bogota	0
4824	Tyndall Air Force Base	Panama City	United States	US	PAM	KPAM	-85.575637	30.066928	America/Chicago	0
4825	Pattani Airport	Pattani	Thailand	TH	PAN	VTSK	101.158333	6.777222	Asia/Bangkok	0
4826	Palo Alto Airport of Santa Clara County	Palo Alto	United States	US	PAO	KPAO	-122.115247	37.460661	America/Los_Angeles	0
4827	Toussaint Louverture International Airport	Port-au-Prince	Haiti	HT	PAP	MTPP	-72.294712	18.575394	America/Port-au-Prince	0
4828	Palmer Municipal Airport	Palmer	United States	US	PAQ	PAAQ	-149.087667	61.601497	America/Anchorage	0
4829	Paris Metropolitan	Paris	France	FR	PAR	LFPW	2.331938	48.833333	Europe/Paris	0
4830	Paros Airport	Paros	Greece	GR	PAS	LGPA	25.1153	37.0225	Europe/Athens	0
4831	Jay Prakash Narayan International Airport	Patna	India	IN	PAT	VEPT	85.090669	25.594891	Asia/Kolkata	0
4832	Pauk Airport	Pauk	Myanmar	MM	PAU	VYPK	94.516667	21.45	Asia/Yangon	0
4833	Paulo Afonso Airport	Paulo Afonso	Brazil	BR	PAV	SBUF	-38.249916	-9.40077	America/Belem	0
4834	Port De Paix Airport	Port De Paix	Haiti	HT	PAX	MTPX	-72.841667	19.933333	America/Port-au-Prince	0
4835	Pamol Airport	Pamol	Malaysia	MY	PAY	WBKP	117.394444	5.993056	Asia/Kuala_Lumpur	0
4836	El Tajin National Airport	Poza Rica	Mexico	MX	PAZ	MMPA	-97.460548	20.600162	America/Mexico_City	0
4837	Paranaiba Airport	Paranaiba	Brazil	BR	PBB	SSPN	-51.202139	-19.649901	America/Campo_Grande	0
4838	Huejotsingo Airport	Puebla	Mexico	MX	PBC	MMPB	-98.3675	19.135	America/Mexico_City	0
4839	Porbandar Airport	Porbandar	India	IN	PBD	VAPR	69.656944	21.647222	Asia/Kolkata	0
4840	Puerto Berrio Airport	Puerto Berrio	Colombia	CO	PBE	SKPR	-74.483333	6.483333	America/Bogota	0
4841	Grider Field	Pine Bluff	United States	US	PBF	KPBF	-91.935556	34.175556	America/Chicago	0
4842	Plattsburgh International Airport	Plattsburgh	United States	US	PBG	KPBG	-73.465092	44.658745	America/New_York	0
4843	Paro Airport	Paro	Bhutan	BT	PBH	VQPR	89.416667	27.433333	Asia/Thimphu	0
4844	Palm Beach International Airport	West Palm Beach	United States	US	PBI	KPBI	-80.095589	26.683164	America/New_York	0
4845	Paama Airport	Paama	Vanuatu	VU	PBJ	NVSI	168.216667	-16.433333	Pacific/Efate	0
4846	General Bartolome Salom International Airport	Puerto Cabello	Venezuela	VE	PBL	SVPC	-68.073611	10.479167	America/Caracas	0
4847	Zanderij International Airport	Paramaribo	Suriname	SR	PBM	SMJP	-55.191111	5.451389	America/Paramaribo	0
4848	Porto Amboim Airport	Porto Amboim	Angola	AO	PBN	FNPA	13.75	-10.7	Africa/Luanda	0
4849	Paraburdoo Airport	Paraburdoo	Australia	AU	PBO	YPBO	117.748002	-23.173908	Australia/Perth	0
4850	Punta Islita Airport	Punta Islita	Costa Rica	CR	PBP	MRIA	-85.369083	9.859188	America/Costa_Rica	0
4851	Pimenta Bueno Airport	Pimenta Bueno	Brazil	BR	PBQ	SWPM	-61.2	-11.7	America/Porto_Velho	0
4852	Puerto Barrios Airport	Puerto Barrios	Guatemala	GT	PBR	MGPB	-88.583744	15.730871	America/Guatemala	0
4853	Putao Airport	Putao	Myanmar	MM	PBU	VYPT	97.416667	27.333333	Asia/Yangon	0
4854	Porto Dos Gauchos Airport	Porto Dos Gauchos	Brazil	BR	PBV	SWPG	-57.365343	-11.541461	America/Campo_Grande	0
4855	Hamilton/Prosperine Airport	Long Island/Palm Bay	Australia	AU	PBY	YPBY	148.850443	-20.344303	Australia/Brisbane	0
4856	Plettenberg Bay Airport	Plettenberg Bay	South Africa	ZA	PBZ	FAPG	23.328589	-34.088225	Africa/Johannesburg	0
4857	Portage Creek Airport	Portage Creek	United States	US	PCA	PAOC	-157.701944	58.901389	America/Anchorage	0
4858	Pondok Cabe Airport	Pondok Cabe	Indonesia	ID	PCB	WIHP	106.766667	-6.35	Asia/Jakarta	0
4859	Puerto Rico Airport	Puerto Rico	Colombia	CO	PCC	SKQW	-75.15	1.9	America/Bogota	0
4860	Prairie Du Chien Municipal Airport	Prairie Du Chien	United States	US	PCD	KPDC	-91.116667	43.016667	America/Chicago	0
4861	Capitan Rolden Airport	Pucallpa	Peru	PE	PCL	SPCL	-74.574745	-8.384505	America/Lima	0
4862	Picton Aerodrome	Picton	New Zealand	NZ	PCN	NZPN	173.959595	-41.342834	Pacific/Auckland	0
4863	Principe Airport	Principe	Sao Tome and Principe	ST	PCP	FPPR	7.412398	1.665093	Africa/Sao_Tome	0
4864	Puerto Carreno Airport	Puerto Carreno	Colombia	CO	PCR	SKPC	-67.633333	6.183333	America/Bogota	0
4865	Picos Airport	Picos	Brazil	BR	PCS	SNPC	-41.466667	-7.083333	America/Belem	0
4866	Pearl River County Airport	Picayune	United States	US	PCU	KPCU	-89.683333	30.433333	America/Chicago	0
4867	Puerto Inirida Airport	Puerto Inirida	Colombia	CO	PDA	SKPD	-67.883333	3.883333	America/Bogota	0
4868	Ponta De Ouro	Ponta De Ouro	Mozambique	MZ	PDD	FQPO	32.880556	-26.783056	Africa/Maputo	0
4869	Pandie Pandie Airport	Pandie Pandie	Australia	AU	PDE	YPDI	138.666667	-26	Australia/Adelaide	0
4870	Prado Airport	Prado	Brazil	BR	PDF	SNRD	-39.216667	-17.35	America/Belem	0
4871	Minangkabau International Airport	Padang	Indonesia	ID	PDG	WIEE	100.280556	-0.786667	Asia/Jakarta	0
4872	Peachtree Dekalb Airport	Atlanta	United States	US	PDK	KPDK	-84.301944	33.875556	America/New_York	0
4873	Joao Paulo II Airport	Ponta Delgada (Azores)	Portugal	PT	PDL	LPPD	-25.696469	37.743847	Atlantic/Azores	0
4874	Capt.  Justiniano Montenegro Airport	Pedasi	Panama	PA	PDM	MPPD	-80.02129	7.553333	America/Panama	0
4875	Parndana Airport	Parndana	Australia	AU	PDN	YPDA	138.083333	-35.916667	Australia/Adelaide	0
4876	Capitan de Corbeta Carlos A. Curbelo International Airport	Punta Del Este	Uruguay	UY	PDP	SULS	-55.093164	-34.857213	America/Montevideo	0
4877	Piedras Negras International Airport	Piedras Negras	Mexico	MX	PDS	MMPG	-100.53604	28.628948	America/Matamoros	0
4878	Eastern Oregon Regional Airport	Pendleton	United States	US	PDT	KPDT	-118.843229	45.693009	America/Los_Angeles	0
4879	Paysandu Airport	Paysandu	Uruguay	UY	PDU	SUPU	-58.064167	-32.365833	America/Montevideo	0
4880	Plovdiv Airport	Plovdiv	Bulgaria	BG	PDV	LBPD	24.8508	42.067799	Europe/Sofia	0
4881	Portland International Airport	Portland	United States	US	PDX	KPDX	-122.592901	45.588995	America/Los_Angeles	0
4882	Pedernales Airport	Pedernales	Venezuela	VE	PDZ	SVPE	-62.233333	9.966667	America/Caracas	0
4883	Pardubice Airport	Pardubice	Czech Republic	CZ	PED	LKPD	15.738611	50.013333	Europe/Prague	0
4884	Perm International Airport	Perm	Russian Federation	RU	PEE	USPP	56.019179	57.920026	Asia/Yekaterinburg	0
4885	Peenemuende Airport	Peenemuende	Germany	DE	PEF	EDCP	13.766667	54.166667	Europe/Berlin	0
4886	Sant Egidio Airport	Perugia	Italy	IT	PEG	LIRZ	12.51386	43.097819	Europe/Rome	0
4887	Pehuajo Airport	Pehuajo	Argentina	AR	PEH	SAZP	-61.866667	-35.85	America/Argentina/Buenos_Aires	0
4888	Matecana International Airport	Pereira	Colombia	CO	PEI	SKPE	-75.736531	4.815945	America/Bogota	0
4889	Beijing Capital International Airport	Beijing	China	CN	PEK	ZBAA	116.587095	40.078538	Asia/Shanghai	0
4890	Pelaneng Airport	Pelaneng	Lesotho	LS	PEL	FXPG	27.916667	-30.55	Africa/Maseru	0
4891	Puerto Maldonado Airport	Puerto Maldonado	Peru	PE	PEM	SPTU	-69.233333	-12.583333	America/Lima	0
4892	Penang International Airport	Penang	Malaysia	MY	PEN	WMKP	100.265173	5.292961	Asia/Kuala_Lumpur	0
4893	Peppimenarti Airport	Peppimenarti	Australia	AU	PEP	YPEP	130.1	-14.15	Australia/Darwin	0
4894	Pecos Municipal Airport	Pecos City	United States	US	PEQ	KPEQ	-103.511002	31.382401	America/Chicago	0
4895	Perth Airport	Perth	Australia	AU	PER	YPPH	115.960236	-31.933604	Australia/Perth	0
4896	Petrozavodsk Airport	Petrozavodsk	Russian Federation	RU	PES	ULPB	34.153871	61.878284	Europe/Moscow	0
4897	Federal Airport	Pelotas	Brazil	BR	PET	SBPK	-52.324444	-31.718056	America/Sao_Paulo	0
4898	Puerto Lempira Airport	Puerto Lempira	Honduras	HN	PEU	MHPL	-83.781197	15.2622	America/Tegucigalpa	0
4899	Pecs-Pogany Airport	Pecs-Pogany	Hungary	HU	PEV	LHPP	18.240996	45.990898	Europe/Budapest	0
4900	Bacha Khan International Airport	Peshawar	Pakistan	PK	PEW	OPPS	71.519252	33.989083	Asia/Karachi	0
4901	Pechora Airport	Pechora	Russian Federation	RU	PEX	UUYP	57.133333	65.116667	Europe/Moscow	0
4902	Penong Airport	Penong	Australia	AU	PEY	YPNG	133.016667	-31.916667	Australia/Adelaide	0
4903	Penza Airport	Penza	Russian Federation	RU	PEZ	UWPP	45.023048	53.118517	Europe/Moscow	0
4904	Passo Fundo Airport	Passo Fundo	Brazil	BR	PFB	SBPF	-52.333333	-28.25	America/Sao_Paulo	0
4905	Pacific City State Airport	Pacific City	United States	US	PFC	KPFC	-123.962047	45.199796	America/Los_Angeles	0
4906	Patrekstjord Airport	Patrekstjord	Iceland	IS	PFJ	BIPA	-19.008333	65.033333	Atlantic/Reykjavik	0
4907	Paphos International Airport	Paphos	Cyprus	CY	PFO	LCPH	32.489104	34.711552	Asia/Nicosia	0
4908	Parsabad Moghan Airport	Parsabad	Iran	IR	PFQ	OITP	47.877521	39.606892	Asia/Tehran	0
4909	Ilebo Airport	Ilebo	The Democratic Republic of The Congo	CD	PFR	FZVS	20.583333	-4.316667	Africa/Lubumbashi	0
4910	Page Airport	Page	United States	US	PGA	KPGA	-111.447222	36.926389	America/Phoenix	0
4911	Charlotte County Airport	Punta Gorda	United States	US	PGD	KPGD	-81.991389	26.919167	America/New_York	0
4912	Llabanere Airport	Perpignan	France	FR	PGF	LFMP	2.868183	42.741018	Europe/Paris	0
4913	Pantnagar Airport	Pantnagar	India	IN	PGH	VIPT	79.473611	29.031944	Asia/Kolkata	0
4914	Depati Amir Airport	Pangkal Pinang	Indonesia	ID	PGK	WIKK	106.137071	-2.164017	Asia/Jakarta	0
4915	Porto Alegre Airport	Porto Alegre	Sao Tome and Principe	ST	PGP	FPPA	6.533333	0.033333	Africa/Sao_Tome	0
4916	Buli Airport	Buil	Indonesia	ID	PGQ	WAEM	128.3825	0.918889	Asia/Makassar	0
4917	Kirk Field	Paragould	United States	US	PGR	KPGR	-90.507802	36.062905	America/Chicago	0
4918	Ala'Marvdasht Airport	Ala'Marvdasht	Iran	IR	PGU	OIBP	52.735514	27.383959	Asia/Tehran	0
4919	Pitt-Greenville Airport	Greenville	United States	US	PGV	KPGV	-77.385278	35.633333	America/New_York	0
4920	Perigueux Airport	Perigueux	France	FR	PGX	LFBX	0.716667	45.183333	Europe/Paris	0
4921	Comte Antonio Amilton Beraldo Airport	Ponta Grossa	Brazil	BR	PGZ	SBPG	-50.145818	-25.185669	America/Sao_Paulo	0
4922	Phan Rang Airport	Phan Rang	Viet Nam	VN	PHA	VVPR	108.95	11.633333	Asia/Ho_Chi_Minh	0
4923	Parnaiba-Prefeito Dr. Joao Silva Filho International Airport	Parnaiba	Brazil	BR	PHB	SBPB	-41.730505	-2.894273	America/Belem	0
4924	Port Harcourt International Airport	Port Harcourt	Nigeria	NG	PHC	DNPO	6.9499	5.006506	Africa/Lagos	0
4925	Harry Clever Field	New Philadelphia	United States	US	PHD	KPHD	-81.419694	40.470892	America/New_York	0
4926	Port Hedland International Airport	Port Hedland	Australia	AU	PHE	YPPD	118.63164	-20.377945	Australia/Perth	0
4927	Newport News/Williamsburg International Airport	Newport News	United States	US	PHF	KPHF	-76.502825	37.130328	America/New_York	0
4928	Pinheiro Airport	Pinheiro	Brazil	BR	PHI	SNYE	-45.083333	-2.516667	America/Belem	0
4929	Newcastle Harbour Heliport	Port Hunter	Australia	AU	PHJ	YNRH	151.766667	-32.916667	Australia/Sydney	0
4930	Palm Beach County Glades Airport	Pahokee	United States	US	PHK	KPHK	-80.693294	26.785189	America/New_York	0
4931	Philadelphia International Airport	Philadelphia	United States	US	PHL	KPHL	-75.243305	39.876413	America/New_York	0
4932	St Clair County International Airport	Port Huron	United States	US	PHN	KPHN	-82.526111	42.913056	America/New_York	0
4933	Kaneohe Bay Marine Corps Air Station	Mokapu	United States	US	NGF	PHNG	-157.769446	21.449229	Pacific/Honolulu	0
4934	Point Hope Airport	Point Hope	United States	US	PHO	PAPO	-166.8	68.35	America/Anchorage	0
4935	Phillip Airport	Philip	United States	US	PHP	KPHP	-101.666667	44.333333	America/Chicago	0
4936	The Monument Airport	Phosphate Hill	Australia	AU	PHQ	YTMO	139.923333	-21.811667	Australia/Brisbane	0
4937	Phitsanulok Airport	Phitsanulok	Thailand	TH	PHS	VTPP	100.281196	16.771307	Asia/Bangkok	0
4938	Henry County Airport	Paris	United States	US	PHT	KPHT	-88.383333	36.333611	America/Chicago	0
4939	Phalaborwa Airport	Phalaborwa	South Africa	ZA	PHW	FAPH	31.156111	-23.933611	Africa/Johannesburg	0
4940	Phoenix Sky Harbor International Airport	Phoenix	United States	US	PHX	KPHX	-112.000164	33.435036	America/Phoenix	0
4941	Phetchabun Airport	Phetchabun	Thailand	TH	PHY	VTPB	101.195104	16.675982	Asia/Bangkok	0
4942	Peoria International Airport	Peoria	United States	US	PIA	KPIA	-89.690117	40.666432	America/Chicago	0
4943	Hattiesburg-Laurel Regional Airport	Laurel	United States	US	PIB	KPIB	-89.336667	31.4675	America/Chicago	0
4944	Pine Cay Airport	Pine Cay	Turks and Caicos Islands	TC	PIC	MBPI	-72.1	21.883333	America/Grand_Turk	0
4945	Paradise Island Airport	Nassau	Bahamas	BS	PID	MYPI	-77.3	25.083333	America/Nassau	0
4946	St. Petersburg-Clearwater International Airport	Saint Petersburg	United States	US	PIE	KPIE	-82.695109	27.912005	America/New_York	0
4947	Pingtung Airport	Pingtung	Taiwan	TW	PIF	RCDC	120.490232	22.705003	Asia/Taipei	0
4948	Pocatello Regional Airport	Pocatello	United States	US	PIH	KPIH	-112.585879	42.909777	America/Denver	0
4949	Glasgow Prestwick Airport	Glasgow	United Kingdom	GB	PIK	EGPK	-4.611286	55.508432	Europe/London	0
4950	Pilar Airport	Pilar	Paraguay	PY	PIL	SGPI	-58.333333	-26.866667	America/Asuncion	0
4951	Garden Harris County Airport	Pine Mountain	United States	US	PIM	KPIM	-84.833333	32.866667	America/New_York	0
4952	Julio Belem Airport	Parintins	Brazil	BR	PIN	SWPI	-56.777151	-2.673015	America/Porto_Velho	0
4953	Capitan FAP Renan Elias Olivera Airport	Pisco	Peru	PE	PIO	SPSO	-76.217276	-13.736786	America/Lima	0
4954	Pilot Point Airport	Pilot Point	United States	US	PIP	PAPN	-157.571956	57.580381	America/Anchorage	0
4955	Pierre Regional Airport	Pierre	United States	US	PIR	KPIR	-100.293192	44.380362	America/Chicago	0
4956	Poitiers-Biard Airport	Poitiers	France	FR	PIS	LFBI	0.306389	46.586111	Europe/Paris	0
4957	Pittsburgh International Airport	Pittsburgh	United States	US	PIT	KPIT	-80.25657	40.49585	America/New_York	0
4958	Cap. FAP Guillermo Concha Iberico International Airport	Piura	Peru	PE	PIU	SPUR	-80.615623	-5.202246	America/Lima	0
4959	Pirapora Airport	Pirapora	Brazil	BR	PIV	SNRA	-44.932222	-17.338611	America/Sao_Paulo	0
4960	Pikwitonei Airport	Pikwitonei	Canada	CA	PIW	CZMN	-97.333333	55.7	America/Winnipeg	0
4961	Pico Island Airport	Pico Island (Azores)	Portugal	PT	PIX	LPPI	-28.441299	38.554298	Atlantic/Azores	0
4962	Dew Station Airport	Point Lay	United States	US	PIZ	PPIZ	-163.166667	69.75	America/Anchorage	0
4963	Pajala Airport	Pajala	Sweden	SE	PJA	ESUP	23.068743	67.245704	Europe/Stockholm	0
4964	Payson Airport	Payson	United States	US	PJB	KPAN	-111.339588	34.256544	America/Phoenix	0
4965	Pedro Juan Caballero Airport	Pedro Juan Caballero	Paraguay	PY	PJC	SGPJ	-55.666667	-22.5	America/Asuncion	0
4966	Panjgur Airport	Panjgur	Pakistan	PK	PJG	OPPG	64.1	26.966667	Asia/Karachi	0
4967	Puerto Jimenez Airport	Puerto Jimenez	Costa Rica	CR	PJM	MRPJ	-83.301079	8.535467	America/Costa_Rica	0
4968	Napaskiak Sea Plane Base	Napaskiak	United States	US	PKA	PAPK	-161.778306	60.702917	America/Anchorage	0
4969	Wood County Airport	Parkersburg	United States	US	PKB	KPKB	-81.438889	39.345556	America/New_York	0
4970	Petropavlovsk-Kamchatsky Airport	Petropavlovsk-Kamchatsky	Russian Federation	RU	PKC	UHPP	158.446571	53.175041	Asia/Kamchatka	0
4971	Park Rapids Municipal Airport-Konshok Field	Park Rapids	United States	US	PKD	KPKD	-95.071667	46.898333	America/Chicago	0
4972	Parkes Airport	Parkes	Australia	AU	PKE	YPKS	148.2329	-33.138455	Australia/Sydney	0
4973	Park Falls Airport	Park Falls	United States	US	PKF	KPKF	-90.533333	45.933333	America/Chicago	0
4974	Pangkor Airport	Pangkor Island	Malaysia	MY	PKG	WMPA	100.554002	4.245778	Asia/Kuala_Lumpur	0
4975	Playa Grande Airport	Playa Grande	Guatemala	GT	PKJ	MGPG	-90.761944	15.6425	America/Guatemala	0
4976	Pakokku Airport	Pakokku	Myanmar	MM	PKK	VYPU	95.11033	21.404321	Asia/Yangon	0
4977	Port Kaituma Airport	Port Kaituma	Guyana	GY	PKM	SYPK	-59.883333	7.733333	America/Guyana	0
4978	Iskandar Airport	Pangkalanbun	Indonesia	ID	PKN	WAGI	111.669942	-2.703815	Asia/Jakarta	0
4979	Parakou Airport	Parakou	Benin	BJ	PKO	DBBP	2.616667	9.35	Africa/Porto-Novo	0
4980	Puka Puka Airport	Puka Puka	French Polynesia	PF	PKP	NTGP	-138.966667	-14.75	Pacific/Tahiti	0
4981	Pokhara Airport	Pokhara	Nepal	NP	PKR	VNPK	83.977761	28.198646	Asia/Kathmandu	0
4982	Port Keats Airport	Port Keats	Australia	AU	PKT	YPKT	129.533333	-14.25	Australia/Darwin	0
4983	Sultan Syarif Kasim II International Airport	Pekanbaru	Indonesia	ID	PKU	WIBB	101.446883	0.464563	Asia/Jakarta	0
4984	Pskov Airport	Pskov	Russian Federation	RU	PKV	ULOO	28.397663	57.790968	Europe/Moscow	0
4985	Selebi-Phikwe Airport	Selebi-Phikwe	Botswana	BW	PKW	FBSP	27.816667	-22.05	Africa/Gaborone	0
4986	Beijing Daxing International Airport	Beijing	China	CN	PKX	ZBAD	116.410833	39.508611	Asia/Shanghai	0
4987	Tjilik Riwut Airport	Palangkaraya	Indonesia	ID	PKY	WAGG	113.945782	-2.223958	Asia/Jakarta	0
4988	Pakse Airport	Pakse	Lao People's Democratic Republic	LA	PKZ	VLPS	105.781295	15.136257	Asia/Vientiane	0
4989	Planadas Airport	Planadas	Colombia	CO	PLA	SQPX	-75.7	3.3	America/Bogota	0
4990	Clinton County Airport	Plattsburgh	United States	US	PLB	KPLB	-73.521111	44.688333	America/New_York	0
4991	Playa Samara Airport	Playa Samara	Costa Rica	CR	PLD	MRCR	-85.480309	9.870578	America/Costa_Rica	0
4992	Pala Airport	Pala	Chad	TD	PLF	FTTP	14.933333	9.383333	Africa/Ndjamena	0
4993	Plymouth Airport	Plymouth	United Kingdom	GB	PLH	EGDB	-4.110009	50.422338	Europe/London	0
4994	M Graham Clark Airport	Branson/Point Lookout	United States	US	PLK	KPLK	-93.216667	36.65	America/Chicago	0
4995	Ponta Pelada Airport	Ponta Pelada	Brazil	BR	PLL	SBMN	-59.984444	-3.145556	America/Porto_Velho	0
4996	Sultan Mahmud Badaruddin II Airport	Palembang	Indonesia	ID	PLM	WIPP	104.698607	-2.900146	Asia/Jakarta	0
4997	Emmet County Airport	Pellston	United States	US	PLN	KPLN	-84.792778	45.570833	America/New_York	0
4998	Port Lincoln Airport	Port Lincoln	Australia	AU	PLO	YPLC	135.87454	-34.603331	Australia/Adelaide	0
4999	La Palma Airport	La Palma	Panama	PA	PLP	MPLP	-78.133333	8.333333	America/Panama	0
5000	Palanga International Airport	Palanga	Lithuania	LT	PLQ	EYPA	21.083333	55.95	Europe/Vilnius	0
5001	St. Clair County Airport	Pell City	United States	US	PLR	KPLR	-86.283333	33.583333	America/Chicago	0
5002	Providenciales International Airport	Providenciales	Turks and Caicos Islands	TC	PLS	MBPV	-72.262635	21.775328	America/Grand_Turk	0
5003	Pampulha Airport	Belo Horizonte	Brazil	BR	PLU	SBBH	-43.950613	-19.851199	America/Sao_Paulo	0
5004	Poltava Airport	Poltava	Ukraine	UA	PLV	UKHP	34.533333	49.583333	Europe/Kiev	0
5005	Mutiara Airport	Palu	Indonesia	ID	PLW	WAFF	119.909729	-0.918617	Asia/Makassar	0
5006	Semipalatinsk Airport	Semipalatinsk	Kazakhstan	KZ	PLX	UASS	80.233789	50.351741	Asia/Almaty	0
5007	Port Elizabeth International Airport	Port Elizabeth	South Africa	ZA	PLZ	FAPE	25.611421	-33.98371	Africa/Johannesburg	0
5008	Wawi Airport	Pemba	United Republic of Tanzania	TZ	PMA	HTPE	39.812617	-5.258731	Africa/Dar_es_Salaam	0
5009	Pembina Intermediate Airport	Pembina	United States	US	PMB	KPMB	-98.083333	49	America/Chicago	0
5010	El Tepual Airport	Puerto Montt	Chile	CL	PMC	SCTE	-73.098312	-41.433726	America/Santiago	0
5011	Palmdale Air Force 42 Base	Palmdale	United States	US	PMD	KPMD	-118.083333	34.6275	America/Los_Angeles	0
5012	Fleetlands Heliport	Portsmouth	United Kingdom	GB	PME	EGVF	-1.16917	50.8353	Europe/London	0
5013	Parma Airport	Parma	Italy	IT	PMF	LIMP	10.295278	44.822222	Europe/Rome	0
5014	Ponta Pora International Airport	Ponta Pora	Brazil	BR	PMG	SBPP	-55.7	-22.55	America/Campo_Grande	0
5015	Portsmouth Regional Airport	Portsmouth	United States	US	PMH	KPMH	-82.983333	38.75	America/New_York	0
5016	Palma de Mallorca Airport	Palma de Mallorca	Spain and Canary Islands	ES	PMI	LEPA	2.730388	39.547654	Europe/Madrid	0
5017	Palm Island Airport	Palm Island	Australia	AU	PMK	YPAM	146.580994	-18.755301	Australia/Brisbane	0
5018	Falcone-Borsellino Airport	Palermo	Italy	IT	PMO	LICJ	13.104779	38.186525	Europe/Rome	0
5019	Perito Moreno Airport	Perito Moreno	Argentina	AR	PMQ	SAWP	-70.983611	-46.536389	America/Argentina/Buenos_Aires	0
5020	Palmerston North Airport	Palmerston North	New Zealand	NZ	PMR	NZPM	175.621268	-40.323534	Pacific/Auckland	0
5021	Palmyra Airport	Palmyra	Syrian Arab Republic	SY	PMS	OSPR	38.25	34.6	Asia/Damascus	0
5022	Paramakotoi Airport	Paramakotoi	Guyana	GY	PMT	SYPM	-57.183333	7.566667	America/Guyana	0
5023	Santiago Marino International Airport	Porlamar	Venezuela	VE	PMV	SVMG	-63.968992	10.917189	America/Caracas	0
5024	Palmas-Brigadeiro Lysias Rodrigues Intl Airport	Palmas	Brazil	BR	PMW	SBPJ	-48.357668	-10.294687	America/Belem	0
5025	Palmer Metropolitan Airport	Palmer	United States	US	PMX	KPMX	-72.316667	42.15	America/New_York	0
5026	El Tehuelche Airport	Puerto Madryn	Argentina	AR	PMY	SAVY	-65.066667	-42.733333	America/Argentina/Buenos_Aires	0
5027	Palmur'Sur Airport	Palmar	Costa Rica	CR	PMZ	MRPM	-83.468583	8.951035	America/Costa_Rica	0
5028	Pamplona Airport	Pamplona	Spain and Canary Islands	ES	PNA	LEPP	-1.639347	42.767497	Europe/Madrid	0
5029	Porto Nacional Airport	Porto Nacional	Brazil	BR	PNB	SBPN	-48.416667	-10.7	America/Belem	0
5030	Ponca City Regional Airport	Ponca City	United States	US	PNC	KPNC	-97.099444	36.728056	America/Chicago	0
5031	Northeast Philadelphia Airport	Philadelphia	United States	US	PNE	KPNE	-75.0125	40.080278	America/New_York	0
5032	Paranagua Municipal Airport	Paranagua	Brazil	BR	PNG	SSPG	-48.5	-25.516667	America/Sao_Paulo	0
5033	Phnom Penh International Airport	Phnom Penh	Cambodia	KH	PNH	VDPP	104.846174	11.552193	Asia/Phnom_Penh	0
5034	Pohnpei Airport	Pohnpei, Caroline Islands	Micronesia	FM	PNI	PTPN	158.203343	6.980947	Pacific/Pohnpei	0
5035	Supadio International Airport	Pontianak	Indonesia	ID	PNK	WIOO	109.405328	-0.14735	Asia/Jakarta	0
5036	Pantelleria Airport	Pantelleria	Italy	IT	PNL	LICG	11.966111	36.813611	Europe/Rome	0
5037	Princeton Airport	Princeton	United States	US	PNN	KPNN	-67.566667	45.233333	America/New_York	0
5038	Girua Airport	Popondetta	Papua New Guinea	PG	PNP	AYGR	148.308728	-8.807474	Pacific/Port_Moresby	0
5039	Pune Airport	Pune	India	IN	PNQ	VAPO	73.920556	18.581389	Asia/Kolkata	0
5040	Pointe Noire Airport	Pointe Noire	Congo	CG	PNR	FCPP	11.884085	-4.815822	Africa/Brazzaville	0
5041	Pensacola International Airport	Pensacola	United States	US	PNS	KPNS	-87.194157	30.475942	America/Chicago	0
5042	Teniente J. Gallardo Airport	Puerto Natales	Chile	CL	PNT	SCNT	-72.529105	-51.668664	America/Santiago	0
5043	Panevezys Airport	Panevezys	Lithuania	LT	PNV	EYPN	24.383333	55.733333	Europe/Vilnius	0
5044	Puducherry Airport	Puducherry	India	IN	PNY	VOPC	79.812846	11.968967	Asia/Kolkata	0
5045	Petrolina International Airport	Petrolina	Brazil	BR	PNZ	SBPL	-40.565845	-9.365738	America/Belem	0
5046	Salgado Filho International Airport	Porto Alegre	Brazil	BR	POA	SBPA	-51.177088	-29.989611	America/Sao_Paulo	0
5047	Pope Field	Fayetteville	United States	US	POB	KPOB	-79.014444	35.170833	America/New_York	0
5048	Brackett Field	La Verne	United States	US	POC	KPOC	-117.781998	34.091599	America/Los_Angeles	0
5049	Podor Airport	Podor	Senegal	SN	POD	GOSP	-14.966667	16.666667	Africa/Dakar	0
5050	Polk Army Air Field	Fort Polk	United States	US	POE	KPOE	-93.192222	31.045833	America/Chicago	0
5051	Earl Fields Memorial Airport	Poplar Bluff	United States	US	POF	KPOF	-90.313889	36.711111	America/Chicago	0
5052	Port Gentil Airport	Port Gentil	Gabon	GA	POG	FOOG	8.753584	-0.719964	Africa/Libreville	0
5053	Pocahontas Municipal Airport	Pocahontas	United States	US	POH	KPOH	-94.644167	42.742222	America/Chicago	0
5054	Captain Nicolas Rojas Airport	Potosi	Bolivia	BO	POI	SLPO	-65.723611	-19.543056	America/La_Paz	0
5055	Patos De Minas Airport	Patos De Minas	Brazil	BR	POJ	SNPD	-46.490833	-18.671667	America/Sao_Paulo	0
5056	Pemba Airport	Pemba	Mozambique	MZ	POL	FQPB	40.5225	-12.988333	Africa/Maputo	0
5057	Jacksons International Airport	Port Moresby	Papua New Guinea	PG	POM	AYPY	147.214469	-9.444308	Pacific/Port_Moresby	0
5058	Poptun Airport	Poptun	Guatemala	GT	PON	MGPP	-89.433333	16.35	America/Guatemala	0
5059	Pocos De Caldas Airport	Pocos De Caldas	Brazil	BR	POO	SBPC	-46.5675	-21.841389	America/Sao_Paulo	0
5060	La Union Airport	Puerto Plata	Dominican Republic	DO	POP	MDPP	-70.56315	19.754942	America/Santo_Domingo	0
5061	Pori Airport	Pori	Finland	FI	POR	EFPO	21.791381	61.46866	Europe/Helsinki	0
5062	Piarco International Airport	Port Of Spain	Trinidad and Tobago	TT	POS	TTPP	-61.339414	10.602089	America/Port_of_Spain	0
5063	Ken Jones Airport	Port Antonio	Jamaica	JM	POT	MKKJ	-76.535556	18.198333	America/Jamaica	0
5064	Dutchess County Airport	Poughkeepsie	United States	US	POU	KPOU	-73.882778	41.628056	America/New_York	0
5065	Presov Airport	Presov	Slovakia	SK	POV	LZPW	21.25	49	Europe/Bratislava	0
5066	Portoroz Airport	Portoroz	Slovenia	SI	POW	LJPZ	13.616055	45.474521	Europe/Ljubljana	0
5067	Pontoise - Cormeilles Aerodrome	Pontoise	France	FR	POX	LFPT	2.040864	49.096717	Europe/Paris	0
5068	Powell/Lovell Airport	Powell/Lovell	United States	US	POY	KPOY	-108.766667	44.75	America/Denver	0
5069	Poznan Airport	Poznan	Poland	PL	POZ	EPPO	16.828845	52.414327	Europe/Warsaw	0
5070	Perry Lefors Field	Pampa	United States	US	PPA	KPPA	-100.966667	35.533333	America/Chicago	0
5071	A. De Barros Airport	Presidente Prudente	Brazil	BR	PPB	SBDN	-51.424599	-22.1751	America/Sao_Paulo	0
5072	Prospect Creek Airport	Prospect Creek	United States	US	PPC	PAPR	-150.7	66.796667	America/Anchorage	0
5073	Puerto Penasco Airport	Puerto Penasco	Mexico	MX	PPE	MMPE	-113.519369	31.352573	America/Hermosillo	0
5074	Tri-City Airport	Parsons	United States	US	PPF	KPPF	-95.508611	37.332222	America/Chicago	0
5075	Pago Pago International Airport	Pago Pago	American Samoa	AS	PPG	NSTU	-170.696389	-14.326389	Pacific/Pago_Pago	0
5076	Port Pirie Airport	Port Pirie	Australia	AU	PPI	YPIR	138	-33.233333	Australia/Adelaide	0
5077	Pulau Panjang Airport	Pulau Panjang	Indonesia	ID	PPJ	WIHG	103.3	-0.633333	Asia/Jakarta	0
5078	Petropavlovsk Airport	Petropavlovsk	Kazakhstan	KZ	PPK	UACP	69.187045	54.775735	Asia/Almaty	0
5079	Phaplu Airport	Phaplu	Nepal	NP	PPL	VNPL	86.6	27.516667	Asia/Kathmandu	0
5080	Pompano Beach Airport	Pompano Beach	United States	US	PPM	KPMP	-80.116667	26.25	America/New_York	0
5081	Guillermo Leon Valencia Airport	Popayan	Colombia	CO	PPN	SKPP	-76.609592	2.453029	America/Bogota	0
5082	Whitsunday Coast Airport	Proserpine	Australia	AU	PPP	YBPN	148.551939	-20.488923	Australia/Brisbane	0
5083	Paraparaumu Airport	Paraparaumu	New Zealand	NZ	PPQ	NZPP	174.990903	-40.90575	Pacific/Auckland	0
5084	Pasir Pangarayan Airport	Pasir Pangarayan	Indonesia	ID	PPR	WIBG	100.367981	0.845755	Asia/Jakarta	0
5085	Puerto Princesa International Airport	Puerto Princesa	Philippines	PH	PPS	RPVP	118.756739	9.740198	Asia/Manila	0
5086	Tahiti Faa'a Airport	Papeete	French Polynesia	PF	PPT	NTAA	-149.609375	-17.559629	Pacific/Tahiti	0
5087	Papun Airport	Papun	Myanmar	MM	PPU	VYPP	97.45	18.066667	Asia/Yangon	0
5088	Papa Westray Airport	Papa Westray	United Kingdom	GB	PPW	EGEP	-2.899779	59.35145	Europe/London	0
5089	Pouso Alegre Airport	Pouso Alegre	Brazil	BR	PPY	SNZA	-45.918889	-22.288333	America/Sao_Paulo	0
5090	Phu Quoc International Airport	Phu Quoc	Viet Nam	VN	PQC	VVPQ	103.993104	10.169789	Asia/Ho_Chi_Minh	0
5091	Presque Isle Municipal Airport	Presque Isle	United States	US	PQI	KPQI	-68.0475	46.685	America/New_York	0
5092	Palenque International Airport	Palenque	Mexico	MX	PQM	MMPQ	-91.988926	17.534443	America/Mexico_City	0
5093	Port Macquarie Airport	Port Macquarie	Australia	AU	PQQ	YPMQ	152.867233	-31.431402	Australia/Sydney	0
5094	Qeqertaq Heliport	Qeqertaq	Greenland	GL	PQT	BGQE	-51.303705	69.999466	America/Godthab	0
5095	General Justo Jose de Urquiza Airport	Parana	Argentina	AR	PRA	SAAP	-60.480278	-31.794722	America/Argentina/Buenos_Aires	0
5096	Paso Robles Municipal Airport	Paso Robles	United States	US	PRB	KPRB	-120.625833	35.670556	America/Los_Angeles	0
5097	Prescott Regional Airport	Prescott	United States	US	PRC	KPRC	-112.424167	34.65	America/Phoenix	0
5098	Pardoo Airport	Pardoo	Australia	AU	PRD	YPDO	119.116667	-20.1	Australia/Perth	0
5099	Pore Airport	Pore	Colombia	CO	PRE	SKEK	-71.983333	5.7	America/Bogota	0
5100	Vaclav Havel Airport Prague	Prague	Czech Republic	CZ	PRG	LKPR	14.266638	50.106188	Europe/Prague	0
5101	Phrae Airport	Phrae	Thailand	TH	PRH	VTCP	100.164106	18.131593	Asia/Bangkok	0
5102	Praslin Island Airport	Praslin Island	Seychelles	SC	PRI	FSPP	55.692313	-4.323883	Indian/Mahe	0
5103	Prieska Airport	Prieska	South Africa	ZA	PRK	FAPK	22.7	-29.666667	Africa/Johannesburg	0
5104	Portimao Airport	Portimao	Portugal	PT	PRM	LPPM	-8.581365	37.147727	Europe/Lisbon	0
5105	Pristina International Airport	Pristina	Republic of Serbia	RS	PRN	LYPR	21.035556	42.573611	Europe/Belgrade	0
5106	Perry Municipal Airport	Perry	United States	US	PRO	KPRO	-94.1	41.85	America/Chicago	0
5107	Propriano Airport	Propriano	France	FR	PRP	LFKO	8.9	41.666667	Europe/Paris	0
5108	Pres. Roque Saenz Pena Airport	Pres. Roque Saenz Pena	Argentina	AR	PRQ	SARS	-60.666667	-26.833333	America/Argentina/Buenos_Aires	0
5109	Paruima Airport	Paruima	Guyana	GY	PRR	SYPR	-61.0564	5.8164	America/Guyana	0
5110	Parasi Airport	Parasi	Solomon Islands	SB	PRS	AGGP	161.425319	-9.641429	Pacific/Guadalcanal	0
5111	Prome Airport	Prome	Myanmar	MM	PRU	VYPY	95.268611	18.825	Asia/Yangon	0
5112	Prerov Airport	Prerov	Czech Republic	CZ	PRV	LKPO	17.404699	49.4258	Europe/Prague	0
5113	Cox Field	Paris	United States	US	PRX	KPRX	-95.450278	33.636667	America/Chicago	0
5114	Wonderboom Airport	Pretoria	South Africa	ZA	PRY	FAWB	28.220833	-25.654444	Africa/Johannesburg	0
5115	Pisa International Airport	Pisa	Italy	IT	PSA	LIRP	10.399915	43.698713	Europe/Rome	0
5116	Mid-State Airport	Philipsburg	United States	US	PSB	KPSB	-78.085833	40.883333	America/New_York	0
5117	Tri-Cities Airport	Pasco	United States	US	PSC	KPSC	-119.1152	46.259093	America/Los_Angeles	0
5118	Port Said Airport	Port Said	Egypt	EG	PSD	HEPS	32.3	31.266667	Africa/Cairo	0
5119	Mercedita Airport	Ponce	Puerto Rico	PR	PSE	TJPS	-66.563542	18.010702	America/Puerto_Rico	0
5120	Pittsfield Municipal Airport	Pittsfield	United States	US	PSF	KPSF	-73.291667	42.426667	America/New_York	0
5121	Petersburg Municipal Airport	Petersburg	United States	US	PSG	PAPG	-132.9425	56.804167	America/Anchorage	0
5122	St. Peter Airport	Saint Peter-Ording	Germany	DE	PSH	EDXO	8.116667	54.5	Europe/Berlin	0
5123	Pasni Airport	Pasni	Pakistan	PK	PSI	OPPI	63.361111	25.3	Asia/Karachi	0
5124	Kasiguncu Airport	Poso	Indonesia	ID	PSJ	WAFP	120.657577	-1.416767	Asia/Makassar	0
5125	New River Valley Airport	Dublin	United States	US	PSK	KPSK	-80.678611	37.137222	America/New_York	0
5126	Perth International Airport	Perth	United Kingdom	GB	PSL	EGPT	-3.37222	56.439201	Europe/London	0
5127	Pease Air Force Base	Portsmouth	United States	US	PSM	KPSM	-70.823303	43.0779	America/New_York	0
5128	Palestine Municipal Airport	Palestine	United States	US	PSN	KPSN	-95.706372	31.776972	America/Chicago	0
5129	Cano Airport	Pasto	Colombia	CO	PSO	SKPS	-77.25	1.466667	America/Bogota	0
5130	Palm Springs International Airport	Palm Springs	United States	US	PSP	KPSP	-116.508444	33.822976	America/Los_Angeles	0
5131	Abruzzo Airport	Pescara	Italy	IT	PSR	LIBP	14.187222	42.437222	Europe/Rome	0
5132	Posadas Airport	Posadas	Argentina	AR	PSS	SARP	-55.9675	-27.383889	America/Argentina/Buenos_Aires	0
5133	Pangsuma Airport	Putussibau	Indonesia	ID	PSU	WIOP	112.937507	0.835433	Asia/Jakarta	0
5134	Passos Airport	Passos	Brazil	BR	PSW	SNOS	-46.616667	-20.716667	America/Sao_Paulo	0
5135	Palacios Airport	Palacios	United States	US	PSX	KPSX	-96.25	28.7	America/Chicago	0
5136	Port Stanley Airport	Port Stanley	Falkland Islands	FK	PSY	SFAL	-57.85	-51.7	Atlantic/Stanley	0
5137	Puerto Suarez Airport	Puerto Suarez	Bolivia	BO	PSZ	SLPS	-57.823839	-18.980472	America/La_Paz	0
5138	Dinwiddie County Airport	Petersburg	United States	US	PTB	KPTB	-77.50569	37.183941	America/New_York	0
5139	Malolo Lailai Island Airport	Malololailai	Fiji	FJ	PTF	NFFO	177.196717	-17.778008	Pacific/Fiji	0
5140	Polokwane Airport	Polokwane	South Africa	ZA	PTG	FAPI	29.966667	-23.916667	Africa/Johannesburg	0
5141	Port Heiden Airport	Port Heiden	United States	US	PTH	PAPH	-158.6375	56.956667	America/Anchorage	0
5142	Port Douglas Airport	Port Douglas	Australia	AU	PTI	YPTD	145.458238	-16.501883	Australia/Brisbane	0
5143	Portland Airport	Portland	Australia	AU	PTJ	YPOD	141.470332	-38.319141	Australia/Sydney	0
5144	Oakland County International Airport	Pontiac	United States	US	PTK	KPTK	-83.420035	42.665101	America/New_York	0
5145	Palmarito Airport	Palmarito	Venezuela	VE	PTM	SVPT	-70.183333	7.566667	America/Caracas	0
5146	Patterson Municipal Heliport	Patterson	United States	US	PTN	KPTN	-91.3375	29.708333	America/Chicago	0
5147	Juvenal Loureiro Cardoso Airport	Pato Branco	Brazil	BR	PTO	SBPO	-52.694463	-26.217184	America/Sao_Paulo	0
5148	Pointe-a-Pitre Le Raizet Airport	Pointe-a-Pitre	Guadeloupe	GP	PTP	TFFR	-61.531803	16.265297	America/Guadeloupe	0
5149	Porto de Moz Airport	Porto de Moz	Brazil	BR	PTQ	SBMZ	-52.244444	-1.738889	America/Belem	0
5150	Pittsburg Municipal Airport	Pittsburg	United States	US	PTS	KPTS	-94.730556	37.446667	America/Chicago	0
5151	Pratt Airport	Pratt	United States	US	PTT	KPTT	-98.75	37.716667	America/Chicago	0
5152	Platinum Airport	Platinum	United States	US	PTU	PAPM	-161.816944	59.011389	America/Anchorage	0
5153	Porterville Airport	Porterville	United States	US	PTV	KPTV	-119.016667	36.066667	America/Los_Angeles	0
5154	Heritage Field	Pottstown	United States	US	PTW	KPTW	-75.669518	40.260373	America/New_York	0
5155	Pitalito Airport	Pitalito	Colombia	CO	PTX	SKPI	-76.089636	1.856385	America/Bogota	0
5156	Panama City Tocumen International Airport	Panama City	Panama	PA	PTY	MPTO	-79.387639	9.066897	America/Panama	0
5157	Pastaza Airport	Pastaza	Ecuador	EC	PTZ	SESM	-77	-2	America/Guayaquil	0
5158	Pueblo Memorial Airport	Pueblo	United States	US	PUB	KPUB	-104.495106	38.284206	America/Denver	0
5159	Carbon County Regional Airport	Price	United States	US	PUC	KPUC	-110.752778	39.609722	America/Denver	0
5160	Puerto Deseado Airport	Puerto Deseado	Argentina	AR	PUD	SAWD	-65.916667	-47.75	America/Argentina/Buenos_Aires	0
5161	Puerto Obaldia Airport	Puerto Obaldia	Panama	PA	PUE	MPOA	-77.41694	8.66694	America/Panama	0
5162	The Pau-Pyrenees International Airport	Pau	France	FR	PUF	LFBP	-0.413573	43.382348	Europe/Paris	0
5163	Port Augusta Airport	Port Augusta	Australia	AU	PUG	YPAG	137.715382	-32.50721	Australia/Adelaide	0
5164	Punta Cana International Airport	Punta Cana	Dominican Republic	DO	PUJ	MDPC	-68.363998	18.562477	America/Santo_Domingo	0
5165	Pukarua Airport	Pukarua, Tuamoto Island	French Polynesia	PF	PUK	NTGQ	-137.017844	-18.296126	Pacific/Tahiti	0
5166	Punia Airport	Punia	The Democratic Republic of The Congo	CD	PUN	FZOP	26.333333	-1.366667	Africa/Lubumbashi	0
5167	Prudhoe Bay Airport	Prudhoe Bay	United States	US	PUO	PAUD	-148.336944	70.251389	America/Anchorage	0
5168	Pres Ibanez Airport	Punta Arenas	Chile	CL	PUQ	SCCI	-70.843074	-53.005357	America/Santiago	0
5169	Busan Gimhae International Airport	Busan	Republic of Korea	KR	PUS	RKPK	128.948728	35.179319	Asia/Seoul	0
5170	Puerto Asis Airport	Puerto Asis	Colombia	CO	PUU	SKAS	-76.533333	0.533333	America/Bogota	0
5230	Colon Airport	Colon	Cuba	CU	QCO	MUCO	-80.922778	22.711111	America/Havana	0
5171	Pullman-Moscow Regional Airport	Pullman	United States	US	PUW	KPUW	-117.105	46.744722	America/Los_Angeles	0
5172	Puerto Varas Airport	Puerto Varas	Chile	CL	PUX	SCPV	-72.944444	-40.340278	America/Santiago	0
5173	Pula Airport	Pula	Croatia	HR	PUY	LDPL	13.923611	44.891667	Europe/Zagreb	0
5174	Puerto Cabezas Airport	Puerto Cabezas	Nicaragua	NI	PUZ	MNPC	-83.383661	14.046136	America/Managua	0
5175	Providencia Airport	Providencia Island	Colombia	CO	PVA	SKPV	-81.35	13.35	America/Bogota	0
5176	Provincetown Airport	Provincetown	United States	US	PVC	KPVC	-70.221667	42.071944	America/New_York	0
5177	Theodore Francis Green Memorial State Airport	Providence	United States	US	PVD	KPVD	-71.436317	41.726312	America/New_York	0
5178	El Porvenir Airport	El Porvenir	Panama	PA	PVE	MPVR	-78.945754	9.556982	America/Panama	0
5179	Placerville Airport	Placerville	United States	US	PVF	KPVF	-120.757327	38.72123	America/Los_Angeles	0
5180	Shanghai Pudong International Airport	Shanghai	China	CN	PVG	ZSPD	121.805278	31.143333	Asia/Shanghai	0
5181	Porto Velho International Airport	Porto Velho	Brazil	BR	PVH	SBPV	-63.898307	-8.714311	America/Porto_Velho	0
5182	Paranavia Airport	Paranavia	Brazil	BR	PVI	SSPI	-52.466667	-23.066667	America/Sao_Paulo	0
5183	Aktion Airport	Preveza	Greece	GR	PVK	LGPZ	20.765833	38.926389	Europe/Athens	0
5184	Portoviejo Airport	Portoviejo	Ecuador	EC	PVO	SEPV	-80.466667	-1.033333	America/Guayaquil	0
5185	Gustavo Diaz Ordaz International Airport	Puerto Vallarta	Mexico	MX	PVR	MMPR	-105.248979	20.678297	America/Mexico_City	0
5186	Provideniya Bay Airport	Provideniya	Russian Federation	RU	PVS	UHMD	-173.243333	64.383333	Asia/Anadyr	0
5187	Provo Airport	Provo	United States	US	PVU	KPVU	-111.722222	40.218056	America/Denver	0
5188	Hale County Airport	Plainview	United States	US	PVW	KPVW	-101.716667	34.183333	America/Chicago	0
5189	Casement Airport	Painesville	United States	US	PVZ	KPVZ	-81.25	41.716667	America/New_York	0
5190	Wiley Post Airport	Oklahoma City	United States	US	PWA	KPWA	-97.646416	35.535143	America/Chicago	0
5191	Sherwood Airport	Plentywood	United States	US	PWD	KPWD	-104.566667	48.783333	America/Denver	0
5192	Pevek Airport	Pevek	Russian Federation	RU	PWE	UHMP	170.6	69.783333	Asia/Anadyr	0
5193	Beles Airport	Pawi	Ethiopia	ET	PWI	HAPW	36.416667	11.333333	Africa/Addis_Ababa	0
5194	Chicago Executive Airport	Chicago	United States	US	PWK	KPWK	-87.901667	42.114167	America/Chicago	0
5195	Purwokerto Airport	Purwokerto	Indonesia	ID	PWL	WAHP	109.15	-7.466667	Asia/Jakarta	0
5196	Portland International Jetport	Portland	United States	US	PWM	KPWM	-70.310307	43.647492	America/New_York	0
5197	Pitts Town Airport	Pitts Town	Bahamas	BS	PWN	MYCP	-74.35	22.833333	America/Nassau	0
5198	Pweto Airport	Pweto	The Democratic Republic of The Congo	CD	PWO	FZQC	28.9	-8.466667	Africa/Lubumbashi	0
5199	Pavlodar Airport	Pavlodar	Kazakhstan	KZ	PWQ	UASP	77.073959	52.195808	Asia/Almaty	0
5200	Bremerton National Airport	Bremerton	United States	US	PWT	KPWT	-122.763333	47.485	America/Los_Angeles	0
5201	Prominent Hill Airport	Prominent Hill Mine	Australia	AU	PXH	YPMH	135.526997	-29.710412	Australia/Adelaide	0
5202	Puerto Escondido Airport	Puerto Escondido	Mexico	MX	PXM	MMPS	-97.083333	15.85	America/Mexico_City	0
5203	Porto Santo Airport	Porto Santo (Madeira)	Portugal	PT	PXO	LPPS	-16.345014	33.070023	Europe/Lisbon	0
5204	Pleiku Airport	Pleiku	Viet Nam	VN	PXU	VVPK	108.00896	14.006346	Asia/Ho_Chi_Minh	0
5205	Puerto Boyaca Airport	Puerto Boyaca	Colombia	CO	PYA	SKVL	-74.6	5.966667	America/Bogota	0
5206	Jeypore Airport	Jeypore	India	IN	PYB	VEJP	82.633333	18.833333	Asia/Kolkata	0
5207	Penrhyn Island Airport	Penrhyn Island	Cook Islands	CK	PYE	NCPY	-158.033333	-9.016667	Pacific/Rarotonga	0
5208	Pakyong Airport	Pakyong	India	IN	PYG	VEPY	88.586944	27.2278	Asia/Kolkata	0
5209	Puerto Ayacucho Airport	Puerto Ayacucho	Venezuela	VE	PYH	SVPA	-67.5	5.6	America/Caracas	0
5210	Polyarnyj Airport	Polyarnyj	Russian Federation	RU	PYJ	UERP	112.05	66.416667	Asia/Yakutsk	0
5211	Plymouth Municipal Airport	Plymouth	United States	US	PYM	KPYM	-70.728798	41.909	America/New_York	0
5212	Putumayo Airport	Putumayo	Ecuador	EC	PYO	SEPT	-75.9	0.083333	America/Guayaquil	0
5213	Andravida Air Base	Pyrgos	Greece	GR	PYR	LGAD	21.283333	37.933333	Europe/Athens	0
5214	Pai Airport	Pai	Thailand	TH	PYY	VTCI	98.436106	19.372789	Asia/Bangkok	0
5215	Casanare Airport	Paz De Ariporo	Colombia	CO	PZA	SKPZ	-71.885	5.877778	America/Bogota	0
5216	Pietermaritzburg Airport	Pietermaritzburg	South Africa	ZA	PZB	FAPM	30.396739	-29.643047	Africa/Johannesburg	0
5217	Penzance Heliport	Penzance	United Kingdom	GB	PZE	EGHK	-5.518258	50.127545	Europe/London	0
5218	Zhob Airport	Zhob	Pakistan	PK	PZH	OPZB	69.46392	31.358241	Asia/Karachi	0
5219	Pukapuka Island Airport	Pukapuka Atoll	Cook Islands	CK	PZK	NCPK	-165.835424	-10.911279	Pacific/Rarotonga	0
5220	Zulu Inyala Airport	Phinda	South Africa	ZA	PZL	FADQ	32.3097	-27.8494	Africa/Johannesburg	0
5221	Manuel Carlos Piar Guayana Airport	Puerto Ordaz	Venezuela	VE	PZO	SVPR	-62.759138	8.286533	America/Caracas	0
5222	Port Sudan Airport	Port Sudan	Sudan	SD	PZU	HSPN	37.213889	19.577778	Africa/Khartoum	0
5223	Piestany Airport	Piestany	Slovakia	SK	PZY	LZPP	17.82808	48.623731	Europe/Bratislava	0
5224	Castro	Castro	Brazil	BR	QAC	SSQT	-50.052778	-24.875	America/Sao_Paulo	0
5225	Barbacena	Barbacena	Brazil	BR	QAK	SBBQ	-43.883333	-21.397222	America/Sao_Paulo	0
5226	Bella Coola Airport	Bella Coola	Canada	CA	QBC	CYBD	-126.666667	52.333333	America/Vancouver	0
5227	Sobral	Sobral	Brazil	BR	QBX	SNOB	-40.366667	-3.781521	America/Belem	0
5228	Botucatu	Botucatu	Brazil	BR	QCJ	SDBK	-48.475	-22.966667	America/Sao_Paulo	0
5229	Canela Airport	Canela	Brazil	BR	CEL	SSCN	-50.922222	-29.497222	America/Sao_Paulo	0
5231	Currais Novos	Currais Novos	Brazil	BR	QCP	SNKN	-36.602778	-6.408333	America/Belem	0
5232	Curitibanos	Curitibanos	Brazil	BR	QCR	SSKU	-50.713889	-27.425	America/Sao_Paulo	0
5233	Akunnaag Heliport	Akunnaaq	Greenland	GL	QCU	BGAK	-52.340356	68.744284	America/Godthab	0
5234	Cachoeira Do Sul	Cachoeira Do Sul	Brazil	BR	QDB	SSKS	-53.002778	-30.022222	America/Campo_Grande	0
5235	Dracena	Dracena	Brazil	BR	QDC	SDDR	-51.666667	-21.561111	America/Sao_Paulo	0
5236	Conselheiro Lafaiete	Conselheiro Lafaiete	Brazil	BR	QDF	SNKF	-43.930556	-20.786111	America/Sao_Paulo	0
5237	Dom Pedrito	Dom Pedrito	Brazil	BR	QDP	SSDP	-54.811111	-31.1	America/Campo_Grande	0
5238	Jundiai Airport	Jundiai	Brazil	BR	QDV	SBJD	-46.943767	-23.181379	America/Sao_Paulo	0
5239	Eqalugaarsuit Heliport	Eqalugaarsuit	Greenland	GL	QFG	BGET	-45.914074	60.619732	America/Godthab	0
5240	Iginniarfik Heliport	Iginniarfik	Greenland	GL	QFI	BGIG	-53.169259	68.145864	America/Godthab	0
5241	Narsaq Kujalleq Heliport	Narsaq Kujalleq	Greenland	GL	QFN	BGFD	-44.656972	60.004684	America/Godthab	0
5242	Qassiarsuk Heliport	Qassiarsuk	Greenland	GL	QFT	BGQK	-45.519467	61.152501	America/Godthab	0
5243	Igaliku Heliport	Igaliku	Greenland	GL	QFX	BGIO	-45.421484	60.990563	America/Godthab	0
5244	Lencois Paulista	Lencois Paulista	Brazil	BR	QGC	SDLP	-48.852778	-22.672222	America/Sao_Paulo	0
5245	Montenegro	Montenegro	Brazil	BR	QGF	SSNG	-51.544444	-29.744444	America/Sao_Paulo	0
5246	Garanhuns	Garanhuns	Brazil	BR	QGP	SNGN	-36.65	-8.911111	America/Sao_Paulo	0
5247	Attu Heliport	Attu	Greenland	GL	QGQ	BGAT	-53.622778	67.940556	America/Godthab	0
5248	Gifu Airport	Gifu	Japan	JP	QGU	RJNG	136.870452	35.394551	Asia/Tokyo	0
5249	Piracicaba	Piracicaba	Brazil	BR	QHB	SDPW	-47.644444	-22.805556	America/Sao_Paulo	0
5250	Taguatinga	Taguatinga	Brazil	BR	QHN	SWTY	-46.405556	-12.438889	America/Sao_Paulo	0
5251	Novo Hamburgo	Novo Hamburgo	Brazil	BR	QHV	SSNH	-51.216667	-29.811111	America/Sao_Paulo	0
5252	Mello Viana	Tres Coracoes	Brazil	BR	QID	SNVI	-45.291667	-21.855556	America/Sao_Paulo	0
5253	Iguatu	Iguatu	Brazil	BR	QIG	SNIG	-39.436111	-6.477778	America/Belem	0
5254	Rio Claro	Rio Claro	Brazil	BR	QIQ	SDRK	-47.691667	-22.561111	America/Sao_Paulo	0
5255	Itapetinga	Itapetinga	Brazil	BR	QIT	SNIP	-40.361111	-15.338889	America/Sao_Paulo	0
5256	Kitsissuarsuit Heliport	Kitsissuarsuit	Greenland	GL	QJE	BGKT	-53.123296	68.857926	America/Godthab	0
5257	Qassimiut Heliport	Qassimiut	Greenland	GL	QJH	BGQT	-47.152561	60.779352	America/Godthab	0
5258	Ikamiut Heliport	Ikamiut	Greenland	GL	QJI	BGIT	-51.833661	68.63223	America/Godthab	0
5259	Lasham Airfield	Lasham	United Kingdom	GB	QLA	EGHL	-1.037654	51.184574	Europe/London	0
5260	Mafra	Mafra	Brazil	BR	QMF	SSMF	-49.972222	-26.238889	America/Sao_Paulo	0
5261	Niagornaarsuk Heliport	Niaqornaarsuk	Greenland	GL	QMK	BGNK	-52.852014	68.236478	America/Godthab	0
5262	Canoas Ab	Porto Alegre	Brazil	BR	QNS	SBCO	-51.288889	-30.016667	America/Sao_Paulo	0
5263	Aeroclube Nova Iguacu	Nova Iguacu	Brazil	BR	QNV	SDNY	-43.461755	-22.74685	America/Sao_Paulo	0
5264	Mococa	Mococa	Brazil	BR	QOA	SDKK	-47.044444	-21.527778	America/Sao_Paulo	0
5265	Saarloq Heliport	Saarloq	Greenland	GL	QOQ	BGSO	-46.02475	60.537829	America/Godthab	0
5266	Paya Lebar Airport	Singapore	Singapore	SG	QPG	WSAP	103.902305	1.358398	Asia/Singapore	0
5267	Strausberg Airport	Strausberg	Germany	DE	QPK	EDAY	13.915935	52.582638	Europe/Berlin	0
5268	Kangaatsiaq Heliport	Kangaatsiaq	Greenland	GL	QPW	BGKA	-53.46021	68.31268	America/Godthab	0
5269	Randgermiston Airport	Johannesburg	South Africa	ZA	QRA	FAGM	28.151648	-26.24284	Africa/Johannesburg	0
5270	De La Independencia	Rancagua	Chile	CL	QRC	SCRG	-70.855556	-34.244444	Pacific/Easter	0
5271	Carazinho	Carazinho	Brazil	BR	QRE	SSKZ	-52.955556	-28.363889	America/Campo_Grande	0
5272	Narromine	Narromine	Australia	AU	QRM	YNRM	148.363889	-32.244444	Australia/Brisbane	0
5273	Queretaro Intercontinental Airport	Queretaro	Mexico	MX	QRO	MMQT	-100.18924	20.622084	America/Mexico_City	0
5274	Warren	Warren	Australia	AU	QRR	YWRN	147.825	-31.733333	Australia/Brisbane	0
5275	Osubi Airstrip	Warri	Nigeria	NG	QRW	DNSU	5.819282	5.594487	Africa/Lagos	0
5276	Ikerasaarsuk Heliport	Ikerasaarsuk	Greenland	GL	QRY	BGIK	-53.441474	68.140895	America/Godthab	0
5277	Mario Pereira Lopes State Airport	Sao Carlos	Brazil	BR	QSC	SDSC	-47.903567	-21.87148	America/Sao_Paulo	0
5278	Setif Airport	Setif	Algeria	DZ	QSF	DAAS	5.331111	36.181389	Africa/Algiers	0
5279	Uetersen Airport	Uetersen	Germany	DE	QSM	EDHE	9.70936	53.648084	Europe/Berlin	0
5280	San Nicolas de Bari Airport	San Nicolas de Bari	Cuba	CU	QSN	MUNB	-81.9208333	22.7561111	America/Havana	0
5281	Ubari Airport	Ubari	Libya	LY	QUB	HLUB	12.820452	26.568267	Africa/Tripoli	0
5282	Goodwood	Chichester	United Kingdom	GB	QUG	EGHR	-0.759167	50.859402	Europe/London	0
5283	A-306	Chunchon	Republic of Korea	KR	QUN	RKNC	127.85	37.9	Asia/Seoul	0
5284	Akwa Ibom Airport	Uyo	Nigeria	NG	QUO	DNAI	8.085693	4.876463	Africa/Lagos	0
5285	Saqqaq Heliport	Saqqaq	Greenland	GL	QUP	BGSQ	-52	70.05	America/Godthab	0
5286	Utsunomiya Aero	Utsunomiya	Japan	JP	QUT	RJTU	140.006083	36.631528	Asia/Tokyo	0
5287	Aappilattoq-Nanortalik Heliport	Aappilattoq	Greenland	GL	QUV	BGAQ	-44.286883	60.148344	America/Godthab	0
5288	Ammassivik Heliport	Ammassivik	Greenland	GL	QUW	BGAS	-45.377452	60.596143	America/Godthab	0
5289	RAF Wyton	Wyton	United Kingdom	GB	QUY	EGUY	-0.107778	52.357222	Europe/London	0
5290	Avare-Arandu	Avare	Brazil	BR	QVP	SDRR	-48.991667	-23.180556	America/Sao_Paulo	0
5291	Caxias	Caxias	Brazil	BR	QXC	SNXS	-43.355556	-4.870141	America/Belem	0
5292	Cachoeiro Do Itapemirim	Cachoeiro Do Itapemirim	Brazil	BR	QXD	SNKI	-41.225	-20.866667	America/Sao_Paulo	0
5293	Mantsala Airport	Mantsala	Finland	FI	QZK	EFMN	25.508611	60.5725	Europe/Helsinki	0
5294	Relizane Airport	Relizane	Algeria	DZ	QZN	DAAZ	0.625833	35.753056	Africa/Algiers	0
5295	Tokua Airport	Rabaul	Papua New Guinea	PG	RAB	AYTK	152.37997	-4.340517	Pacific/Port_Moresby	0
5296	Horlick Airport	Racine	United States	US	RAC	KRAC	-87.85	42.683333	America/Chicago	0
5297	Arar Airport	Arar	Saudi Arabia	SA	RAE	OERR	41.137115	30.903029	Asia/Riyadh	0
5298	Ras An Naqb Airport	Ras An Naqb	Egypt	EG	RAF	SAFR	-61.501667	-31.2825	Africa/Cairo	0
5299	Raglan Airfield	Raglan	New Zealand	NZ	RAG	NZRA	174.859635	-37.804648	Pacific/Auckland	0
5300	Rafha Airport	Rafha	Saudi Arabia	SA	RAH	OERF	43.488786	29.623463	Asia/Riyadh	0
5301	Nelson Mandela International Airport	Praia	Cape Verde	CV	RAI	GVNP	-23.486566	14.945321	Atlantic/Cape_Verde	0
5302	Civil Airport	Rajkot	India	IN	RAJ	VARK	70.782346	22.308673	Asia/Kolkata	0
5303	Menara Airport	Marrakech	Morocco	MA	RAK	GMMX	-8.026902	31.601875	Africa/Casablanca	0
5304	Riverside Municipal Airport	Riverside	United States	US	RAL	KRAL	-117.442222	33.951667	America/Los_Angeles	0
5305	Ramingining Airport	Ramingining	Australia	AU	RAM	YRNG	134.816667	-12	Australia/Darwin	0
5306	La Spreta Airport	Ravenna	Italy	IT	RAN	LIDR	12.223333	44.366667	Europe/Rome	0
5307	Dr. Leite Lopes State Airport	Ribeirao Preto	Brazil	BR	RAO	SBRP	-47.775859	-21.139432	America/Sao_Paulo	0
5308	Rapid City Regional Airport	Rapid City	United States	US	RAP	KRAP	-103.061182	44.037581	America/Denver	0
5309	Sugimanuru Airport	Raha	Indonesia	ID	RAQ	WAWR	122.5692	-4.7603	Asia/Makassar	0
5310	Rarotonga Airport	Rarotonga	Cook Islands	CK	RAR	NCRG	-159.798529	-21.19992	Pacific/Rarotonga	0
5311	Rasht Airport	Rasht	Iran	IR	RAS	OIGG	49.619586	37.321814	Asia/Tehran	0
5312	Raduzhnyi Airport	Raduzhnyi	Russian Federation	RU	RAT	USNR	77	62.5	Asia/Yekaterinburg	0
5313	Cravo Norte Airport	Cravo Norte	Colombia	CO	RAV	SKCN	-70.183333	6.316667	America/Bogota	0
5314	Rawala Kot Airport	Rawala Kot	Pakistan	PK	RAZ	OPRT	73.833333	33.841667	Asia/Karachi	0
5315	Sale Airport	Rabat	Morocco	MA	RBA	GMME	-6.748619	34.036138	Africa/Casablanca	0
5316	Borba Airport	Borba	Brazil	BR	RBB	SWBR	-59.583333	-4.4	America/Porto_Velho	0
5317	Robinvale Airport	Robinvale	Australia	AU	RBC	YROI	142.75	-34.666667	Australia/Sydney	0
5318	Dallas Executive Airport	Dallas	United States	US	RBD	KRBD	-96.868333	32.680833	America/Chicago	0
5319	Ratanakiri Airport	Ratanakiri	Cambodia	KH	RBE	VRBE	106.983333	13.666667	Asia/Phnom_Penh	0
5320	Roseburg Regional Airport	Roseburg	United States	US	RBG	KRBG	-123.357623	43.235436	America/Los_Angeles	0
5321	Rebun Airport	Rebun	Japan	JP	RBJ	RJCR	141.033333	45.383333	Asia/Tokyo	0
5322	Red Bluff Municipal Airport	Red Bluff	United States	US	RBL	KRBL	-122.252468	40.154998	America/Los_Angeles	0
5323	Wallmuhle Airport	Straubing	Germany	DE	RBM	EDMS	12.515756	48.901636	Europe/Berlin	0
5324	Robore Airport	Robore	Bolivia	BO	RBO	SLRB	-59.755278	-18.344444	America/La_Paz	0
5325	Rurrenabaque Airport	Rurrenabaque	Bolivia	BO	RBQ	SLRQ	-67.55	-14.45	America/La_Paz	0
5326	Pres. Medici Airport	Rio Branco	Brazil	BR	RBR	SBRB	-67.898056	-9.868889	America/Rio_Branco	0
5327	Orbost Airport	Orbost	Australia	AU	RBS	YORB	148.610001	-37.790001	Australia/Sydney	0
5328	Marsabit Airport	Marsabit	Kenya	KE	RBT	HKMB	37.983333	2.333333	Africa/Nairobi	0
5329	Roebourne Airport	Roebourne	Australia	AU	RBU	YROE	117.166667	-20.8	Australia/Perth	0
5330	Ramata Airport	Ramata	Solomon Islands	SB	RBV	AGRM	157.639444	-8.165556	Pacific/Guadalcanal	0
5331	Lowcountry Regional Airport	Walterboro	United States	US	RBW	KRBW	-80.640584	32.92106	America/New_York	0
5332	Ruby Airport	Ruby	United States	US	RBY	PARY	-155.460833	64.73	America/Anchorage	0
5333	Ellsworth Air Force Base	Rapid City	United States	US	RCA	KRCA	-103.103563	44.145036	America/Denver	0
5334	Richards Bay Airport	Richards Bay	South Africa	ZA	RCB	FARB	32.093056	-28.740556	Africa/Johannesburg	0
5335	Riohacha Airport	Riohacha	Colombia	CO	RCH	SKRH	-72.925956	11.526226	America/Bogota	0
5336	Coffield Airport	Rockdale	United States	US	RCK	KRCK	-97	30.65	America/Chicago	0
5337	Redcliffe Airport	Redcliffe	Vanuatu	VU	RCL	NVSR	167.83501	-15.472	Pacific/Efate	0
5338	Richmond Airport	Richmond	Australia	AU	RCM	YRMD	143.117298	-20.700448	Australia/Brisbane	0
5339	Saint Agnant Airport	Rochefort	France	FR	RCO	LFDN	-0.980556	45.890556	Europe/Paris	0
5340	Reconquista Airport	Reconquista	Argentina	AR	RCQ	SATR	-59.680007	-29.210298	America/Argentina/Buenos_Aires	0
5341	Fulton County Airport	Rochester	United States	US	RCR	KRCR	-86.216667	41.066667	America/Indiana/Indianapolis	0
5342	Rochester Airport	Rochester	United Kingdom	GB	RCS	EGTO	0.5	51.35	Europe/London	0
5343	Nartron Field	Reed City	United States	US	RCT	KRCT	-85.51579	43.899998	America/New_York	0
5344	Las Higueras Airport	Rio Cuarto	Argentina	AR	RCU	SAOC	-64.274677	-33.096852	America/Argentina/Buenos_Aires	0
5345	New Port Nelson Airport	Rum Cay	Bahamas	BS	RCY	MYRP	-74.835023	23.684308	America/Nassau	0
5346	Rockhampton Downs Airport	Rockhampton Downs	Australia	AU	RDA	YRKD	135.166667	-18.95	Australia/Darwin	0
5347	Red Dog Airport	Red Dog	United States	US	RDB	PADG	-162.89917	68.03222	America/Anchorage	0
5348	Redencao Airport	Redencao	Brazil	BR	RDC	SNDC	-49.98	-8.030278	America/Belem	0
5349	Redding Municipal Airport	Redding	United States	US	RDD	KRDD	-122.299914	40.505769	America/Los_Angeles	0
5350	Merdey Airport	Merdey	Indonesia	ID	RDE	WAUM	133.333333	-1.583333	Asia/Jayapura	0
5351	Reading Regional Airport	Reading	United States	US	RDG	KRDG	-75.963889	40.378611	America/New_York	0
5352	Roberts Field	Redmond	United States	US	RDM	KRDM	-121.150106	44.254112	America/Los_Angeles	0
5353	LTS Pulau Redang Airport	Redang	Malaysia	MY	RDN	WMPR	103.006944	5.765278	Asia/Kuala_Lumpur	0
5354	Radom Airport	Warsaw	Poland	PL	RDO	EPRA	21.213611	51.389167	Europe/Warsaw	0
5355	Kazi Nazrul Islam Airport	Andal	India	IN	RDP	VEDG	87.243333	23.621389	Asia/Kolkata	0
5356	Grand Forks Air Force Base	Red River	United States	US	RDR	KRDR	-97.400751	47.961307	America/Chicago	0
5357	Richard Toll Airport	Richard Toll	Senegal	SN	RDT	GOSR	-15.657222	16.437222	Africa/Dakar	0
5358	Raleigh-Durham International Airport	Raleigh/Durham	United States	US	RDU	KRDU	-78.790862	35.873592	America/New_York	0
5359	Marcillac Airport	Rodez	France	FR	RDZ	LFCR	2.483866	44.410594	Europe/Paris	0
5360	Reao Airport	Reao, Tuamoto Island	French Polynesia	PF	REA	NTGE	-136.4	-18.5	Pacific/Tahiti	0
5361	Recife International Airport	Recife	Brazil	BR	REC	SBRF	-34.917921	-8.131507	America/Belem	0
5362	Mifflin County Airport	Reedsville	United States	US	RED	KRVL	-77.616667	40.683333	America/New_York	0
5363	Tito Menniti Airport	Reggio Calabria	Italy	IT	REG	LICR	15.650833	38.075278	Europe/Rome	0
5364	Regina Airport	Regina	French Guiana	GF	REI	SOOR	-52.133333	4.316667	America/Cayenne	0
5365	Trelew Airport	Trelew	Argentina	AR	REL	SAVT	-65.323333	-43.233333	America/Argentina/Buenos_Aires	0
5366	Orenburg Airport	Orenburg	Russian Federation	RU	REN	UWOO	55.456698	51.791049	Asia/Yekaterinburg	0
5367	Rome State Airport	Rome	United States	US	REO	KREO	-117.885556	42.577778	America/Los_Angeles	0
5368	Siem Reap International Airport	Siem Reap	Cambodia	KH	REP	VDSR	103.815927	13.408436	Asia/Phnom_Penh	0
5369	Retalhuleu Airport	Retalhuleu	Guatemala	GT	RER	MGRT	-91.697382	14.521131	America/Guatemala	0
5370	Resistencia Airport	Resistencia	Argentina	AR	RES	SARE	-59.050833	-27.451389	America/Argentina/Buenos_Aires	0
5371	Rost Airport	Rost	Norway	NO	RET	ENRS	12.103479	67.527675	Europe/Oslo	0
5372	Reus Airport	Reus	Spain and Canary Islands	ES	REU	LERS	1.153319	41.146102	Europe/Madrid	0
5373	Gen Lucio Blanco International Airport	Reynosa	Mexico	MX	REX	MMRX	-98.227557	26.011243	America/Matamoros	0
5374	Reyes Airport	Reyes	Bolivia	BO	REY	SLRY	-67.266667	-14.316667	America/La_Paz	0
5375	Rafai Airport	Rafai	Central African Republic	CF	RFA	FEGR	23.966667	4.983333	Africa/Bangui	0
5376	Chicago Rockford International Airport	Rockford	United States	US	RFD	KRFD	-89.095372	42.201748	America/Chicago	0
5377	Rooke Field	Refugio	United States	US	RFG	KRFG	-97.324458	28.2934	America/Chicago	0
5378	Raufarhofn Airport	Raufarhofn	Iceland	IS	RFN	BIRG	-15.016667	66.416667	Atlantic/Reykjavik	0
5379	Raiatea Airport	Raiatea	French Polynesia	PF	RFP	NTTR	-151.466665	-16.725004	Pacific/Tahiti	0
5380	Rio Frio Airport	Rio Frio	Costa Rica	CR	RFR	MRRF	-83.883333	10.333333	America/Costa_Rica	0
5381	Rosita Airport	Rosita	Nicaragua	NI	RFS	MNRT	-84.4	13.883333	America/Managua	0
5382	Rio Grande Airport	Rio Grande	Argentina	AR	RGA	SAWE	-67.75	-53.779167	America/Argentina/Buenos_Aires	0
5383	Balurghat Airport	Balurghat	India	IN	RGH	VEBG	88.733333	25.25	Asia/Kolkata	0
5384	Rangiroa Airport	Rangiroa	French Polynesia	PF	RGI	NTTG	-147.659149	-14.956334	Pacific/Tahiti	0
5385	Gorno-Altaysk Airport	Gorno-Altaysk	Russian Federation	RU	RGK	UNBG	85.83639	51.969166	Asia/Barnaul	0
5386	Rio Gallegos Internacional Airport	Rio Gallegos	Argentina	AR	RGL	SAWG	-69.283333	-51.616667	America/Argentina/Buenos_Aires	0
5387	Yangon International Airport	Yangon	Myanmar	MM	RGN	VYYY	96.134152	16.900069	Asia/Yangon	0
5388	Orang Chongjin Airport	Chongjin	Democratic People's Republic of Korea	KP	RGO	ZKHM	129.648611	41.429722	Asia/Pyongyang	0
5389	Japura Airport	Rengat	Indonesia	ID	RGT	WIBJ	102.55	-0.4	Asia/Jakarta	0
5390	Reykholar Airport	Reykholar	Iceland	IS	RHA	BIRE	-21.416667	65.166667	Atlantic/Reykjavik	0
5391	Rio Hondo Airport	Rio Hondo	Argentina	AR	RHD	SANR	-64.935958	-27.496667	America/Argentina/Buenos_Aires	0
5392	Reims Airport	Reims	France	FR	RHE	LFSR	4.050556	49.310833	Europe/Paris	0
5393	Ruhengeri Airport	Ruhengeri	Rwanda	RW	RHG	HRYU	29.6	-1.5	Africa/Kigali	0
5394	Oneida County Airport	Rhinelander	United States	US	RHI	KRHI	-89.462533	45.625707	America/Chicago	0
5395	Roy Hill Airport	Roy Hill	Australia	AU	RHL	YRYH	120	-22.75	Australia/Perth	0
5396	Rosh Pina Airport	Rosh Pina	Namibia	NA	RHN	FYSA	16.7	-27.966667	Africa/Windhoek	0
5397	Rhodes Airport	Rhodes	Greece	GR	RHO	LGRP	28.090677	36.401866	Europe/Athens	0
5398	Ramechhap Airport	Ramechhap	Nepal	NP	RHP	VNRC	86.083333	27.333333	Asia/Kathmandu	0
5399	Reid-Hillview Airport	San Jose	United States	US	RHV	KRHV	-121.818215	37.334155	America/Los_Angeles	0
5400	Santa Maria Airport	Santa Maria	Brazil	BR	RIA	SBSM	-53.6875	-29.710556	America/Sao_Paulo	0
5401	Gen Buech Airport	Riberalta	Bolivia	BO	RIB	SLRI	-66.093056	-11.006944	America/La_Paz	0
5402	Richmond International Airport	Richmond	United States	US	RIC	KRIC	-77.3225	37.506111	America/New_York	0
5403	Richmond Airport	Richmond	United States	US	RID	KRID	-84.9	39.833333	America/Indiana/Indianapolis	0
5404	Rice Lake Regional Airport-Carl's Field	Rice Lake	United States	US	RIE	KRPD	-91.773847	45.42054	America/Chicago	0
5405	Reynolds Airport	Richfield	United States	US	RIF	KRIF	-112.094444	38.741111	America/Denver	0
5406	Rio Grande Airport	Rio Grande	Brazil	BR	RIG	SBRG	-52.166667	-32.083333	America/Sao_Paulo	0
5407	Scarlett Martinez International Airport	Rio Hato	Panama	PA	RIH	MPSM	-80.12788	8.371162	America/Panama	0
5408	Juan Simons Vela Airport	Rioja	Peru	PE	RIJ	SPJA	-77.162062	-6.065464	America/Lima	0
5409	Garfield County Airport	Rifle	United States	US	RIL	KRIL	-107.725484	39.526267	America/Denver	0
5410	Rodriguez De Mendoza Airport	Rodriguez De Mendoza	Peru	PE	RIM	SPLN	-78	-6	America/Lima	0
5411	Ringi Cove Airport	Ringi Cove	Solomon Islands	SB	RIN	AGRC	157.033333	-8.2	Pacific/Guadalcanal	0
5412	Riverside Flabob Airport	Riverside	United States	US	RIR	KRIR	-117.409042	33.988828	America/Los_Angeles	0
5413	Rishiri Airport	Rishiri	Japan	JP	RIS	RJER	141.25	45.183333	Asia/Tokyo	0
5414	March Air Reserve Base	Riverside	United States	US	RIV	KRIV	-117.258414	33.888479	America/Los_Angeles	0
5415	Riverton Airport	Riverton	United States	US	RIW	KRIW	-108.456944	43.064444	America/Denver	0
5416	Riga International Airport	Riga	Latvia	LV	RIX	EVRA	23.979806	56.92208	Europe/Riga	0
5417	Riyan Airport	Riyan	Republic of Yemen	YE	RIY	OYRN	49.373684	14.666999	Asia/Aden	0
5418	Rajahmundry Airport	Rajahmundry	India	IN	RJA	VORY	81.820807	17.109639	Asia/Kolkata	0
5419	Rajbiraj Airport	Rajbiraj	Nepal	NP	RJB	VNRB	86.734684	26.509793	Asia/Kathmandu	0
5420	Muroran Airport	Muroran	Japan	JP	QRN	RJCY	140.983333	42.316667	Asia/Tokyo	0
5421	Rajshahi Airport	Rajshahi	Bangladesh	BD	RJH	VGRJ	88.616667	24.433333	Asia/Dhaka	0
5422	Rijeka Airport	Rijeka	Croatia	HR	RJK	LDRI	14.568333	45.215833	Europe/Zagreb	0
5423	Agoncillo Airport	Logrono	Spain and Canary Islands	ES	RJL	LERJ	-2.323611	42.456944	Europe/Madrid	0
5424	Marinda Airport	Waisai	Indonesia	ID	RJM	WASN	130.773333	-0.423056	Asia/Jayapura	0
5425	Rafsanjan Airport	Rafsanjan	Iran	IR	RJN	OIKR	56.051102	30.297701	Asia/Tehran	0
5426	Iwakuni Kintaikyo Airport	Iwakuni	Japan	JP	IWK	RJOI	132.23555	34.135277	Asia/Tokyo	0
5427	Aratika-Nord Airport	Aratika	French Polynesia	PF	RKA	NTKK	-145.468877	-15.485299	Pacific/Tahiti	0
5428	Knox County Regional Airport	Rockland	United States	US	RKD	KRKD	-69.098056	44.059167	America/New_York	0
5429	Roskilde Airport	Copenhagen	Denmark	DK	RKE	EKRK	12.128183	55.589721	Europe/Copenhagen	0
5430	York County Airport-Bryant Field	Rock Hill	United States	US	RKH	KUZA	-81.057196	34.987798	America/New_York	0
5431	Rokot Airport	Rokot	Indonesia	ID	RKI	WIEB	100.75	-0.95	Asia/Jakarta	0
5432	Aransas County Airport	Rockport	United States	US	RKP	KRKP	-97.05	28.033333	America/Chicago	0
5433	Robert S. Kerr Airport	Poteau	United States	US	RKR	KRKR	-94.616667	35.05	America/Chicago	0
5434	Rock Springs-Sweetwater County Airport	Rock Springs	United States	US	RKS	KRKS	-109.072092	41.598034	America/Denver	0
5435	Ras Al Khaimah International Airport	Ras al-Khaimah	United Arab Emirates	AE	RKT	OMRK	55.941224	25.616667	Asia/Dubai	0
5436	Seosan Airport	Seosan	Republic of Korea	KR	HMY	RKTP	126.487222	36.705556	Asia/Seoul	0
5437	Kairuku Airport	Yule Island	Papua New Guinea	PG	RKU	AYRK	146.516667	-8.816667	Pacific/Port_Moresby	0
5438	Reykjavik International Airport	Reykjavik	Iceland	IS	RKV	BIRK	-21.932476	64.131055	Atlantic/Reykjavik	0
5439	Rockwood Municipal Airport	Rockwood	United States	US	RKW	KRKW	-84.683333	35.866667	America/New_York	0
5440	Rokeby Airport	Rokeby	Australia	AU	RKY	YRBY	143.433333	-13.166667	Australia/Brisbane	0
5441	Shigatse Peace Airport	Shigatse	China	CN	RKZ	ZURK	89.31	29.351944	Asia/Shanghai	0
5442	Rolla Downtown Airport	Rolla	United States	US	RLA	KVIH	-91.813478	37.935903	America/Chicago	0
5443	Richland Airport	Richland	United States	US	RLD	KRLD	-119.305556	46.308333	America/Los_Angeles	0
5444	Laage Airport	Rostock-Laage	Germany	DE	RLG	ETNL	12.266667	53.92	Europe/Berlin	0
5445	Valle del Conlara Airport	Santa Rose de Conlara	Argentina	AR	RLO	SAOS	-65.180267	-32.380006	America/Argentina/Buenos_Aires	0
5446	Relais de la Reine Airport	Isalo	Madagascar	MG	RLR	FMSO	45.323612	-22.645277	Indian/Antananarivo	0
5447	Arlit Airport	Arlit	Niger	NE	RLT	DRZL	7.366667	18.783333	Africa/Niamey	0
5448	Roma Airport	Roma	Australia	AU	RMA	YROM	148.779431	-26.543553	Australia/Brisbane	0
5449	Buraimi Airport	Buraimi	Oman	OM	RMB	OOBR	55.783333	24.25	Asia/Muscat	0
5450	Ramagundam Airport	Ramagundam	India	IN	RMD	VORG	79.4	18.766667	Asia/Kolkata	0
5451	Griffiss International Airport	Rome	United States	US	RME	KRME	-75.406998	43.233799	America/New_York	0
5452	Marsa Alam International Airport	Marsa Alam	Egypt	EG	RMF	HEMA	34.592778	25.555787	Africa/Cairo	0
5453	Richard B Russell Airport	Rome	United States	US	RMG	KRMG	-85.158611	34.351389	America/New_York	0
5454	Miramare Airport	Rimini	Italy	IT	RMI	LIPR	12.619594	44.022952	Europe/Rome	0
5455	Renmark Airport	Renmark	Australia	AU	RMK	YREN	140.683333	-34.2	Australia/Adelaide	0
5456	Ratmalana Airport	Colombo	Sri Lanka	LK	RML	VCCC	79.886201	6.821998	Asia/Colombo	0
5457	Taichung International Airport	Shalu	Taiwan	TW	RMQ	RCMQ	120.601184	24.254755	Asia/Taipei	0
5458	Ramstein Air Base	Ramstein	Germany	DE	RMS	ETAR	7.589789	49.441015	Europe/Berlin	0
5459	Rimatara Airport	Rimatara	French Polynesia	PF	RMT	NTAM	-152.805155	-22.638783	Pacific/Gambier	0
5460	Corvera International Airport	Corvera	Spain and Canary Islands	ES	RMU	LEMI	-1.125	37.803	Europe/Madrid	0
5461	Ulawa Airport	Arona	Solomon Islands	SB	RNA	AGAR	161.983056	-9.864444	Pacific/Guadalcanal	0
5462	Kallinge Airport	Ronneby	Sweden	SE	RNB	ESDF	15.261111	56.258333	Europe/Stockholm	0
5463	Warren County Memorial Airport	McMinnville	United States	US	RNC	KRNC	-85.843808	35.698566	America/Chicago	0
5464	Randolph Air Force Base	San Antonio	United States	US	RND	KRND	-98.27889	29.529672	America/Chicago	0
5465	Renaison Airport	Roanne	France	FR	RNE	LFLO	4.000833	46.053333	Europe/Paris	0
5466	New Richmond Municipal Airport	New Richmond	United States	US	RNH	KRNH	-92.55	45.133333	America/Chicago	0
5467	Corn Island Airport	Corn Island	Nicaragua	NI	RNI	MNCI	-83.059682	12.174154	America/Managua	0
5468	Yoron Airport	Yoronjima	Japan	JP	RNJ	RORY	128.406343	27.042213	Asia/Tokyo	0
5469	Rennell Airport	Rennell	Solomon Islands	SB	RNL	AGGR	160.3	-11.666667	Pacific/Guadalcanal	0
5470	Qarn Alam Airport	Qarn Alam	Oman	OM	RNM	OOGB	57.054806	21.375585	Asia/Muscat	0
5471	Bornholm Airport	Bornholm	Denmark	DK	RNN	EKRN	14.758274	55.063645	Europe/Copenhagen	0
5472	Reno-Tahoe International Airport	Reno	United States	US	RNO	KRNO	-119.775698	39.505782	America/Los_Angeles	0
5473	Rennes Airport	Rennes	France	FR	RNS	LFRN	-1.726249	48.068064	Europe/Paris	0
5474	Renton Municipal Airport	Renton	United States	US	RNT	KRNT	-122.216003	47.493099	America/Los_Angeles	0
5475	Ranau Airport	Ranau	Malaysia	MY	RNU	WBKR	116.666667	5.95	Asia/Kuala_Lumpur	0
5476	Rensselaer Airport	Rensselaer	United States	US	RNZ	KRZL	-87.15	40.95	America/Indiana/Indianapolis	0
5477	Roanoke-Blacksburg Regional Airport	Roanoke	United States	US	ROA	KROA	-79.970384	37.320509	America/New_York	0
5478	Roberts International Airport	Monrovia	Liberia	LR	ROB	GLRB	-10.358889	6.239722	Africa/Monrovia	0
5479	Greater Rochester International Airport	Rochester	United States	US	ROC	KROC	-77.665427	43.127974	America/New_York	0
5480	Robertson Airport	Robertson	South Africa	ZA	ROD	FARS	19.9	-33.816667	Africa/Johannesburg	0
5481	Rogers Municipal Airport - Carter Field	Rogers	United States	US	ROG	KROG	-94.106667	36.372222	America/Chicago	0
5482	Robinhood Airport	Robinhood	Australia	AU	ROH	YROB	144	-18.25	Australia/Brisbane	0
5483	Roi Et Airport	Roi Et	Thailand	TH	ROI	VTUV	103.773842	16.116736	Asia/Bangkok	0
5484	Rockhampton Airport	Rockhampton	Australia	AU	ROK	YBRK	150.475006	-23.381901	Australia/Brisbane	0
5485	Rondon Airport	Rondon	Colombia	CO	RON	SKRD	-71.083333	6.3	America/Bogota	0
5486	Rondonopolis Airport	Rondonopolis	Brazil	BR	ROO	SBRD	-54.7248	-16.586	America/Campo_Grande	0
5487	Rota Airport	Rota	Northern Mariana Islands	MP	ROP	PGRO	145.244085	14.171568	Pacific/Saipan	0
5488	Airai Airport	Koror	Palau	PW	ROR	PTRO	134.532892	7.364122	Pacific/Palau	0
5489	Fisherton Airport	Rosario	Argentina	AR	ROS	SAAR	-60.783333	-32.933333	America/Argentina/Buenos_Aires	0
5490	Rotorua International Airport	Rotorua	New Zealand	NZ	ROT	NZRO	176.317459	-38.10982	Pacific/Auckland	0
5491	Rousse Airport	Rousse	Bulgaria	BG	ROU	LBRS	26.05	43.683333	Europe/Sofia	0
5492	Platov International Airport	Rostov	Russian Federation	RU	ROV	URRP	39.916471	47.497087	Europe/Moscow	0
5493	Roswell International Air Center	Roswell	United States	US	ROW	KROW	-104.525744	33.305389	America/Denver	0
5494	Roseau Municipal Airport	Roseau	United States	US	ROX	KROX	-95.696899	48.853845	America/Chicago	0
5495	Rio Mayo Airport	Rio Mayo	Argentina	AR	ROY	SAWM	-70.25	-45.666667	America/Argentina/Buenos_Aires	0
5496	Naval Station Rota	Rota	Spain and Canary Islands	ES	ROZ	LERT	-6.350709	36.645252	Europe/Madrid	0
5497	Rolpa Airport	Rolpa	Nepal	NP	RPA	VNRP	82.7564	28.2669	Asia/Kathmandu	0
5498	Roper Bar Airport	Roper Bar	Australia	AU	RPB	YRRB	134.733333	-14.733333	Australia/Darwin	0
5499	Ngukurr Airport	Ngukurr	Australia	AU	RPM	YNGU	134	-14.933333	Australia/Darwin	0
5500	Rosh Pina Airport	Rosh Pina	Israel	IL	RPN	LLIB	35.571111	32.981667	Asia/Jerusalem	0
5501	Swami Vivekananda Airport	Raipur	India	IN	RPR	VERP	81.739751	21.184561	Asia/Kolkata	0
5502	Urucu Airport	Coari	Brazil	BR	RPU	SBUY	-65.355379	-4.884204	America/Manaus	0
5503	Roundup Airport	Roundup	United States	US	RPX	KRPX	-108.533333	46.433333	America/Denver	0
5504	Qayyarah Airfield West	Qayyarah	Iraq	IQ	RQW	ORQW	43.125	35.767222	Asia/Baghdad	0
5505	Marree Airport	Marree	Australia	AU	RRE	YMRE	138.066667	-29.65	Australia/Adelaide	0
5506	Plaine Corail Airport	Rodrigues Island	Mauritius	MU	RRG	FIMR	63.360985	-19.757652	Indian/Mauritius	0
5507	Rourkela Airport	Rourkela	India	IN	RRK	VERK	84.814722	22.256667	Asia/Kolkata	0
5508	Merrill Municipal Airport	Merrill	United States	US	RRL	KRRL	-89.683333	45.183333	America/Chicago	0
5509	Raroia Airport	Raroia	French Polynesia	PF	RRR	NTKO	-142.475561	-16.044858	Pacific/Tahiti	0
5510	Roros Airport	Roros	Norway	NO	RRS	ENRO	11.345556	62.579167	Europe/Oslo	0
5511	Warroad Airport	Warroad	United States	US	RRT	KRRT	-95.3	48.9	America/Chicago	0
5512	Robinson River Airport	Robinson River	Australia	AU	RRV	YRBR	136.966667	-16.75	Australia/Darwin	0
5513	Santa Rosa Airport	Santa Rosa	Argentina	AR	RSA	SAZR	-64.266667	-36.566667	America/Argentina/Buenos_Aires	0
5514	Roseberth Airport	Roseberth	Australia	AU	RSB	YRSB	139.633333	-25.833333	Australia/Brisbane	0
5515	South Eleuthera Airport	Rock Sound	Bahamas	BS	RSD	MYER	-76.178056	24.891667	America/Nassau	0
5516	Au-Rose Bay Airport	Sydney	Australia	AU	RSE	YRAY	151.262	-33.869	Australia/Sydney	0
5517	Russian Mission Airport	Russian Mission	United States	US	RSH	PARS	-161.319167	61.783056	America/Anchorage	0
5518	Abresso Airport	Ransiki	Indonesia	ID	RSK	WASC	134.179972	-1.499828	Asia/Jayapura	0
5519	Russell Airport	Russell	United States	US	RSL	KRSL	-98.85	38.883333	America/Chicago	0
5520	Ruston Airport	Ruston	United States	US	RSN	KRSN	-92.633333	32.516667	America/Chicago	0
5521	Damazin Airport	Damazin	Sudan	SD	RSS	HSDZ	34.336558	11.792422	Africa/Khartoum	0
5522	Rochester International Airport	Rochester	United States	US	RST	KRST	-92.489768	43.910793	America/Chicago	0
5523	Yeosu Airport	Yeosu	Republic of Korea	KR	RSU	RKJY	127.612673	34.8419	Asia/Seoul	0
5524	Southwest Florida International Airport	Fort Myers	United States	US	RSW	KRSW	-81.755263	26.527887	America/New_York	0
5525	Rotuma Island Airport	Rotuma Island	Fiji	FJ	RTA	NFNR	177.0711	-12.4825	Pacific/Fiji	0
5526	Roatan Airport	Roatan	Honduras	HN	RTB	MHRO	-86.52722	16.318209	America/Tegucigalpa	0
5527	Ratnagiri Airport	Ratnagiri	India	IN	RTC	VARG	73.316667	17	Asia/Kolkata	0
5528	Frans Sales Lega Airport	Ruteng	Indonesia	ID	RTG	WATG	120.478345	-8.596921	Asia/Makassar	0
5529	David C. Saudale Airport	Rote Island	Indonesia	ID	RTI	WATR	123.073303	-10.767597	Asia/Makassar	0
5530	Rotterdam The Hague Airport	Rotterdam	Netherlands	NL	RTM	EHRD	4.433606	51.948949	Europe/Amsterdam	0
5531	Crews Field	Raton	United States	US	RTN	KRTN	-104.501111	36.741389	America/Denver	0
5532	Rutland Plains Airport	Rutland Plains	Australia	AU	RTP	YRTP	141.833333	-15.6	Australia/Brisbane	0
5533	Rottnest Island Airport	Rottnest Island	Australia	AU	RTS	YRTI	115.536667	-32.006944	Australia/Perth	0
5534	Saratov Airport	Saratov	Russian Federation	RU	RTW	UWSS	46.035095	51.561674	Europe/Saratov	0
5535	Arua Airport	Arua	Uganda	UG	RUA	HUAR	30.933333	3.033333	Africa/Kampala	0
5536	Shahrud Airport	Shahrud	Iran	IR	RUD	OIMJ	55.104198	36.425301	Asia/Tehran	0
5537	Rughenda Airfield	Butembo	The Democratic Republic of The Congo	CD	RUE	FZMB	29.266667	0.133333	Africa/Lubumbashi	0
5538	Yuruf, Irian Jaya Airport	Yuruf, Irian Jaya	Indonesia	ID	RUF	WAJE	140.933333	-3.633333	Asia/Jayapura	0
5539	Rugao Airport	Rugao	China	CN	RUG	ZSRG	120.555278	32.388333	Asia/Shanghai	0
5540	Riyadh King Khalid International Airport	Riyadh	Saudi Arabia	SA	RUH	OERK	46.702876	24.959289	Asia/Riyadh	0
5541	Ruidoso Municipal Airport	Ruidoso	United States	US	RUI	KSRR	-105.6625	33.360833	America/Denver	0
5542	Rukumkot Chaurjahari Airport	Rukumkot	Nepal	NP	RUK	VNCJ	82.193888	28.628006	Asia/Kathmandu	0
5543	Rumjatar Airport	Rumjatar	Nepal	NP	RUM	VNRT	86.533333	27.316667	Asia/Kathmandu	0
5544	Reunion Roland Garros Airport	Saint Denis de la Reunion	Reunion	RE	RUN	FMEE	55.511877	-20.892	Indian/Reunion	0
5545	Rupsi Airport	Rupsi	India	IN	RUP	VERU	89.916667	26.15	Asia/Kolkata	0
5546	Rurutu Airport	Rurutu	French Polynesia	PF	RUR	NTAR	-151.333333	-22.433333	Pacific/Tahiti	0
5547	Marau Airport	Marau	Solomon Islands	SB	RUS	AGGU	160.82528	-9.86167	Pacific/Guadalcanal	0
5548	Rutland Airport	Rutland	United States	US	RUT	KRUT	-72.948333	43.529444	America/New_York	0
5549	Farafangana Airport	Farafangana	Madagascar	MG	RVA	FMSG	47.819444	-22.801944	Indian/Antananarivo	0
5550	Rio Verde Airport	Rio Verde	Brazil	BR	RVD	SWLC	-50.956112	-17.834723	America/Sao_Paulo	0
5551	Saravena Airport	Saravena	Colombia	CO	RVE	SKSA	-71.9	6.916667	America/Bogota	0
5552	Ryumsjoen Airport	Roervik	Norway	NO	RVK	ENRM	11.1461	64.838303	Europe/Oslo	0
5553	Rovaniemi Airport	Rovaniemi	Finland	FI	RVN	EFRO	25.829609	66.559047	Europe/Helsinki	0
5554	Reivilo Airport	Reivilo	South Africa	ZA	RVO	FARI	24.133333	-27.6	Africa/Johannesburg	0
5555	Tulsa Riverside Airport	Tulsa	United States	US	RVS	KRVS	-95.98448	36.038843	America/Chicago	0
5556	Ravensthorpe Airport	Ravensthorpe	Australia	AU	RVT	YNRV	120.201389	-33.785556	Australia/Perth	0
5557	Raivavae Airport	Rairua	French Polynesia	PF	RVV	NTAV	-147.66528	-23.88611	Pacific/Tahiti	0
5558	Rivera Airport	Rivera	Uruguay	UY	RVY	SURV	-55.477031	-30.973483	America/Montevideo	0
5559	Redwood Falls Municipal Airport	Redwood Falls	United States	US	RWF	KRWF	-95.1	44.5	America/Chicago	0
5560	Rocky Mount-Wilson Airport	Rocky Mount/Wilson	United States	US	RWI	KRWI	-77.890556	35.854444	America/New_York	0
5561	Rawlins Municipal Airport (Harvey Field)	Rawlins	United States	US	RWL	KRWL	-107.201389	41.804444	America/Denver	0
5562	Rovno Airport	Rovno	Ukraine	UA	RWN	UKLR	26.15	50.6	Europe/Kiev	0
5563	Roxas City Airport	Roxas City	Philippines	PH	RXS	RPVR	122.748817	11.60066	Asia/Manila	0
5564	Moss-Rygge Airport	Rygge	Norway	NO	RYG	ENRY	10.783043	59.375931	Europe/Oslo	0
5565	Rahim Yar Khan Airport	Rahim Yar Khan	Pakistan	PK	RYK	OPRK	70.286621	28.39178	Asia/Karachi	0
5566	Royal Airport	Lower Zambezi National Park	Zambia	ZM	RYL	FLRZ	29.296678	-15.726728	Africa/Lusaka	0
5567	Medis Airport	Royan	France	FR	RYN	LFCY	-1.016667	45.616667	Europe/Paris	0
5568	Rio Turbio Airport	Rio Turbio	Argentina	AR	RYO	SAWT	-72.219595	-51.604478	America/Argentina/Buenos_Aires	0
5569	Santa Cruz Airport	Santa Cruz	Argentina	AR	RZA	SAWU	-68.533333	-50	America/Argentina/Buenos_Aires	0
5570	Rzeszow International Airport	Rzeszow	Poland	PL	RZE	EPRZ	22.031331	50.115248	Europe/Warsaw	0
5571	Ramsar Airport	Ramsar	Iran	IR	RZR	OINR	50.682442	36.904624	Asia/Tehran	0
5572	Sawan Airport	Sawan	Pakistan	PK	RZS	OPSW	68.87952	26.966531	Asia/Karachi	0
5573	Rize-Artvin Airport	Rize	Turkiye	TR	RZV	LTFO	40.850968	41.18025	Europe/Istanbul	0
5574	Halifax County Airport	Roanoke Rapids	United States	US	RZZ	KRZZ	-77.666667	36.466667	America/New_York	0
5575	Tillamook Airport	Tillamook	United States	US	OTK	KTMK	-123.814525	45.417299	America/Los_Angeles	0
5576	Shively Field	Saratoga	United States	US	SAA	KSAA	-106.823933	41.444782	America/Denver	0
5577	J. Yrausquin Airport	Saba	Caribbean Netherlands	BQ	SAB	TNCS	-63.216667	17.65	America/Curacao	0
5578	Sacramento Executive Airport	Sacramento	United States	US	SAC	KSAC	-121.494136	38.513195	America/Los_Angeles	0
5579	Safford Regional Airport	Safford	United States	US	SAD	KSAD	-109.636769	32.853332	America/Phoenix	0
5580	Saattut Heliport	Saattut	Greenland	GL	SAE	BGST	-51.626467	70.808742	America/Godthab	0
5581	Santa Fe Municipal Airport	Santa Fe	United States	US	SAF	KSAF	-106.088333	35.6175	America/Denver	0
5582	Shirdi Airport	Shirdi	India	IN	SAG	VASD	74.378889	19.688611	Asia/Kolkata	0
5583	Sana'a International Airport	Sana'a	Republic of Yemen	YE	SAH	OYSN	44.219702	15.476298	Asia/Aden	0
5584	Saudarkrokur Airport	Saudarkrokur	Iceland	IS	SAK	BIKR	-19.65	65.75	Atlantic/Reykjavik	0
5585	El Salvador International Airport	San Salvador	El Salvador	SV	SAL	MSLP	-89.05723	13.445126	America/El_Salvador	0
5586	San Diego International Airport	San Diego	United States	US	SAN	KSAN	-117.197312	32.731938	America/Los_Angeles	0
5587	Ramon Villeda Morales International Airport	San Pedro Sula	Honduras	HN	SAP	MHLM	-87.927796	15.456245	America/Tegucigalpa	0
5588	San Andros Airport	San Andros	Bahamas	BS	SAQ	MYAN	-78.048182	25.053652	America/Nassau	0
5589	Sparta Community Airport	Sparta	United States	US	SAR	KSAR	-89.7	38.133333	America/Chicago	0
5590	Salton City Airport	Salton City	United States	US	SAS	KSAS	-115.983333	33.316667	America/Los_Angeles	0
5591	San Antonio International Airport	San Antonio	United States	US	SAT	KSAT	-98.472643	29.524937	America/Chicago	0
5592	Tardamu Airport	Sawu	Indonesia	ID	SAU	WATS	121.8482	-10.4924	Asia/Makassar	0
5593	Savannah-Hilton Head International Airport	Savannah	United States	US	SAV	KSAV	-81.210588	32.1358	America/New_York	0
5594	Istanbul Sabiha Gokcen International Airport	Istanbul	Turkiye	TR	SAW	LTFJ	29.309188	40.904676	Europe/Istanbul	0
5595	Sambu Airport	Sambu	Panama	PA	SAX	MPSB	-78.083333	8.033333	America/Panama	0
5596	Ampugnano Airport	Siena	Italy	IT	SAY	LIQS	11.255	43.256302	Europe/Rome	0
5597	Sasstown Airport	Sasstown	Liberia	LR	SAZ	GLST	-8.433333	4.666667	Africa/Monrovia	0
5598	Santa Barbara Municipal Airport	Santa Barbara	United States	US	SBA	KSBA	-119.836476	34.432833	America/Los_Angeles	0
5599	San Bernardino International Airport	San Bernardino	United States	US	SBD	KSBD	-117.242902	34.098476	America/Los_Angeles	0
5600	Maimun Saleh Airport	Sabang	Indonesia	ID	SBG	WITN	95.341587	5.87365	Asia/Jakarta	0
5601	St. Barthelemy Airport	Saint Barthelemy	Guadeloupe	GP	SBH	TFFJ	-62.843601	17.9044	America/Guadeloupe	0
5602	Sambailo Airport	Koundara	Guinea	GN	SBI	GUSB	-13.3	12.483333	Africa/Conakry	0
5603	Sao Mateus Airport	Sao Mateus	Brazil	BR	SBJ	SNMX	-39.733333	-18.583333	America/Sao_Paulo	0
5604	Jacarepagua-Roberto Marinho Airport	Rio De Janeiro	Brazil	BR	RRJ	SBJR	-43.369897	-22.986689	America/Sao_Paulo	0
5605	Tremuson Airport	Saint Brieuc	France	FR	SBK	LFRT	-2.808889	48.513056	Europe/Paris	0
5606	Sheboygan County Memorial Airport	Sheboygan	United States	US	SBM	KSBM	-87.850707	43.764751	America/Chicago	0
5607	Campo de Marte Airport	Sao Paulo	Brazil	BR	RTE	SBMT	-46.634107	-23.510839	America/Sao_Paulo	0
5608	South Bend Regional	South Bend	United States	US	SBN	KSBN	-86.313345	41.700555	America/Indiana/Indianapolis	0
5609	San Luis Obispo County Regional Airport	San Luis Obispo	United States	US	SBP	KSBP	-120.640623	35.239113	America/Los_Angeles	0
5610	Sibi Airport	Sibi	Pakistan	PK	SBQ	OPSB	67.883333	29.55	Asia/Karachi	0
5611	Saibai Island Airport	Saibai Island	Australia	AU	SBR	YSII	142.625011	-9.378331	Australia/Brisbane	0
5612	Bob Adams Field	Steamboat Springs	United States	US	SBS	KSBS	-106.866379	40.516366	America/Denver	0
5613	Sabetta International Airport	Sabetta	Russian Federation	RU	SBT	USDA	72.043922	71.215207	Asia/Yekaterinburg	0
5614	Springbok Airport	Springbok	South Africa	ZA	SBU	FASB	17.939444	-29.688611	Africa/Johannesburg	0
5615	Sibu Airport	Sibu	Malaysia	MY	SBW	WBGS	111.986575	2.254997	Asia/Kuala_Lumpur	0
5616	Shelby Airport	Shelby	United States	US	SBX	KSBX	-111.85	48.5	America/Denver	0
5617	Wicomico Regional Airport	Salisbury-Ocean City	United States	US	SBY	KSBY	-75.517269	38.34312	America/New_York	0
5618	Sibiu Airport	Sibiu	Romania	RO	SBZ	LRSB	24.093529	45.789757	Europe/Bucharest	0
5619	Scribner State Airport	Scribner	United States	US	SCB	KSCB	-96.629823	41.610328	America/Chicago	0
5620	Prudhoe Bay/Deadhorse Airport	Prudhoe Bay/Deadhorse	United States	US	SCC	PASC	-148.464206	70.196561	America/Anchorage	0
5621	University Park Airport	State College	United States	US	SCE	KUNV	-77.848228	40.853721	America/New_York	0
5622	Scottsdale Airport	Phoenix	United States	US	SCF	KSDL	-111.908681	33.621966	America/Phoenix	0
5623	Spring Creek Airport	Spring Creek	Australia	AU	SCG	YSPK	142.416667	-38.016667	Australia/Brisbane	0
5624	Schenectady County Airport	Schenectady	United States	US	SCH	KSCH	-73.92849	42.853488	America/New_York	0
5625	San Cristobal Airport	San Cristobal	Venezuela	VE	SCI	SVPM	-72.199896	7.800072	America/Caracas	0
5626	Stockton Airport	Stockton	United States	US	SCK	KSCK	-121.239167	37.894444	America/Los_Angeles	0
5627	Santiago Arturo Merino Benitez Intl Airport	Santiago	Chile	CL	SCL	SCEL	-70.793821	-33.397175	America/Santiago	0
5628	Scammon Bay Sea Plane Base	Scammon Bay	United States	US	SCM	PACM	-165.57375	61.844542	America/Nome	0
5629	Ensheim Airport	Saarbruecken	Germany	DE	SCN	EDDR	7.112705	49.220088	Europe/Berlin	0
5630	Aktau International Airport	Aktau	Kazakhstan	KZ	SCO	UATE	51.089073	43.857447	Asia/Aqtau	0
5631	Santiago de Compostela Airport	Santiago De Compostela	Spain and Canary Islands	ES	SCQ	LEST	-8.415125	42.896308	Europe/Madrid	0
5632	Scatsta Airport	Shetland Islands	United Kingdom	GB	SCS	EGPM	-1.294972	60.436824	Europe/London	0
5633	Socotra Airport	Socotra	Republic of Yemen	YE	SCT	OYSQ	53.909245	12.627546	Asia/Aden	0
5634	Antonio Maceo Airport	Santiago	Cuba	CU	SCU	MUCU	-75.835833	19.969167	America/Havana	0
5635	Suceava Airport	Suceava	Romania	RO	SCV	LRSV	26.351656	47.685773	Europe/Bucharest	0
5636	Syktyvkar Airport	Syktyvkar	Russian Federation	RU	SCW	UUYY	50.766667	61.666667	Europe/Moscow	0
5637	Salina Cruz Airport	Salina Cruz	Mexico	MX	SCX	MM57	-95.2	16.166667	America/Mexico_City	0
5638	San Cristobal Airport	San Cristobal	Ecuador	EC	SCY	SEST	-89.617401	-0.910206	Pacific/Galapagos	0
5639	Santa Cruz Island Airport	Santa Cruz Island	Solomon Islands	SB	SCZ	AGGL	165.797497	-10.719397	Pacific/Guadalcanal	0
5640	Langebaanweg Airport	Saldanha Bay	South Africa	ZA	SDB	FALW	18	-33.066667	Africa/Johannesburg	0
5641	Sandcreek Airport	Sand Creek	Guyana	GY	SDC	SYSC	-58.166667	3.333333	America/Guyana	0
5642	Lubango Airport	Lubango	Angola	AO	SDD	FNUB	13.576667	-14.924444	Africa/Luanda	0
5643	Santiago Del Estero Airport	Santiago Del Estero	Argentina	AR	SDE	SANE	-64.322222	-27.765278	America/Argentina/Buenos_Aires	0
5644	Louisville Muhammad Ali International Airport	Louisville	United States	US	SDF	KSDF	-85.73599	38.174397	America/New_York	0
5645	Sanandaj Airport	Sanandaj	Iran	IR	SDG	OICS	47.013766	35.251473	Asia/Tehran	0
5646	Sendai Airport	Sendai	Japan	JP	SDJ	RJSS	140.923889	38.135556	Asia/Tokyo	0
5647	Sandakan Airport	Sandakan	Malaysia	MY	SDK	WBKS	118.061833	5.896877	Asia/Kuala_Lumpur	0
5648	Sundsvall-Timra Airport	Sundsvall	Sweden	SE	SDL	ESNN	17.43873	62.526556	Europe/Stockholm	0
5649	Brown Field Municipal Airport	San Diego	United States	US	SDM	KSDM	-116.98	32.572222	America/Los_Angeles	0
5650	Sandane Airport	Sandane	Norway	NO	SDN	ENSD	6.216667	61.766667	Europe/Oslo	0
5651	Sand Point Municipal Airport	Sand Point	United States	US	SDP	PASD	-160.513889	55.316667	America/Anchorage	0
5652	Las Americas International Airport	Santo Domingo	Dominican Republic	DO	SDQ	MDSD	-69.676742	18.430125	America/Santo_Domingo	0
5653	Santander Airport	Santander	Spain and Canary Islands	ES	SDR	LEXJ	-3.824453	43.423086	Europe/Madrid	0
5654	Sado Shima Airport	Sado Shima	Japan	JP	SDS	RJSD	138.416667	38	Asia/Tokyo	0
5655	Saidu Sharif Airport	Saidu Sharif	Pakistan	PK	SDT	OPSS	72.35	34.75	Asia/Karachi	0
5656	Santos Dumont Airport	Rio De Janeiro	Brazil	BR	SDU	SBRJ	-43.167097	-22.911541	America/Sao_Paulo	0
5657	Dov Hoz Airport	Tel Aviv-Yafo	Israel	IL	SDV	LLSD	34.787858	32.104885	Asia/Jerusalem	0
5658	Sindhudurg Airport	Malvan	India	IN	SDW	VOSR	73.53111	16.0025	Asia/Kolkata	0
5659	Sedona Airport	Sedona	United States	US	SDX	KSEZ	-111.788002	34.848598	America/Phoenix	0
5660	Richland Municipal Airport	Sidney	United States	US	SDY	KSDY	-104.191944	47.706944	America/Denver	0
5661	Seattle-Tacoma International Airport	Seattle	United States	US	SEA	KSEA	-122.301732	47.443839	America/Los_Angeles	0
5662	Sebha Airport	Sebha	Libya	LY	SEB	HLLS	14.461354	27.001483	Africa/Tripoli	0
5663	Gillespie Field	San Diego	United States	US	SEE	KSEE	-116.972222	32.826111	America/Los_Angeles	0
5664	Sebring Air Terminal	Sebring	United States	US	SEF	KSEF	-81.342519	27.457846	America/New_York	0
5665	Penn Valley Airport	Selinsgrove	United States	US	SEG	KSEG	-76.863899	40.820599	America/New_York	0
5666	Senggeh Airport	Senggeh	Indonesia	ID	SEH	WAJS	140.816667	-3.433333	Asia/Jayapura	0
5667	Jumandy Airport	Tena	Ecuador	EC	TNW	SEJD	-77.573011	-1.06248	America/Guayaquil	0
5668	Craig Field	Selma	United States	US	SEM	KSEM	-87.987778	32.343889	America/Chicago	0
5669	London Southend Airport	Southend	United Kingdom	GB	SEN	EGMC	0.698248	51.57265	Europe/London	0
5670	Seguela Airport	Seguela	Cote d'Ivoire	CI	SEO	DISG	-6.666667	7.966667	Africa/Abidjan	0
5671	Clark Field	Stephenville	United States	US	SEP	KSEP	-98.2	32.216667	America/Chicago	0
5672	Sungaipinang Airport	Sungaipinang	Indonesia	ID	SEQ	WIBS	114.066667	-0.8	Asia/Jakarta	0
5673	Freeman Municipal Airport	Seymour	United States	US	SER	KSER	-85.883333	38.966667	America/Indiana/Indianapolis	0
5674	Coronel Artilleria Victor Larrea Airport	Santa Rosa	Ecuador	EC	ETR	SERO	-79.96167	-3.452222	America/Guayaquil	0
5675	Seronera Airstrip	Seronera	United Republic of Tanzania	TZ	SEU	HTSN	34.821546	-2.4567	Africa/Dar_es_Salaam	0
5676	Selibaby Airport	Selibaby	Mauritania	MR	SEY	GQNS	-12.206111	15.182222	Africa/Nouakchott	0
5677	Seychelles International Airport	Mahe Island	Seychelles	SC	SEZ	FSIA	55.511279	-4.671275	Indian/Mahe	0
5678	Sfax El Maou Airport	Sfax	Tunisia	TN	SFA	DTTX	10.683333	34.716667	Africa/Tunis	0
5679	Orlando Sanford International Airport	Orlando	United States	US	SFB	KSFB	-81.243204	28.775118	America/New_York	0
5680	Saint Francois Airport	Saint Francois	Guadeloupe	GP	SFC	TFFC	-61.283333	16.25	America/Guadeloupe	0
5681	Las Flecheras Airport	San Fernando de Apure	Venezuela	VE	SFD	SVSR	-67.443462	7.884271	America/Caracas	0
5682	San Fernando Airport	San Fernando	Philippines	PH	SFE	RPUS	120.3	16.6	Asia/Manila	0
5683	Felts Field	Spokane	United States	US	SFF	KSFF	-117.322714	47.683148	America/Los_Angeles	0
5684	Esperance Airport	Saint Martin	Saint Martin	MF	SFG	TFFG	-63.04889	18.100555	America/Marigot	0
5685	San Felipe International Airport	San Felipe	Mexico	MX	SFH	MMSF	-114.808764	30.931762	America/Tijuana	0
5686	Safi Airport	Safi	Morocco	MA	SFI	GMMS	-9.333333	32.3	Africa/Casablanca	0
5687	Kangerlussuaq Airport	Kangerlussuaq	Greenland	GL	SFJ	BGSF	-50.719722	67.012222	America/Godthab	0
5688	Soure Airport	Soure	Brazil	BR	SFK	SNSW	-48.522222	-0.7	America/Belem	0
5689	Sao Filipe Airport	Sao Filipe	Cape Verde	CV	SFL	GVSF	-24.516667	14.9	Atlantic/Cape_Verde	0
5690	Seacoast Regional Airport	Sanford	United States	US	SFM	KSFM	-70.708	43.393902	America/New_York	0
5691	Santa Fe Airport	Santa Fe	Argentina	AR	SFN	SAAV	-60.816667	-31.716667	America/Argentina/Buenos_Aires	0
5692	San Francisco International Airport	San Francisco	United States	US	SFO	KSFO	-122.389881	37.615215	America/Los_Angeles	0
5693	Subic Bay International Airport	Subic Bay	Philippines	PH	SFS	RPLB	120.267222	14.785556	Asia/Manila	0
5694	Skelleftea Airport	Skelleftea	Sweden	SE	SFT	ESNS	21.068549	64.622513	Europe/Stockholm	0
5695	North Central State Airport	Pawtucket	United States	US	SFZ	KSFZ	-71.491402	41.920799	America/New_York	0
5696	Sheghnan Airport	Sheghnan	Afghanistan	AF	SGA	OASN	71.716667	38.033333	Asia/Kabul	0
5697	Surgut Airport	Surgut	Russian Federation	RU	SGC	USRR	73.409534	61.339916	Asia/Yekaterinburg	0
5698	Sonderborg Airport	Sonderborg	Denmark	DK	SGD	EKSB	9.791731	54.964444	Europe/Copenhagen	0
5699	Siegerland Airport	Siegen	Germany	DE	SGE	EDGS	8	50.85	Europe/Berlin	0
5700	Springfield-Branson National Airport	Springfield	United States	US	SGF	KSGF	-93.396929	37.238707	America/Chicago	0
5701	Sermiligaaq Heliport	Sermiligaaq	Greenland	GL	SGG	BGSG	-36.378285	65.905923	America/Godthab	0
5702	Springfield Airport	Springfield	United States	US	SGH	KSGH	-83.8	39.916667	America/New_York	0
5703	Danilo Atienza Air Base	Manila	Philippines	PH	SGL	RPLS	120.905584	14.496097	Asia/Manila	0
5704	Ho Chi Minh Tan Son Nhat International Airport	Ho Chi Minh City	Viet Nam	VN	SGN	VVTS	106.662477	10.813045	Asia/Ho_Chi_Minh	0
5705	St. George Airport	Saint George	Australia	AU	SGO	YSGE	148.593889	-28.053333	Australia/Brisbane	0
5706	Sanggata Airport	Sanggata	Indonesia	ID	SGQ	WALA	117.333333	0.5	Asia/Makassar	0
5707	Sugar Land Municipal Airport	Houston	United States	US	SGR	KSGR	-95.647824	29.611597	America/Chicago	0
5708	Stuttgart Airport	Stuttgart	United States	US	SGT	KSGT	-91.574997	34.599499	America/Chicago	0
5709	Saint George Municipal Airport	Saint George	United States	US	SGU	KSGU	-113.510167	37.032628	America/Denver	0
5710	Sierra Grande Airport	Sierra Grande	Argentina	AR	SGV	SAVS	-65.35	-41.566667	America/Argentina/Buenos_Aires	0
5711	Songea Airport	Songea	United Republic of Tanzania	TZ	SGX	HTSO	35.582609	-10.682404	Africa/Dar_es_Salaam	0
5712	Skagway Airport	Skagway	United States	US	SGY	PAGY	-135.315556	59.460556	America/Anchorage	0
5713	Songkhla Airport	Songkhla	Thailand	TH	SGZ	VTSH	100.616667	7.183889	Asia/Bangkok	0
5714	Shanghai Hongqiao International Airport	Shanghai	China	CN	SHA	ZSSS	121.333473	31.19779	Asia/Shanghai	0
5715	Nakashibetsu Airport	Nakashibetsu	Japan	JP	SHB	RJCN	144.956129	43.572196	Asia/Tokyo	0
5716	Indaselassie Airport	Shire	Ethiopia	ET	SHC	HASR	38.268239	14.083742	Africa/Addis_Ababa	0
5717	Shenandoah Valley Airport	Staunton	United States	US	SHD	KSHD	-78.896667	38.263889	America/New_York	0
5718	Shenyang Taoxian International Airport	Shenyang	China	CN	SHE	ZYTX	123.485731	41.634992	Asia/Shanghai	0
5719	Shungnak Airport	Shungnak	United States	US	SHG	PAGH	-157.157778	66.889722	America/Anchorage	0
5720	Shishmaref Airport	Shishmaref	United States	US	SHH	PASH	-166.058333	66.256944	America/Anchorage	0
5721	Shimojishima Airport	Miyakojima	Japan	JP	SHI	RORS	125.15	24.816667	Asia/Tokyo	0
5722	Sharjah International Airport	Sharjah	United Arab Emirates	AE	SHJ	OMSJ	55.52029	25.320873	Asia/Dubai	0
5723	Sehonghong Airport	Sehonghong	Lesotho	LS	SHK	FXSH	27.833333	-29.475	Africa/Maseru	0
5724	Shillong Airport	Umroi	India	IN	SHL	VEBI	91.975983	25.704872	Asia/Kolkata	0
5725	Shirahama Airport	Shirahama	Japan	JP	SHM	RJBD	135.358056	33.661389	Asia/Tokyo	0
5726	Sanderson Field	Shelton	United States	US	SHN	KSHN	-123.138889	47.233889	America/Los_Angeles	0
5727	King Mswati III International Airport	Manzini	Eswatini	SZ	SHO	FDSK	31.716944	-26.358611	Africa/Mbabane	0
5728	Sheridan Airport	Sheridan	United States	US	SHR	KSHR	-106.977222	44.774167	America/Denver	0
5729	Shashi Airport	Shashi	China	CN	SHS	ZHSS	112.2781	30.321995	Asia/Shanghai	0
5730	Shepparton Airport	Shepparton	Australia	AU	SHT	YSHT	145.433333	-36.383333	Australia/Sydney	0
5731	Smith Point Airport	Smith Point	Australia	AU	SHU	YSMP	132.133333	-11.133333	Australia/Darwin	0
5732	Shreveport Regional Airport	Shreveport	United States	US	SHV	KSHV	-93.828383	32.454707	America/Chicago	0
5733	Sharurah Airport	Sharurah	Saudi Arabia	SA	SHW	OESH	47.111983	17.469459	Asia/Riyadh	0
5734	Shageluk Airport	Shageluk	United States	US	SHX	PAHX	-159.569222	62.692306	America/Anchorage	0
5735	Shinyanga Airport	Shinyanga	United Republic of Tanzania	TZ	SHY	HTSY	33.504487	-3.608185	Africa/Dar_es_Salaam	0
5736	Seshutes Airport	Seshutes	Lesotho	LS	SHZ	FXSS	28	-29.166667	Africa/Maseru	0
5737	Xiguan Airport	Xian	China	CN	SIA	ZLXG	109.119659	34.375941	Asia/Shanghai	0
5738	Sibiti Airport	Sibiti	Congo	CG	SIB	FCBS	13.4	-3.733333	Africa/Brazzaville	0
5739	Amilcar Cabral International Airport	Sal	Cape Verde	CV	SID	GVAC	-22.943613	16.734696	Atlantic/Cape_Verde	0
5740	Sines Airport	Sines	Portugal	PT	SIE	LPSI	-8.809576	37.944201	Europe/Lisbon	0
5741	Simara Airport	Simara	Nepal	NP	SIF	VNSI	84.979195	27.163563	Asia/Kathmandu	0
5742	Fernando Luis Ribas Dominicci Airport	San Juan	Puerto Rico	PR	SIG	TJIG	-66.099306	18.456006	America/Puerto_Rico	0
5743	Sidi Ifni Airport	Sidi Ifni	Morocco	MA	SII	GMMF	-10.2	29.4	Africa/Casablanca	0
5744	Siglufjordur Airport	Siglufjordur	Iceland	IS	SIJ	BISI	-18.933333	66.166667	Atlantic/Reykjavik	0
5745	Sikeston Memorial Airport	Sikeston	United States	US	SIK	KSIK	-89.55	36.866667	America/Chicago	0
5746	Singapore Changi Airport	Singapore	Singapore	SG	SIN	WSSS	103.990201	1.361173	Asia/Singapore	0
5747	Smithton Airport	Smithton	Australia	AU	SIO	YSMI	145.081667	-40.835833	Australia/Hobart	0
5748	Simferopol International Airport	Simferopol	Ukraine	UA	SIP	UKFF	33.998193	45.020658	Europe/Simferopol	0
5749	Dabo Airport	Singkep	Indonesia	ID	SIQ	WIDS	104.416667	-0.5	Asia/Jakarta	0
5750	Sion Airport	Sion	Switzerland	CH	SIR	LSGS	7.322294	46.21725	Europe/Zurich	0
5751	Sishen Airport	Sishen	South Africa	ZA	SIS	FASS	22.999137	-27.649178	Africa/Johannesburg	0
5752	Sitka Airport	Sitka	United States	US	SIT	PASI	-135.362	57.0471	America/Anchorage	0
5753	Siuna Airport	Siuna	Nicaragua	NI	SIU	MNSI	-84.777253	13.728636	America/Managua	0
5754	Sullivan County Airport	Sullivan	United States	US	SIV	KSIV	-87.4	39.1	America/Indiana/Indianapolis	0
5755	Sibisa Airport	Parapat	Indonesia	ID	SIW	WIMP	98.962778	2.601389	Asia/Jakarta	0
5756	Singleton Airport	Singleton	Australia	AU	SIX	YSGT	151.166667	-32.566667	Australia/Sydney	0
5757	Siskiyou County Airport	Montague	United States	US	SIY	KSIY	-122.533333	41.733333	America/Los_Angeles	0
5758	San Juan Airport	San Juan	Peru	PE	SJA	SPJN	-75.15	-15.35	America/Lima	0
5759	San Joaquin Airport	San Joaquin	Bolivia	BO	SJB	SLJO	-64.8	-13.083333	America/La_Paz	0
5760	San Jose Mineta International Airport	San Jose	United States	US	SJC	KSJC	-121.926375	37.366736	America/Los_Angeles	0
5761	Los Cabos International Airport	San Jose Cabo	Mexico	MX	SJD	MMSD	-109.717283	23.162354	America/Mazatlan	0
5762	San Jose Del Gua Airport	San Jose Del Gua	Colombia	CO	SJE	SKSJ	-72.666667	2.583333	America/Bogota	0
5763	San Juan Del Cesar Airport	San Juan Del Cesar	Colombia	CO	SJH	SKNJ	-73.016667	10.766667	America/Bogota	0
5764	San Jose Airport	San Jose	Philippines	PH	SJI	RPUH	121.045574	12.360818	Asia/Manila	0
5765	Sarajevo International Airport	Sarajevo	Bosnia and Herzegovina	BA	SJJ	LQSA	18.331541	43.824601	Europe/Sarajevo	0
5766	Professor Urbano Ernesto Stumpf Airport	Sao Jose dos Campos	Brazil	BR	SJK	SBSJ	-45.8628	-23.2281	America/Sao_Paulo	0
5767	Sao Gabriel Cachoeira Airport	Sao Gabriel Cachoeira	Brazil	BR	SJL	SBUA	-66.98556	-0.148333	America/Porto_Velho	0
5768	Saint Johns Municipal Airport	Saint Johns	United States	US	SJN	KSJN	-109.35	34.5	America/Phoenix	0
5769	Juan Santamaria International Airport	San Jose	Costa Rica	CR	SJO	MROC	-84.20408	9.998238	America/Costa_Rica	0
5770	Sao Jose do Rio Preto Airport	Sao Jose Do Rio Preto	Brazil	BR	SJP	SBSR	-49.406244	-20.814853	America/Sao_Paulo	0
5771	Sesheke Airport	Sesheke	Zambia	ZM	SJQ	FLSS	24.283333	-17.483333	Africa/Lusaka	0
5772	San Juan De Uraba Airport	San Juan De Uraba	Colombia	CO	SJR	SQJQ	-76.533333	8.766667	America/Bogota	0
5773	San Jose de Chiquitos Airport	San Jose	Bolivia	BO	SJS	SLJE	-60.748557	-17.830813	America/La_Paz	0
5774	San Angelo Regional Airport	San Angelo	United States	US	SJT	KSJT	-100.494444	31.359722	America/Chicago	0
5775	Luis Munoz Marin International Airport	San Juan	Puerto Rico	PR	SJU	TJSJ	-66.004683	18.437403	America/Puerto_Rico	0
5776	San Javier Airport	San Javier	Bolivia	BO	SJV	SLJV	-62.416667	-16.233333	America/La_Paz	0
5777	Shijiazhuang Zhengding International Airport	Shijiazhuang	China	CN	SJW	ZBSJ	114.692106	38.281868	Asia/Shanghai	0
5778	Ilmajoki Airport	Seinajoki	Finland	FI	SJY	EFSI	22.826712	62.692567	Europe/Helsinki	0
5779	Sao Jorge Island Airport	Sao Jorge Island	Portugal	PT	SJZ	LPSJ	-28.16843	38.664616	Atlantic/Azores	0
5780	Fairchild Air Force Base	Spokane	United States	US	SKA	KSKA	-117.655561	47.615154	America/Los_Angeles	0
5781	Luis F. Gomez Nino Air Base	Apiay	Colombia	CO	API	SKAP	-73.562834	4.076085	America/Bogota	0
5782	Robert L. Bradshaw International Airport	Saint Kitts	St. Kitts and Nevis	KN	SKB	TKPK	-62.71397	17.310843	America/St_Kitts	0
5783	Samarkand Airport	Samarkand	Uzbekistan	UZ	SKD	UTSS	66.990854	39.696217	Asia/Tashkent	0
5784	Skien Airport	Skien	Norway	NO	SKE	ENSN	9.5625	59.182778	Europe/Oslo	0
5785	Kelly Field Annex	San Antonio	United States	US	SKF	KSKF	-98.570968	29.372971	America/Chicago	0
5786	Thessaloniki International Airport	Thessaloniki	Greece	GR	SKG	LGTS	22.972222	40.520833	Europe/Athens	0
5787	Surkhet Airport	Surkhet	Nepal	NP	SKH	VNSK	81.635933	28.586104	Asia/Kathmandu	0
5788	Skikda Airport	Skikda	Algeria	DZ	SKI	DABP	6.950833	36.862222	Africa/Algiers	0
5789	Broadford Airport	Isle of Skye	United Kingdom	GB	SKL	EGEI	-5.8244	57.2533	Europe/London	0
5790	Skeldon Airport	Skeldon	Guyana	GY	SKM	SYSK	-57.175	5.877778	America/Guyana	0
5791	Stokmarknes Skagen Airport	Stokmarknes	Norway	NO	SKN	ENSK	15.032921	68.579147	Europe/Oslo	0
5792	Sokoto Airport	Sokoto	Nigeria	NG	SKO	DNSO	5.242222	13.006389	Africa/Lagos	0
5793	Skopje International Airport	Skopje	Macedonia (FYROM)	MK	SKP	LWSK	21.625757	41.960559	Europe/Skopje	0
5794	Sekakes Airport	Sekakes	Lesotho	LS	SKQ	FXSK	28.166667	-29.65	Africa/Maseru	0
5795	Shakiso Airport	Shakiso	Ethiopia	ET	SKR	HASK	38.9728	5.6919	Africa/Addis_Ababa	0
5796	Vojens Airport	Vojens	Denmark	DK	SKS	EKSP	9.264722	55.221944	Europe/Copenhagen	0
5797	Sialkot Airport	Sialkot	Pakistan	PK	SKT	OPST	74.365498	32.536793	Asia/Karachi	0
5798	Skiros Airport	Skiros	Greece	GR	SKU	LGSY	24.566667	38.916667	Europe/Athens	0
5799	St Catherine International Airport	St Catherine	Egypt	EG	SKV	HESC	34.0625	28.685278	Africa/Cairo	0
5800	Skwentna Intermediate Airport	Skwentna	United States	US	SKW	PASW	-151.188611	61.965833	America/Anchorage	0
5801	Saransk Airport	Saransk	Russian Federation	RU	SKX	UWPS	45.216099	54.127631	Europe/Moscow	0
5802	Griffin Sandusky Airport	Sandusky	United States	US	SKY	KSKY	-83.652619	41.434295	America/New_York	0
5803	Sukkur Airport	Sukkur	Pakistan	PK	SKZ	OPSK	68.795803	27.72336	Asia/Karachi	0
5804	Martin Miguel de Guemes International Airport	Salta	Argentina	AR	SLA	SASA	-65.478493	-24.844217	America/Argentina/Buenos_Aires	0
5805	Storm Lake Municipal Airport	Storm Lake	United States	US	SLB	KSLB	-95.2	42.633333	America/Chicago	0
5806	Salt Lake City International Airport	Salt Lake City	United States	US	SLC	KSLC	-111.980673	40.785645	America/Denver	0
5807	Sliac Airport	Sliac	Slovakia	SK	SLD	LZSL	19.13442	48.637963	Europe/Bratislava	0
5808	McNary Field	Salem	United States	US	SLE	KSLE	-123.002496	44.909534	America/Los_Angeles	0
5809	Smith Field	Siloam Springs	United States	US	SLG	KSLG	-94.533333	36.183333	America/Chicago	0
5810	Vanua Lava Airport	Sola	Vanuatu	VU	SLH	NVSC	167.537003	-13.8517	Pacific/Efate	0
5811	Solwezi Airport	Solwezi	Zambia	ZM	SLI	FLSW	26.366667	-12.172222	Africa/Lusaka	0
5812	Solomon Airport	Solomon	Australia	AU	SLJ	YSOL	117.761944	-22.255278	Australia/Perth	0
5813	Adirondack Airport	Saranac Lake	United States	US	SLK	KSLK	-74.206667	44.382778	America/New_York	0
5814	Salalah International Airport	Salalah	Oman	OM	SLL	OOSA	54.089113	17.045195	Asia/Muscat	0
5815	Salamanca Airport	Salamanca	Spain and Canary Islands	ES	SLM	LESA	-5.501944	40.951944	Europe/Madrid	0
5816	Salina Regional Airport	Salina	United States	US	SLN	KSLN	-97.6525	38.790833	America/Chicago	0
5817	Leckrone Airport	Salem	United States	US	SLO	KSLO	-88.95	38.633333	America/Chicago	0
5818	Ponciano Arriaga International Airport	San Luis Potosi	Mexico	MX	SLP	MMSP	-100.931	22.254299	America/Mexico_City	0
5819	Sleetmute Airport	Sleetmute	United States	US	SLQ	PASL	-157.166667	61.705	America/Anchorage	0
5820	Sulphur Springs Airport	Sulphur Springs	United States	US	SLR	KSLR	-95.618679	33.159655	America/Chicago	0
5821	George F. L. Charles Airport	Saint Lucia	Saint Lucia	LC	SLU	TLPC	-60.99583	14.020023	America/St_Lucia	0
5822	Shimla Airport	Shimla	India	IN	SLV	VISM	77.068001	31.0818	Asia/Kolkata	0
5823	Plan de Guadalupe International Airport	Saltillo	Mexico	MX	SLW	MMIO	-100.928347	25.543326	America/Mexico_City	0
5824	Salt Cay Airport	Salt Cay	Turks and Caicos Islands	TC	SLX	MBSY	-71.201667	21.333333	America/Grand_Turk	0
5825	Salekhard Airport	Salekhard	Russian Federation	RU	SLY	USDD	66.591548	66.590358	Asia/Yekaterinburg	0
5826	Marechal Cunha Machado International Airport	Sao Luiz	Brazil	BR	SLZ	SBSL	-44.236684	-2.583316	America/Belem	0
5827	Vila Do Porto Airport	Santa Maria (Azores)	Portugal	PT	SMA	LPAZ	-25.1	36.966667	Atlantic/Azores	0
5828	Franco Bianco Airport	Cerro Sombrero	Chile	CL	SMB	SCSB	-69.333603	-52.736698	America/Santiago	0
5829	Smith Field	Fort Wayne	United States	US	SMD	KSMD	-85.152789	41.143344	America/Indiana/Indianapolis	0
5830	Lake Cumberland Regional Airport	Somerset	United States	US	SME	KSME	-84.615898	37.053398	America/New_York	0
5831	Sacramento International Airport	Sacramento	United States	US	SMF	KSMF	-121.593695	38.692283	America/Los_Angeles	0
5832	Santa Maria Airport	Santa Maria	Peru	PE	SMG	SPMR	-76.755833	-12.391389	America/Lima	0
5833	Samos Airport	Samos	Greece	GR	SMI	LGSM	26.914418	37.691448	Europe/Athens	0
5834	St. Michael Airport	Saint Michael	United States	US	SMK	PAMK	-162.111813	63.484295	America/Anchorage	0
5835	Stella Maris Airport	Stella Maris	Bahamas	BS	SML	MYLS	-75.268056	23.583333	America/Nassau	0
5836	Semporna Airport	Semporna	Malaysia	MY	SMM	WBKA	118.833333	4.416667	Asia/Kuala_Lumpur	0
5837	Lemhi County Airport	Salmon	United States	US	SMN	KSMN	-113.885913	45.115059	America/Denver	0
5838	Santa Monica Municipal Airport	Santa Monica	United States	US	SMO	KSMO	-118.449646	34.017736	America/Los_Angeles	0
5839	H. Asan Airport	Sampit	Indonesia	ID	SMQ	WAGS	112.979002	-2.502806	Asia/Jakarta	0
5840	Simon Bolivar International Airport	Santa Marta	Colombia	CO	SMR	SKSM	-74.232704	11.117132	America/Bogota	0
5841	Sainte Marie Airport	Sainte Marie	Madagascar	MG	SMS	FMMS	49.816667	-17.083333	Indian/Antananarivo	0
5842	Sorriso Airport	Sorriso	Brazil	BR	SMT	SBSO	-55.674872	-12.479939	America/Campo_Grande	0
5843	Sheep Mountain Airport	Sheep Mountain	United States	US	SMU	PASP	-147.666667	61.8	America/Anchorage	0
5844	Samedan Airport	Saint Moritz	Switzerland	CH	SMV	LSZS	9.885556	46.534722	Europe/Zurich	0
5845	Santa Maria Public Airport	Santa Maria	United States	US	SMX	KSMX	-120.457778	34.905	America/Los_Angeles	0
5846	Simenti Airport	Simenti	Senegal	SN	SMY	GOTS	-13.166667	13.166667	Africa/Dakar	0
5847	John Wayne Airport	Santa Ana	United States	US	SNA	KSNA	-117.860538	33.680201	America/Los_Angeles	0
5848	Aracati	Aracati	Brazil	BR	ARX	SBAC	-37.80472	-4.56861	America/Belem	0
5849	Snake Bay Airport	Snake Bay	Australia	AU	SNB	YSNK	130.666667	-11.416667	Australia/Darwin	0
5850	General Ulpiano Paez Airport	Salinas	Ecuador	EC	SNC	SESA	-80.991491	-2.203127	America/Guayaquil	0
5851	Preguica Airport	Sao Nicolau	Cape Verde	CV	SNE	GVSN	-24.288611	16.586944	Atlantic/Cape_Verde	0
5852	San Felipe Airport	San Felipe	Venezuela	VE	SNF	SVSP	-68.753889	10.280278	America/Caracas	0
5853	Cap. Juan Cochamanidis Airport	San Ignacio De Velasco	Bolivia	BO	SNG	SLSI	-60.962799	-16.3836	America/La_Paz	0
5854	Stanthorpe Airport	Stanthorpe	Australia	AU	SNH	YSPE	151.95	-28.65	Australia/Brisbane	0
5855	Santa Magalhaes Airport	Serra Talhada	Brazil	BR	SET	SNHS	-38.386111	-8.052778	America/Belem	0
5856	R. E. Murray Airport	Sinoe	Liberia	LR	SNI	GLGE	-9.063611	5.033056	Africa/Monrovia	0
5857	San Julian Air Base	San Julian	Cuba	CU	SNJ	MUSJ	-84.152249	22.095531	America/Havana	0
5858	Sao Joao Del Rei Airport	Sao Joao Del Rei	Brazil	BR	JDR	SNJR	-44.230097	-21.087957	America/Sao_Paulo	0
5859	Winston Field	Snyder	United States	US	SNK	KSNK	-100.9	32.716667	America/Chicago	0
5860	Shawnee Municipal Airport	Shawnee	United States	US	SNL	KSNL	-96.916667	35.333333	America/Chicago	0
5861	San Ignacio De Moxos Airport	San Ignacio de Moxos	Bolivia	BO	SNM	SLSM	-65.635556	-14.966389	America/La_Paz	0
5862	Shannon Airport	Shannon	Ireland	IE	SNN	EINN	-8.92039	52.69248	Europe/Dublin	0
5863	Sakon Nakhon Airport	Sakon Nakhon	Thailand	TH	SNO	VTUI	104.119003	17.195101	Asia/Bangkok	0
5864	Saint Paul Island Airport	Saint Paul Island	United States	US	SNP	PASN	-170.217222	57.152222	America/Anchorage	0
5865	Montoir Airport	Saint Nazaire	France	FR	SNR	LFRZ	-2.153864	47.312047	Europe/Paris	0
5866	Salinas Municipal Airport	Salinas	United States	US	SNS	KSNS	-121.610426	36.664911	America/Los_Angeles	0
5867	Sabana De Torres Airport	Sabana De Torres	Colombia	CO	SNT	SKRU	-73	7.666667	America/Bogota	0
5868	Aeroporto Brigadeiro Firmino Ayres	Patos de Paraiba	Brazil	BR	JPO	SNTS	-37.251769	-7.038944	America/Fortaleza	0
5869	Santa Clara Airport	Santa Clara	Cuba	CU	SNU	MUSC	-79.941944	22.491944	America/Havana	0
5870	Santa Elena Airport	Santa Elena	Venezuela	VE	SNV	SVSE	-61.116667	4.55	America/Caracas	0
5871	Thandwe Airport	Thandwe	Myanmar	MM	SNW	VYTD	94.30038	18.453876	Asia/Yangon	0
5872	Sidney Municipal Airport	Sidney	United States	US	SNY	KSNY	-102.9825	41.099444	America/Denver	0
5873	Paracatu	Paracatu	Brazil	BR	PYT	SNZR	-46.883098	-17.242599	America/Sao_Paulo	0
5874	Sarmellek/Balaton Airport	Sarmellek	Hungary	HU	SOB	LHSM	17.240444	46.713472	Europe/Budapest	0
5875	Adi Sumarmo International Airport	Surakarta	Indonesia	ID	SOC	WAHQ	110.749956	-7.514458	Asia/Jakarta	0
5876	Sorocaba Airport	Sorocaba	Brazil	BR	SOD	SDCO	-47.476095	-23.476313	America/Sao_Paulo	0
5877	Souanke Airport	Souanke	Congo	CG	SOE	FCOS	14.166667	2	Africa/Brazzaville	0
5878	Sofia Airport	Sofia	Bulgaria	BG	SOF	LBSF	23.414431	42.688342	Europe/Sofia	0
5879	Sogndal Airport	Sogndal	Norway	NO	SOG	ENSG	7.136988	61.158127	Europe/Oslo	0
6056	Senanga Airport	Senanga	Zambia	ZM	SXG	FLSN	23.281944	-16.119444	Africa/Lusaka	0
5880	South Molle Island Airport	South Molle Island	Australia	AU	SOI	YSML	148.583333	-20.75	Australia/Brisbane	0
5881	Sorkjosen Airport	Sorkjosen	Norway	NO	SOJ	ENSR	20.933333	69.783333	Europe/Oslo	0
5882	Semongkong Airport	Semongkong	Lesotho	LS	SOK	FXSM	28.5	-29.833333	Africa/Maseru	0
5883	San Tome Airport	San Tome	Venezuela	VE	SOM	SVST	-64.14502	8.946078	America/Caracas	0
5884	Santo International Airport	Luganville	Vanuatu	VU	SON	NVSS	167.2214	-15.5058	Pacific/Efate	0
5885	Soderhamn Airport	Soderhamn	Sweden	SE	SOO	ESNY	17.098267	61.261823	Europe/Stockholm	0
5886	Moore County Airport	Southern Pines	United States	US	SOP	KSOP	-79.388796	35.237611	America/New_York	0
5887	Sorong Airport	Sorong	Indonesia	ID	SOQ	WASS	131.290591	-0.890214	Asia/Jayapura	0
5888	Sodankyla Airport	Sodankyla	Finland	FI	SOT	EFSO	26.616667	67.383333	Europe/Helsinki	0
5889	Southampton Airport	Southampton	United Kingdom	GB	SOU	EGHI	-1.361318	50.950725	Europe/London	0
5890	Seldovia Airport	Seldovia	United States	US	SOV	PASO	-151.704167	59.4425	America/Anchorage	0
5891	Show Low Airport	Show Low	United States	US	SOW	KSOW	-110.004167	34.264444	America/Phoenix	0
5892	Sogamoso Airport	Sogamoso	Colombia	CO	SOX	SKSO	-72.933333	5.716667	America/Bogota	0
5893	Stronsay Airport	Stronsay	United Kingdom	GB	SOY	EGER	-2.641532	59.155282	Europe/London	0
5894	Solenzara Airport	Solenzara	France	FR	SOZ	LFKS	9.383333	41.883333	Europe/Paris	0
5895	Spartanburg Downtown Memorial Airport	Spartanburg	United States	US	SPA	KSPA	-81.916667	34.95	America/New_York	0
5896	La Palma Airport	Santa Cruz De La Palma	Spain and Canary Islands	ES	SPC	GCLA	-17.755556	28.626389	Atlantic/Canary	0
5897	Saidpur Airport	Saidpur	Bangladesh	BD	SPD	VGSD	88.90897	25.759272	Asia/Dhaka	0
5898	Sepulot Airport	Sepulot	Malaysia	MY	SPE	WBKO	116.456944	4.712222	Asia/Kuala_Lumpur	0
5899	Black Hills Airport	Spearfish	United States	US	SPF	KSPF	-103.866667	44.5	America/Denver	0
5900	St Pete-Albert Whitted Airport	Saint Petersburg	United States	US	SPG	KSPG	-82.625278	27.766944	America/New_York	0
5901	Sopu Airport	Sopu	Papua New Guinea	PG	SPH	AYQO	147.1659	-8.3038	Pacific/Port_Moresby	0
5902	Capital Airport	Springfield	United States	US	SPI	KSPI	-89.678889	39.844167	America/Chicago	0
5903	Sparta Airport	Sparta	Greece	GR	SPJ	LGSP	22.533333	36.983333	Europe/Athens	0
5904	Spangdahlem Air Base	Spangdahlem	Germany	DE	SPM	ETAD	6.694407	49.973876	Europe/Berlin	0
5905	Francisco C. Ada International Airport	Saipan	Northern Mariana Islands	MP	SPN	PGSN	145.729013	15.119011	Pacific/Saipan	0
5906	Menongue Airport	Menongue	Angola	AO	SPP	FNME	17.725556	-14.6375	Africa/Luanda	0
5907	San Pedro Airport	San Pedro	Belize	BZ	SPR	MZSP	-87.96571	17.917067	America/Belize	0
5908	Wichita Falls Municipal Airport/Sheppard Air Force Base	Wichita Falls	United States	US	SPS	KSPS	-98.491944	33.988333	America/Chicago	0
5909	Split Airport	Split	Croatia	HR	SPU	LDSP	16.29946	43.536525	Europe/Zagreb	0
5910	Spencer Municipal Airport	Spencer	United States	US	SPW	KSPW	-95.200833	43.163889	America/Chicago	0
5911	Sphinx International Airport	Giza	Egypt	EG	SPX	HESX	30.894444	30.109722	Africa/Cairo	0
5912	San Pedro Airport	San Pedro	Cote d'Ivoire	CI	SPY	DISP	-6.658856	4.746695	Africa/Abidjan	0
5913	Springdale Municipal Airport	Springdale	United States	US	SPZ	KSPZ	-94.166667	36.183333	America/Chicago	0
5914	Maria Reiche Neuman Airport	Nazca	Peru	PE	NZC	SPZA	-74.960174	-14.85453	America/Lima	0
5915	Santa Ynez Airport	Santa Ynez	United States	US	SQA	KIZA	-120.07556	34.60694	America/Los_Angeles	0
5916	Southern Cross Airport	Southern Cross	Australia	AU	SQC	YSCR	119.35	-31.25	Australia/Perth	0
5917	Sanqingshan Airport	Shangrao	China	CN	SQD	ZSSR	117.964167	28.379722	Asia/Shanghai	0
5918	San Luis De Palenque Airport	San Luis De Palenque	Colombia	CO	SQE	SKNP	-71.723351	5.412453	America/Bogota	0
5919	Solano Airport	Solano	Colombia	CO	SQF	SQSQ	-66.966667	2	America/Bogota	0
5920	Susilo Airport	Sintang	Indonesia	ID	SQG	WIOS	111.472328	0.063215	Asia/Jakarta	0
5921	Whiteside County Airport	Sterling	United States	US	SQI	KSQI	-89.680833	41.74	America/Chicago	0
5922	San Carlos Airport	San Carlos	United States	US	SQL	KSQL	-122.25	37.511902	America/Los_Angeles	0
5923	Emalamo Sanana Airport	Sanana	Indonesia	ID	SQN	WAPN	125.965079	-2.098013	Asia/Jayapura	0
5924	Gunnarn Airport	Storuman	Sweden	SE	SQO	ESUD	17.8	64.962222	Europe/Stockholm	0
5925	Siauliai International Airport	Siauliai	Lithuania	LT	SQQ	EYSA	23.39311	55.895292	Europe/Vilnius	0
5926	Soroako Airport	Soroako	Indonesia	ID	SQR	WAWS	121.359134	-2.531678	Asia/Jayapura	0
5927	Saposoa Airport	Saposoa	Peru	PE	SQU	SPOA	-76.75	-6.95	America/Lima	0
5928	Skive Airport	Skive	Denmark	DK	SQW	EKSV	9.17298	56.550201	Europe/Copenhagen	0
5929	Sao Miguel Do Oeste Airport	Sao Miguel Do Oeste	Brazil	BR	SQX	SSOE	-53.502778	-26.780556	America/Sao_Paulo	0
5930	Sao Lourenco Do Sul Airport	Sao Lourenco Do Sul	Brazil	BR	SQY	SSRU	-52.032222	-31.382778	America/Sao_Paulo	0
5931	Santa Rosa Airport	Santa Rosa	Brazil	BR	SRA	SSZR	-54.483333	-27.866667	America/Sao_Paulo	0
5932	Santa Rosa Airport	Santa Rosa	Bolivia	BO	SRB	SLSR	-67.333333	-10.6	America/La_Paz	0
5933	Searcy Airport	Searcy	United States	US	SRC	KSRC	-91.733333	35.25	America/Chicago	0
5934	San Ramon Airport	San Ramon	Bolivia	BO	SRD	SLRA	-64.716667	-13.283333	America/La_Paz	0
5935	Juana Azurduy de Padilla International Airport	Sucre	Bolivia	BO	SRE	SLSU	-65.293155	-19.013393	America/La_Paz	0
5936	Achmad Yani International Airport	Semarang	Indonesia	ID	SRG	WAHS	110.378549	-6.979155	Asia/Jakarta	0
5937	Sarh Airport	Sarh	Chad	TD	SRH	FTTA	18.383333	9.083333	Africa/Ndjamena	0
5938	Aji Pangeran Tumenggung Pranoto International Airport	Samarinda	Indonesia	ID	SRI	WALS	117.255556	-0.373611	Asia/Makassar	0
5939	Capitan G Q Guardia Airport	San Borja	Bolivia	BO	SRJ	SLSB	-66.833333	-14.816667	America/La_Paz	0
5940	Siorapaluk Heliport	Siorapaluk	Greenland	GL	SRK	BGSI	-70.638584	77.786526	America/Thule	0
5941	Sandringham Airport	Sandringham	Australia	AU	SRM	YSAG	139.066667	-24.05	Australia/Brisbane	0
5942	Strahan Airport	Strahan	Australia	AU	SRN	YSRN	145.316667	-42.15	Australia/Hobart	0
5943	Stord Airport	Stord	Norway	NO	SRP	ENSO	5.416667	59.833333	Europe/Oslo	0
5944	Sarasota Bradenton International Airport	Sarasota	United States	US	SRQ	KSRQ	-82.553282	27.38748	America/New_York	0
5945	San Marcos Airport	San Marcos	Colombia	CO	SRS	SQGX	-75.133333	8.65	America/Bogota	0
5946	Soroti Airport	Soroti	Uganda	UG	SRT	HUSO	33.616667	1.7	Africa/Kampala	0
5947	Rowan County Airport	Salisbury	United States	US	SRW	KRUQ	-80.483333	35.666667	America/New_York	0
5948	Dashte Naz Airport	Sary	Iran	IR	SRY	OINZ	53.197276	36.635727	Asia/Tehran	0
5949	El Trompillo Airport	Santa Cruz	Bolivia	BO	SRZ	SLET	-63.171715	-17.811047	America/La_Paz	0
5950	Deputado Luis Eduardo Magalhaes International Airport	Salvador	Brazil	BR	SSA	SBSV	-38.335196	-12.913988	America/Belem	0
5951	Christiansted Harbor Seaplane Base	Saint Croix	U.S. Virgin Islands	VI	SSB	VI32	-64.707825	17.746836	America/St_Thomas	0
5952	Shaw Air Force Base	Sumter	United States	US	SSC	KSSC	-80.47071	33.972178	America/New_York	0
5953	Cianorte Airport	Cianorte	Brazil	BR	GGH	SSCT	-52.642222	-23.691667	America/Campo_Grande	0
5954	San Felipe Airport	San Felipe	Colombia	CO	SSD	SCSF	-67.1	1.916667	America/Bogota	0
5955	Sholapur Airport	Sholapur	India	IN	SSE	VASL	75.933333	17.633333	Asia/Kolkata	0
5956	Stinson Municipal Airport	San Antonio	United States	US	SSF	KSSF	-98.469359	29.337084	America/Chicago	0
5957	Malabo Airport	Malabo	Equatorial Guinea	GQ	SSG	FGSL	8.716096	3.757791	Africa/Malabo	0
5958	Sharm El Sheikh Airport	Sharm el Sheikh	Egypt	EG	SSH	HESH	34.385253	27.979357	Africa/Cairo	0
5959	McKinnon St. Simons Island Airport	Brunswick	United States	US	SSI	KSSI	-81.390313	31.152237	America/New_York	0
5960	Stokka Airport	Sandnessjoen	Norway	NO	SSJ	ENST	12.476518	65.959944	Europe/Oslo	0
5961	Santa Rosalia Airport	Santa Rosalia	Colombia	CO	SSL	SKSL	-72.233333	1.466667	America/Bogota	0
5962	Seoul Air Base	Seoul	Republic of Korea	KR	SSN	RKSM	127.112609	37.447241	Asia/Seoul	0
5963	Sao Lourenzo Airport	Sao Lourenzo	Brazil	BR	SSO	SNLO	-45.05	-22.116667	America/Sao_Paulo	0
5964	Silver Planes Airport	Silver Planes	Australia	AU	SSP	YSVP	143.55	-13.983333	Australia/Brisbane	0
5965	La Sarre Airport	La Sarre	Canada	CA	SSQ	CSR8	-79.180253	48.913745	America/Toronto	0
5966	Sara Airport	Arongbwaratu	Vanuatu	VU	SSR	NVSH	168.153707	-15.472951	Pacific/Efate	0
5967	Santa Teresita Airport	Santa Teresita	Argentina	AR	SST	SAZL	-60.783333	-33.416667	America/Argentina/Buenos_Aires	0
5968	Tres Lagoas Airport	Tres Lagoas	Brazil	BR	TJL	SBTG	-51.681253	-20.753642	America/Campo_Grande	0
5969	M'Banza Congo Airport	M'Banza Congo	Angola	AO	SSY	FNBC	14.244167	-6.273889	Africa/Luanda	0
5970	Base Aerea de Santos Airport	Santos	Brazil	BR	SSZ	SBST	-46.30147	-23.928796	America/Sao_Paulo	0
5971	Stauning Airport	Stauning	Denmark	DK	STA	EKVJ	8.355	55.990278	Europe/Copenhagen	0
5972	L Delicias Airport	Santa Barbara Ed	Venezuela	VE	STB	SVSZ	-71.95	9.033333	America/Caracas	0
5973	St. Cloud Municipal Airport	Saint Cloud	United States	US	STC	KSTC	-94.057826	45.545616	America/Chicago	0
5974	Mayo Guerrero Airport	Santo Domingo	Venezuela	VE	STD	SVSO	-72.044116	7.570489	America/Caracas	0
5975	Stevens Point Municipal Airport	Stevens Point	United States	US	STE	KSTE	-89.530833	44.545278	America/Chicago	0
5976	Stephen Island	Stephen Island	Australia	AU	STF	YSTI	143.566667	-9.5	Australia/Brisbane	0
5977	Strathmore Airport	Strathmore	Australia	AU	STH	YSMR	142.583333	-17.833333	Australia/Brisbane	0
5978	Cibao International Airport	Santiago	Dominican Republic	DO	STI	MDST	-70.601868	19.402928	America/Santo_Domingo	0
5979	Rosecrans Memorial Airport	Saint Joseph	United States	US	STJ	KSTJ	-94.925	39.960556	America/Chicago	0
5980	Sterling Municipal Airport	Sterling	United States	US	STK	KSTK	-103.264838	40.615312	America/Denver	0
5981	St Louis Lambert International Airport	Saint Louis	United States	US	STL	KSTL	-90.379002	38.748707	America/Chicago	0
5982	Maestro Wilson Fonseca Airport	Santarem	Brazil	BR	STM	SBSN	-54.792406	-2.422362	America/Belem	0
5983	London Stansted Airport	London	United Kingdom	GB	STN	EGSS	0.262703	51.889267	Europe/London	0
5984	St. Paul Downtown Airport	Saint Paul	United States	US	STP	KSTP	-93.059998	44.934502	America/Chicago	0
5985	St. Marys Airport	Sainte Marys	United States	US	STQ	KOYM	-78.566667	41.433333	America/New_York	0
5986	Stuttgart Airport	Stuttgart	Germany	DE	STR	EDDS	9.193624	48.690732	Europe/Berlin	0
5987	Sonoma County Airport	Santa Rosa	United States	US	STS	KSTS	-122.806704	38.509962	America/Los_Angeles	0
5988	Cyril E. King Airport	Saint Thomas	U.S. Virgin Islands	VI	STT	TIST	-64.969444	18.3375	America/St_Thomas	0
5989	Surat Gujarat Airport	Surat Gujarat	India	IN	STV	VASU	72.745258	21.117658	Asia/Kolkata	0
5990	Stavropol Airport	Stavropol	Russian Federation	RU	STW	URMT	42.114278	45.109419	Europe/Moscow	0
5991	Henry E. Rohlsen Airport	Saint Croix	U.S. Virgin Islands	VI	STX	TISX	-64.798611	17.701944	America/St_Thomas	0
5992	Salto Airport	Salto	Uruguay	UY	STY	SUSO	-57.983723	-31.43704	America/Montevideo	0
5993	Confresa Airport	Santa Teresinha	Brazil	BR	STZ	SWST	-50.45	-10.300278	America/Campo_Grande	0
5994	Witham Field	Stuart	United States	US	SUA	KSUA	-80.221679	27.182892	America/New_York	0
5995	Juanda International Airport	Surabaya	Indonesia	ID	SUB	WARR	112.793782	-7.377937	Asia/Jakarta	0
5996	Stroud Airport	Stroud	United States	US	SUD	KSUD	-96.683333	35.75	America/Chicago	0
5997	Door County Airport	Sturgeon Bay	United States	US	SUE	KSUE	-87.421389	44.843889	America/Chicago	0
5998	Lamezia Terme International Airport	Lamezia-Terme	Italy	IT	SUF	LICA	16.244972	38.910015	Europe/Rome	0
5999	Surigao Airport	Surigao	Philippines	PH	SUG	RPMS	125.479167	9.758889	Asia/Manila	0
6000	Babusheri Airport	Sukhumi	Georgia	GE	SUI	UGSS	41.116667	42.866667	Asia/Tbilisi	0
6001	Satu Mare International Airport	Satu Mare	Romania	RO	SUJ	LRSM	22.883396	47.706094	Europe/Bucharest	0
6002	Sui Airport	Sui	Pakistan	PK	SUL	OPSU	69.1725	28.648889	Asia/Karachi	0
6003	Sumter Municipal Airport	Sumter	United States	US	SUM	KSMS	-80.361994	33.993316	America/New_York	0
6004	Friedman Memorial Airport	Sun Valley	United States	US	SUN	KSUN	-114.300822	43.506471	America/Denver	0
6005	Trunojoyo Airport	Sumenep	Indonesia	ID	SUP	WART	113.933333	-7.066667	Asia/Jakarta	0
6006	Sucua Airport	Sucua	Ecuador	EC	SUQ	SESC	-78.166667	-2.466667	America/Guayaquil	0
6007	Summer Beaver Airport	Summer Beaver	Canada	CA	SUR	CJV7	-88.5475	52.715278	America/Toronto	0
6008	Spirit of St. Louis Airport	Saint Louis	United States	US	SUS	KSUS	-90.65646	38.663008	America/Chicago	0
6009	Sumbawanga Airport	Sumbawanga	United Republic of Tanzania	TZ	SUT	HTSU	31.616667	-7.966667	Africa/Dar_es_Salaam	0
6010	Travis AFB	Fairfield	United States	US	SUU	KSUU	-121.936722	38.264321	America/Los_Angeles	0
6011	Nausori Airport	Suva	Fiji	FJ	SUV	NFNA	178.559816	-18.045885	Pacific/Fiji	0
6012	Richard I Bong Airport	Superior	United States	US	SUW	KSUW	-92.103333	46.691111	America/Chicago	0
6013	Sioux Gateway Airport	Sioux City	United States	US	SUX	KSUX	-96.384167	42.401944	America/Chicago	0
6014	Suntar Airport	Suntar	Russian Federation	RU	SUY	UENS	117.636111	62.184722	Asia/Yakutsk	0
6015	Savoonga Airport	Savoonga	United States	US	SVA	PASA	-170.486792	63.690931	America/Anchorage	0
6016	Sambava Airport	Sambava	Madagascar	MG	SVB	FMNS	50.175	-14.276944	Indian/Antananarivo	0
6017	Grant County Airport	Silver City	United States	US	SVC	KSVC	-108.153889	32.631944	America/Denver	0
6018	Argyle International Airport	Saint Vincent	Saint Vincent and the Grenadines	VC	SVD	TVSA	-61.149941	13.156701	America/St_Vincent	0
6019	Susanville Airport	Susanville	United States	US	SVE	KSVE	-120.572998	40.375702	America/Los_Angeles	0
6020	Save Airport	Save	Benin	BJ	SVF	DBBS	2.483333	8.033333	Africa/Porto-Novo	0
6021	Stavanger Airport Sola	Stavanger	Norway	NO	SVG	ENZV	5.629197	58.882149	Europe/Oslo	0
6022	Statesville Municipal Airport	Statesville	United States	US	SVH	KSVH	-80.951421	35.765122	America/New_York	0
6023	Eduardo Falla Solano Airport	San Vicente del Caguan	Colombia	CO	SVI	SKSV	-74.766263	2.152148	America/Bogota	0
6024	A.M. Salazar Marcano Airport	Isla De Coche	Venezuela	VE	ICC	SVIE	-64.033333	10.8	America/Caracas	0
6025	Helle Airport	Svolvaer	Norway	NO	SVJ	ENSH	14.667774	68.244983	Europe/Oslo	0
6026	Savonlinna Airport	Savonlinna	Finland	FI	SVL	EFSA	28.932545	61.944186	Europe/Helsinki	0
6027	Hunter Air Force Base	Savannah	United States	US	SVN	KSVN	-81.146012	32.010124	America/New_York	0
6028	Moscow Sheremetyevo International Airport	Moscow	Russian Federation	RU	SVO	UUEE	37.416574	55.966324	Europe/Moscow	0
6029	Kuito Airport	Kuito	Angola	AO	SVP	FNKU	16.955244	-12.3997	Africa/Luanda	0
6030	Seville Airport	Sevilla	Spain and Canary Islands	ES	SVQ	LEZL	-5.900136	37.423476	Europe/Madrid	0
6031	Savissivik Heliport	Savissivik	Greenland	GL	SVR	BGSV	-65.117578	76.018608	America/Thule	0
6032	Savusavu Airport	Savusavu	Fiji	FJ	SVU	NFNS	179.339123	-16.798828	Pacific/Fiji	0
6033	Sparrevohn Air Force Station	Sparrevohn	United States	US	SVW	PASV	-155.572222	61.0975	America/Anchorage	0
6034	Koltsovo International Airport	Yekaterinburg	Russian Federation	RU	SVX	USSS	60.804312	56.750335	Asia/Yekaterinburg	0
6035	Juan Vicente Gomez International Airport	San Antonio del Tachira	Venezuela	VE	SVZ	SVSA	-72.440059	7.839308	America/Caracas	0
6036	Jieyang Chaoshan Airport	Jieyang	China	CN	SWA	ZGOW	116.510277	23.54944	Asia/Shanghai	0
6037	Stawell Airport	Stawell	Australia	AU	SWC	YSWL	142.766667	-37.066667	Australia/Sydney	0
6038	Seward Airport	Seward	United States	US	SWD	PAWD	-149.418056	60.133333	America/Anchorage	0
6039	Stewart International Airport	Newburgh	United States	US	SWF	KSWF	-74.101045	41.49843	America/New_York	0
6040	Swan Hill Airport	Swan Hill	Australia	AU	SWH	YSWH	143.533005	-35.375801	Australia/Sydney	0
6041	Humaita Airport	Humaita	Brazil	BR	HUW	SWHT	-63.069795	-7.537679	America/Porto_Velho	0
6042	South West Bay Airport	South West Bay	Vanuatu	VU	SWJ	NVSX	167.166667	-16.25	Pacific/Efate	0
6043	San Vicente Airport	San Vicente	Philippines	PH	SWL	RPSV	119.273333	10.524722	Asia/Manila	0
6044	Searcy Field	Stillwater	United States	US	SWO	KSWO	-97.085556	36.158889	America/Chicago	0
6045	Swakopmund Airport	Swakopmund	Namibia	NA	SWP	FYSM	14.566667	-22.683333	Africa/Windhoek	0
6046	Sultan Muhammad Kaharuddin III Airport	Sumbawa Besar	Indonesia	ID	SWQ	WADS	117.414088	-8.489122	Asia/Makassar	0
6047	Swansea Airport	Swansea	United Kingdom	GB	SWS	EGFH	-4.067821	51.605299	Europe/London	0
6048	Strezhevoy Airport	Strezhevoy	Russian Federation	RU	SWT	UNSS	77.660004	60.7094	Asia/Tomsk	0
6049	Suwon Air Base	Suwon	Republic of Korea	KR	SWU	RKSW	127.006976	37.239386	Asia/Seoul	0
6050	Avenger Field	Sweetwater	United States	US	SWW	KSWW	-100.466991	32.467378	America/Chicago	0
6051	Shakawe Airport	Shakawe	Botswana	BW	SWX	FBSW	21.833333	-18.383333	Africa/Gaborone	0
6052	Sitiawan Airport	Sitiawan	Malaysia	MY	SWY	WMBA	100.700285	4.220703	Asia/Kuala_Lumpur	0
6053	Apui Airport	Apui	Brazil	BR	IUP	SWYN	-59.839599	-7.17287	America/Porto_Velho	0
6054	Strasbourg Airport	Strasbourg	France	FR	SXB	LFST	7.627674	48.544877	Europe/Paris	0
6055	Sale Airport	Sale	Australia	AU	SXE	YMES	147.140913	-38.09727	Australia/Sydney	0
6057	Sehulea Airport	Sehulea	Papua New Guinea	PG	SXH	AYSL	151.183333	-9.983333	Pacific/Port_Moresby	0
6058	Sirri Island Airport	Sirri Island	Iran	IR	SXI	OIBS	54.546614	25.902504	Asia/Tehran	0
6059	Shanshan Airport	Shanshan	China	CN	SXJ	ZWSS	90.233333	42.816667	Asia/Shanghai	0
6060	Saumlaki Olilit Airport	Saumlaki	Indonesia	ID	SXK	WAPI	131.304336	-7.988421	Asia/Jayapura	0
6061	Collooney Airport	Sligo	Ireland	IE	SXL	EISG	-8.59921	54.280201	Europe/Dublin	0
6062	Princess Juliana International Airport	Sint Maarten	Sint Maarten	SX	SXM	TNCM	-63.108646	18.041232	America/Curacao	0
6063	Sao Felix Do Araguaia Airport	Sao Felix Do Araguaia	Brazil	BR	SXO	SWFX	-50.65	-11.6	America/Campo_Grande	0
6064	Soldotna Airport	Soldotna	United States	US	SXQ	PASX	-151.036389	60.475556	America/Anchorage	0
6065	Srinagar International Airport	Srinagar	India	IN	SXR	VISR	74.762631	34.002308	Asia/Kolkata	0
6066	Sahabat 16 Airport	Sahabat 16	Malaysia	MY	SXS	WBKH	119.091667	5.089722	Asia/Kuala_Lumpur	0
6067	Taman Negara Airport	Taman Negara	Malaysia	MY	SXT	WMAN	102.396667	4.330556	Asia/Kuala_Lumpur	0
6068	Soddu Airport	Soddu	Ethiopia	ET	SXU	HASD	37.775	6.836111	Africa/Addis_Ababa	0
6069	Salem Airport	Salem	India	IN	SXV	VOSM	78.065217	11.783128	Asia/Kolkata	0
6070	Sao Felix Do Xingu Airport	Sao Felix Do Xingu	Brazil	BR	SXX	SNFX	-51.983333	-6.633333	America/Belem	0
6071	Siirt Airport	Siirt	Turkiye	TR	SXZ	LTCL	41.840439	37.978894	Europe/Istanbul	0
6072	Shemya Air Force Base	Shemya	United States	US	SYA	PASY	174.089444	52.7175	America/Adak	0
6073	Shiringayoc O Hda Mejia	Leon Velarde	Peru	PE	SYC	SPOV	-69.166667	-11.9	America/Lima	0
6074	Sydney Kingsford Smith International Airport	Sydney	Australia	AU	SYD	YSSY	151.179898	-33.932922	Australia/Sydney	0
6075	Sadah Airport	Sadah	Republic of Yemen	YE	SYE	OYSH	43.616667	16.866667	Asia/Aden	0
6076	Syangboche Airport	Syangboche	Nepal	NP	SYH	VNSB	86.6775	27.826944	Asia/Kathmandu	0
6077	Shelbyville Municipal Airport-Bomar Field	Shelbyville	United States	US	SYI	KSYI	-86.4425	35.560833	America/Chicago	0
6078	Sirjan Airport	Sirjan	Iran	IR	SYJ	OIKY	55.665193	29.551414	Asia/Tehran	0
6079	Stykkisholmur Airport	Stykkisholmur	Iceland	IS	SYK	BIST	-22.8	65.1	Atlantic/Reykjavik	0
6080	Roberts Air Force Base	San Miguel	United States	US	SYL	KSYL	-120.7	35.75	America/Los_Angeles	0
6081	Pu'er Simao Airport	Pu'er	China	CN	SYM	ZPSM	100.96222	22.796569	Asia/Shanghai	0
6082	Carleton Airport	Stanton	United States	US	SYN	KSYN	-101.8	32.133333	America/Chicago	0
6083	Shonai Airport	Shonai	Japan	JP	SYO	RJSY	139.790556	38.809444	Asia/Tokyo	0
6084	Hancock International Airport	Syracuse	United States	US	SYR	KSYR	-76.112231	43.113984	America/New_York	0
6085	Warraber Island Airport	Sue Island	Australia	AU	SYU	YWBS	142.82382	-10.207324	Australia/Brisbane	0
6086	Sylvester Airport	Sylvester	United States	US	SYV	KSYV	-83.833333	31.516667	America/New_York	0
6087	Sanya Phoenix International Airport	Sanya	China	CN	SYX	ZJSY	109.40888	18.305276	Asia/Shanghai	0
6088	Stornoway Airport	Stornoway, Outer Stat Hebrides	United Kingdom	GB	SYY	EGPO	-6.321995	58.213626	Europe/London	0
6089	Shiraz International Airport	Shiraz	Iran	IR	SYZ	OISS	52.58997	29.54613	Asia/Tehran	0
6090	Soyo Airport	Soyo	Angola	AO	SZA	FNSO	12.375155	-6.140637	Africa/Luanda	0
6091	Sultan Abdul Aziz Shah Airport	Kuala Lumpur	Malaysia	MY	SZB	WMSA	101.558078	3.130644	Asia/Kuala_Lumpur	0
6092	Semera Airport	Semera	Ethiopia	ET	SZE	HASM	40.991723	11.787483	Africa/Addis_Ababa	0
6093	Samsun-Carsamba Airport	Samsun	Turkiye	TR	SZF	LTFH	36.555057	41.257381	Europe/Istanbul	0
6094	W. A. Mozart Salzburg Airport	Salzburg	Austria	AT	SZG	LOWS	12.997331	47.791226	Europe/Vienna	0
6095	Zaisan Airport	Zaisan	Kazakhstan	KZ	SZI	UASZ	84.887255	47.487252	Asia/Almaty	0
6096	Siguanea Airport	Siguanea	Cuba	CU	SZJ	MUSN	-82.954448	21.643059	America/Havana	0
6097	Skukuza Airport	Skukuza	South Africa	ZA	SZK	FASZ	31.589516	-24.9628	Africa/Johannesburg	0
6098	Whiteman Air Force Base	Warrensburg	United States	US	SZL	KSZL	-93.547922	38.7303	America/Chicago	0
6099	Sesriem Airport	Sesriem	Namibia	NA	SZM	FYSS	15.833333	-24.583333	Africa/Windhoek	0
6100	Santa Cruz Island Airport	Santa Barbara	United States	US	SZN	KSZN	-119.915	34.060556	America/Los_Angeles	0
6101	Santa Paula Airport	Santa Paula	United States	US	SZP	KSZP	-119.060997	34.347198	America/Los_Angeles	0
6102	Stewart Island Airport	Stewart Island	New Zealand	NZ	SZS	NZRC	167.866667	-47	Pacific/Auckland	0
6103	San Cristobal de las Casas Airport	San Cristobal de las Casas	Mexico	MX	SZT	MMSC	-92.544167	16.690556	America/Mexico_City	0
6104	Segou Airport	Segou	Mali	ML	SZU	GASG	-6.283333	13.433333	Africa/Bamako	0
6105	Suzhou Airport	Suzhou	China	CN	SZV	ZSSZ	120.400833	31.2630556	Asia/Shanghai	0
6106	Parchim Airport	Schwerin	Germany	DE	SZW	EDOP	11.78091	53.430391	Europe/Berlin	0
6107	Shenzhen Bao'an International Airport	Shenzhen	China	CN	SZX	ZGSZ	113.810833	22.639444	Asia/Shanghai	0
6108	Mazury Airport	Szymany	Poland	PL	SZY	EPSY	20.937668	53.481924	Europe/Warsaw	0
6109	Goleniow Airport	Szczecin	Poland	PL	SZZ	EPSC	14.894611	53.593524	Europe/Warsaw	0
6110	A.N.R. Robinson International Airport	Tobago	Trinidad and Tobago	TT	TAB	TTCP	-60.839685	11.152541	America/Port_of_Spain	0
6111	D. Z. Romualdez Airport	Tacloban	Philippines	PH	TAC	RPVA	125.025916	11.22684	Asia/Manila	0
6112	Perry Stokes Municipal Airport	Trinidad	United States	US	TAD	KTAD	-104.336957	37.262394	America/Denver	0
6113	Daegu International Airport	Daegu	Republic of Korea	KR	TAE	RKTN	128.637874	35.899254	Asia/Seoul	0
6114	Tafaraoui Airport	Oran	Algeria	DZ	TAF	DAOL	-0.532687	35.543502	Africa/Algiers	0
6115	Bohol International Airport	Panglao	Philippines	PH	TAG	RPSP	123.770949	9.574353	Asia/Manila	0
6116	Al Janad Airport	Taiz	Republic of Yemen	YE	TAI	OYTZ	44.134345	13.685553	Asia/Aden	0
6117	Takamatsu Airport	Takamatsu	Japan	JP	TAK	RJOT	134.018252	34.219017	Asia/Tokyo	0
6118	Ralph M Calhoun Airport	Tanana	United States	US	TAL	PATA	-152.109955	65.174422	America/Anchorage	0
6119	Tampico International Airport	Tampico	Mexico	MX	TAM	MMTM	-97.870162	22.289082	America/Mexico_City	0
6120	Tangalooma Airport	Tangalooma	Australia	AU	TAN	YTGA	153.367009	-27.136848	Australia/Brisbane	0
6121	Qingdao Jiaodong International Airport	Qingdao	China	CN	TAO	ZSQD	120.088333	36.361944	Asia/Shanghai	0
6122	Tapachula International Airport	Tapachula	Mexico	MX	TAP	MMTP	-92.37022	14.794083	America/Mexico_City	0
6123	Tarcoola Airport	Tarcoola	Australia	AU	TAQ	YTAR	134.55	-30.683333	Australia/Adelaide	0
6124	Taranto-Grottaglie Airport	Taranto	Italy	IT	TAR	LIBG	17.401944	40.517778	Europe/Rome	0
6125	Tashkent International Airport	Tashkent	Uzbekistan	UZ	TAS	UTTT	69.281204	41.257893	Asia/Tashkent	0
6126	Poprad/Tatry Airport	Poprad	Slovakia	SK	TAT	LZTT	20.248118	49.073281	Europe/Bratislava	0
6127	Tauramena Airport	Tauramena	Colombia	CO	TAU	SKTA	-72.733333	5	America/Bogota	0
6128	Tacuarembo Airport	Tacuarembo	Uruguay	UY	TAW	SUTB	-55.916667	-31.75	America/Montevideo	0
6129	Tartu Airport	Tartu	Estonia	EE	TAY	EETU	26.690904	58.30969	Europe/Tallinn	0
6130	Dashoguz Airport	Dashoguz	Turkmenistan	TM	TAZ	UTAT	59.834052	41.763678	Asia/Ashgabat	0
6131	Timbiqui Airport	Timbiqui	Colombia	CO	TBD	SKMB	-77.7	2.766667	America/Bogota	0
6132	Tabiteuea Airport	Tabiteuea	Kiribati	KI	TBF	NGTE	174.78	-1.231944	Pacific/Tarawa	0
6133	Tabubil Airport	Tabubil	Papua New Guinea	PG	TBG	AYTB	141.227009	-5.274722	Pacific/Port_Moresby	0
6134	Tugdan Airport	Barangay Tugdan	Philippines	PH	TBH	RPVU	122.081968	12.315823	Asia/Manila	0
6135	New Bight Airport	Cat Island	Bahamas	BS	TBI	MYCB	-75.453611	24.315	America/Nassau	0
6136	Tabarka-Ain Draham Airport	Tabarka	Tunisia	TN	TBJ	DTKA	8.876389	36.978333	Africa/Tunis	0
6137	Timber Creek Airport	Timber Creek	Australia	AU	TBK	YTBR	130.483333	-15.65	Australia/Darwin	0
6138	Tableland Airport	Tableland	Australia	AU	TBL	YTAB	126.833333	-17.3	Australia/Perth	0
6139	Tumbang Samba Airport	Tumbang Samba	Indonesia	ID	TBM	WAGT	113.0833	-1.4694	Asia/Pontianak	0
6140	Waynesville-St. Robert Regional Airport	Fort Leonard Wood	United States	US	TBN	KTBN	-92.140556	37.741389	America/Chicago	0
6141	Tabora Airport	Tabora	United Republic of Tanzania	TZ	TBO	HTTB	32.834744	-5.073437	Africa/Dar_es_Salaam	0
6142	Capitan FAP Pedro Canga Rodriguez Airport	Tumbes	Peru	PE	TBP	SPME	-80.384033	-3.550817	America/Lima	0
6143	Statesboro-Bulloch County Airport	Statesboro	United States	US	TBR	KTBR	-81.741444	32.480883	America/New_York	0
6144	Tbilisi International Airport	Tbilisi	Georgia	GE	TBS	UGTB	44.958958	41.674063	Asia/Tbilisi	0
6145	Tabatinga International Airport	Tabatinga	Brazil	BR	TBT	SBTT	-69.939568	-4.251359	America/Rio_Branco	0
6146	Fua'amotu International Airport	Nuku'alofa	Tonga	TO	TBU	NFTF	-175.141916	-21.242181	Pacific/Tongatapu	0
6147	Tsabong Airport	Tsabong	Botswana	BW	TBY	FBTS	22.466667	-26.066667	Africa/Gaborone	0
6148	Tabriz Airport	Tabriz	Iran	IR	TBZ	OITT	46.244274	38.122849	Asia/Tehran	0
6149	Tennant Creek Airport	Tennant Creek	Australia	AU	TCA	YTNK	134.184487	-19.6409	Australia/Darwin	0
6150	Treasure Cay Airport	Treasure Cay	Bahamas	BS	TCB	MYAT	-77.372222	26.735	America/Nassau	0
6151	Tucumcari Airport	Tucumcari	United States	US	TCC	KTCC	-103.733333	35.166667	America/Denver	0
6152	Tarapaca Airport	Tarapaca	Colombia	CO	TCD	SKRA	-69.745354	-2.893984	America/Bogota	0
6153	Tulcea Airport	Tulcea	Romania	RO	TCE	LRTC	28.714956	45.064492	Europe/Bucharest	0
6154	Tacheng Airport	Tacheng	China	CN	TCG	ZWTC	83.339733	46.670595	Asia/Shanghai	0
6155	Tchibanga Airport	Tchibanga	Gabon	GA	TCH	FOOT	11	-2.816667	Africa/Libreville	0
6156	Tuscaloosa Regional Airport	Tuscaloosa	United States	US	TCL	KTCL	-87.610833	33.221111	America/Chicago	0
6157	McChord Field	Tacoma	United States	US	TCM	KTCM	-122.476581	47.138344	America/Los_Angeles	0
6158	Tehuacan Airport	Tehuacan	Mexico	MX	TCN	MMHC	-97.417778	18.499722	America/Mexico_City	0
6159	La Florida Airport	Tumaco	Colombia	CO	TCO	SKCO	-78.766667	1.816667	America/Bogota	0
6160	Taba International Airport	Taba	Egypt	EG	TCP	HETB	34.777077	29.594197	Africa/Cairo	0
6161	Tacna Airport	Tacna	Peru	PE	TCQ	SPTN	-70.278889	-18.063333	America/Lima	0
6162	Tuticorin Airport	Tuticorin	India	IN	TCR	VOTK	78.033333	8.716667	Asia/Kolkata	0
6163	Truth Or Consequences Municipal Airport	Truth or Consequences	United States	US	TCS	KTCS	-107.25	33.133333	America/Denver	0
6164	Thaba Nchu Airport	Thaba Nchu	South Africa	ZA	TCU	FATN	26.866667	-29.283333	Africa/Johannesburg	0
6165	Tocumwal Airport	Tocumwal	Australia	AU	TCW	YTOC	145.6	-35.816667	Australia/Sydney	0
6166	Tabas Airport	Tabas	Iran	IR	TCX	OIMT	56.895559	33.667169	Asia/Tehran	0
6167	Trinidad Airport	Trinidad	Colombia	CO	TDA	SKTD	-71.66323	5.42292	America/Bogota	0
6168	Teniente Jorge Henrich Arauz Airport	Trinidad	Bolivia	BO	TDD	SLTR	-64.919313	-14.822613	America/La_Paz	0
6169	Tandag Airport	Tandag	Philippines	PH	TDG	RPMW	126.171174	9.072063	Asia/Manila	0
6170	Tadjoura Airport	Tadjoura	Djibouti	DJ	TDJ	HDTJ	42.9	11.783333	Africa/Djibouti	0
6171	Taldykorgan Airport	Taldykorgan	Kazakhstan	KZ	TDK	UAAT	78.441326	45.109287	Asia/Almaty	0
6172	Tandil Airport	Tandil	Argentina	AR	TDL	SAZT	-59.083333	-37.333333	America/Argentina/Buenos_Aires	0
6173	Theda Station Airport	Theda	Australia	AU	TDN	YTHD	126.516667	-14.75	Australia/Perth	0
6174	Winlock Airport	Toledo	United States	US	TDO	KTDO	-122.85	46.433333	America/Los_Angeles	0
6175	Theodore Airport	Theodore	Australia	AU	TDR	YTDR	150.083333	-24.983333	Australia/Brisbane	0
6176	Sasereme Airport	Sasereme	Papua New Guinea	PG	TDS	AYSS	142.8681	-7.6217	Pacific/Port_Moresby	0
6177	Tanda Tula Airport	Tanda Tula	South Africa	ZA	TDT	FATD	31.3	-24.533333	Africa/Johannesburg	0
6178	Tanandava Airport	Tanandava	Madagascar	MG	TDV	FMSN	43.733333	-21.7	Indian/Antananarivo	0
6179	Tradewind Airport	Amarillo	United States	US	TDW	KTDW	-101.833333	35.216667	America/Chicago	0
6180	Trat Airport	Trat	Thailand	TH	TDX	VTBO	102.318675	12.273953	Asia/Bangkok	0
6181	Toledo Executive Airport	Toledo	United States	US	TDZ	KTDZ	-83.476711	41.56515	America/New_York	0
6182	Tela Airport	Tela	Honduras	HN	TEA	MHTE	-87.487778	15.771667	America/Tegucigalpa	0
6183	Teterboro Airport	Teterboro	United States	US	TEB	KTEB	-74.062222	40.849722	America/New_York	0
6184	Telemaco Borba Airport	Telemaco Borba	Brazil	BR	TEC	SBTL	-50.651667	-24.315833	America/Sao_Paulo	0
6185	Thisted Airport	Thisted	Denmark	DK	TED	EKTS	8.703333	57.072222	Europe/Copenhagen	0
6186	Cheikh Larbi Tebessi Airport	Tebessa	Algeria	DZ	TEE	DABS	8.124067	35.428594	Africa/Algiers	0
6187	Telfer Airport	Telfer	Australia	AU	TEF	YTEF	122.22613	-21.71113	Australia/Perth	0
6188	Tenkodogo Airport	Tenkodogo	Burkina Faso	BF	TEG	DFET	-0.316667	11.9	Africa/Ouagadougou	0
6189	Tezu Airport	Tezu	India	IN	TEI	VETJ	96.133333	27.95	Asia/Kolkata	0
6190	Telupid Airport	Telupid	Malaysia	MY	TEL	WBKE	117.116667	5.583333	Asia/Kuala_Lumpur	0
6191	Temora Airport	Temora	Australia	AU	TEM	YTEM	147.5	-34.416667	Australia/Sydney	0
6192	Tongren Airport	Tongren	China	CN	TEN	ZUTR	109.299019	27.883689	Asia/Shanghai	0
6193	Corlu Airport	Tekirdag	Turkiye	TR	TEQ	LTBU	27.5	40.966667	Europe/Istanbul	0
6194	Lajes Field	Terceira	Portugal	PT	TER	LPLA	-27.08757	38.754075	Atlantic/Azores	0
6195	Tessenei Airport	Tessenei	Eritrea	ER	TES	HHTS	36.683333	15.116667	Africa/Asmara	0
6196	Matundo Airport	Tete	Mozambique	MZ	TET	FQTT	33.638889	-16.103333	Africa/Maputo	0
6197	Manapouri Airport	Te Anau	New Zealand	NZ	TEU	NZMO	167.643093	-45.532876	Pacific/Auckland	0
6198	Teruel Airport	Teruel	Spain and Canary Islands	ES	TEV	LETL	-1.2175	40.411944	Europe/Madrid	0
6199	Telluride Regional Airport	Telluride	United States	US	TEX	KTEX	-107.901005	37.95354	America/Denver	0
6200	Thingeyri Airport	Thingeyri	Iceland	IS	TEY	BITE	-23.45	65.883333	Atlantic/Reykjavik	0
6201	Tefe Airport	Tefe	Brazil	BR	TFF	SBTF	-64.724217	-3.379786	America/Porto_Velho	0
6202	Tenerife North Airport	Tenerife	Spain and Canary Islands	ES	TFN	GCXO	-16.345982	28.488057	Atlantic/Canary	0
6203	Tenerife South Airport	Tenerife	Spain and Canary Islands	ES	TFS	GCTS	-16.5725	28.044444	Atlantic/Canary	0
6204	Chengdu Tianfu International Airport	Chengdu	China	CN	TFU	ZUTF	104.44186	30.314195	Asia/Shanghai	0
6205	Tarfaya Airport	Tarfaya	Morocco	MA	TFY	WILP	-12.916667	27.916667	Africa/Casablanca	0
6206	Tengah Airport	Singapore	Singapore	SG	TGA	WSAT	103.711557	1.389724	Asia/Singapore	0
6207	Tanjung Manis Airport	Sarikei	Malaysia	MY	TGC	WBTM	111.203344	2.176315	Asia/Kuala_Lumpur	0
6208	Podgorica Airport	Podgorica	Montenegro	ME	TGD	LYPG	19.246024	42.368023	Europe/Podgorica	0
6209	Sultan Mahmud Airport	Kuala Terengganu	Malaysia	MY	TGG	WMKN	103.104434	5.379951	Asia/Kuala_Lumpur	0
6210	Tongoa Airport	Tongoa	Vanuatu	VU	TGH	NVST	168.550995	-16.8911	Pacific/Efate	0
6211	Tingo Maria Airport	Tingo Maria	Peru	PE	TGI	SPGM	-76.005526	-9.292779	America/Lima	0
6212	Tiga Airport	Tiga	New Caledonia	NC	TGJ	NWWA	167.802935	-21.098359	Pacific/Noumea	0
6213	Taganrog Yuzhny Airport	Taganrog	Russian Federation	RU	TGK	URRT	38.849167	47.198333	Europe/Moscow	0
6214	Transilvania Airport	Targu-Mures	Romania	RO	TGM	LRTM	24.412525	46.467719	Europe/Bucharest	0
6215	La Trobe Regional Airport	Traralgon	Australia	AU	TGN	YLTV	146.470001	-38.207199	Australia/Sydney	0
6216	Tongliao Airport	Tongliao	China	CN	TGO	ZBTL	122.204604	43.557011	Asia/Shanghai	0
6217	Podkamennaya Tunguska Airport	Bor	Russian Federation	RU	TGP	UNIP	89.97945	61.59	Asia/Krasnoyarsk	0
6218	Touggourt Airport	Touggourt	Algeria	DZ	TGR	DAUK	6.089239	33.066948	Africa/Algiers	0
6219	Tanga Airport	Tanga	United Republic of Tanzania	TZ	TGT	HTTG	39.071669	-5.092163	Africa/Dar_es_Salaam	0
6220	Toncontin Airport	Tegucigalpa	Honduras	HN	TGU	MHTG	-87.219716	14.060123	America/Tegucigalpa	0
6221	Angel Albino Corzo International Airport	Tuxtla Gutierrez	Mexico	MX	TGZ	MMTG	-93.0225	16.563611	America/Mexico_City	0
6222	Northern Airport	Tullahoma	United States	US	THA	KTHA	-86.183333	35.366667	America/Chicago	0
6223	Thaba-Tseka Airport	Thaba-Tseka	Lesotho	LS	THB	FXTA	29.5	-28.833333	Africa/Maseru	0
6224	Tchien Airport	Tchien	Liberia	LR	THC	GLTN	-8.133333	6.066667	Africa/Monrovia	0
6225	Bai Thuong Airport	Thanh Hoa	Viet Nam	VN	THD	VVTX	105.46917	19.9025	Asia/Ho_Chi_Minh	0
6226	Teresina Airport	Teresina	Brazil	BR	THE	SBTE	-42.821085	-5.06335	America/Belem	0
6227	Thangool Airport	Thangool	Australia	AU	THG	YTNG	150.576387	-24.494162	Australia/Brisbane	0
6228	Tichitt Airport	Tichitt	Mauritania	MR	THI	GQNC	-9.5	18.45	Africa/Nouakchott	0
6229	Thakhek Airport	Thakhek	Lao People's Democratic Republic	LA	THK	VLTK	104.816667	17.4	Asia/Vientiane	0
6230	Tachilek Airport	Tachilek	Myanmar	MM	THL	VYTL	99.934535	20.48443	Asia/Yangon	0
6231	Trollhattan Airport	Trollhattan	Sweden	SE	THN	ESGT	12.3	58.266667	Europe/Stockholm	0
6232	Thorshofn Airport	Thorshofn	Iceland	IS	THO	BITN	-15.332381	66.220705	Atlantic/Reykjavik	0
6233	Hot Springs Airport	Thermopolis	United States	US	THP	KTHP	-108.216667	43.65	America/Denver	0
6234	Tehran Mehrabad International Airport	Tehran	Iran	IR	THR	OIII	51.321868	35.691534	Asia/Tehran	0
6235	Sukhothai Airport	Sukhothai	Thailand	TH	THS	VTPO	99.822222	17.223056	Asia/Bangkok	0
6236	Tamchakett Airport	Tamchakett	Mauritania	MR	THT	GQNT	-10.816667	17.233333	Africa/Nouakchott	0
6237	Thule Air Base	Pituffik	Greenland	GL	THU	BGTL	-68.7	76.533333	America/Thule	0
6238	York Airport	York	United States	US	THV	KTHV	-76.873739	39.918128	America/New_York	0
6239	Turukhansk Airport	Turukhansk	Russian Federation	RU	THX	UOTT	87.935278	65.797222	Asia/Krasnoyarsk	0
6240	Tahoua Airport	Tahoua	Niger	NE	THZ	DRRT	5.263889	14.872778	Africa/Niamey	0
6241	Tirana International Airport	Tirana	Albania	AL	TIA	LATI	19.71328	41.419133	Europe/Tirane	0
6242	Tibu Airport	Tibu	Colombia	CO	TIB	SKTB	-72.733333	8.633333	America/Bogota	0
6243	Bouchekif Airport	Tiaret	Algeria	DZ	TID	DAOB	1.46946	35.343274	Africa/Algiers	0
6244	Tippi Airport	Tippi	Ethiopia	ET	TIE	HATP	35.415278	7.201111	Africa/Addis_Ababa	0
6245	Taif Airport	Taif	Saudi Arabia	SA	TIF	OETF	40.552684	21.480364	Asia/Riyadh	0
6246	Tikehau Atoll Airport	Tikehau Atoll	French Polynesia	PF	TIH	NTGC	-148.233789	-15.118639	Pacific/Tahiti	0
6247	Tereen Airport	Tarin Kot	Afghanistan	AF	TII	OATN	65.633333	32.866667	Asia/Kabul	0
6248	Tijuana International Airport	Tijuana	Mexico	MX	TIJ	MMTJ	-116.975924	32.544303	America/Tijuana	0
6249	Tinker Air Force Base	Oklahoma City	United States	US	TIK	KTIK	-97.383333	35.416667	America/Chicago	0
6250	Timika Airport	Tembagapura	Indonesia	ID	TIM	WAYY	136.887486	-4.525666	Asia/Jayapura	0
6251	Tindouf Airport	Tindouf	Algeria	DZ	TIN	DAOF	-8.163246	27.701163	Africa/Algiers	0
6252	Tilin Airport	Tilin	Myanmar	MM	TIO	VYHN	96	20	Asia/Yangon	0
6253	Tripoli International Airport	Tripoli	Libya	LY	TIP	HLLT	13.144279	32.66989	Africa/Tripoli	0
6254	Tinian International Airport	Tinian	Northern Mariana Islands	MP	TIQ	PGWT	145.626344	14.994319	Pacific/Saipan	0
6255	Tirupati Airport	Tirupati	India	IN	TIR	VOTP	79.542929	13.635721	Asia/Kolkata	0
6256	Thursday Island Airport	Thursday Island	Australia	AU	TIS	YTUD	142.05	-10.5	Australia/Brisbane	0
6257	Timaru Airport	Timaru	New Zealand	NZ	TIU	NZTU	171.226325	-44.303446	Pacific/Auckland	0
6258	Tivat Airport	Tivat	Montenegro	ME	TIV	LYTV	18.725556	42.403611	Europe/Podgorica	0
6259	Tacoma Narrows Airport	Tacoma	United States	US	TIW	KTIW	-122.576477	47.267632	America/Los_Angeles	0
6260	Space Center Executive Airport	Titusville	United States	US	TIX	KTIX	-80.799444	28.512222	America/New_York	0
6261	Tidjikja Airport	Tidjikja	Mauritania	MR	TIY	GQND	-11.416667	18.566667	Africa/Nouakchott	0
6262	Tari Airport	Tari	Papua New Guinea	PG	TIZ	AYTA	142.940556	-5.860556	Pacific/Port_Moresby	0
6263	Capitan Oriel Lea Plaza Airport	Tarija	Bolivia	BO	TJA	SLTJ	-64.709102	-21.548009	America/La_Paz	0
6264	Tanjung Balai Airport	Tanjung Balai	Indonesia	ID	TJB	WIDT	103.3942	1.0525	Asia/Jakarta	0
6265	Warukin Airport	Tanjung	Indonesia	ID	TJG	WAON	115.435997	-2.21656	Asia/Makassar	0
6266	Tajima Airport	Toyooka	Japan	JP	TJH	RJBT	134.787674	35.51366	Asia/Tokyo	0
6267	Capiro Airport	Trujillo	Honduras	HN	TJI	MHTJ	-85.939444	15.925833	America/Tegucigalpa	0
6268	Tokat Airport	Tokat	Turkiye	TR	TJK	LTAW	36.363533	40.30402	Europe/Istanbul	0
6269	Roshchino International Airport	Tyumen	Russian Federation	RU	TJM	USTR	65.350246	57.181826	Asia/Yekaterinburg	0
6270	Takume Airport	Takume	French Polynesia	PF	TJN	NTKM	-142.266944	-15.850556	Pacific/Tahiti	0
6271	Bulutumbang Airport	Tanjung Pandan	Indonesia	ID	TJQ	WIKT	107.754997	-2.74572	Asia/Jakarta	0
6272	Tanjung Harapan Airport	Tanjung Selor	Indonesia	ID	TJS	WALG	117.373611	2.836389	Asia/Makassar	0
6273	Kulyab Airport	Kulyab	Tajikistan	TJ	TJU	UTDK	69.80666	37.988335	Asia/Dushanbe	0
6274	Talkeetna Airport	Talkeetna	United States	US	TKA	PATK	-150.09	62.322222	America/Anchorage	0
6275	Tiko Airport	Tiko	Cameroon	CM	TKC	FKKC	9.333333	4.116667	Africa/Douala	0
6276	Takoradi Airport	Takoradi	Ghana	GH	TKD	DGTK	-1.77476	4.89606	Africa/Accra	0
6277	Truckee Tahoe Airport	Truckee	United States	US	TKF	KTRK	-120.140502	39.317892	America/Los_Angeles	0
6278	Radin Inten II Airport	Bandar Lampung	Indonesia	ID	TKG	WILL	105.175795	-5.242783	Asia/Jakarta	0
6279	Takhli Airport	Takhli	Thailand	TH	TKH	VTPI	100.312602	15.263263	Asia/Bangkok	0
6280	Tok Airport	Tok	United States	US	TKJ	PATJ	-143.001111	63.303333	America/Anchorage	0
6281	Chuuk International Airport	Truk, Caroline Islands	Micronesia	FM	TKK	PTKK	151.842005	7.457446	Pacific/Chuuk	0
6282	Tokunoshima Airport	Tokunoshima	Japan	JP	TKN	RJKN	128.883333	27.833333	Asia/Tokyo	0
6283	Tlokoeng Airport	Tlokoeng	Lesotho	LS	TKO	FXTK	28.883333	-29.233333	Africa/Maseru	0
6284	Takapoto Airport	Takapoto	French Polynesia	PF	TKP	NTGT	-145.246002	-14.7095	Pacific/Tahiti	0
6285	Kigoma Airport	Kigoma	United Republic of Tanzania	TZ	TKQ	HTKA	29.67	-4.885	Africa/Dar_es_Salaam	0
6286	Tokushima Awaodori Airport	Tokushima	Japan	JP	TKS	RJOS	134.594826	34.139024	Asia/Tokyo	0
6287	Tak Airport	Tak	Thailand	TH	TKT	VTPT	99.152222	16.878333	Asia/Bangkok	0
6288	Turku Airport	Turku	Finland	FI	TKU	EFTU	22.272771	60.512348	Europe/Helsinki	0
6289	Takaroa Airport	Takaroa	French Polynesia	PF	TKX	NTKR	-145.026392	-14.457749	Pacific/Tahiti	0
6290	Turkey Creek Airport	Turkey Creek	Australia	AU	TKY	YTKY	128.25	-17.066667	Australia/Perth	0
6291	Tokoroa Airfield	Tokoroa	New Zealand	NZ	TKZ	NZTO	175.89549	-38.238476	Pacific/Auckland	0
6292	Teller Airport	Teller	United States	US	TLA	PATE	-166.339389	65.240389	America/Anchorage	0
6293	Toluca International Airport	Toluca	Mexico	MX	TLC	MMTO	-99.565748	19.336622	America/Mexico_City	0
6294	Limpopo Valley Airfield	Tuli Block	Botswana	BW	TLD	FBLV	29.116667	-22.183333	Africa/Gaborone	0
6295	Toliara Airport	Toliara	Madagascar	MG	TLE	FMST	43.723888	-23.38882	Indian/Antananarivo	0
6296	Tulaghi Heliport	Tulaghi	Solomon Islands	SB	TLG	AGTI	160.149159	-9.108003	Pacific/Guadalcanal	0
6297	Tallahassee International Airport	Tallahassee	United States	US	TLH	KTLH	-84.34444	30.395783	America/New_York	0
6298	Sultan Bantilan Airport	Toli Toli	Indonesia	ID	TLI	WAFL	120.793618	1.122492	Asia/Makassar	0
6299	Tatalina Air Force Station	Tatalina	United States	US	TLJ	PATL	-155.9772	62.89	America/Anchorage	0
6300	Tallinn Airport	Tallinn	Estonia	EE	TLL	EETN	24.798703	59.416622	Europe/Tallinn	0
6301	Zenata Airport	Tlemcen	Algeria	DZ	TLM	DAON	-1.45	35.016667	Africa/Algiers	0
6302	Hyeres Airport	Toulon	France	FR	TLN	LFTH	6.159303	43.093489	Europe/Paris	0
6303	Turpan Jiaohe Airport	Turpan	China	CN	TLQ	ZWTL	89.074545	43.019961	Asia/Shanghai	0
6304	Mefford Field	Tulare	United States	US	TLR	KTLR	-119.326001	36.156302	America/Los_Angeles	0
6305	Toulouse-Blagnac Airport	Toulouse	France	FR	TLS	LFBO	1.374321	43.630071	Europe/Paris	0
6306	Golfo de Morrosquillo Airport	Tolu	Colombia	CO	TLU	SKTL	-75.585763	9.509446	America/Bogota	0
6307	Tel Aviv Ben Gurion International Airport	Tel Aviv-Yafo	Israel	IL	TLV	LLBG	34.870741	32.000454	Asia/Jerusalem	0
6308	Talca Airport	Talca	Chile	CL	TLX	SCTL	-71.666667	-35.466667	America/Santiago	0
6309	Plastun Airport	Plastun	Russian Federation	RU	TLY	UHWP	136.289279	44.81465	Asia/Vladivostok	0
6310	Henry Tift Myers Airport	Tifton	United States	US	TMA	KTMA	-83.483333	31.433333	America/New_York	0
6311	Miami Executive Airport	Miami	United States	US	TMB	KTMB	-80.433333	25.65	America/New_York	0
6312	Tambolaka Airport	Tambolaka	Indonesia	ID	TMC	WATK	119.244003	-9.40972	Asia/Makassar	0
6313	Timbedra Airport	Timbedra	Mauritania	MR	TMD	GQNH	-8.154167	16.236667	Africa/Nouakchott	0
6314	Gabriel Vargas Santos Airport	Tame	Colombia	CO	TME	SKTM	-71.752051	6.454619	America/Bogota	0
6315	Thimarafushi Airport	Thimarafushi	Maldives	MV	TMF	VRNT	73.149312	2.211622	Indian/Maldives	0
6316	Tomanggong Airport	Tomanggong	Malaysia	MY	TMG	WBKM	118.65	5.4	Asia/Kuala_Lumpur	0
6317	Tanahmerah Airport	Tanahmerah	Indonesia	ID	TMH	WAKT	140.305916	-6.096228	Asia/Jayapura	0
6318	Tumling Tar Airport	Tumling Tar	Nepal	NP	TMI	VNTR	87.2	27.3	Asia/Kathmandu	0
6319	Termez Airport	Termez	Uzbekistan	UZ	TMJ	UTST	67.318954	37.280501	Asia/Tashkent	0
6320	Tamale Airport	Tamale	Ghana	GH	TML	DGLE	-0.876603	9.409979	Africa/Accra	0
6321	Tamatave Airport	Tamatave	Madagascar	MG	TMM	FMMT	49.392222	-18.11	Indian/Antananarivo	0
6322	Tamana Island Airport	Tamana Island	Kiribati	KI	TMN	NGTM	175.9681	-2.4858	Pacific/Tarawa	0
6323	Tumeremo Airport	Tumeremo	Venezuela	VE	TMO	SVTM	-61.5	7.3	America/Caracas	0
6324	Tampere-Pirkkala Airport	Tampere	Finland	FI	TMP	EFTP	23.617564	61.420449	Europe/Helsinki	0
6325	Tambao Airport	Tambao	Burkina Faso	BF	TMQ	DFEM	0.083333	14.783333	Africa/Ouagadougou	0
6326	Aguenar Airport	Tamanrasset	Algeria	DZ	TMR	DAAT	5.44912	22.813283	Africa/Algiers	0
6327	Sao Tome Island Airport	Sao Tome Island	Sao Tome and Principe	ST	TMS	FPST	6.725	0.378333	Africa/Sao_Tome	0
6328	Trombetas Airport	Trombetas	Brazil	BR	TMT	SBTB	-56.396801	-1.4896	America/Belem	0
6329	Tambor Airport	Tambor	Costa Rica	CR	TMU	MRTR	-85.016222	9.739357	America/Costa_Rica	0
6330	Tamworth Airport	Tamworth	Australia	AU	TMW	YSTW	150.848496	-31.0845	Australia/Sydney	0
6331	Timimoun Airport	Timimoun	Algeria	DZ	TMX	DAUT	0.284086	29.24174	Africa/Algiers	0
6332	Tiom Airport	Tiom	Indonesia	ID	TMY	WAVT	138.416667	-3.95	Asia/Jayapura	0
6333	Thames Aerodrome	Thames	New Zealand	NZ	TMZ	NZTH	175.553626	-37.16259	Pacific/Auckland	0
6334	Jinan Yaoqiang International Airport	Jinan	China	CN	TNA	ZSJN	117.206881	36.857689	Asia/Shanghai	0
6335	Tanahgrogot Airport	Tanahgrogot	Indonesia	ID	TNB	WALH	116.2	-1.916667	Asia/Makassar	0
6336	Tin City Air Force Station	Tin City	United States	US	TNC	PATC	-167.918889	65.563889	America/Anchorage	0
6337	New Tanegashima Airport	Nakatane	Japan	JP	TNE	RJFG	130.9929	30.604837	Asia/Tokyo	0
6338	Toussus-le-Noble Airport	Toussus-le-Noble	France	FR	TNF	LFPN	2.113056	48.750833	Europe/Paris	0
6339	Tangier Ibn Battouta Airport	Tangier	Morocco	MA	TNG	GMTT	-5.912898	35.726286	Africa/Casablanca	0
6340	Tonghua Sanyuanpu Airport	Sanyuanpu	China	CN	TNH	ZYTN	125.703889	42.253889	Asia/Shanghai	0
6341	Satna Airport	Satna	India	IN	TNI	VIST	80.85181	24.564325	Asia/Kolkata	0
6342	Raja Haji Fisabilillah Airport	Tanjung Pinang	Indonesia	ID	TNJ	WIDN	104.531998	0.922683	Asia/Jakarta	0
6343	Ternopol Airport	Ternopol	Ukraine	UA	TNL	UKLT	25.6	49.566667	Europe/Kiev	0
6344	Teniente R. Marsh Martin Airport	King George Island	Antarctica	AQ	TNM	SCRM	-58.986389	-62.190556	Antarctica/Palmer	0
6345	Tainan Airport	Tainan	Taiwan	TW	TNN	RCNN	120.215712	22.948705	Asia/Taipei	0
6346	Tamarindo Airport	Tamarindo	Costa Rica	CR	TNO	MRTM	-85.812226	10.31587	America/Costa_Rica	0
6347	Twentynine Palms Airport	Twentynine Palms	United States	US	TNP	KTNP	-115.935	34.118889	America/Los_Angeles	0
6348	Antananarivo Ivato International Airport	Antananarivo	Madagascar	MG	TNR	FMMI	47.475028	-18.799632	Indian/Antananarivo	0
6349	Cantung Airport	Tungsten	Canada	CA	TNS	CBX5	-128.203003	61.956902	America/Edmonton	0
6350	Dade Collier Training and Transition Airport	Miami	United States	US	TNT	KTNT	-80.895721	25.86081	America/New_York	0
6351	Newton Municipal Airport	Newton	United States	US	TNU	KTNU	-93.05	41.7	America/Chicago	0
6352	Fanning Island Airport	Tabuaeran	Kiribati	KI	TNV	PLFA	-159.35	3.833333	Pacific/Kiritimati	0
6353	Stung Treng Airport	Stung Treng	Cambodia	KH	TNX	VDST	106.033333	13.533333	Asia/Phnom_Penh	0
6354	Tosontsengel Airport	Tosontsengel	Mongolia	MN	TNZ	ZMTL	98.275278	48.739722	Asia/Ulaanbaatar	0
6355	Zamperini Field	Torrance	United States	US	TOA	KTOA	-118.341548	33.801676	America/Los_Angeles	0
6356	R.G. LeTourneau Field	Toccoa	United States	US	TOC	KTOC	-83.295799	34.5938	America/New_York	0
6357	Tioman Airport	Tioman	Malaysia	MY	TOD	WMBT	104.159803	2.818021	Asia/Kuala_Lumpur	0
6358	Tozeur Nefta International Airport	Tozeur	Tunisia	TN	TOE	DTTZ	8.11056	33.939701	Africa/Tunis	0
6359	Tomsk Bogashevo Airport	Tomsk	Russian Federation	RU	TOF	UNTT	85.208298	56.380299	Asia/Tomsk	0
6360	Togiak Village Airport	Togiak Village	United States	US	TOG	PATG	-160.397728	59.05292	America/Anchorage	0
6361	Torres Airstrip	Torres	Vanuatu	VU	TOH	NVSD	166.75	-13.166667	Pacific/Efate	0
6362	Troy Municipal Airport	Troy	United States	US	TOI	KTOI	-85.966667	31.8	America/Chicago	0
6363	Torrejon Air Force Base	Madrid	Spain and Canary Islands	ES	TOJ	LETO	-3.44587	40.4967	Europe/Madrid	0
6364	Toledo Express Airport	Toledo	United States	US	TOL	KTOL	-83.806898	41.592497	America/New_York	0
6365	Tombouctou Airport	Tombouctou	Mali	ML	TOM	GATB	-3.005278	16.732222	Africa/Bamako	0
6366	San Vito Airport	San Vito	Costa Rica	CR	TOO	MRSV	-82.966667	8.833333	America/Costa_Rica	0
6367	Philip Billard Municipal Airport	Topeka	United States	US	TOP	KTOP	-95.6225	39.069722	America/Chicago	0
6368	Barriles Airport	Tocopilla	Chile	CL	TOQ	SCBE	-70.061389	-22.136111	America/Santiago	0
6369	Torrington Municipal Airport	Torrington	United States	US	TOR	KTOR	-104.183333	42.066667	America/Denver	0
6370	Tromso/Langnes Airport	Tromso	Norway	NO	TOS	ENTC	18.907343	69.679835	Europe/Oslo	0
6371	Totness Airport	Totness	Suriname	SR	TOT	SMCO	-56.327493	5.865832	America/Paramaribo	0
6372	Touho Airport	Touho	New Caledonia	NC	TOU	NWWU	165.25	-20.8	Pacific/Noumea	0
6373	Luis dal Canalle Filho Airport	Toledo	Brazil	BR	TOW	SBTD	-53.697497	-24.6863	America/Sao_Paulo	0
6374	Toyama Airport	Toyama	Japan	JP	TOY	RJNT	137.189456	36.642447	Asia/Tokyo	0
6375	Mahana Airport	Touba	Cote d'Ivoire	CI	TOZ	DITM	-7.673662	8.29326	Africa/Abidjan	0
6376	Tampa International Airport	Tampa	United States	US	TPA	KTPA	-82.535415	27.979869	America/New_York	0
6377	Tarapoa Airport	Tarapoa	Ecuador	EC	TPC	SETR	-76.337777	-1.227777	America/Guayaquil	0
6378	Taiwan Taoyuan International Airport	Taipei	Taiwan	TW	TPE	RCTP	121.23248	25.075512	Asia/Taipei	0
6379	Peter O. Knight Airport	Tampa	United States	US	TPF	KTPF	-82.446688	27.915572	America/New_York	0
6380	Taiping Airport	Taiping	Malaysia	MY	TPG	WMBI	100.733333	4.85	Asia/Kuala_Lumpur	0
6381	Tonopah Airport	Tonopah	United States	US	TPH	KTPH	-117.233333	38.066667	America/Los_Angeles	0
6382	Taplejung Airport	Taplejung	Nepal	NP	TPJ	VNTJ	87.683333	27.35	Asia/Kathmandu	0
6383	Tapaktuan Airport	Tapaktuan	Indonesia	ID	TPK	WIMT	97.183333	3.266667	Asia/Jakarta	0
6384	Draughon-Miller Airport	Temple	United States	US	TPL	KTPL	-97.409167	31.150278	America/Chicago	0
6385	Tiputini Airport	Tiputini	Ecuador	EC	TPN	SETI	-75.533333	-0.766667	America/Guayaquil	0
6386	Cad. FAP Guillermo del Castillo Paredes Airport	Tarapoto	Peru	PE	TPP	SPST	-76.369621	-6.512208	America/Lima	0
6387	Amado Nervo Airport	Tepic	Mexico	MX	TPQ	MMEP	-104.842575	21.419445	America/Mazatlan	0
6388	Tom Price Airport	Tom Price	Australia	AU	TPR	YTMP	117.666667	-22.75	Australia/Perth	0
6389	Trapani-Birgi Airport	Trapani	Italy	IT	TPS	LICT	12.495865	37.901385	Europe/Rome	0
6390	Tikapur Airport	Tikapur	Nepal	NP	TPU	VNTP	81.191667	28.55	Asia/Kathmandu	0
6391	Tupai Airport	Tupai	French Polynesia	PF	TPX	NTTU	-151.833333	-16.283333	Pacific/Tahiti	0
6392	Tasiusaq Heliport (Upernavik)	Tasiusaq	Greenland	GL	TQA	BGTA	-56.060278	73.373056	America/Godthab	0
6393	Tiniteqilaaq Heliport	Tiniteqilaaq	Greenland	GL	TQI	BGTN	-37.783347	65.892015	America/Godthab	0
6394	Tarko-Sale Airport	Tarko-Sale	Russian Federation	RU	TQL	USDS	77.790755	64.92203	Asia/Yekaterinburg	0
6395	Taluquan Airport	Taluquan	Afghanistan	AF	TQN	OATQ	69.533333	36.766667	Asia/Kabul	0
6396	Maranggo Airport	Tomia	Indonesia	ID	TQQ	WAWC	123.919596	-5.767236	Asia/Makassar	0
6397	Tres Esquinas Airport	Tres Esquinas	Colombia	CO	TQS	SKTQ	-75.233333	0.733333	America/Bogota	0
6398	Tarama Airport	Taramajima	Japan	JP	TRA	RORT	124.676793	24.653795	Asia/Tokyo	0
6399	Gonzalo Airport	Turbo	Colombia	CO	TRB	SKTU	-76.748056	8.078333	America/Bogota	0
6400	Francisco Sarabia International Airport	Torreon	Mexico	MX	TRC	MMTC	-103.398741	25.563066	America/Mexico_City	0
6401	Trondheim Airport Vaernes	Trondheim	Norway	NO	TRD	ENVA	10.917863	63.454285	Europe/Oslo	0
6402	Tiree Airport	Tiree, Inner Hebrides	United Kingdom	GB	TRE	EGPU	-6.871389	56.500556	Europe/London	0
6403	Torp Sandefjord Airport	Sandefjord	Norway	NO	TRF	ENTO	10.251807	59.178087	Europe/Oslo	0
6404	Tauranga City Airport	Tauranga	New Zealand	NZ	TRG	NZTG	176.195999	-37.671902	Pacific/Auckland	0
6405	Tri-Cities Regional Airport	Bristol, VA/Johnson City/Kingsport	United States	US	TRI	KTRI	-82.407852	36.481109	America/New_York	0
6406	Juwata International Airport	Tarakan	Indonesia	ID	TRK	WAQQ	117.568603	3.326377	Asia/Makassar	0
6407	Terrell Municipal Airport	Terrell	United States	US	TRL	KTRL	-96.267403	32.709202	America/Chicago	0
6408	Jacqueline Cochran Regional Airport	Thermal	United States	US	TRM	KTRM	-116.15863	33.639217	America/Los_Angeles	0
6409	Turin Airport	Turin	Italy	IT	TRN	LIMF	7.643049	45.191455	Europe/Rome	0
6410	Taree Airport	Taree	Australia	AU	TRO	YTRE	152.508964	-31.890273	Australia/Sydney	0
6411	Tarauaca Airport	Tarauaca	Brazil	BR	TRQ	SBTK	-70.75	-8.1	America/Rio_Branco	0
6412	China Bay Airport	Trincomalee	Sri Lanka	LK	TRR	VCCT	81.181889	8.538984	Asia/Colombo	0
6413	Trieste - Friuli Venezia Giulia Airport	Trieste	Italy	IT	TRS	LIPQ	13.485678	45.820781	Europe/Rome	0
6414	Trujillo Airport	Trujillo	Peru	PE	TRU	SPRU	-79.115	-8.09	America/Lima	0
6415	Trivandrum International Airport	Thiruvananthapuram	India	IN	TRV	VOTV	76.91907	8.476126	Asia/Kolkata	0
6416	Bonriki Airport	Tarawa	Kiribati	KI	TRW	NGTA	173.147003	1.38164	Pacific/Tarawa	0
6417	Trenton Memorial Airport	Trenton	United States	US	TRX	KTRX	-93.616667	40.083333	America/Chicago	0
6418	Tororo Airport	Tororo	Uganda	UG	TRY	HUTO	34.183333	0.7	Africa/Kampala	0
6419	Tiruchirapalli International Airport	Tiruchirappalli	India	IN	TRZ	VOTR	78.707241	10.762168	Asia/Kolkata	0
6420	Taipei Songshan Airport	Taipei	Taiwan	TW	TSA	RCSS	121.551924	25.062789	Asia/Taipei	0
6421	Tsumeb Airport	Tsumeb	Namibia	NA	TSB	FYTM	17.733333	-19.266667	Africa/Windhoek	0
6422	Taisha Airport	Taisha	Ecuador	EC	TSC	SETH	-77.5	-2.383333	America/Guayaquil	0
6423	Nur-Sultan Nazarbayev Airport	Astana	Kazakhstan	KZ	NQZ	UACC	71.461199	51.027811	Asia/Almaty	0
6424	Treviso Airport	Venice	Italy	IT	TSF	LIPH	12.204444	45.655113	Europe/Rome	0
6425	Tshikapa Airport	Tshikapa	The Democratic Republic of The Congo	CD	TSH	FZUK	20.794326	-6.437853	Africa/Lubumbashi	0
6426	Tsushima Airport	Tsushima	Japan	JP	TSJ	RJDT	129.326368	34.286151	Asia/Tokyo	0
6427	Tamuin Airport	Tamuin	Mexico	MX	TSL	MMTN	-98.75	21.983333	America/Mexico_City	0
6428	Taos Airport	Taos	United States	US	TSM	KSKX	-105.675278	36.459167	America/Denver	0
6429	Tianjin Binhai International Airport	Tianjin	China	CN	TSN	ZBTJ	117.355906	39.128273	Asia/Shanghai	0
6430	Tresco Airport	Isles Of Scilly	United Kingdom	GB	TSO	EGHT	-6.331389	49.945556	Europe/London	0
6431	Kern County Airport	Tehachapi	United States	US	TSP	KTSP	-118.441667	35.1375	America/Los_Angeles	0
6432	Timisoara Traian Vuia International Airport	Timisoara	Romania	RO	TSR	LRTR	21.32012	45.809924	Europe/Bucharest	0
6433	Trang Airport	Trang	Thailand	TH	TST	VTST	99.616667	7.5	Asia/Bangkok	0
6434	Tabiteuea South Airport	Tabiteuea South	Kiribati	KI	TSU	NGTS	174.833333	-1.416667	Pacific/Tarawa	0
6435	Townsville Airport	Townsville	Australia	AU	TSV	YBTL	146.770793	-19.256506	Australia/Brisbane	0
6436	Tanjung Santan Airport	Tanjung Santan	Indonesia	ID	TSX	WALT	117.433333	-0.083333	Asia/Makassar	0
6437	Tasikmalaya Airport	Tasikmalaya	Indonesia	ID	TSY	WICM	108.246002	-7.3466	Asia/Jakarta	0
6438	Tan Tan Airport	Tan Tan	Morocco	MA	TTA	GMAT	-11.083333	28.45	Africa/Casablanca	0
6439	Arbatax Airport	Tortoli	Italy	IT	TTB	LIET	9.683333	39.916667	Europe/Rome	0
6440	Taltal Airport	Taltal	Chile	CL	TTC	SCTT	-70.422222	-25.517778	America/Santiago	0
6441	Troutdale Airport	Troutdale	United States	US	TTD	KTTD	-122.401001	45.5494	America/Los_Angeles	0
6442	Babullah Airport	Ternate	Indonesia	ID	TTE	WAEE	127.379132	0.832233	Asia/Jayapura	0
6443	Tartagal Airport	Tartagal	Argentina	AR	TTG	SAST	-63.833333	-22.533333	America/Argentina/Buenos_Aires	0
6444	Thumrait Air Base	Thumrait	Oman	OM	TTH	OOTH	54.024752	17.665789	Asia/Muscat	0
6445	Tetiaroa Island Airport	Tetiaroa Island	French Polynesia	PF	TTI	NTTE	-149.587006	-17.0133	Pacific/Tahiti	0
6446	Tottori Airport	Tottori	Japan	JP	TTJ	RJOR	134.167562	35.525915	Asia/Tokyo	0
6447	Tablon De Tamara Airport	Tablon De Tamara	Colombia	CO	TTM	SQUJ	-72.1	5.716667	America/Bogota	0
6448	Trenton-Mercer Airport	Trenton	United States	US	TTN	KTTN	-74.8125	40.278056	America/New_York	0
6449	Britton Municipal Airport	Britton	United States	US	TTO	KBTN	-97.75	45.8	America/Chicago	0
6450	Tortuquero Airport	Tortuquero	Costa Rica	CR	TTQ	MRBT	-83.514975	10.568984	America/Costa_Rica	0
6451	Tsaratanana Airport	Tsaratanana	Madagascar	MG	TTS	FMNT	47.6	-16.733333	Indian/Antananarivo	0
6452	Taitung Airport	Taitung City	Taiwan	TW	TTT	RCFN	121.106027	22.75683	Asia/Taipei	0
6453	Sania Ramel Airport	Tetouan	Morocco	MA	TTU	GMTN	-5.330265	35.591244	Africa/Casablanca	0
6454	Tulcan Airport	Tulcan	Ecuador	EC	TUA	SETU	-77.716667	0.8	America/Guayaquil	0
6455	Tubuai Island Airport	Tubuai Island	French Polynesia	PF	TUB	NTAT	-149.466667	-23.35	Pacific/Tahiti	0
6456	Teniente Benjamin Matienzo Airport	Tucuman	Argentina	AR	TUC	SANT	-65.10754	-26.836106	America/Argentina/Buenos_Aires	0
6457	Tambacounda Airport	Tambacounda	Senegal	SN	TUD	GOTT	-13.658333	13.736111	Africa/Dakar	0
6458	Val de Loire Airport	Tours	France	FR	TUF	LFOT	0.726584	47.432237	Europe/Paris	0
6459	Tuguegarao Airport	Tuguegarao	Philippines	PH	TUG	RPUT	121.731667	17.641111	Asia/Manila	0
6460	Turaif Airport	Turaif	Saudi Arabia	SA	TUI	OETR	38.733831	31.68873	Asia/Riyadh	0
6461	Turbat Airport	Turbat	Pakistan	PK	TUK	OPTU	63.066667	25.983333	Asia/Karachi	0
6462	Tulsa International Airport	Tulsa	United States	US	TUL	KTUL	-95.890102	36.189809	America/Chicago	0
6463	Tumut Airport	Tumut	Australia	AU	TUM	YTMU	148.216667	-35.3	Australia/Sydney	0
6464	Tunis-Carthage International Airport	Tunis	Tunisia	TN	TUN	DTTA	10.21709	36.847621	Africa/Tunis	0
6465	Taupo Airport	Taupo	New Zealand	NZ	TUO	NZAP	176.082347	-38.741433	Pacific/Auckland	0
6466	Tupelo Regional Airport	Tupelo	United States	US	TUP	KTUP	-88.767222	34.258889	America/Chicago	0
6467	Tougan Airport	Tougan	Burkina Faso	BF	TUQ	DFOT	-3.076275	13.059053	Africa/Ouagadougou	0
6468	Tucurui Airport	Tucurui	Brazil	BR	TUR	SBTU	-49.733333	-3.7	America/Belem	0
6469	Tucson International Airport	Tucson	United States	US	TUS	KTUS	-110.937369	32.120688	America/Phoenix	0
6470	Tabuk Regional Airport	Tabuk	Saudi Arabia	SA	TUU	OETB	36.598686	28.373017	Asia/Riyadh	0
6471	San Rafael Airport	Tucupita	Venezuela	VE	TUV	SVTC	-62.094541	9.089247	America/Caracas	0
6472	Tumbler Ridge Airport	Tumbler Ridge	Canada	CA	TUX	CBX7	-121.083333	55.1	America/Vancouver	0
6473	Morafenobe Airport	Morafenobe	Madagascar	MG	TVA	FMMR	44.919167	-17.849444	Indian/Antananarivo	0
6474	Cherry Capital Airport	Traverse City	United States	US	TVC	KTVC	-85.579631	44.737631	America/New_York	0
6475	Thief River Falls Regional Airport	Thief River Falls	United States	US	TVF	KTVF	-96.185	48.066111	America/Chicago	0
6476	Thomasville Regional Airport	Thomasville	United States	US	TVI	KTVI	-83.880556	30.9025	America/New_York	0
6477	Lake Tahoe Airport	South Lake Tahoe	United States	US	TVL	KTVL	-119.994444	38.894167	America/Los_Angeles	0
6478	Tangshan Sannuhe Airport	Tangshan	China	CN	TVS	ZBTS	117.997913	39.718784	Asia/Shanghai	0
6479	Matei Airport	Taveuni	Fiji	FJ	TVU	NFNM	179.869921	-16.688375	Pacific/Fiji	0
6480	Dawe Airport	Dawe	Myanmar	MM	TVY	VYDW	98.2	14.1	Asia/Yangon	0
6481	Toowoomba Airport	Toowoomba	Australia	AU	TWB	YTWB	151.913889	-27.542222	Australia/Brisbane	0
6482	Magic Valley Regional Airport	Twin Falls	United States	US	TWF	KTWF	-114.486667	42.481944	America/Denver	0
6483	Torwood Airport	Torwood	Australia	AU	TWP	YTRW	143.75	-17.366667	Australia/Brisbane	0
6484	Sanga Sanga Airport	Bongao	Philippines	PH	TWT	RPMN	119.740982	5.044251	Asia/Manila	0
6485	Tawau Airport	Tawau	Malaysia	MY	TWU	WBKW	118.121497	4.313084	Asia/Kuala_Lumpur	0
6486	Aerodrome Orsha	Orsha	Belarus	BY	TXC	UMIO	30.296667	54.440278	Europe/Minsk	0
6487	Takengon Rembele Airport	Takengon	Indonesia	ID	TXE	WITK	96.849009	4.72123	Asia/Jakarta	0
6488	Teixeira de Freitas Airport	Teixeira de Freitas	Brazil	BR	TXF	SNTF	-39.669842	-17.523049	America/Belem	0
6489	Texarkana Regional Airport - Webb Field	Texarkana	United States	US	TXK	KTXK	-93.989167	33.456389	America/Chicago	0
6490	Teminabuan Airport	Teminabuan	Indonesia	ID	TXM	WAST	132.016667	-1.433333	Asia/Jayapura	0
6491	Huangshan Tunxi International Airport	Tunxi	China	CN	TXN	ZSTX	118.254197	29.731388	Asia/Shanghai	0
6492	Tabou Airport	Tabou	Cote d'Ivoire	CI	TXU	DITB	-7.366667	4.433333	Africa/Abidjan	0
6493	Tibooburra Airport	Tibooburra	Australia	AU	TYB	YTIB	142.062222	-29.456944	Australia/Sydney	0
6494	Torsby Airport	Torsby	Sweden	SE	TYF	ESST	12.99661	60.154484	Europe/Stockholm	0
6495	Thylungra Airport	Thylungra	Australia	AU	TYG	YTHY	143.455556	-26.098611	Australia/Brisbane	0
6496	Captain FAP Victor Montes Arias Airport	Talara	Peru	PE	TYL	SPYL	-81.254489	-4.575406	America/Lima	0
6497	Staniel Cay Airport	Staniel Cay	Bahamas	BS	TYM	MYES	-76.439995	24.168911	America/Nassau	0
6498	Taiyuan Wusu International Airport	Taiyuan	China	CN	TYN	ZBYN	112.62585	37.754996	Asia/Shanghai	0
6499	Tobermorey Airport	Tobermorey	Australia	AU	TYP	YTMY	137.966667	-22.283333	Australia/Darwin	0
6500	Tyler Pounds Regional Airport	Tyler	United States	US	TYR	KTYR	-95.410117	32.351598	America/Chicago	0
6501	Knoxville McGhee Tyson Airport	Knoxville	United States	US	TYS	KTYS	-83.989729	35.80565	America/New_York	0
6502	Treinta-y-Tres Airport	Treinta-y-Tres	Uruguay	UY	TYT	SUTR	-54.283333	-33.266667	America/Montevideo	0
6503	Taylor Airport	Taylor	United States	US	TYZ	KTYL	-110.083333	34.466667	America/Phoenix	0
6504	Sir Barry Bowen Municipal Airport	Belize City	Belize	BZ	TZA	MZBE	-88.194394	17.51578	America/Belize	0
6505	Tuzla International Airport	Tuzla	Bosnia and Herzegovina	BA	TZL	LQTZ	18.709167	44.409722	Europe/Sarajevo	0
6506	South Andros Airport	Congo Town	Bahamas	BS	TZN	MYAK	-77.588798	24.158367	America/Nassau	0
6507	Trabzon Airport	Trabzon	Turkiye	TR	TZX	LTCG	39.781681	40.994191	Europe/Istanbul	0
6508	Incirlik Air Base	Adana	Turkiye	TR	UAB	LTAG	35.418333	37.000278	Europe/Istanbul	0
6509	Ua Huka Airport	Ua Huka	French Polynesia	PF	UAH	NTMU	-139.55	-8.933333	Pacific/Marquesas	0
6510	Suai Airport	Suai	East Timor	TL	UAI	WPDB	125.283333	-9.3	Asia/Dili	0
6511	Narsarsuaq Airport	Narsarsuaq	Greenland	GL	UAK	BGBW	-45.417921	61.162598	America/Godthab	0
6512	Anderson Air Force Base	Guam	Guam	GU	UAM	PGUA	144.92954	13.580373	Pacific/Guam	0
6513	Ua Pou Airport	Ua Pou, Marquesas Island	French Polynesia	PF	UAP	NTMP	-140.081252	-9.343477	Pacific/Marquesas	0
6514	San Juan Airport	San Juan	Argentina	AR	UAQ	SANU	-68.418198	-31.571501	America/Argentina/Buenos_Aires	0
6515	Bouarfa Airport	Bouarfa	Morocco	MA	UAR	GMFB	-1.98167	32.51417	Africa/Casablanca	0
6516	Samburu Airport	Samburu	Kenya	KE	UAS	HKSB	37.55	0.466667	Africa/Nairobi	0
6517	Uberaba Airport	Uberaba	Brazil	BR	UBA	SBUR	-47.958333	-19.776389	America/Sao_Paulo	0
6518	Mabuiag Island Airport	Mabuiag Island	Australia	AU	UBB	YMAA	142.195363	-9.950447	Australia/Brisbane	0
6519	Yamaguchi Ube Airport	Ube	Japan	JP	UBJ	RJDC	131.274894	33.933397	Asia/Tokyo	0
6520	Chinggis Khan International Airport	Ulaanbaatar	Mongolia	MN	UBN	ZMCK	106.819722	47.646944	Asia/Ulaanbaatar	0
6521	Ubon Ratchathani International Airport	Ubon Ratchathani	Thailand	TH	UBP	VTUU	104.870683	15.246491	Asia/Bangkok	0
6522	Ubrub, Irian Jaya Airport	Ubrub, Irian Jaya	Indonesia	ID	UBR	WAJU	140.85	-3.666667	Asia/Jayapura	0
6523	Lowndes County Airport	Columbus	United States	US	UBS	KUBS	-88.383333	33.466667	America/Chicago	0
6524	Ubatuba Airport	Ubatuba	Brazil	BR	UBT	SDUB	-45.083333	-23.433333	America/Sao_Paulo	0
6525	Oneida County Airport	Utica	United States	US	UCA	KUCA	-75.380278	43.141389	America/New_York	0
6526	Buchanan Airport	Buchanan	Liberia	LR	UCN	GLBU	-10.033333	5.95	Africa/Monrovia	0
6527	Ukhta Airport	Ukhta	Russian Federation	RU	UCT	UUYH	53.8	63.566667	Europe/Moscow	0
6528	Everett-Stewart Airport	Union City	United States	US	UCY	KUCY	-89.05	36.433333	America/Chicago	0
6529	Undarra Airport	Undarra	Australia	AU	UDA	YUDA	144.6	-18.183333	Australia/Brisbane	0
6530	Bermuda Dunes Airport	Palm Springs	United States	US	UDD	KUDD	-116.270782	33.746019	America/Los_Angeles	0
6531	Uberlandia-Ten. Cel. Av. Cesar Bombonato Airport	Uberlandia	Brazil	BR	UDI	SBUL	-48.230073	-18.889319	America/Sao_Paulo	0
6532	Uzhhorod International Airport	Uzhhorod	Ukraine	UA	UDJ	UKLU	22.271291	48.636348	Europe/Kiev	0
6533	Udine Airfield	Udine	Italy	IT	UDN	LIPD	13.183333	46.033333	Europe/Rome	0
6534	Maharana Pratap Airport	Udaipur	India	IN	UDR	VAUD	73.891269	24.61919	Asia/Kolkata	0
6535	Quelimane Airport	Quelimane	Mozambique	MZ	UEL	FQQL	36.871545	-17.857741	Africa/Maputo	0
6536	Kume-jima Airport	Kume-jima	Japan	JP	UEO	ROKJ	126.719444	26.365278	Asia/Tokyo	0
6537	Waukesha County Airport	Waukesha	United States	US	UES	KUES	-88.237747	43.038912	America/Chicago	0
6538	Quetta Airport	Quetta	Pakistan	PK	UET	OPQT	66.949036	30.249266	Asia/Karachi	0
6539	Ufa International Airport	Ufa	Russian Federation	RU	UFA	UWUU	55.884543	54.565403	Asia/Yekaterinburg	0
6540	Bulgan Airport	Bulgan	Mongolia	MN	UGA	ZMBN	103.55	48.8	Asia/Ulaanbaatar	0
6541	Urgench Airport	Urgench	Uzbekistan	UZ	UGC	UTNU	60.633029	41.584834	Asia/Tashkent	0
6542	Union Glacier Station	Union Glacier	Antarctica	AQ	UGL	SCGC	-83.419187	-79.780731	Antarctica/Palmer	0
6543	Waukegan National Airport	Waukegan	United States	US	UGN	KUGN	-87.866024	42.420903	America/Chicago	0
6544	Uige Airport	Uige	Angola	AO	UGO	FNUG	15.15	-7.816667	Africa/Luanda	0
6545	Kunovice Airport	Uherske Hradiste	Czech Republic	CZ	UHE	LKKU	17.439825	49.029364	Europe/Prague	0
6546	Shakhtyorsk Airport	Shakhtyorsk	Russian Federation	RU	EKS	UHSK	142.085469	49.1896	Asia/Sakhalin	0
6547	El Carano Airport	Quibdo	Colombia	CO	UIB	SKUI	-76.641945	5.690556	America/Bogota	0
6548	Phu Cat Airport	Qui Nhon	Viet Nam	VN	UIH	VVPC	109.042222	13.955	Asia/Ho_Chi_Minh	0
6549	Utila Airport	Utila	Honduras	HN	UII	MHUT	-86.8875	16.091667	America/Tegucigalpa	0
6550	Quillayute State Airport	Quillayute	United States	US	UIL	KUIL	-124.633333	47.9	America/Los_Angeles	0
6551	Quincy Municipal Airport	Quincy	United States	US	UIN	KUIN	-91.197222	39.944167	America/Chicago	0
6552	Mariscal Sucre International Airport	Quito	Ecuador	EC	UIO	SEQM	-78.355976	-0.123811	America/Guayaquil	0
6553	Pluguffan Airport	Quimper	France	FR	UIP	LFRQ	-4.170833	47.974444	Europe/Paris	0
6554	Quine Hill Airport	Quine Hill	Vanuatu	VU	UIQ	NVVQ	168.166667	-17	Pacific/Efate	0
6555	Quirindi Airport	Quirindi	Australia	AU	UIR	YQDI	150.516667	-31.5	Australia/Sydney	0
6556	Berz-Macomb Airport	Utica	United States	US	UIZ	KUIZ	-83.05	42.616667	America/New_York	0
6557	Uljin Airport	Uljin	Republic of Korea	KR	UJN	RKTL	129.46167	36.77694	Asia/Seoul	0
6558	Ukunda Airport	Ukunda	Kenya	KE	UKA	HKUK	39.566667	-4.3	Africa/Nairobi	0
6559	Kobe Airport	Kobe	Japan	JP	UKB	RJBE	135.228388	34.6373	Asia/Tokyo	0
6560	Utkela Airport	Utkela	India	IN	UKE	VEUK	83.1808	20.0947	Asia/Kolkata	0
6561	Ust-Kuyga Airport	Ust-Kuyga	Russian Federation	RU	UKG	UEBT	135.645004	70.011002	Asia/Vladivostok	0
6562	Mukhaizna Airport	Mukhaizna Oil Field	Oman	OM	UKH	OOMK	56.401389	19.386389	Asia/Muscat	0
6563	Ukiah Municipal Airport	Ukiah	United States	US	UKI	KUKI	-123.202162	39.125815	America/Los_Angeles	0
6564	Ust-Kamenogorsk Airport	Ust-Kamenogorsk	Kazakhstan	KZ	UKK	UASK	82.493495	50.03657	Asia/Almaty	0
6565	Mukeiras Airport	Mukeiras	Republic of Yemen	YE	UKR	OYMS	45.683333	13.933333	Asia/Aden	0
6566	Belbek Airport	Sevastopol	Ukraine	UA	UKS	UKFB	33.576667	44.691667	Europe/Simferopol	0
6567	Upper Bucks Airport	Quakertown	United States	US	UKT	KUKT	-75.381102	40.434173	America/New_York	0
6568	San Julian Airport	San Julian	Argentina	AR	ULA	SAWJ	-67.666667	-49.316667	America/Argentina/Buenos_Aires	0
6569	Ulei Airport	Ulei	Vanuatu	VU	ULB	NVSU	168.333333	-16.416667	Pacific/Efate	0
6570	Los Cerrillos Airport	Santiago	Chile	CL	ULC	SCTI	-70.694722	-33.489722	America/Santiago	0
6571	Prince Mangosuthu Buthelezi Airport	Ulundi	South Africa	ZA	ULD	FAUL	31.419104	-28.315803	Africa/Johannesburg	0
6572	Sule Airport	Sule	Papua New Guinea	PG	ULE	SULE	151.266667	-4.933333	Pacific/Port_Moresby	0
6573	Olgii Airport	Ulgit	Mongolia	MN	ULG	ZMUL	89.920228	48.992091	Asia/Ulaanbaatar	0
6574	Prince Abdul Majeed bin Abdulaziz Airport	Al Ula	Saudi Arabia	SA	ULH	OEAO	38.116654	26.480861	Asia/Riyadh	0
6575	Ulithi Airport	Ulithi Caroline Islands	Micronesia	FM	ULI	TT02	139.78999	10.019938	Pacific/Chuuk	0
6576	Lensk Airport	Lensk	Russian Federation	RU	ULK	UERL	114.824025	60.723301	Asia/Yakutsk	0
6577	New Ulm Airport	New Ulm	United States	US	ULM	KULM	-94.500556	44.321389	America/Chicago	0
6578	Buyant-Ukhaa International Airport	Ulaanbaatar	Mongolia	MN	ULN	ZMUB	106.763268	47.852749	Asia/Ulaanbaatar	0
6579	Ulaangom Airport	Ulaangom	Mongolia	MN	ULO	ZMUG	92.080288	49.973383	Asia/Ulaanbaatar	0
6580	Quilpie Airport	Quilpie	Australia	AU	ULP	YQLP	144.3	-26.633333	Australia/Brisbane	0
6581	Farfan Airport	Tulua	Colombia	CO	ULQ	SKUL	-76.229167	4.097222	America/Bogota	0
6582	Gulu Airport	Gulu	Uganda	UG	ULU	HUGU	32.273952	2.789803	Africa/Kampala	0
6583	Ulyanovsk Baratayevka Airport	Ulyanovsk	Russian Federation	RU	ULV	UWLL	48.226665	54.268333	Europe/Ulyanovsk	0
6584	Ulusaba Airport	Ulusaba	South Africa	ZA	ULX	FAUS	31.353811	-24.782376	Africa/Johannesburg	0
6585	Ulyanovsk Vostochny Airport	Ulyanovsk	Russian Federation	RU	ULY	UWLW	48.802801	54.399045	Europe/Ulyanovsk	0
6586	Donoi Airport	Uliastai	Mongolia	MN	ULZ	ZMDN	96.525498	47.709633	Asia/Ulaanbaatar	0
6587	Alfredo Noa Diaz Airport	Punta de Maisi	Cuba	CU	UMA	MUMA	-74.1475	20.242222	America/Havana	0
6588	Uummannaq Heliport	Uummannaq	Greenland	GL	UMD	BGUM	-52.111657	70.680362	America/Godthab	0
6589	Umea Airport	Umea	Sweden	SE	UME	ESNU	20.289539	63.793332	Europe/Stockholm	0
6590	Quincemil Airport	Quincemil	Peru	PE	UMI	SPIL	-70.666667	-13.25	America/Lima	0
6591	Summit Airport	Summit	United States	US	UMM	PAST	-149.128836	63.331039	America/Anchorage	0
6592	Woomera Airport	Woomera	Australia	AU	UMR	YPWR	136.816667	-31.15	Australia/Adelaide	0
6593	Umiat Airport	Umiat	United States	US	UMT	PAUM	-152.333333	69.416667	America/Anchorage	0
6594	Ernesto Geisel Airport	Umuarama	Brazil	BR	UMU	SSUM	-53.313333	-23.798333	America/Sao_Paulo	0
6595	Sumy Airport	Sumy	Ukraine	UA	UMY	UKHS	34.783333	50.933333	Europe/Kiev	0
6596	Una Airport	Una	Brazil	BR	UNA	SBTC	-38.999001	-15.3552	America/Belem	0
6597	Kunduz Airport	Kunduz	Afghanistan	AF	UND	OAUZ	68.910593	36.665175	Asia/Kabul	0
6598	Qachas Airport	Qachas	Lesotho	LS	UNE	FXQN	27.166667	-30.166667	Africa/Maseru	0
6599	Kiunga Airport	Kiunga	Papua New Guinea	PG	UNG	AYKI	141.286017	-6.125552	Pacific/Port_Moresby	0
6600	Union Island Airport	Union Island	Saint Vincent and the Grenadines	VC	UNI	TVSU	-61	13.5	America/St_Vincent	0
6601	Baykit Airport	Baykit	Russian Federation	RU	BKA	UNIB	96.354265	61.677768	Asia/Krasnoyarsk	0
6602	Tura Airport	Tura	Russian Federation	RU	GOY	UNIT	100.433333	64.333333	Asia/Krasnoyarsk	0
6603	Unalakleet Airport	Unalakleet	United States	US	UNK	PAUN	-160.799433	63.881928	America/Anchorage	0
6604	Ranong Airport	Ranong	Thailand	TH	UNN	VTSR	98.629167	9.852778	Asia/Bangkok	0
6605	Underkhaan Airport	Underkhaan	Mongolia	MN	UNR	ZMUH	110.666667	47.316667	Asia/Ulaanbaatar	0
6606	Unst Airport	Baltasound	United Kingdom	GB	UNT	EGPW	-0.849653	60.748559	Europe/London	0
6607	Dodge County Airport	Juneau	United States	US	UNU	KUNU	-134.416667	58.3	America/Chicago	0
6608	Moruroa Airport	Moruroa Atoll	French Polynesia	PF	UOA	NTTX	-138.813611	-21.809722	Pacific/Tahiti	0
6609	Pogogul Airport	Buol	Indonesia	ID	UOL	WAFY	121.416029	1.104373	Asia/Makassar	0
6610	Franklin County Airport	Sewanee	United States	US	UOS	KUOS	-85.9	35.183333	America/Chicago	0
6611	University-Oxford Airport	Oxford	United States	US	UOX	KUOX	-89.535296	34.38	America/Chicago	0
6612	Playa Baracoa Airport	Havana	Cuba	CU	UPB	MUPB	-82.579444	23.032778	America/Havana	0
6613	Makassar Sultan Hasanuddin International Airport	Ujung Pandang	Indonesia	ID	UPG	WAAA	119.547738	-5.077019	Asia/Makassar	0
6614	Upernavik Kujalleq Heliport	Upernavik Kujalleq	Greenland	GL	UPK	BGKL	-55.531099	72.15273	America/Godthab	0
6615	Upala Airport	Upala	Costa Rica	CR	UPL	MRUP	-85.033333	10.783333	America/Costa_Rica	0
6616	Licenciado y General Ignacio Lopez Rayon Airport	Uruapan	Mexico	MX	UPN	MMPN	-102.037988	19.402278	America/Mexico_City	0
6617	Upolu Point Airport	Hawi	United States	US	UPP	PHUP	-155.8625	20.268056	Pacific/Honolulu	0
6618	Upavon Airport	Upavon	United Kingdom	GB	UPV	EGDJ	-1.816667	51.3	Europe/London	0
6619	Uralsk Airport	Uralsk	Kazakhstan	KZ	URA	UARR	51.538562	51.153708	Asia/Oral	0
6620	Ernesto Pochler Airport	Urubupunga	Brazil	BR	URB	SBUP	-51.56287	-20.77833	America/Sao_Paulo	0
6621	Urumqi Diwopu International Airport	Urumqi	China	CN	URC	ZWWW	87.475148	43.90126	Asia/Shanghai	0
6622	Burg Feuerstein Airport	Burg Feuerstein	Germany	DE	URD	EDQE	11.133333	49.8	Europe/Berlin	0
6623	Kuressaare Airport	Kuressaare	Estonia	EE	URE	EEKE	22.509542	58.229938	Europe/Tallinn	0
6624	Ruben Berta Airport	Uruguaiana	Brazil	BR	URG	SBUG	-57.035952	-29.783427	America/Sao_Paulo	0
6625	Uribe Airport	Uribe	Colombia	CO	URI	SKUB	-74.4	3.216667	America/Bogota	0
6626	Uraj Airport	Uraj	Russian Federation	RU	URJ	USHU	64.833333	60.116667	Asia/Yekaterinburg	0
6627	Uriman Airport	Uriman	Venezuela	VE	URM	SVUM	-62.758333	5.341667	America/Caracas	0
6628	Urgoon Airport	Urgoon	Afghanistan	AF	URN	OAOG	69.156389	32.931944	Asia/Kabul	0
6629	Boos Airport	Rouen	France	FR	URO	LFOP	1.1875	49.388611	Europe/Paris	0
6630	Urrao Airport	Urrao	Colombia	CO	URR	SKUR	-76.183333	6.333333	America/Bogota	0
6631	Kursk Vostochny Airport	Kursk	Russian Federation	RU	URS	UUOK	36.283127	51.750993	Europe/Moscow	0
6632	Surat Thani Airport	Surat Thani	Thailand	TH	URT	VTSB	99.143198	9.133865	Asia/Bangkok	0
6633	Gurayat Airport	Gurayat	Saudi Arabia	SA	URY	OEGT	37.275006	31.409623	Asia/Riyadh	0
6634	Malvinas Argentinas International Airport	Ushuaia	Argentina	AR	USH	SAWH	-68.312449	-54.839347	America/Argentina/Buenos_Aires	0
6635	Mabaruma Airport	Mabaruma	Guyana	GY	USI	SYMB	-59.833333	8.166667	America/Guyana	0
6636	Usharal Airport	Usharal	Kazakhstan	KZ	USJ	UAAL	80.830922	46.190767	Asia/Almaty	0
6637	Usinsk Airport	Usinsk	Russian Federation	RU	USK	UUYS	57.37496	66.002429	Europe/Moscow	0
6638	Useless Loop Airport	Useless Loop	Australia	AU	USL	YUSL	113.116667	-25.966667	Australia/Perth	0
6639	Koh Samui Airport	Koh Samui	Thailand	TH	USM	VTSM	100.062878	9.55117	Asia/Bangkok	0
6640	Ulsan Airport	Ulsan	Republic of Korea	KR	USN	RKPU	129.355976	35.593671	Asia/Seoul	0
6641	Usak Airport	Usak	Turkiye	TR	USQ	LTBO	29.481672	38.680031	Europe/Istanbul	0
6642	Sancti Spiritus Airport	Sancti Spiritus	Cuba	CU	USS	MUSS	-79.55	21.866667	America/Havana	0
6643	St. Augustine Airport	Saint Augustine	United States	US	UST	KSGJ	-81.337849	29.959323	America/New_York	0
6644	Busuanga Airport	Busuanga	Philippines	PH	USU	RPVV	120.166667	12.1	Asia/Manila	0
6645	Mutare Airport	Mutare	Zimbabwe	ZW	UTA	FVMU	32.666667	-18.966667	Africa/Harare	0
6646	Muttaburra Airport	Muttaburra	Australia	AU	UTB	YMTB	144.525	-22.5875	Australia/Brisbane	0
6647	Soesterberg Airport	Utrecht	Netherlands	NL	UTC	EHSB	5.166667	52.083333	Europe/Amsterdam	0
6648	Nutwood Downs Airport	Nutwood Downs	Australia	AU	UTD	YNUT	134.166667	-15.816667	Australia/Darwin	0
6649	Quthing Airport	Quthing	Lesotho	LS	UTG	FXQG	27.6	-30.5	Africa/Maseru	0
6650	Udon Thani International Airport	Udon Thani	Thailand	TH	UTH	VTUD	102.788	17.386392	Asia/Bangkok	0
6651	Utti Airport	Kouvola	Finland	FI	UTI	EFUT	26.933333	60.9	Europe/Helsinki	0
6652	Tunica Municipal Airport	Tunica	United States	US	UTM	KUTA	-90.349798	34.683418	America/Chicago	0
6653	Upington Airport	Upington	South Africa	ZA	UTN	FAUP	21.253333	-28.400556	Africa/Johannesburg	0
6654	Indian Mountain Air Force Station	Utopia Creek	United States	US	UTO	PAIM	-153.701667	65.993333	America/Anchorage	0
6655	Utapao Airport	Utapao	Thailand	TH	UTP	VTBU	101.016667	12.683333	Asia/Bangkok	0
6656	Uttaradit Airport	Uttaradit	Thailand	TH	UTR	VTPU	100.243889	17.669444	Asia/Bangkok	0
6657	Ust-Tsilma Airport	Ust-Tsilma	Russian Federation	RU	UTS	UUYX	52.200336	65.437294	Europe/Moscow	0
6658	Umtata Airport	Umtata	South Africa	ZA	UTT	FAUT	28.783333	-31.583333	Africa/Johannesburg	0
6659	Queenstown Airport	Queenstown	South Africa	ZA	UTW	FAQT	26.866667	-31.866667	Africa/Johannesburg	0
6660	Bugulma Airport	Bugulma	Russian Federation	RU	UUA	UWKB	52.791009	54.633958	Europe/Moscow	0
6661	Ulan-Ude Airport	Ulan-Ude	Russian Federation	RU	UUD	UIUU	107.5	51.833333	Asia/Irkutsk	0
6662	Baruun-Urt Airport	Baruun-Urt	Mongolia	MN	UUN	ZMBU	113.283333	46.683333	Asia/Ulaanbaatar	0
6663	Yuzhno-Sakhalinsk Airport	Yuzhno-Sakhalinsk	Russian Federation	RU	UUS	UHSS	142.721561	46.885341	Asia/Sakhalin	0
6664	Garner Field	Uvalde	United States	US	UVA	KUVA	-99.735	29.201944	America/Chicago	0
6665	Ouvea Airport	Ouvea	New Caledonia	NC	UVE	NWWV	166.571983	-20.64242	Pacific/Noumea	0
6666	Hewanorra Airport	Saint Lucia	Saint Lucia	LC	UVF	TLPL	-60.952222	13.735556	America/St_Lucia	0
6667	Kharga Airport	New Valley	Egypt	EG	UVL	HEKG	30.590833	25.475	Africa/Cairo	0
6668	Nyala Airport	Nyala	Sudan	SD	UYL	HSNN	24.894722	12.071667	Africa/Khartoum	0
6669	Yulin Yuyang Airport	Yulin	China	CN	UYN	ZLYL	109.596181	38.361466	Asia/Shanghai	0
6670	Uyuni Airport	Uyuni	Bolivia	BO	UYU	SLUY	-66.8484	-20.4463	America/La_Paz	0
6671	Ponikve Airport	Uzice	Republic of Serbia	RS	UZC	LYUZ	19.697403	43.898836	Europe/Belgrade	0
6672	Urzhar Airport	Urzhar	Kazakhstan	KZ	UZR	UASU	81.664679	47.091038	Asia/Almaty	0
6673	Curuzu Cuatia Airport	Curuzu Cuatia	Argentina	AR	UZU	SATU	-58.095556	-29.778889	America/Argentina/Buenos_Aires	0
6674	Vaasa Airport	Vaasa	Finland	FI	VAA	EFVA	21.760123	63.043549	Europe/Helsinki	0
6675	Yavarate Airport	Yavarate	Colombia	CO	VAB	SQYV	-70.75	1.116667	America/Bogota	0
6676	Varrelbusch Airport	Varrelbusch	Germany	DE	VAC	EDWU	8.05	52.916667	Europe/Berlin	0
6677	Moody Air Force Base	Valdosta	United States	US	VAD	KVAD	-83.193053	30.968364	America/New_York	0
6678	Chabeuil Airport	Valence	France	FR	VAF	LFLU	4.970278	44.920278	Europe/Paris	0
6679	Major-Brigadeiro Trompowsky Airport	Varginha	Brazil	BR	VAG	SBVG	-45.473199	-21.586348	America/Sao_Paulo	0
6680	Vallegrande Airport	Vallegrande	Bolivia	BO	VAH	SLVG	-64.1	-18.483333	America/La_Paz	0
6681	Vanimo Airport	Vanimo	Papua New Guinea	PG	VAI	AYVN	141.298987	-2.687288	Pacific/Port_Moresby	0
6682	Chevak Airport	Chevak	United States	US	VAK	PAVA	-165.590278	61.528611	America/Anchorage	0
6683	Maamigili Island Airport	Maamigili Island	Maldives	MV	VAM	VRMV	72.835833	3.470556	Indian/Maldives	0
6684	Van Ferit Melen Airport	Van	Turkiye	TR	VAN	LTCI	43.337264	38.469878	Europe/Istanbul	0
6685	Suavanao Airport	Suavanao	Solomon Islands	SB	VAO	AGGV	158.731003	-7.58556	Pacific/Guadalcanal	0
6686	Ozar Airport	Ozar	India	IN	ISK	VAOZ	73.913354	20.119548	Asia/Kolkata	0
6687	Valparaiso Airport	Valparaiso	Chile	CL	VAP	SCRD	-71.666667	-33.033333	America/Santiago	0
6688	Varna Airport	Varna	Bulgaria	BG	VAR	LBWN	27.829096	43.237258	Europe/Sofia	0
6689	Sivas Airport	Sivas	Turkiye	TR	VAS	LTAR	36.904167	39.813889	Europe/Istanbul	0
6690	Vatomandry Airport	Vatomandry	Madagascar	MG	VAT	FMMY	48.833333	-19.283333	Indian/Antananarivo	0
6691	Vava'u International Airport	Vava'u	Tonga	TO	VAV	NFTV	-173.96436	-18.585537	Pacific/Tongatapu	0
6692	Vardoe Airport	Vardoe	Norway	NO	VAW	ENSS	31.045556	70.354722	Europe/Oslo	0
6693	Ann Airport	Ann	Myanmar	MM	VBA	VYAN	94.028292	19.777449	Asia/Yangon	0
6694	Mandalay Chan Mya Thazi Airport	Mandalay	Myanmar	MM	VBC	VYCZ	96.089586	21.940539	Asia/Yangon	0
6695	Vandenburg Air Force Base	Lompoc	United States	US	VBG	KVBG	-120.575367	34.733805	America/Los_Angeles	0
6696	Bokpyin Airport	Bokpyin	Myanmar	MM	VBP	VYBP	98.766667	11.266667	Asia/Yangon	0
6697	Montichiari Airport	Brescia	Italy	IT	VBS	LIPO	10.326545	45.425447	Europe/Rome	0
6698	Vanua Balavu Airport	Vanuabalavu	Fiji	FJ	VBV	NFVB	-178.956461	-17.246505	Pacific/Fiji	0
6699	Visby Airport	Visby	Sweden	SE	VBY	ESSV	18.338154	57.660447	Europe/Stockholm	0
6700	Victoria River Downs Airport	Victoria River Downs	Australia	AU	VCD	YVRD	131	-16.4	Australia/Darwin	0
6701	Venice Marco Polo Airport	Venice	Italy	IT	VCE	LIPZ	12.337947	45.502285	Europe/Rome	0
6702	Vichadero Airport	Vichadero	Uruguay	UY	VCH	SUVO	-54.25	-31.733333	America/Montevideo	0
6703	Chu Lai International Airport	Tamky-Chulai Airport	Viet Nam	VN	VCL	VVCA	108.70309	15.413901	Asia/Ho_Chi_Minh	0
6704	Viracopos-Campinas International Airport	Campinas	Brazil	BR	VCP	SBKP	-47.141673	-23.009892	America/Sao_Paulo	0
6705	Carora Airport	Carora	Venezuela	VE	VCR	SVCO	-70.083333	10.183333	America/Caracas	0
6706	County-Foster Airport	Victoria	United States	US	VCT	KVCT	-96.914444	28.851111	America/Chicago	0
6707	Southern California Logistics Airport	Victorville	United States	US	VCV	KVCV	-117.378251	34.586573	America/Los_Angeles	0
6708	Ovda Airport	Ovda	Israel	IL	VDA	LLOV	34.9339	29.952014	Asia/Jerusalem	0
6709	Leirin Airport	Fagernes	Norway	NO	VDB	ENFG	9.288056	61.015556	Europe/Oslo	0
6710	Glauber Rocha Airport	Vitoria Da Conquista	Brazil	BR	VDC	SBVC	-40.916111	-14.906944	America/Belem	0
6711	Hierro Airport	Valverde	Spain and Canary Islands	ES	VDE	GCHI	-17.884937	27.813968	Atlantic/Canary	0
6712	Tampa Executive Airport	Tampa	United States	US	VDF	KVDF	-82.342102	28.010858	America/New_York	0
6713	Dong Hoi Airport	Dong Hoi	Viet Nam	VN	VDH	VVDH	106.590556	17.515	Asia/Ho_Chi_Minh	0
6714	Vidalia Municipal Airport	Vidalia	United States	US	VDI	KVDI	-82.416667	32.216667	America/New_York	0
6951	Warder Airport	Warder	Ethiopia	ET	WRA	HAWR	45.333333	6.966667	Africa/Addis_Ababa	0
6715	Gobernador Edgardo Castello Airport	Viedma	Argentina	AR	VDM	SAVV	-63.0004	-40.8692	America/Argentina/Buenos_Aires	0
6716	Van Don International Airport	Quang Ninh	Viet Nam	VN	VDO	VVVD	107.419444	21.113775	Asia/Ho_Chi_Minh	0
6717	Valle de la Pascua Airport	Valle de la Pascua	Venezuela	VE	VDP	SVVP	-65.991111	9.221389	America/Caracas	0
6718	Villa Dolores Airport	Villa Dolores	Argentina	AR	VDR	SAOD	-65.142222	-31.941111	America/Argentina/Buenos_Aires	0
6719	Vadso Airport	Vadso	Norway	NO	VDS	ENVD	29.845278	70.065	Europe/Oslo	0
6720	Jindal Airport	Vijaynagar	India	IN	VDY	VOJV	76.634947	15.174967	Asia/Kolkata	0
6721	Pioneer Field	Valdez	United States	US	VDZ	PAVD	-146.248026	61.133913	America/Anchorage	0
6722	Venetie Airport	Venetie	United States	US	VEE	PAVE	-146.366358	67.008675	America/Anchorage	0
6723	Maikwak Airport	Maikwak	Guyana	GY	VEG	SYMK	-59.283333	5.55	America/Guyana	0
6724	Veer Surendra Sai Airport	Jharsuguda	India	IN	JRG	VEJH	84.050091	21.912951	Asia/Kolkata	0
6725	Vernal Regional Airport	Vernal	United States	US	VEL	KVEL	-109.510278	40.438889	America/Denver	0
6726	Veracruz International Airport	Veracruz	Mexico	MX	VER	MMVR	-96.18321	19.142275	America/Mexico_City	0
6727	Barakoma Airport	Barakoma	Solomon Islands	SB	VEV	AGBA	159.55	-7.85	Pacific/Guadalcanal	0
6728	Vestmannaeyjar Airport	Vestmannaeyjar	Iceland	IS	VEY	BIVM	-20.277778	63.426389	Atlantic/Reykjavik	0
6729	Victoria Falls Airport	Victoria Falls	Zimbabwe	ZW	VFA	FVFA	25.840278	-18.093056	Africa/Harare	0
6730	Vijayawada Airport	Vijayawada	India	IN	VGA	VOBZ	80.797222	16.529444	Asia/Kolkata	0
6731	Vologda Airport	Vologda	Russian Federation	RU	VGD	ULWW	39.95	59.283333	Europe/Moscow	0
6732	Vigo Airport	Vigo	Spain and Canary Islands	ES	VGO	LEVX	-8.634025	42.224551	Europe/Madrid	0
6733	North Las Vegas Airport	Las Vegas	United States	US	VGT	KVGT	-115.190826	36.210172	America/Los_Angeles	0
6734	Villa Garzon Airport	Villa Garzon	Colombia	CO	VGZ	SKVG	-76.604937	0.982125	America/Bogota	0
6735	Saurimo Airport	Saurimo	Angola	AO	VHC	FNSA	20.55	-9.75	Africa/Luanda	0
6736	Vilhelmina Airport	Vilhelmina	Sweden	SE	VHM	ESNV	16.833586	64.579084	Europe/Stockholm	0
6737	Culberson County Airport	Van Horn	United States	US	VHN	KVHN	-104.783997	31.0578	America/Chicago	0
6738	Charmeil Airport	Vichy	France	FR	VHY	LFLV	3.409722	46.165556	Europe/Paris	0
6739	Vahitahi Airport	Vahitahi	French Polynesia	PF	VHZ	NTUV	-138.833333	-18.583333	Pacific/Tahiti	0
6740	Videira Airport	Videira	Brazil	BR	VIA	SSVI	-51.136111	-27.008333	America/Sao_Paulo	0
6741	Vienna International Airport	Vienna	Austria	AT	VIE	LOWW	16.563583	48.11972	Europe/Vienna	0
6742	El Vigia Airport	El Vigia	Venezuela	VE	VIG	SVVG	-71.65	8.633333	America/Caracas	0
6743	Vinh Airport	Vinh City	Viet Nam	VN	VII	VVVH	105.669709	18.728766	Asia/Ho_Chi_Minh	0
6744	Virgin Gorda Airport	Virgin Gorda	British Virgin Islands	VG	VIJ	TUPW	-64.427735	18.45027	America/Tortola	0
6745	Dakhla Airport	Dakhla	Morocco	MA	VIL	GSVO	-15.929061	23.714534	Africa/Casablanca	0
6746	Havryshivka Vinnytsia International Airport	Vinnytsia	Ukraine	UA	VIN	UKWW	28.606481	49.243126	Europe/Kiev	0
6747	Virginia Airport	Durban	South Africa	ZA	VIR	FAVG	31.058088	-29.770839	Africa/Johannesburg	0
6748	Visalia Municipal Airport	Visalia	United States	US	VIS	KVIS	-119.393889	36.319444	America/Los_Angeles	0
6749	Vitoria Airport	Vitoria	Spain and Canary Islands	ES	VIT	LEVT	-2.725372	42.881961	Europe/Madrid	0
6750	Viru Harbour Airstrip	Viru	Solomon Islands	SB	VIU	AGVH	157.666667	-8.5	Pacific/Guadalcanal	0
6751	Vivigani Airport	Vivigani	Papua New Guinea	PG	VIV	AYVV	150.341667	-9.330556	Pacific/Port_Moresby	0
6752	Eurico de Aguiar Salles Airport	Vitoria	Brazil	BR	VIX	SBVT	-40.289567	-20.256809	America/Sao_Paulo	0
6753	Xai Xai Airport	Xai Xai	Mozambique	MZ	VJB	FQXA	33.616667	-25.033333	Africa/Maputo	0
6754	Virginia Highlands Airport	Abingdon	United States	US	VJI	KVJI	-82.033333	36.686111	America/New_York	0
6755	Rach Gia Airport	Rach Gia	Viet Nam	VN	VKG	VVRG	105.13238	9.95803	Asia/Ho_Chi_Minh	0
6756	Moscow Vnukovo International Airport	Moscow	Russian Federation	RU	VKO	UUWW	37.292098	55.60315	Europe/Moscow	0
6757	Vicksburg Airport	Vicksburg	United States	US	VKS	KVKS	-90.85	32.35	America/Chicago	0
6758	Vorkuta Airport	Vorkuta	Russian Federation	RU	VKT	UUYW	63.995203	67.486238	Europe/Moscow	0
6759	Vandalia Airport	Vandalia	United States	US	VLA	KVLA	-89.1	38.966667	America/Chicago	0
6760	Valencia Airport	Valencia	Spain and Canary Islands	ES	VLC	LEVC	-0.473475	39.491792	Europe/Madrid	0
6761	Valdosta Regional Airport	Valdosta	United States	US	VLD	KVLD	-83.272354	30.784051	America/New_York	0
6762	Villa Gesell Airport	Villa Gesell	Argentina	AR	VLG	SAZV	-57.025808	-37.236258	America/Argentina/Buenos_Aires	0
6763	Port Vila Airport	Port Vila	Vanuatu	VU	VLI	NVVV	168.319503	-17.701853	Pacific/Efate	0
6764	Valladolid Airport	Valladolid	Spain and Canary Islands	ES	VLL	LEVD	-4.844626	41.70581	Europe/Madrid	0
6765	Villamontes Airport	Villamontes	Bolivia	BO	VLM	SLVM	-63.5	-21.25	America/La_Paz	0
6766	Arturo Michelena International Airport	Valencia	Venezuela	VE	VLN	SVVA	-67.922479	10.15429	America/Caracas	0
6767	Vila Rica Municipal Airport	Vila Rica	Brazil	BR	VLP	SWVC	-51.122222	-10.015556	America/Campo_Grande	0
6768	Vallenar Airport	Vallenar	Chile	CL	VLR	SCLL	-70.761667	-28.591667	America/Santiago	0
6769	Valesdir Airport	Valesdir	Vanuatu	VU	VLS	NVSV	168.179006	-16.800254	Pacific/Efate	0
6770	Velikiye Luki Airport	Velikiye Luki	Russian Federation	RU	VLU	ULOL	30.616667	56.383333	Europe/Moscow	0
6771	Colonel Antonio Nicolas Briceno Airport	Valera	Venezuela	VE	VLV	SVVL	-70.585942	9.33998	America/Caracas	0
6772	Villa Reynolds Airport	Villa Mercedes	Argentina	AR	VME	SAOR	-65.378143	-33.724979	America/Argentina/Buenos_Aires	0
6773	Saravane Airport	Saravane	Lao People's Democratic Republic	LA	VNA	VLSV	106.426111	15.692778	Asia/Vientiane	0
6774	Venice Municipal Airport	Venice	United States	US	VNC	KVNC	-82.438754	27.077821	America/New_York	0
6775	Vangaindrano Airport	Vangaindrano	Madagascar	MG	VND	FMSU	47.566667	-23.35	Indian/Antananarivo	0
6776	Meucon Airport	Vannes	France	FR	VNE	LFRV	-2.71856	47.723301	Europe/Paris	0
6777	Vilnius International Airport	Vilnius	Lithuania	LT	VNO	EYVI	25.279605	54.643079	Europe/Vilnius	0
6778	Vanrook Airport	Vanrook	Australia	AU	VNR	YVRS	141.916667	-16.866667	Australia/Brisbane	0
6779	Lal Bahadur Shastri International Airport	Varanasi	India	IN	VNS	VEBN	82.853732	25.449697	Asia/Kolkata	0
6780	Ventspils Airport	Ventspils	Latvia	LV	VNT	EVVA	21.544167	57.357778	Europe/Riga	0
6781	Vilanculos Airport	Vilanculos	Mozambique	MZ	VNX	FQVL	35.283333	-22.016667	Africa/Maputo	0
6782	Van Nuys Airport	Los Angeles	United States	US	VNY	KVNY	-118.490169	34.21016	America/Los_Angeles	0
6783	Volgograd International Airport	Volgograd	Russian Federation	RU	VOG	URWW	44.354805	48.792	Europe/Volgograd	0
6784	Vohemar Airport	Vohemar	Madagascar	MG	VOH	FMNV	50	-13.366667	Indian/Antananarivo	0
6785	Voinjama Airport	Voinjama	Liberia	LR	VOI	GLVA	-9.75	8.416667	Africa/Monrovia	0
6786	Volk Field	Camp Douglas	United States	US	VOK	KVOK	-90.256884	43.937056	America/Chicago	0
6787	Nea Anchialos Airport	Volos	Greece	GR	VOL	LGBL	22.792661	39.220291	Europe/Athens	0
6788	Votuporanga Airport	Votuporanga	Brazil	BR	VOT	SDVG	-49.883333	-20.433333	America/Sao_Paulo	0
6789	Voronezh Airport	Voronezh	Russian Federation	RU	VOZ	UUOO	39.226997	51.812356	Europe/Moscow	0
6790	Ongiva Airport	Ongiva	Angola	AO	VPE	FNGI	15.689624	-17.047413	Africa/Luanda	0
6791	Vopnafjordur Airport	Vopnafjordur	Iceland	IS	VPN	BIVO	-14.8506	65.720596	Atlantic/Reykjavik	0
6792	Destin Fort Walton Beach Airport	Fort Walton Beach	United States	US	VPS	KVPS	-86.549461	30.495913	America/Chicago	0
6793	Chimoio Airport	Chimoio	Mozambique	MZ	VPY	FQCH	33.426891	-19.148927	Africa/Maputo	0
6794	Porter County Regional Airport	Valparaiso	United States	US	VPZ	KVPZ	-87.005278	41.4525	America/Chicago	0
6795	Bathpalathang Airport	Jakar	Bhutan	BT	BUT	VQBT	90.746101	27.562955	Asia/Thimphu	0
6796	Antonio Rivera Rodriguez Airport	Vieques	Puerto Rico	PR	VQS	TJVQ	-65.488031	18.134088	America/Puerto_Rico	0
6797	Juan Gualberto Gomez Airport	Varadero	Cuba	CU	VRA	MUVR	-81.436943	23.039896	America/Havana	0
6798	Vero Beach Regional Airport	Vero Beach	United States	US	VRB	KVRB	-80.413611	27.6525	America/New_York	0
6799	Virac Airport	Virac	Philippines	PH	VRC	RPUV	124.211873	13.579579	Asia/Manila	0
6800	Vredendal Airport	Vredendal	South Africa	ZA	VRE	FAVR	18.5	-31.666667	Africa/Johannesburg	0
6801	Varkaus Airport	Varkaus	Finland	FI	VRK	EFVR	27.861281	62.172505	Europe/Helsinki	0
6802	Vila Real Airport	Vila Real	Portugal	PT	VRL	LPVR	-7.719278	41.275892	Europe/Lisbon	0
6803	Verona Villafranca Airport	Verona	Italy	IT	VRN	LIPX	10.906796	45.40233	Europe/Rome	0
6804	Kawama Airport	Matanzas	Cuba	CU	VRO	MUKW	-81.3	23.133333	America/Havana	0
6805	Vryburg Airport	Vryburg	South Africa	ZA	VRU	FAVB	24.75	-26.916667	Africa/Johannesburg	0
6806	Vaeroy Heliport	Vaeroy	Norway	NO	VRY	ENVR	12.72707	67.654561	Europe/Oslo	0
6807	Carlos Rovirosa Perez International Airport	Villahermosa	Mexico	MX	VSA	MMVA	-92.818987	17.992429	America/Mexico_City	0
6808	Viseu Airport	Viseu	Portugal	PT	VSE	LPVZ	-7.889235	40.722683	Europe/Lisbon	0
6809	Hartness State Airport	Springfield	United States	US	VSF	KVSF	-72.524756	43.341625	America/New_York	0
6810	Vasteras/Hasslo Airport	Stockholm	Sweden	SE	VST	ESOW	16.630556	59.589167	Europe/Stockholm	0
6811	Vitebsk Airport	Vitebsk	Belarus	BY	VTB	UMII	30.35506	55.13008	Europe/Minsk	0
6812	Wattay International Airport	Vientiane	Lao People's Democratic Republic	LA	VTE	VLVT	102.567721	17.975432	Asia/Vientiane	0
6813	Vatulele Airport	Vatulele	Fiji	FJ	VTF	NFVL	177.616667	-18.55	Pacific/Fiji	0
6814	Vung Tau Airport	Vung Tau	Viet Nam	VN	VTG	VVVT	107.091111	10.374444	Asia/Ho_Chi_Minh	0
6815	Vittel Airport	Vittel	France	FR	VTL	LFSZ	5.95	48.2	Europe/Paris	0
6816	Nevatim Air Force Base	Nevatim	Israel	IL	VTM	LLNV	35.012299	31.2083	Asia/Jerusalem	0
6817	Miller Field	Valentine	United States	US	VTN	KVTN	-100.55	42.866667	America/Chicago	0
6818	Hermanos Ameijeiras Airport	Las Tunas	Cuba	CU	VTU	MUVT	-76.939842	20.985606	America/Havana	0
6819	Vishakhapatnam Airport	Vishakhapatnam	India	IN	VTZ	VOVZ	83.22768	17.723596	Asia/Kolkata	0
6820	Valledupar Airport	Valledupar	Colombia	CO	VUP	SKVP	-73.252778	10.436667	America/Bogota	0
6821	Mahanoro Airport	Mahanoro	Madagascar	MG	VVB	FMMH	48.8	-19.833333	Indian/Antananarivo	0
6822	Vanguardia Airport	Villavicencio	Colombia	CO	VVC	SKVV	-73.613773	4.167867	America/Bogota	0
6823	Viru Viru International Airport	Santa Cruz	Bolivia	BO	VVI	SLVR	-63.140489	-17.648234	America/La_Paz	0
6824	Vastervik Airport	Vastervik	Sweden	SE	VVK	ESSW	16.633333	57.75	Europe/Stockholm	0
6825	Malvinas Airport	Malvinas	Peru	PE	VVN	SPWT	-72.940278	-11.85	America/Lima	0
6826	Vladivostok International Airport	Vladivostok	Russian Federation	RU	VVO	UHWW	132.165372	43.396342	Asia/Vladivostok	0
6827	Illizi Airport	Illizi	Algeria	DZ	VVZ	DAAP	8.6208	26.7194	Africa/Algiers	0
6828	Lichinga Airport	Lichinga	Mozambique	MZ	VXC	FQLC	35.25	-13.283333	Africa/Maputo	0
6829	Cesaria Evora International Airport	Sao Vicente	Cape Verde	CV	VXE	GVSV	-25.054359	16.837258	Atlantic/Cape_Verde	0
6830	Vaxjo Airport	Vaxjo	Sweden	SE	VXO	ESMX	14.732046	56.925094	Europe/Stockholm	0
6831	Vryheid Airport	Vryheid	South Africa	ZA	VYD	FAVY	30.8	-27.783333	Africa/Johannesburg	0
6832	Illinois Valley Regional Airport	Peru	United States	US	VYS	KVYS	-89.133333	41.333333	America/Chicago	0
6833	Wales Airport	Wales	United States	US	WAA	PAIW	-168.090833	65.617222	America/Anchorage	0
6834	Waca Airport	Waca	Ethiopia	ET	WAC	HAWC	37.166667	7.166667	Africa/Addis_Ababa	0
6835	Wadi Ad Dawasir Airport	Wadi Ad Dawasir	Saudi Arabia	SA	WAE	OEWD	45.204447	20.498443	Asia/Riyadh	0
6836	Wanganui Airport	Wanganui	New Zealand	NZ	WAG	NZWU	175.024443	-39.960921	Pacific/Auckland	0
6837	Wahpeton Airport	Wahpeton	United States	US	WAH	KBWP	-96.6	46.266667	America/Chicago	0
6838	Ambalabe Airport	Antsohihy	Madagascar	MG	WAI	FMNW	47.993895	-14.89875	Indian/Antananarivo	0
6839	Ankazoabo Airport	Ankazoabo	Madagascar	MG	WAK	FMSZ	44.533333	-22.3	Indian/Antananarivo	0
6840	Wallops Flight Facility	Chincoteague	United States	US	WAL	KWAL	-75.468061	37.941166	America/New_York	0
6841	Ambatondrazaka Airport	Ambatondrazaka	Madagascar	MG	WAM	FMMZ	48.433333	-17.8	Indian/Antananarivo	0
6842	Alto Palena Airport	Alto Palena	Chile	CL	WAP	SCAP	-71.8	-43.616667	America/Santiago	0
6843	Antsalova Airport	Antsalova	Madagascar	MG	WAQ	FMMG	44.616667	-18.7	Indian/Antananarivo	0
6844	Waris Airport	Waris	Indonesia	ID	WAR	WAJR	140.883333	-3.116667	Asia/Jayapura	0
6845	Waterford Airport	Waterford	Ireland	IE	WAT	EIWF	-7.081527	52.188932	Europe/Dublin	0
6846	Wauchope Airport	Wauchope	Australia	AU	WAU	YWAC	152.75	-31.466667	Australia/Sydney	0
6847	Kalkgurung Airport	Wave Hill	Australia	AU	WAV	YWAV	130.95	-17.483333	Australia/Darwin	0
6848	Warsaw Chopin Airport	Warsaw	Poland	PL	WAW	EPWA	20.973289	52.170906	Europe/Warsaw	0
6849	Green County Airport	Waynesburg	United States	US	WAY	KWAY	-77.583333	39.75	America/New_York	0
6850	Wahai Airport	Wahai	Indonesia	ID	WBA	WAPV	129.483333	-2.816667	Asia/Jayapura	0
6851	Befandriana Airport	Befandriana	Madagascar	MG	WBD	FMNF	48.483333	-15.2	Indian/Antananarivo	0
6852	Schleswig Airport	Schleswig	Germany	DE	WBG	ETNS	9.516667	54.45	Europe/Berlin	0
6853	Wapenamanda Airport	Wapenamanda	Papua New Guinea	PG	WBM	AYWD	143.89102	-5.633084	Pacific/Port_Moresby	0
6854	Beroroha Airport	Beroroha	Madagascar	MG	WBO	FMSB	45.133333	-21.6	Indian/Antananarivo	0
6855	Beaver Airport	Beaver	United States	US	WBQ	PAWB	-147.408333	66.362222	America/Anchorage	0
6856	Big Rapids Airport	Big Rapids	United States	US	WBR	KRQB	-85.483333	43.7	America/New_York	0
6857	Wyoming Valle Airport	Wilkes-Barre	United States	US	WBW	KWBW	-75.883333	41.233333	America/New_York	0
6858	Carosue Dam Airport	Kalgoorlie-Boulder	Australia	AU	WCD	YSCD	122.32222	-30.173611	Australia/Perth	0
6859	Nuevo Chaiten Airport	Chaiten	Chile	CL	WCH	SCTN	-72.833889	-42.782222	America/Santiago	0
6860	Chandalar Airport	Chandalar	United States	US	WCR	PALR	-148.5	67.505556	America/Anchorage	0
6861	Weda Bay Airport	Weda	Indonesia	ID	WDB	WAEH	127.9492	0.4678	Asia/Jayapura	0
6862	Enid Woodring Municipal Airport	Enid	United States	US	WDG	KWDG	-97.788232	36.383604	America/Chicago	0
6863	Hosea Kutako International Airport	Windhoek	Namibia	NA	WDH	FYWH	17.463202	-22.487345	Africa/Windhoek	0
6864	Wondai Airport	Wondai	Australia	AU	WDI	YWND	151.816667	-26.333333	Australia/Brisbane	0
6865	Winder Airport	Winder	United States	US	WDR	KWDR	-83.716667	33.983333	America/New_York	0
6866	Shiyan Wudangshan Airport	Shiyan	China	CN	WDS	ZHSY	110.906355	32.589946	Asia/Shanghai	0
6867	Parker County Airport	Weatherford	United States	US	WEA	KWEA	-97.8	32.766667	America/Chicago	0
6868	Weifang Airport	Weifang	China	CN	WEF	ZSWF	119.113469	36.641074	Asia/Shanghai	0
6869	Weihai International Airport	Weihai	China	CN	WEH	ZSWH	122.236067	37.188142	Asia/Shanghai	0
6870	Weipa Airport	Weipa	Australia	AU	WEI	YBWP	141.924697	-12.681317	Australia/Brisbane	0
6871	Welkom Airport	Welkom	South Africa	ZA	WEL	FAWM	26.75	-28	Africa/Johannesburg	0
6872	Wagethe Airport	Wagethe	Indonesia	ID	WET	WABG	135.833333	-4.166667	Asia/Jayapura	0
6873	Wee Waa Airport	Wee Waa	Australia	AU	WEW	YWWA	149.433333	-30.233333	Australia/Sydney	0
6874	Manchester Woodford Airport	Woodford	United Kingdom	GB	WFD	EGCD	-2.148889	53.338056	Europe/London	0
6875	Fianarantsoa Airport	Fianarantsoa	Madagascar	MG	WFI	FMSF	47.110553	-21.441319	Indian/Antananarivo	0
6876	Frenchville Airport	Frenchville	United States	US	WFK	KFVE	-68.333333	47.35	America/New_York	0
6877	Wagga Wagga Airport	Wagga Wagga	Australia	AU	WGA	YSWG	147.466265	-35.159918	Australia/Sydney	0
6878	Warangal Airport	Warangal	India	IN	WGC	VOWA	79.6	17.916667	Asia/Kolkata	0
6879	Walgett Airport	Walgett	Australia	AU	WGE	YWLG	148.133333	-30.033333	Australia/Sydney	0
6880	Winchester Regional Airport	Winchester	United States	US	WGO	KOKV	-78.147094	39.143356	America/New_York	0
6881	Umbu Mehang Kunda Airport	Waingapu	Indonesia	ID	WGP	WATU	120.302005	-9.669213	Asia/Makassar	0
6882	Wangaratta Airport	Wangaratta	Australia	AU	WGT	YWGT	146.333333	-36.366667	Australia/Sydney	0
6883	Eliwana Camp Airport	Eliwana Camp	Australia	AU	WHB	YEWA	116.887222	-22.428889	Australia/Perth	0
6884	Wadi Halfa Airport	Wadi Halfa	Sudan	SD	WHF	HSSW	31.5	21.75	Africa/Khartoum	0
6885	Whakatane Airport	Whakatane	New Zealand	NZ	WHK	NZWK	176.917483	-37.924676	Pacific/Auckland	0
6886	Franz Josef Airport	Franz Josef	New Zealand	NZ	WHO	NZFJ	170.183333	-43.383333	Pacific/Auckland	0
6887	Whiteman Airport	Los Angeles	United States	US	WHP	KWHP	-118.25	34.05	America/Los_Angeles	0
6888	Whalsay Airport	Whalsay	United Kingdom	GB	WHS	EGEH	-0.921905	60.376935	Europe/London	0
6889	Wuhu Air Base	Wuhu	China	CN	WHU	ZSWU	118.410796	31.392401	Asia/Shanghai	0
6890	Wick Airport	Wick	United Kingdom	GB	WIC	EGPC	-3.086667	58.456944	Europe/London	0
6891	Wiesbaden Army Airfield	Wiesbaden	Germany	DE	WIE	ETOU	8.324533	50.04957	Europe/Berlin	0
6892	Waiheke Reeve Airport	Surfdale	New Zealand	NZ	WIK	NZKE	175.085634	-36.810189	Pacific/Auckland	0
6893	Wilson Airport	Nairobi	Kenya	KE	WIL	HKNW	36.813246	-1.318018	Africa/Nairobi	0
6894	Winton Airport	Winton	Australia	AU	WIN	YWTN	143.066667	-22.35	Australia/Brisbane	0
6895	Wilcannia Airport	Wilcannia	Australia	AU	WIO	YWCA	143.55	-31.083333	Australia/Sydney	0
6896	Silampari Airport	Lubuk Linggau	Indonesia	ID	LLJ	WIPB	102.913333	-3.284167	Asia/Makassar	0
6897	Wairoa Airport	Wairoa	New Zealand	NZ	WIR	NZWO	177.405358	-39.014772	Pacific/Auckland	0
6898	Witu Airport	Witu	Papua New Guinea	PG	WIU	WITU	149.5	-4.666667	Pacific/Port_Moresby	0
6899	General William J Fox Airfield	Lancaster	United States	US	WJF	KWJF	-118.218185	34.740316	America/Los_Angeles	0
6900	Wajir Airport	Wajir	Kenya	KE	WJR	HKWJ	40.09167	1.73306	Africa/Nairobi	0
6901	Wonju Airport	Wonju	Republic of Korea	KR	WJU	RKNW	127.965838	37.441926	Asia/Seoul	0
6902	Wanaka Airport	Wanaka	New Zealand	NZ	WKA	NZWF	169.244242	-44.723358	Pacific/Auckland	0
6903	Warracknabeal Airport	Warracknabeal	Australia	AU	WKB	YWKB	142.433333	-36.15	Australia/Sydney	0
6904	Waterkloof Air Force Base	Waterkloof	South Africa	ZA	WKF	FAWK	28.2225	-25.834892	Africa/Johannesburg	0
6905	Hwange Airport	Hwange	Zimbabwe	ZW	WKI	FVWT	26.518333	-18.3625	Africa/Harare	0
6906	Hokkaido Airport	Wakkanai	Japan	JP	WKJ	RJCW	141.797398	45.399428	Asia/Tokyo	0
6907	Walkers Cay Airport	Walkers Cay	Bahamas	BS	WKR	MYAW	-78.4	27.266667	America/Nassau	0
6908	Wallal Downs Airport	Wallal Downs	Australia	AU	WLA	YWAL	120.666667	-19.783333	Australia/Perth	0
6909	Walcha Airport	Walcha	Australia	AU	WLC	YWCH	151.6	-30.983333	Australia/Sydney	0
6910	Strother Field	Winfield	United States	US	WLD	KWLD	-97.037597	37.168594	America/Chicago	0
6911	Wellington International Airport	Wellington	New Zealand	NZ	WLG	NZWN	174.812163	-41.329036	Pacific/Auckland	0
6912	Walaha Airport	Walaha	Vanuatu	VU	WLH	NVSW	167.691593	-15.412913	Pacific/Efate	0
6913	Selawik Airport	Selawik	United States	US	WLK	PASK	-159.983333	66.602778	America/Anchorage	0
6914	Wollogorand Airport	Wollogorand	Australia	AU	WLL	YWOR	137.916667	-17.616667	Australia/Brisbane	0
6915	Waterloo Airport	Waterloo	Australia	AU	WLO	YWTL	129.316667	-16.633333	Australia/Darwin	0
6916	Wallis Island Airport	Wallis Island	Wallis and Futuna Islands	WF	WLS	NLWW	-176.166667	-13.233333	Pacific/Wallis	0
6917	Glenn County Airport	Willows	United States	US	WLW	KWLW	-122.218002	39.516399	America/Los_Angeles	0
6918	Mandritsara Airport	Mandritsara	Madagascar	MG	WMA	FMNX	48.833333	-15.833333	Indian/Antananarivo	0
6919	Warrnambool Airport	Warrnambool	Australia	AU	WMB	YWBL	142.448333	-38.295	Australia/Sydney	0
6920	Winnemucca Municipal Airport	Winnemucca	United States	US	WMC	KWMC	-117.806942	40.904331	America/Los_Angeles	0
6921	Mandabe Airport	Mandabe	Madagascar	MG	WMD	FMSC	44.95	-21.033333	Indian/Antananarivo	0
6922	Mount Keith Airport	Mount Keith	Australia	AU	WME	YMNE	120.550259	-27.284315	Australia/Perth	0
6923	Mountain Home Airport	Mountain Home	United States	US	WMH	KBPK	-92.383333	36.333333	America/Chicago	0
6924	Malaimbandy Airport	Malaimbandy	Madagascar	MG	WML	FMMC	45.55	-20.35	Indian/Antananarivo	0
6925	Maroantsetra Airport	Maroantsetra	Madagascar	MG	WMN	FMNR	49.690302	-15.436459	Indian/Antananarivo	0
6926	White Mountain Airport	White Mountain	United States	US	WMO	PAWM	-163.406667	64.686944	America/Anchorage	0
6927	Mampikony Airport	Mampikony	Madagascar	MG	WMP	FMNP	47.597222	-16.075	Indian/Antananarivo	0
6928	Mananara Nord Airport	Mananara	Madagascar	MG	WMR	FMNC	49.774969	-16.164107	Indian/Antananarivo	0
6929	Wamena Airport	Wamena	Indonesia	ID	WMX	WAVV	138.953592	-4.099906	Asia/Jayapura	0
6930	Napakiak Sea Plane Base	Napakiak	United States	US	WNA	PANA	-161.9785	60.690333	America/Anchorage	0
6931	Windarra Airport	Windarra	Australia	AU	WND	YWDA	121.833333	-28.266667	Australia/Perth	0
6932	Wenshan Puzhehei Airport	Wenshan	China	CN	WNH	ZPWS	104.330926	23.566683	Asia/Shanghai	0
6933	Matahora Airport	Wangiwangi Island	Indonesia	ID	WNI	WAWD	123.635	-5.290556	Asia/Makassar	0
6934	Wunnummin Lake Airport	Wunnummin Lake	Canada	CA	WNN	CKL3	-89.166667	52.916667	America/Winnipeg	0
6935	Naga Airport	Naga	Philippines	PH	WNP	RPUN	123.27	13.587222	Asia/Manila	0
6936	Windorah Airport	Windorah	Australia	AU	WNR	YWDH	142.666667	-25.416667	Australia/Brisbane	0
6937	Nawabshah Airport	Nawabshah	Pakistan	PK	WNS	OPNH	68.392222	26.219444	Asia/Karachi	0
6938	Wenzhou Longwan International Airport	Wenzhou	China	CN	WNZ	ZSWZ	120.847381	27.91566	Asia/Shanghai	0
6939	Woensdrecht Air Base	Woensdrecht Ab	Netherlands	NL	WOE	EHWO	4.342054	51.449072	Europe/Amsterdam	0
6940	Illawara Airport	Wollongong	Australia	AU	WOL	YSHL	150.788885	-34.561352	Australia/Sydney	0
6941	Wondoola Airport	Wondoola	Australia	AU	WON	YWDL	140.9	-18.583333	Australia/Brisbane	0
6942	Wonsan Kalma International Airport	Wonsan	Democratic People's Republic of Korea	KP	WOS	ZKWS	127.486136	39.164242	Asia/Pyongyang	0
6943	Wonan Airport	Wonan	Taiwan	TW	WOT	RCWA	119.5	23.416667	Asia/Taipei	0
6944	Willow Airport	Willow	United States	US	WOW	PAUO	-150.166667	61.833333	America/Anchorage	0
6945	Puerto Aisen Airport	Puerto Aisen	Chile	CL	WPA	SCAS	-72.7	-45.4	America/Santiago	0
6946	Port Berge Airport	Port Berge	Madagascar	MG	WPB	FMNG	47.666667	-15.55	Indian/Antananarivo	0
6947	Pincher Creek Airport	Pincher Creek	Canada	CA	WPC	CZPC	-113.95	49.483333	America/Edmonton	0
6948	Wrotham Park Airport	Wrotham Park	Australia	AU	WPK	YWMP	144	-16.633333	Australia/Brisbane	0
6949	Captain F. Martinez Airport	Porvenir	Chile	CL	WPR	SCFM	-70.323942	-53.252626	America/Santiago	0
6950	Guardiamarina Zanartu Airport	Puerto Williams	Chile	CL	WPU	SCGZ	-67.626297	-54.931099	America/Santiago	0
6952	Robins Air Force Base	Macon	United States	US	WRB	KWRB	-83.58806	32.636712	America/New_York	0
6953	Whangarei Airport	Whangarei	New Zealand	NZ	WRE	NZWR	174.364026	-35.767422	Pacific/Auckland	0
6954	Wrangell Airport	Wrangell	United States	US	WRG	PAWG	-132.366667	56.484444	America/Sitka	0
6955	McGuire Air Force Base	Trenton	United States	US	WRI	KWRI	-74.592989	40.014634	America/New_York	0
6956	Worland Airport	Worland	United States	US	WRL	KWRL	-107.953056	43.9675	America/Denver	0
6957	Windarling Airport	Windarling	Australia	AU	WRN	YWDG	119.386493	-30.032337	Australia/Perth	0
6958	Wroclaw Airport	Wroclaw	Poland	PL	WRO	EPWR	16.899403	51.104822	Europe/Warsaw	0
6959	Warrawagine Airport	Warrawagine	Australia	AU	WRW	YWWG	120.716667	-20.866667	Australia/Perth	0
6960	Westray Airport	Westray	United Kingdom	GB	WRY	EGEW	-2.95	59.35	Europe/London	0
6961	Weerawila Airport	Weerawila	Sri Lanka	LK	WRZ	VCCW	81.234569	6.254053	Asia/Colombo	0
6962	Condron Army Air Field	White Sands	United States	US	WSD	KWSD	-106.406997	32.33806	America/Denver	0
6963	County Airport	Washington	United States	US	WSG	KAFJ	-80.25	40.166667	America/New_York	0
6964	Brookhaven Airport	Shirley	United States	US	WSH	KHWV	-72.8694	40.821899	America/New_York	0
6965	South Naknek Airport	South Naknek	United States	US	WSN	PFWS	-157.004018	58.702779	America/Anchorage	0
6966	Waspam Airport	Waspam	Nicaragua	NI	WSP	MNWP	-83.969445	14.739477	America/Managua	0
6967	Wasior Airport	Wasior	Indonesia	ID	WSR	WAUW	134.5	-2.716667	Asia/Jayapura	0
6968	Westerly State Airport	Westerly	United States	US	WST	KWST	-71.806897	41.350194	America/New_York	0
6969	Whitsunday Airstrip	Airlie Beach	Australia	AU	WSY	YSHR	148.754339	-20.277343	Australia/Brisbane	0
6970	Westport Airport	Westport	New Zealand	NZ	WSZ	NZWS	171.578577	-41.74002	Pacific/Auckland	0
6971	Tambohorano Airport	Tambohorano	Madagascar	MG	WTA	FMMU	43.966667	-17.483333	Indian/Antananarivo	0
6972	Brisbane West Wellcamp Airport	Wellcamp	Australia	AU	WTB	YBWW	151.795	-27.558611	Australia/Brisbane	0
6973	Noatak Airport	Noatak	United States	US	WTK	PAWN	-162.984167	67.563056	America/Anchorage	0
6974	Waddington RAF Station	Waddington	United Kingdom	GB	WTN	EGXW	-0.523825	53.166211	Europe/London	0
6975	Wotho Airport	Wotho	Marshall Islands	MH	WTO	CWTO	166.033333	10.166667	Pacific/Majuro	0
6976	Tsiroanomandidy Airport	Tsiroanomandidy	Madagascar	MG	WTS	FMMX	46.054444	-18.757222	Indian/Antananarivo	0
6977	Wudinna Airport	Wudinna	Australia	AU	WUD	YWUD	135.447006	-33.043301	Australia/Adelaide	0
6978	Wuhan Tianhe International Airport	Wuhan	China	CN	WUH	ZHHH	114.217577	30.776789	Asia/Shanghai	0
6979	Wiluna Airport	Wiluna	Australia	AU	WUN	YWLU	120.220082	-26.628151	Australia/Perth	0
6980	Wuyishan Airport	Wuyishan	China	CN	WUS	ZSWY	118.000604	27.701284	Asia/Shanghai	0
6981	Wau Airport	Wau	South Sudan	SS	WUU	HJWW	27.978742	7.724391	Africa/Juba	0
6982	Wuxi Sunan Shuofang International Airport	Wuxi	China	CN	WUX	ZSWX	120.424374	31.492889	Asia/Shanghai	0
6983	Xijiang Airport	Wuzhou	China	CN	WUZ	ZGWZ	111.099167	23.403056	Asia/Shanghai	0
6984	Rooikop Airport	Walvis Bay	Namibia	NA	WVB	FYWB	14.645329	-22.979712	Africa/Windhoek	0
6985	Watsonville Municipal Airport	Watsonville	United States	US	WVI	KWVI	-121.790001	36.935699	America/Los_Angeles	0
6986	Manakara Airport	Manakara	Madagascar	MG	WVK	FMSK	48.016667	-22.116667	Indian/Antananarivo	0
6987	Waterville Robert LaFleur Airport	Waterville	United States	US	WVL	KWVL	-69.679746	44.533186	America/New_York	0
6988	Mariensiel Airport	Wilhelmshaven	Germany	DE	WVN	EDWI	8.05223	53.502219	Europe/Berlin	0
6989	Wasilla Airport	Wasilla	United States	US	WWA	PAWS	-149.504176	61.57291	America/Anchorage	0
6990	Cape May County Airport	Wildwood	United States	US	WWD	KWWD	-74.908889	39.006389	America/New_York	0
6991	Woodie Woodie Airport	Woodie Woodie Mine	Australia	AU	WWI	YWWI	121.189207	-21.640958	Australia/Perth	0
6992	Boram Airport	Wewak	Papua New Guinea	PG	WWK	AYWK	143.669155	-3.580034	Pacific/Port_Moresby	0
6993	West Woodward Airport	Woodward	United States	US	WWR	KWWR	-99.526389	36.436111	America/Chicago	0
6994	Newtok Airport	Newtok	United States	US	WWT	PAEW	-164.648611	60.922778	America/Anchorage	0
6995	West Wyalong Airport	West Wyalong	Australia	AU	WWY	YWWL	147.25	-33.933333	Australia/Sydney	0
6996	Wuqiao Airport	Wanxian	China	CN	WXN	ZUWX	108.433	30.8017	Asia/Shanghai	0
6997	Whyalla Airport	Whyalla	Australia	AU	WYA	YWHA	137.521971	-33.052411	Australia/Adelaide	0
6998	Yengema Airport	Yengema	Sierra Leone	SL	WYE	GFYE	-11.058889	8.616667	Africa/Freetown	0
6999	Wyndham Airport	Wyndham	Australia	AU	WYN	YWYM	128.1375	-15.507222	Australia/Perth	0
7000	Yellowstone Airport	West Yellowstone	United States	US	WYS	KWYS	-111.104722	44.686667	America/Denver	0
7001	Chapeco Airport	Chapeco	Brazil	BR	XAP	SBCH	-52.660374	-27.132448	America/Sao_Paulo	0
7002	Aribinda Airport	Aribinda	Burkina Faso	BF	XAR	DFOY	-0.866667	14.233333	Africa/Ouagadougou	0
7003	Saul Airport	Saul	French Guiana	GF	XAU	SOOS	-53.2	3.616667	America/Cayenne	0
7004	Bearskin Lake Airport	Bearskin Lake	Canada	CA	XBE	CNE3	-90.983333	53.95	America/Winnipeg	0
7005	Bogande Airport	Bogande	Burkina Faso	BF	XBG	DFEB	-0.133333	12.983333	Africa/Ouagadougou	0
7006	Birjand Airport	Birjand	Iran	IR	XBJ	OIMB	59.25499	32.899053	Asia/Tehran	0
7007	Buno Bedelle Airport	Buno Bedelle	Ethiopia	ET	XBL	HABB	36.333333	8.45	Africa/Addis_Ababa	0
7008	Boulsa Airport	Boulsa	Burkina Faso	BF	XBO	DFEA	-0.566667	12.65	Africa/Ouagadougou	0
7009	Brockville Airport	Brockville	Canada	CA	XBR	CNL3	-75.683333	44.583333	America/Toronto	0
7010	Christmas Island Airport	Christmas Island	Christmas Island	CX	XCH	YPXM	105.666667	-10.5	Indian/Christmas	0
7011	Cluff Lake Airport	Cluff Lake	Canada	CA	XCL	CJS3	-107	59	America/Regina	0
7012	Chatham Airport	Chatham	Canada	CA	XCM	CYCK	-82.081902	42.3064	America/Toronto	0
7013	Colac Airport	Colac	Australia	AU	XCO	YOLA	143.583333	-38.35	Australia/Sydney	0
7014	Chalons Vatry Airport	Chalons-en-Champagne	France	FR	XCR	LFOK	4.19097	48.779595	Europe/Paris	0
7015	Diebougou Airport	Diebougou	Burkina Faso	BF	XDE	DFOU	-3.25	10.966667	Africa/Ouagadougou	0
7016	Djibo Airport	Djibo	Burkina Faso	BF	XDJ	DFCJ	-1.633333	14.1	Africa/Ouagadougou	0
7017	Tasiusaq (Nanotalik) Heliport	Tasiuasaq	Greenland	GL	XEQ	BGTQ	-44.813449	60.194353	America/Godthab	0
7018	Xiangyang Airport	Xiangyang	China	CN	XFN	ZHXF	112.290691	32.150067	Asia/Shanghai	0
7019	Hamburg Finkenwerder Airport	Finkenwerder	Germany	DE	XFW	EDHI	9.835556	53.535278	Europe/Berlin	0
7020	Amilcar Cabral Airport	Gaoua	Burkina Faso	BF	XGA	DFOG	-3.163414	10.383954	Africa/Ouagadougou	0
7021	Gorum-Gorum Airport	Gorom-Gorom	Burkina Faso	BF	XGG	DFEG	-0.233333	14.433333	Africa/Ouagadougou	0
7022	Xangongo Airport	Xangongo	Angola	AO	XGN	FNXA	14.972222	-16.75	Africa/Luanda	0
7023	Kangiqsualujjuaq Airport	Kangiqsualujjuaq	Canada	CA	XGR	CYLU	-65.983333	58.5	America/Toronto	0
7024	Xichang Airport	Xichang	China	CN	XIC	ZUXC	102.187645	27.981922	Asia/Shanghai	0
7025	Ahmed al Jaber Air Base	Ahmed al Jaber	Kuwait	KW	XIJ	OKAJ	47.791972	28.934917	Asia/Kuwait	0
7026	Xilinhot Airport	Xilinhot	China	CN	XIL	ZBXH	115.95924	43.918761	Asia/Shanghai	0
7027	Xingning Airport	Xingning	China	CN	XIN	ZGXN	116	24	Asia/Shanghai	0
7028	Ilimanaq Heliport	Ilimanaq	Greenland	GL	XIQ	BGIL	-51.108807	69.082256	America/Godthab	0
7029	Xi'an Xianyang International Airport	Xian	China	CN	XIY	ZLXY	108.760946	34.438416	Asia/Shanghai	0
7030	Al Udeid Air Base	Doha	Qatar	QA	XJD	OTBH	51.314722	25.117222	Asia/Qatar	0
7031	Kantchari Airport	Kantchari	Burkina Faso	BF	XKA	DFEL	1.516667	12.483333	Africa/Ouagadougou	0
7032	Xieng Khouang Airport	Xieng Khouang	Lao People's Democratic Republic	LA	XKH	VLXK	103.151796	19.444328	Asia/Vientiane	0
7033	Kasabonika Airport	Kasabonika	Canada	CA	XKS	CYAQ	-88.646667	53.52	America/Winnipeg	0
7034	Kaya Airport	Kaya	Burkina Faso	BF	XKY	DFCA	-1.083333	13.083333	Africa/Ouagadougou	0
7035	Lac Brochet Airport	Lac Brochet	Canada	CA	XLB	CZWH	-101.465405	58.615514	America/Winnipeg	0
7036	St. Louis Airport	Saint Louis	Senegal	SN	XLS	GOSS	-16.460278	16.050278	Africa/Dakar	0
7037	Leo Airport	Leo	Burkina Faso	BF	XLU	DFCL	-2.1	11.1	Africa/Ouagadougou	0
7038	Lemwerder Airport	Lemwerder	Germany	DE	XLW	EDWD	8.6	53.166667	Europe/Berlin	0
7039	Mallacoota Airport	Mallacoota	Australia	AU	XMC	YMCO	149.716667	-37.6	Australia/Sydney	0
7040	Madison Airport	Madison	United States	US	XMD	KMDS	-97.116667	44	America/Chicago	0
7041	Mahendranagar Airport	Mahendranagar	Nepal	NP	XMG	VNMN	80.2	28.966667	Asia/Kathmandu	0
7042	Manihi Airport	Manihi	French Polynesia	PF	XMH	NTGI	-146.070784	-14.437609	Pacific/Tahiti	0
7043	Masasi Airport	Masasi	United Republic of Tanzania	TZ	XMI	HTMI	38.8	-10.716667	Africa/Dar_es_Salaam	0
7044	Minlaton Airport	Minlaton	Australia	AU	XML	YMIN	137.533005	-34.75	Australia/Adelaide	0
7045	Xiamen Gaoqi International Airport	Xiamen	China	CN	XMN	ZSAM	118.134178	24.543064	Asia/Shanghai	0
7046	Macmillan Pass Airport	Macmillan Pass	Canada	CA	XMP	CFC4	-135.916667	62.866667	America/Vancouver	0
7047	Macas Airport	Macas	Ecuador	EC	XMS	SEMC	-78.133333	-2.316667	America/Guayaquil	0
7048	Yam Island Airport	Yam Island	Australia	AU	XMY	YYMI	142.773115	-9.898765	Australia/Brisbane	0
7049	Northwest Arkansas Regional Airport	Bentonville	United States	US	XNA	KXNA	-94.297109	36.275259	America/Chicago	0
7050	Ali Air Base	Nasiriyah	Iraq	IQ	XNH	ORTL	46.090124	30.935756	Asia/Baghdad	0
7051	Xining Caojiabao Airport	Xining	China	CN	XNN	ZLXN	102.043002	36.527506	Asia/Shanghai	0
7052	Xingtai Airport	Xingtai	China	CN	XNT	ZBXT	114.5	37.1	Asia/Shanghai	0
7053	Nouna Airport	Nouna	Burkina Faso	BF	XNU	DFON	-3.866667	12.733333	Africa/Ouagadougou	0
7054	Pama Airport	Pama	Burkina Faso	BF	XPA	DFEP	0.7	11.25	Africa/Ouagadougou	0
7055	Pukatawagan Airport	Pukatawagan	Canada	CA	XPK	CZFG	-101.233333	55.766667	America/Winnipeg	0
7056	Poplar River Airport	Poplar River	Canada	CA	XPP	CZNG	-97.3	53	America/Winnipeg	0
7057	Pine Ridge Airport	Pine Ridge	United States	US	XPR	KIEN	-102.516667	43.016667	America/Denver	0
7058	Balad Airbase	Balad	Iraq	IQ	XQC	ORBD	44.370403	33.949337	Asia/Baghdad	0
7059	La Managua Airport	Quepos	Costa Rica	CR	XQP	MRQP	-84.129428	9.443547	America/Costa_Rica	0
7060	RAAF Base Richmond	Richmond	Australia	AU	XRH	YSRI	150.790165	-33.604134	Australia/Sydney	0
7061	Ross River Airport	Ross River	Canada	CA	XRR	CYDM	-132.45	61.983333	America/Vancouver	0
7062	Jerez Airport	Jerez De La Frontera	Spain and Canary Islands	ES	XRY	LEJR	-6.064535	36.750614	Europe/Madrid	0
7063	Yas Island Airport	Sir Bani Yas Island	United Arab Emirates	AE	XSB	OMBY	52.583875	24.283973	Asia/Dubai	0
7064	South Caicos International Airport	South Caicos	Turks and Caicos Islands	TC	XSC	MBSC	-71.529722	21.515833	America/Grand_Turk	0
7065	Tonopah Test Range Airport	Tonopah	United States	US	XSD	KTNX	-116.778611	37.794722	America/Los_Angeles	0
7066	Sebba Airport	Sebba	Burkina Faso	BF	XSE	DFES	0.533333	13.433333	Africa/Ouagadougou	0
7067	South Indian Lake Airport	South Indian Lake	Canada	CA	XSI	CZSN	-98.90753	56.79474	America/Winnipeg	0
7068	Siocon Airport	Siocon	Philippines	PH	XSO	RPNO	122.15	7.7	Asia/Manila	0
7069	Seletar Airport	Singapore	Singapore	SG	XSP	WSSL	103.871122	1.41769	Asia/Singapore	0
7070	Thargomindah Airport	Thargomindah	Australia	AU	XTG	YTGM	143.815152	-27.987414	Australia/Brisbane	0
7071	Tadoule Lake Airport	Tadoule Lake	Canada	CA	XTL	CYBQ	-98.513441	58.707956	America/Winnipeg	0
7072	Taroom Airport	Taroom	Australia	AU	XTO	YTAM	149.898764	-25.802221	Australia/Brisbane	0
7073	Tara Airport	Tara	Australia	AU	XTR	YTAA	150.466667	-27.283333	Australia/Brisbane	0
7074	Xuzhou Guanyin Airport	Xuzhou	China	CN	XUZ	ZSXZ	117.554758	34.055033	Asia/Shanghai	0
7075	Basin International Airport	Williston	United States	US	XWA	KXWA	-103.750556	48.259722	America/Chicago	0
7076	Yandina Airport	Yandina	Solomon Islands	SB	XYA	AGGY	159.216667	-9.116667	Pacific/Guadalcanal	0
7077	Ye Airport	Ye	Myanmar	MM	XYE	VYYE	97.85	15.25	Asia/Yangon	0
7078	Zabre Airport	Zabre	Burkina Faso	BF	XZA	DFEZ	-1	11.133333	Africa/Ouagadougou	0
7079	Anahim Lake Airport	Anahim Lake	Canada	CA	YAA	CAJ4	-125.307311	52.45685	America/Vancouver	0
7080	Arctic Bay Airport	Arctic Bay	Canada	CA	YAB	CYAB	-85.027525	73.004915	America/Iqaluit	0
7081	Cat Lake Airport	Cat Lake	Canada	CA	YAC	CYAC	-91.825289	51.727298	America/Winnipeg	0
7082	Fort Frances Municipal Airport	Fort Frances	Canada	CA	YAG	CYAG	-93.447222	48.652778	America/Winnipeg	0
7083	La Grande-4 Airport	La Grande-4	Canada	CA	YAH	CYAH	-73.678192	53.754126	America/Toronto	0
7084	Chillan Airport	Chillan	Chile	CL	YAI	SCCH	-72.116667	-36.6	America/Santiago	0
7085	Yakutat Airport	Yakutat	United States	US	YAK	PAYA	-139.659722	59.509167	America/Anchorage	0
7086	Alert Bay Airport	Alert Bay	Canada	CA	YAL	CYAL	-126.916667	50.583333	America/Vancouver	0
7087	Sault Ste. Marie Airport	Sault Ste. Marie	Canada	CA	YAM	CYAM	-84.499949	46.485301	America/Toronto	0
7088	Yangambi Airport	Yangambi	The Democratic Republic of The Congo	CD	YAN	FZIR	24.4	0.783333	Africa/Lubumbashi	0
7089	West Angelas Airport	West Angelas	Australia	AU	WLP	YANG	118.70739	-23.135729	Australia/Perth	0
7090	Yaounde Ville Airport	Yaounde	Cameroon	CM	YAO	FKKY	11.52199	3.835258	Africa/Douala	0
7091	Yap International Airport	Yap, Caroline Islands	Micronesia	FM	YAP	PTYA	138.08673	9.497715	Pacific/Chuuk	0
7092	La Grande-3 Airport	La Grande-3	Canada	CA	YAR	CYAD	-76.18887	53.571406	America/Toronto	0
7093	Yasawa Island Airport	Yasawa Island	Fiji	FJ	YAS	NFSW	177.545155	-16.759281	Pacific/Fiji	0
7094	Attawapiskat Airport	Attawapiskat	Canada	CA	YAT	CYAT	-82.4	52.941667	America/Toronto	0
7095	Shearwater Airport	Halifax	Canada	CA	YAW	CYAW	-63.616667	44.866667	America/Halifax	0
7096	Wapekeka Airport	Angling Lake	Canada	CA	YAX	CKB6	-89.579408	53.849215	America/Winnipeg	0
7097	St. Anthony Airport	Saint Anthony	Canada	CA	YAY	CYAY	-55.583333	51.366667	America/St_Johns	0
7098	Tofino Long Beach Airport	Tofino	Canada	CA	YAZ	CYAZ	-125.768599	49.078163	America/Vancouver	0
7099	Banff Airport	Banff	Canada	CA	YBA	CYBA	-115.566667	51.166667	America/Edmonton	0
7100	Kugaaruk Airport	Pelly Bay	Canada	CA	YBB	CYBB	-89.791847	68.538173	America/Edmonton	0
7101	Baie-Comeau Airport	Baie Comeau	Canada	CA	YBC	CYBC	-68.198988	49.13321	America/Toronto	0
7102	Bedarra Island Airport	Bedarra Island	Australia	AU	QIY	YBDA	146.153333	-18.008333	Australia/Brisbane	0
7103	Uranium City Airport	Uranium City	Canada	CA	YBE	CYBE	-108.481003	59.561401	America/Regina	0
7104	Saguenay-Bagotville Airport	La Baie	Canada	CA	YBG	CYBG	-70.985892	48.333417	America/Toronto	0
7105	Bull Harbour Seaplane Base	Bull Harbour	Canada	CA	YBH	CYBH	-127.9339	50.9156	America/Vancouver	0
7106	Black Tickle Airport	Black Tickle	Canada	CA	YBI	CCE4	-55.785678	53.468248	America/Halifax	0
7107	Baker Lake Airport	Baker Lake	Canada	CA	YBK	CYBK	-96.083333	64.3	America/Winnipeg	0
7108	Campbell River Airport	Campbell River	Canada	CA	YBL	CYBL	-125.268126	49.951726	America/Vancouver	0
7109	Bronson Creek Airport	Bronson Creek	Canada	CA	YBM	CAB5	-131	56.7	America/Vancouver	0
7110	Borden CFB Heliport	Borden	Canada	CA	YBN	CYBN	-79.912395	44.27161	America/Toronto	0
7111	Yibin Caiba Airport	Yibin	China	CN	YBP	ZUYB	104.551835	28.801665	Asia/Shanghai	0
7112	Brandon Municipal Airport	Brandon	Canada	CA	YBR	CYBR	-99.946773	49.908687	America/Winnipeg	0
7113	Brochet Airport	Brochet	Canada	CA	YBT	CYBT	-101.678994	57.888469	America/Winnipeg	0
7114	Berens River Airport	Berens River	Canada	CA	YBV	CYBV	-97.021411	52.358695	America/Winnipeg	0
7115	Blanc Sablon Airport	Blanc Sablon	Canada	CA	YBX	CYBX	-57.216667	51.433333	America/Blanc-Sablon	0
7116	Bonnyville Airport	Bonnyville	Canada	CA	YBY	CYBF	-110.750772	54.304758	America/Edmonton	0
7117	Courtenay Airport	Courtenay	Canada	CA	YCA	CAH3	-124.983333	49.683333	America/Vancouver	0
7118	Cambridge Bay Airport	Cambridge Bay	Canada	CA	YCB	CYCB	-105.133333	69.1	America/Edmonton	0
7119	Cornwall Regional Airport	Cornwall	Canada	CA	YCC	CYCC	-74.566667	45.1	America/Toronto	0
7120	Nanaimo Airport	Nanaimo	Canada	CA	YCD	CYCD	-123.872995	49.053158	America/Vancouver	0
7121	Centralia Airport	Centralia	Canada	CA	YCE	CYCE	-81.483333	43.283333	America/Toronto	0
7122	Castlegar Airport	Castlegar	Canada	CA	YCG	CYCG	-117.632222	49.295556	America/Vancouver	0
7123	Miramichi Airport	Miramichi	Canada	CA	YCH	CYCH	-65.437869	47.012714	America/Halifax	0
7124	RAAF Base Curtin	Curtin	Australia	AU	DCN	YCIN	123.828597	-17.580511	Australia/Perth	0
7125	Colville Lake Airport	Colville Lake	Canada	CA	YCK	CYVL	-126.090471	67.039932	America/Edmonton	0
7126	Charlo Airport	Charlo	Canada	CA	YCL	CYCL	-66.328812	47.990927	America/Halifax	0
7127	St. Catharines Airport	Saint Catharines	Canada	CA	YCM	CYSN	-79.166667	43.2	America/Toronto	0
7128	Cochrane Airport	Cochrane	Canada	CA	YCN	CYCN	-81.012895	49.106018	America/Toronto	0
7129	Kugluktuk Airport	Kugluktuk/Coppermine	Canada	CA	YCO	CYCO	-115.083333	67.833333	America/Edmonton	0
7130	Chetwynd Airport	Chetwynd	Canada	CA	YCQ	CYCQ	-121.633333	55.683333	America/Dawson_Creek	0
7131	Charlie Sinclair Memorial Airport	Cross Lake	Canada	CA	YCR	CYCR	-97.760803	54.6106	America/Winnipeg	0
7132	Chesterfield Inlet Airport	Chesterfield Inlet	Canada	CA	YCS	CYCS	-90.716667	63.333333	America/Winnipeg	0
7133	Coronation Airport	Coronation	Canada	CA	YCT	CYCT	-111.416667	52.1	America/Edmonton	0
7134	Yuncheng Airport	Yuncheng	China	CN	YCU	ZBYC	111.037051	35.114987	Asia/Shanghai	0
7135	Chilliwack Airport	Chilliwack	Canada	CA	YCW	CYCW	-121.9	49.166667	America/Vancouver	0
7136	Gagetown CFB Heliport	Gagetown	Canada	CA	YCX	CYCX	-66.436723	45.837788	America/Halifax	0
7137	Clyde River Airport	Clyde River	Canada	CA	YCY	CYCY	-68.5	70.416667	America/Toronto	0
7138	Fairmount Springs Airport	Fairmount Springs	Canada	CA	YCZ	CYCZ	-115.873611	50.331944	America/Edmonton	0
7139	Dawson City Airport	Dawson City	Canada	CA	YDA	CYDA	-139.125977	64.044748	America/Whitehorse	0
7140	Burwash Landings Airport	Burwash Landings	Canada	CA	YDB	CYDB	-139.016667	61.35	America/Vancouver	0
7141	Industrial Airport	Drayton Valley	Canada	CA	YDC	CER3	-114.966667	53.2	America/Edmonton	0
7142	Deer Lake Regional Airport	Deer Lake	Canada	CA	YDF	CYDF	-57.399727	49.21027	America/St_Johns	0
7143	Annapolis Regional Airport	Digby	Canada	CA	YDG	CYID	-65.785564	44.545998	America/Halifax	0
7144	Davis Inlet Airport	Davis Inlet	Canada	CA	YDI	CCB4	-60.95	55.933333	America/Halifax	0
7145	Hatchet Lake Airport	Hatchet Lake	Canada	CA	YDJ	CJL2	-102.539444	58.660556	America/Regina	0
7146	Dease Lake Airport	Dease Lake	Canada	CA	YDL	CYDL	-130.025156	58.424632	America/Vancouver	0
7147	Lt. W.G. (Billy) Barker Airport	Dauphin	Canada	CA	YDN	CYDN	-100.052002	51.1008	America/Winnipeg	0
7148	St. Felicien Airport	Dolbeau	Canada	CA	YDO	CYDO	-72.374972	48.778541	America/Toronto	0
7149	Nain Airport	Nain	Canada	CA	YDP	CYDP	-61.666667	56.533333	America/Halifax	0
7150	Dawson Creek Airport	Dawson Creek	Canada	CA	YDQ	CYDQ	-120.183333	55.733333	America/Dawson_Creek	0
7151	Boundary Bay Airport	Vancouver	Canada	CA	YDT	CZBB	-123.006123	49.077573	America/Vancouver	0
7152	Kasba Lake Airport	Kasba Lake	Canada	CA	YDU	CJL8	-102.503333	60.290278	America/Winnipeg	0
7153	Bloodvein Airport	Bloodvein	Canada	CA	YDV	CZTA	-96.733333	51.75	America/Winnipeg	0
7154	Yecheon Airport	Yecheon	Republic of Korea	KR	YEC	RKTY	128.370356	36.631563	Asia/Seoul	0
7155	CFB Namao Heliport	Edmonton	Canada	CA	YED	CYED	-113.46392	53.671852	America/Edmonton	0
7156	Edmonton International Airport	Edmonton	Canada	CA	YEG	CYEG	-113.584047	53.307375	America/Edmonton	0
7157	Yenisehir Airport	Bursa	Turkiye	TR	YEI	LTBR	29.544743	40.255767	Europe/Istanbul	0
7158	Arviat Airport	Arviat	Canada	CA	YEK	CYEK	-94.05	61.116667	America/Winnipeg	0
7159	Elliot Lake Municipal Airport	Elliot Lake	Canada	CA	YEL	CYEL	-82.563056	46.352222	America/Toronto	0
7160	Manitoulin East Municipal Airport	Manitowaning	Canada	CA	YEM	CYEM	-81.858056	45.842778	America/Toronto	0
7161	Estevan Regional Airport	Estevan	Canada	CA	YEN	CYEN	-102.962821	49.207544	America/Regina	0
7162	Yeovilton Airport	Yeovilton	United Kingdom	GB	YEO	EGDY	-2.55	51.016667	Europe/London	0
7163	Fort Severn Airport	Fort Severn	Canada	CA	YER	CYER	-87.677509	56.017702	America/Toronto	0
7164	Yasuj Airport	Yasouj	Iran	IR	YES	OISY	51.545102	30.700507	Asia/Tehran	0
7165	Edson Airport	Edson	Canada	CA	YET	CYET	-116.466667	53.583333	America/Edmonton	0
7166	Eureka Airport	Eureka	Canada	CA	YEU	CYEU	-85.933333	80	America/Winnipeg	0
7167	Inuvik Mike Zubko Airport	Inuvik	Canada	CA	YEV	CYEV	-133.49767	68.306649	America/Edmonton	0
7168	Amos/Magny Airport	Amos	Canada	CA	YEY	CYEY	-78.241714	48.558741	America/Toronto	0
7169	Fort Albany Airport	Fort Albany	Canada	CA	YFA	CYFA	-81.591667	52.241667	America/Toronto	0
7170	Iqaluit Airport	Iqaluit	Canada	CA	YFB	CYFB	-68.536586	63.75175	America/Toronto	0
7171	Fredericton International Airport	Fredericton	Canada	CA	YFC	CYFC	-66.52978	45.873161	America/Halifax	0
7172	Forestville Airport	Forestville	Canada	CA	YFE	CYFE	-69.066667	48.75	America/Toronto	0
7173	Fort Hope Airport	Fort Hope	Canada	CA	YFH	CYFH	-87.897958	51.559345	America/Toronto	0
7174	Firebag Aerodrome	Firebag River	Canada	CA	YFI	CYFI	-110.976667	57.275833	America/Edmonton	0
7175	Wekweeti Airport	Snare Lake	Canada	CA	YFJ	CYWE	-114.075556	64.190556	America/Edmonton	0
7176	Flin Flon Airport	Flin Flon	Canada	CA	YFO	CYFO	-101.683333	54.683333	America/Winnipeg	0
7177	Fort Resolution Airport	Fort Resolution	Canada	CA	YFR	CYFR	-113.684434	61.176132	America/Edmonton	0
7178	Fort Simpson Airport	Fort Simpson	Canada	CA	YFS	CYFS	-121.233333	61.75	America/Edmonton	0
7179	Fox Harbour Airport	Fox Harbour	Canada	CA	YFX	CCK4	-55.676069	52.370953	America/St_Johns	0
7180	Gillies Bay Airport	Gillies Bay	Canada	CA	YGB	CYGB	-124.533333	49.7	America/Vancouver	0
7181	Grande Cache Airport	Grande Cache	Canada	CA	YGC	CEQ5	-118.866667	53.916667	America/Edmonton	0
7182	Fort Good Hope Airport	Fort Good Hope	Canada	CA	YGH	CYGH	-128.65	66.266667	America/Edmonton	0
7183	Miho Airport	Yonago	Japan	JP	YGJ	RJOH	133.244477	35.500651	Asia/Tokyo	0
7184	Kingston/Norman Rogers Airport	Kingston	Canada	CA	YGK	CYGK	-76.59366	44.219512	America/Toronto	0
7185	La Grande Airport	La Grande	Canada	CA	YGL	CYGL	-77.706389	53.629722	America/Toronto	0
7186	Gimli Industrial Park Airport	Gimli	Canada	CA	YGM	CYGM	-97.043336	50.628055	America/Winnipeg	0
7187	Gods Lake Narrows Airport	Gods Lake Narrows	Canada	CA	YGO	CYGO	-94.491173	54.557701	America/Winnipeg	0
7188	Michel-Pouliot Gaspe Airport	Gaspe	Canada	CA	YGP	CYGP	-64.475971	48.77638	America/Toronto	0
7189	Greenstone Regional Airport	Geraldton	Canada	CA	YGQ	CYGQ	-86.9394	49.778301	America/Toronto	0
7190	Iles De La Madeleine Airport	Iles De La Madeleine	Canada	CA	YGR	CYGR	-61.9	47.366667	America/Halifax	0
7191	Igloolik Airport	Igloolik	Canada	CA	YGT	CYGT	-81.816667	69.4	America/Toronto	0
7192	Havre St. Pierre Airport	Havre St. Pierre	Canada	CA	YGV	CYGV	-63.583333	50.25	America/Toronto	0
7193	Kuujjuarapik Airport	Kuujjuarapik	Canada	CA	YGW	CYGW	-77.766667	55.279167	America/Toronto	0
7194	Gillam Airport	Gillam	Canada	CA	YGX	CYGX	-94.7	56.35	America/Winnipeg	0
7195	Grise Fiord Airport	Grise Fiord	Canada	CA	YGZ	CYGZ	-82.957222	76.417778	America/Toronto	0
7196	Hudson Bay Airport	Hudson Bay	Canada	CA	YHB	CYHB	-102.416667	52.866667	America/Regina	0
7197	Dryden Regional Airport	Dryden	Canada	CA	YHD	CYHD	-92.747061	49.830601	America/Winnipeg	0
7198	Hope Airport	Hope	Canada	CA	YHE	CYHE	-121.416667	49.416667	America/Vancouver	0
7199	Rene Fontaine Municipal Airport	Hearst	Canada	CA	YHF	CYHF	-83.686096	49.714199	America/Toronto	0
7200	Charlottetown Airport	Charlottetown	Canada	CA	YHG	CCH4	-56.118263	52.765459	America/St_Johns	0
7201	Ulukhaktok Airport	Ulukhaktok	Canada	CA	YHI	CYHI	-117.806	70.762802	America/Edmonton	0
7202	Gjoa Haven Airport	Gjoa Haven	Canada	CA	YHK	CYHK	-95.95	68.633333	America/Edmonton	0
7203	John C. Munro Hamilton Airport	Hamilton	Canada	CA	YHM	CYHM	-79.934225	43.173646	America/Toronto	0
7204	Hornepayne Municipal Airport	Hornepayne	Canada	CA	YHN	CYHN	-84.76461	49.188723	America/Toronto	0
7205	Hopedale Airport	Hopedale	Canada	CA	YHO	CYHO	-60.229444	55.448333	America/Halifax	0
7206	Chevery Airport	Chevery	Canada	CA	YHR	CYHR	-59.5	50.5	America/Blanc-Sablon	0
7207	Sechelt Airport	Sechelt	Canada	CA	YHS	CAP3	-123.75	49.466667	America/Vancouver	0
7208	Haines Junction Airport	Haines Junction	Canada	CA	YHT	CYHT	-137.5	60.75	America/Vancouver	0
7209	Aeroport metropolitain de Montreal	Montreal	Canada	CA	YHU	CYHU	-73.420789	45.516318	America/Toronto	0
7210	Merlyn Carter Airport	Hay River	Canada	CA	YHY	CYHY	-115.782997	60.839699	America/Edmonton	0
7211	Halifax Stanfield International Airport	Halifax	Canada	CA	YHZ	CYHZ	-63.514253	44.88496	America/Halifax	0
7212	New Yogyakarta International Airport	Yogyakarta	Indonesia	ID	YIA	WAHI	110.056623	-7.905099	Asia/Jakarta	0
7213	Atikokan Airport	Atikokan	Canada	CA	YIB	CYIB	-91.616667	48.75	America/Atikokan	0
7214	Arxan Yiershi Airport	Arxan	China	CN	YIE	ZBES	119.911944	47.310556	Asia/Shanghai	0
7215	Pakuashipi Airport	Pakuashipi	Canada	CA	YIF	CYIF	-58.666667	51.216667	America/Blanc-Sablon	0
7216	Yichang Sanxia Airport	Yichang	China	CN	YIH	ZHYC	111.478938	30.549934	Asia/Shanghai	0
7217	Ivujivik Airport	Ivujivik	Canada	CA	YIK	CYIK	-77.92529	62.417339	America/Toronto	0
7218	Yining Airport	Yining	China	CN	YIN	ZWYN	81.331444	43.951998	Asia/Shanghai	0
7219	Pond Inlet Airport	Pond Inlet	Canada	CA	YIO	CYIO	-78	72.683333	America/Toronto	0
7220	Willow Run Airport	Detroit	United States	US	YIP	KYIP	-83.533333	42.233333	America/New_York	0
7221	Island Lake Airport	Island Lake	Canada	CA	YIV	CYIV	-94.653043	53.856785	America/Winnipeg	0
7222	Yiwu Airport	Yiwu	China	CN	YIW	ZSYW	120.028808	29.344562	Asia/Shanghai	0
7223	Jasper Airport	Jasper	Canada	CA	YJA	CYJA	-118.057523	52.992122	America/Edmonton	0
7224	Fort Liard Airport	Fort Liard	Canada	CA	YJF	CYJF	-123.466667	60.25	America/Edmonton	0
7225	Saint Jean Airport	Saint Jean	Canada	CA	YJN	CYJN	-73.281293	45.29758	America/Toronto	0
7226	Samjiyon Airport	Samjiyon	Democratic People's Republic of Korea	KP	YJS	ZKSE	128.41	41.907222	Asia/Pyongyang	0
7227	Stephenville Airport	Stephenville	Canada	CA	YJT	CYJT	-58.552972	48.54372	America/St_Johns	0
7228	Kamloops Airport	Kamloops	Canada	CA	YKA	CYKA	-120.442023	50.705447	America/Vancouver	0
7229	Collins Bay Airport	Collins Bay	Canada	CA	YKC	CYKC	-103.677213	58.23561	America/Regina	0
7230	Kincardine Airport	Kincardine	Canada	CA	YKD	CYKM	-81.606667	44.201389	America/Toronto	0
7231	Knee Lake Airport	Knee Lake	Canada	CA	YKE	CJT3	-94.666667	53.05	America/Winnipeg	0
7232	Region of Waterloo International Airport	Kitchener	Canada	CA	YKF	CYKF	-80.385056	43.458978	America/Toronto	0
7233	Kangirsuk Airport	Kangirsuk	Canada	CA	YKG	CYAS	-70.004602	60.023082	America/Toronto	0
7234	Key Lake Airport	Key Lake	Canada	CA	YKJ	CYKJ	-105.618634	57.256287	America/Regina	0
7235	Schefferville Airport	Schefferville	Canada	CA	YKL	CYKL	-66.805282	54.805294	America/Toronto	0
7236	Yakima Air Terminal	Yakima	United States	US	YKM	KYKM	-120.537778	46.566944	America/Los_Angeles	0
7237	Chan Gurney Airport	Yankton	United States	US	YKN	KYKN	-97.386389	42.916944	America/Chicago	0
7238	Hakkari Yuksekova Selahaddin Eyyubi Airport	Yuksekova	Turkiye	TR	YKO	LTCW	44.255164	37.545243	Europe/Istanbul	0
7239	Waskaganish Airport	Waskaganish	Canada	CA	YKQ	CYKQ	-78.75	51.4875	America/Toronto	0
7240	Yakutsk Airport	Yakutsk	Russian Federation	RU	YKS	UEEE	129.750067	62.085607	Asia/Yakutsk	0
7241	Kirkland Lake Airport	Kirkland Lake	Canada	CA	YKX	CYKX	-79.98139	48.210279	America/Toronto	0
7242	Kindersley Regional Airport	Kindersley	Canada	CA	YKY	CYKY	-109.175262	51.517662	America/Regina	0
7243	Buttonville Municipal Airport	Toronto	Canada	CA	YKZ	CYKZ	-79.367734	43.861308	America/Toronto	0
7244	Lac Biche Airport	Lac Biche	Canada	CA	YLB	CYLB	-112.016667	54.766667	America/Edmonton	0
7245	Kimmirut Airport	Kimmirut/Lake Harbour	Canada	CA	YLC	CYLC	-69.883333	62.85	America/Toronto	0
7246	Chapleau Airport	Chapleau	Canada	CA	YLD	CYLD	-83.352778	47.819444	America/Toronto	0
7247	Whati Airport	Whati/Lac La Martre	Canada	CA	YLE	CEM3	-117.243177	63.132944	America/Edmonton	0
7248	Yalgoo Airport	Yalgoo	Australia	AU	YLG	YYAL	116.666667	-28.35	Australia/Perth	0
7249	Lansdowne House Airport	Lansdowne House	Canada	CA	YLH	CYLH	-87.934193	52.195593	America/Toronto	0
7250	Ylivieska Airport	Ylivieska	Finland	FI	YLI	EFYL	24.728889	64.054444	Europe/Helsinki	0
7251	Meadow Lake Airport	Meadow Lake	Canada	CA	YLJ	CYLJ	-108.511841	54.126525	America/Regina	0
7252	Lloydminster Airport	Lloydminster	Canada	CA	YLL	CYLL	-110.072718	53.31297	America/Edmonton	0
7253	Ballera Airport	Ballera	Australia	AU	BBL	YLLE	141.80998	-27.405497	Australia/Brisbane	0
7254	La Tuque Airport	La Tuque	Canada	CA	YLQ	CYLQ	-72.788902	47.409698	America/Toronto	0
7255	Leaf Rapids Airport	Leaf Rapids	Canada	CA	YLR	CYLR	-99.985274	56.513336	America/Winnipeg	0
7256	Lebel-Sur-Quevillon Airport	Lebel-Sur-Quevillon	Canada	CA	YLS	CSH4	-77.016667	49.033333	America/Toronto	0
7257	Alert Airport	Alert	Canada	CA	YLT	CYLT	-62.283333	82.516667	America/Winnipeg	0
7258	Kelowna International Airport	Kelowna	Canada	CA	YLW	CYLW	-119.381396	49.951542	America/Vancouver	0
7259	Langley Regional Airport	Langley	Canada	CA	YLY	CYNJ	-122.630833	49.100833	America/Vancouver	0
7260	Mayo Airport	Mayo	Canada	CA	YMA	CYMA	-135.873611	63.616389	America/Vancouver	0
7261	Merritt Airport	Merritt	Canada	CA	YMB	CAD5	-120.75	50.116667	America/Vancouver	0
7262	Matane Airport	Matane	Canada	CA	YME	CYME	-67.516667	48.833333	America/Toronto	0
7263	Manitouwadge Airport	Manitouwadge	Canada	CA	YMG	CYMG	-85.866667	49.083333	America/Toronto	0
7264	Mary's Harbour Airport	Mary's Harbour	Canada	CA	YMH	CYMH	-55.847787	52.303039	America/St_Johns	0
7265	C.M. McEwen Airport	Moose Jaw	Canada	CA	YMJ	CYMJ	-105.556196	50.330287	America/Regina	0
7266	Mys Kamennyy Airport	Mys Kamennyy	Russian Federation	RU	YMK	USDK	73.595732	68.46843	Asia/Yekaterinburg	0
7267	Charlevoix Airport	Murray Bay	Canada	CA	YML	CYML	-70.166667	47.65	America/Toronto	0
7268	Fort McMurray International Airport	Fort McMurray	Canada	CA	YMM	CYMM	-111.223952	56.656589	America/Edmonton	0
7269	Murrin Murrin Airport	Murrin Murrin	Australia	AU	WUI	YMMI	121.886149	-28.710743	Australia/Perth	0
7270	Makkovik Airport	Makkovik	Canada	CA	YMN	CYFT	-59.166667	55.166667	America/Halifax	0
7271	Moosonee Airport	Moosonee	Canada	CA	YMO	CYMO	-80.604167	51.291111	America/Toronto	0
7272	Yurimaguas Airport	Yurimaguas	Peru	PE	YMS	SPMS	-76.1	-5.9	America/Lima	0
7273	Chibougamau Airport	Chibougamau	Canada	CA	YMT	CYMT	-74.366667	49.916667	America/Toronto	0
7274	Maniwaki Airport	Maniwaki	Canada	CA	YMW	CYMW	-75.966667	46.383333	America/Toronto	0
7275	Mirabel International Airport	Montreal	Canada	CA	YMX	CYMX	-74.024407	45.680615	America/Toronto	0
7276	Natashquan Airport	Natashquan	Canada	CA	YNA	CYNA	-61.8	50.183333	America/Toronto	0
7277	Yanbu Airport	Yanbu	Saudi Arabia	SA	YNB	OEYN	38.063019	24.140733	Asia/Riyadh	0
7278	Wemindji Airport	Wemindji	Canada	CA	YNC	CYNC	-78.816667	53	America/Toronto	0
7279	Gatineau Airport	Gatineau	Canada	CA	YND	CYND	-75.562827	45.520631	America/Toronto	0
7280	Norway House Airport	Norway House	Canada	CA	YNE	CYNE	-97.845833	53.954167	America/Winnipeg	0
7281	Youngstown-Warren Regional Airport	Youngstown	United States	US	YNG	KYNG	-80.669722	41.256111	America/New_York	0
7282	Hudson's Hope Airport	Hudson's Hope	Canada	CA	YNH	CYNH	-121.9	56	America/Edmonton	0
7283	Yanji Chaoyangchuan Airport	Yanji	China	CN	YNJ	ZYYJ	129.439369	42.885662	Asia/Shanghai	0
7284	Points North Landing Airport	Points North Landing	Canada	CA	YNL	CYNL	-104.081111	58.275	America/Regina	0
7285	Matagami Airport	Matagami	Canada	CA	YNM	CYNM	-77.8	49.75	America/Toronto	0
7286	Nemiscau Airport	Nemiscau	Canada	CA	YNS	CYHH	-76.135564	51.691056	America/Toronto	0
7287	Penglai International Airport	Yantai	China	CN	YNT	ZSYT	120.987222	37.657222	Asia/Shanghai	0
7288	Yangyang Airport	Yangyang	Republic of Korea	KR	YNY	RKNY	128.663985	38.059459	Asia/Seoul	0
7289	Yancheng Nanyang International Airport	Yancheng	China	CN	YNZ	ZSYN	120.204406	33.431217	Asia/Shanghai	0
7290	Ekati Airport	Ekati	Canada	CA	YOA	CYOA	-110.614444	64.699444	America/Edmonton	0
7291	Old Crow Airport	Old Crow	Canada	CA	YOC	CYOC	-139.849179	67.568133	America/Vancouver	0
7292	R.W. McNair Airport	Cold Lake	Canada	CA	YOD	CYOD	-110.278999	54.404999	America/Edmonton	0
7293	Ogoki Airport	Ogoki	Canada	CA	YOG	CYKP	-85.916667	51.666667	America/Toronto	0
7294	Oxford House Airport	Oxford House	Canada	CA	YOH	CYOH	-95.276677	54.934241	America/Winnipeg	0
7295	High Level Airport	High Level	Canada	CA	YOJ	CYOJ	-117.165001	58.621399	America/Edmonton	0
7296	Yola Airport	Yola	Nigeria	NG	YOL	DNYO	12.426414	9.267332	Africa/Lagos	0
7297	Yongphulla Airport	Trashigang	Bhutan	BT	YON	VQTY	91.514444	27.256389	Asia/Thimphu	0
7298	Oshawa Municipal Airport	Oshawa	Canada	CA	YOO	CYOO	-78.9	43.916667	America/Toronto	0
7299	Rainbow Lake Airport	Rainbow Lake	Canada	CA	YOP	CYOP	-119.413406	58.494372	America/Edmonton	0
7300	Billy Bishop Regional Airport	Owen Sound	Canada	CA	YOS	CYOS	-80.8375	44.590278	America/Toronto	0
7301	Ottawa/Macdonald-Cartier International Airport	Ottawa	Canada	CA	YOW	CYOW	-75.672778	45.320833	America/Toronto	0
7302	Valcartier CFB Heliport	Valcartier	Canada	CA	YOY	CYOY	-72.493605	45.892533	America/Toronto	0
7303	Glass Field	Prince Albert	Canada	CA	YPA	CYPA	-105.676601	53.21585	America/Regina	0
7304	Nora A. Ruben Airport	Paulatuk	Canada	CA	YPC	CYPC	-124.07547	69.360838	America/Edmonton	0
7305	Parry Sound Airport	Parry Sound	Canada	CA	YPD	CNK4	-79.827109	45.255391	America/Toronto	0
7306	Peace River Airport	Peace River	Canada	CA	YPE	CYPE	-117.442556	56.231854	America/Edmonton	0
7307	Esquimalt Airport	Esquimalt	Canada	CA	YPF	CYPF	-123.4	48.433333	America/Vancouver	0
7308	Southport Airport	Portage La Prarie	Canada	CA	YPG	CYPG	-98.273817	49.903099	America/Winnipeg	0
7309	Inukjuak Airport	Inukjuak	Canada	CA	YPH	CYPH	-78.166667	58.433333	America/Toronto	0
7310	Aupaluk Airport	Aupaluk	Canada	CA	YPJ	CYLA	-69.666667	59.3	America/Toronto	0
7311	Pickle Lake Airport	Pickle Lake	Canada	CA	YPL	CYPL	-90.21415	51.44646	America/Atikokan	0
7312	Pikangikum Airport	Pikangikum	Canada	CA	YPM	CYPM	-93.972869	51.817377	America/Winnipeg	0
7313	Port-Menier Airport	Port-Menier	Canada	CA	YPN	CYPN	-64.291116	49.837066	America/Toronto	0
7314	Peawanuk Airport	Peawanuk	Canada	CA	YPO	CYPO	-85.433333	54.983333	America/Toronto	0
7315	Peterborough Airport	Peterborough	Canada	CA	YPQ	CYPQ	-78.357789	44.233199	America/Toronto	0
7316	Digby Island Airport	Prince Rupert	Canada	CA	YPR	CYPR	-130.440833	54.287222	America/Vancouver	0
7317	Port Hawkesbury Airport	Port Hawkesbury	Canada	CA	YPS	CYPD	-61.35	45.616667	America/Halifax	0
7318	Powell River Airport	Powell River	Canada	CA	YPW	CYPW	-124.5	49.816667	America/Vancouver	0
7319	Puvirnituq Airport	Povungnituk	Canada	CA	YPX	CYPX	-77.166667	60.033333	America/Toronto	0
7320	Fort Chipewyan Airport	Fort Chipewyan	Canada	CA	YPY	CYPY	-111.114062	58.767989	America/Edmonton	0
7321	Burns Lake Airport	Burns Lake	Canada	CA	YPZ	CYPZ	-125.766667	54.233333	America/Vancouver	0
7322	Muskoka Airport	Muskoka	Canada	CA	YQA	CYQA	-79.306808	44.976497	America/Toronto	0
7323	Quebec City Jean Lesage International Airport	Quebec	Canada	CA	YQB	CYQB	-71.383388	46.792037	America/Toronto	0
7324	Quaqtaq Airport	Quaqtaq	Canada	CA	YQC	CYHA	-69.633333	61.333333	America/Toronto	0
7325	The Pas Airport	The Pas	Canada	CA	YQD	CYQD	-101.1	53.966667	America/Winnipeg	0
7326	Red Deer Regional Airport	Red Deer	Canada	CA	YQF	CYQF	-113.893333	52.176944	America/Edmonton	0
7327	Windsor International Airport	Windsor	Canada	CA	YQG	CYQG	-82.95919	42.266386	America/Toronto	0
7328	Watson Lake Airport	Watson Lake	Canada	CA	YQH	CYQH	-128.825	60.123611	America/Vancouver	0
7329	Yarmouth Airport	Yarmouth	Canada	CA	YQI	CYQI	-66.083333	43.833333	America/Halifax	0
7330	Kenora Airport	Kenora	Canada	CA	YQK	CYQK	-94.358333	49.7875	America/Winnipeg	0
7331	Lethbridge Airport	Lethbridge	Canada	CA	YQL	CYQL	-112.791667	49.631944	America/Edmonton	0
7332	Greater Moncton International Airport	Moncton	Canada	CA	YQM	CYQM	-64.686106	46.113609	America/Halifax	0
7333	Nakina Airport	Nakina	Canada	CA	YQN	CYQN	-86.699242	50.182993	America/Toronto	0
7334	Comox Airport	Comox	Canada	CA	YQQ	CYQQ	-124.907815	49.705865	America/Vancouver	0
7335	Regina International Airport	Regina	Canada	CA	YQR	CYQR	-104.65519	50.433326	America/Regina	0
7336	Pembroke Area Municipal Airport	Saint Thomas	Canada	CA	YQS	CYQS	-81.2	42.783333	America/Toronto	0
7337	Thunder Bay International Airport	Thunder Bay	Canada	CA	YQT	CYQT	-89.31167	48.371841	America/Toronto	0
7338	Grande Prairie Airport	Grande Prairie	Canada	CA	YQU	CYQU	-118.873603	55.177076	America/Edmonton	0
7339	Yorkton Municipal Airport	Yorkton	Canada	CA	YQV	CYQV	-102.459351	51.264097	America/Regina	0
7340	Cameron McIntosh Airport	North Battleford	Canada	CA	YQW	CYQW	-108.244003	52.769199	America/Regina	0
7341	Gander International Airport	Gander	Canada	CA	YQX	CYQX	-54.570223	48.946243	America/St_Johns	0
7342	Sydney Airport	Sydney	Canada	CA	YQY	CYQY	-60.05	46.166667	America/Halifax	0
7343	Quesnel Airport	Quesnel	Canada	CA	YQZ	CYQZ	-122.509722	53.026667	America/Vancouver	0
7344	Null	Campbell River	Canada	CA	YR6	CYR6	-125.35	50.11667	America/Vancouver	0
7345	Gameti Rae Lakes Airport	Rae Lakes	Canada	CA	YRA	CYRA	-117.311732	64.116888	America/Edmonton	0
7346	Resolute Bay Airport	Resolute	Canada	CA	YRB	CYRB	-94.966667	74.716667	America/Winnipeg	0
7347	Cartwright Airport	Cartwright	Canada	CA	YRF	CYCA	-57.03828	53.682606	America/Halifax	0
7348	Rigolet Airport	Rigolet	Canada	CA	YRG	CCZ2	-58.416667	54.333333	America/Halifax	0
7349	Riviere-du-Loup Airport	Riviere-du-Loup	Canada	CA	YRI	CYRI	-69.533333	47.833333	America/Toronto	0
7350	Roberval Airport	Roberval	Canada	CA	YRJ	CYRJ	-72.267327	48.522342	America/Toronto	0
7351	Red Lake Airport	Red Lake	Canada	CA	YRL	CYRL	-93.800059	51.068762	America/Winnipeg	0
7352	Rocky Mountain House Airport	Rocky Mountain House	Canada	CA	YRM	CYRM	-114.916667	52.366667	America/Edmonton	0
7353	Rockcliffe Airport	Ottawa	Canada	CA	YRO	CYRO	-75.646103	45.4603	America/Toronto	0
7354	Trois-Rivieres Airport	Trois-Rivieres	Canada	CA	YRQ	CYRQ	-72.675591	46.362201	America/Toronto	0
7355	Red Sucker Lake Airport	Red Sucker Lake	Canada	CA	YRS	CYRS	-93.557619	54.167569	America/Winnipeg	0
7356	Rankin Inlet Airport	Rankin Inlet	Canada	CA	YRT	CYRT	-92.100187	62.80998	America/Winnipeg	0
7357	Revelstoke Airport	Revelstoke	Canada	CA	YRV	CYRV	-118.166667	51	America/Vancouver	0
7358	Sudbury Airport	Sudbury	Canada	CA	YSB	CYSB	-80.795924	46.622961	America/Toronto	0
7359	Sherbrooke Airport	Sherbrooke	Canada	CA	YSC	CYSC	-71.9	45.416667	America/Toronto	0
7360	Suffield CFB Heliport	Suffield	Canada	CA	YSD	CYSD	-111.183701	50.275541	America/Edmonton	0
7361	Squamish Airport	Squamish	Canada	CA	YSE	CYSE	-123.161944	49.781667	America/Vancouver	0
7362	Stony Rapids Airport	Stony Rapids	Canada	CA	YSF	CYSF	-105.836574	59.251162	America/Regina	0
7363	Lutselke Airport	Lutselke/Snowdrift	Canada	CA	YSG	CYLK	-110.075556	62.418611	America/Edmonton	0
7364	Montague Airport	Smith Falls	Canada	CA	YSH	CYSH	-75.939592	44.94829	America/Toronto	0
7365	Saint John Airport	Saint John	Canada	CA	YSJ	CYSJ	-65.890201	45.32948	America/Halifax	0
7366	Sanikiluaq Airport	Sanikiluaq	Canada	CA	YSK	CYSK	-79.216667	56.55	America/Toronto	0
7367	St Leonard Airport	St Leonard	Canada	CA	YSL	CYSL	-67.835866	47.156841	America/Halifax	0
7368	Fort Smith Airport	Fort Smith	Canada	CA	YSM	CYSM	-111.966667	60.016667	America/Edmonton	0
7369	Salmon Arm Airport	Salmon Arm	Canada	CA	YSN	CZAM	-119.233333	50.683333	America/Vancouver	0
7370	Postville Airport	Postville	Canada	CA	YSO	CCD4	-59.966667	54.916667	America/Halifax	0
7371	Marathon Airport	Marathon	Canada	CA	YSP	CYSP	-86.35	48.75	America/Toronto	0
7372	Nanisivik Airport	Nanisivik	Canada	CA	YSR	CYSR	-84.5	73.75	America/Toronto	0
7373	St. Theresa Point Airport	St. Theresa Point	Canada	CA	YST	CYST	-94.851598	53.846127	America/Winnipeg	0
7374	Summerside Airport	Summerside	Canada	CA	YSU	CYSU	-63.833612	46.44059	America/Halifax	0
7375	Sachs Harbour Airport	Sachs Harbour	Canada	CA	YSY	CYSY	-125.241046	71.991445	America/Edmonton	0
7376	Pembroke And Area Airport	Pembroke	Canada	CA	YTA	CYTA	-77.249444	45.861667	America/Toronto	0
7377	Thicket Portage Airport	Thicket Portage	Canada	CA	YTD	CZLQ	-97.7	55.316667	America/Winnipeg	0
7378	Cape Dorset Airport	Cape Dorset	Canada	CA	YTE	CYTE	-76.533333	64.233333	America/Toronto	0
7379	Trepell Airport	Trepell	Australia	AU	TQP	YTEE	140.893762	-21.839603	Australia/Brisbane	0
7380	Alma Airport	Alma	Canada	CA	YTF	CYTF	-71.642714	48.509654	America/Toronto	0
7381	Thompson Airport	Thompson	Canada	CA	YTH	CYTH	-97.8605	55.797532	America/Winnipeg	0
7382	Terrace Bay Airport	Terrace Bay	Canada	CA	YTJ	CYTJ	-87.166667	48.75	America/Toronto	0
7383	Big Trout Airport	Big Trout	Canada	CA	YTL	CYTL	-89.889516	53.815942	America/Winnipeg	0
7384	Mont-Tremblant International Airport	La Macaza	Canada	CA	YTM	CYFJ	-74.780056	46.405758	America/Toronto	0
7385	Tasiujuaq Airport	Tasiujuaq	Canada	CA	YTQ	CYTQ	-69.956328	58.6678	America/Toronto	0
7386	Trenton Airport	Trenton	Canada	CA	YTR	CYTR	-77.583333	44.1	America/Toronto	0
7387	Timmins Victor M. Power Airport	Timmins	Canada	CA	YTS	CYTS	-81.371642	48.566371	America/Toronto	0
7388	Truscott-Mungalalu Airport	Truscott	Australia	AU	TTX	YTST	126.380997	-14.0897	Australia/Perth	0
7389	Tisdale Airport	Tisdale	Canada	CA	YTT	CJY3	-104.066667	52.85	America/Regina	0
7390	Telegraph Creek Airport	Telegraph Creek	Canada	CA	YTX	CBM5	-131.15	57.9	America/Vancouver	0
7391	Yangzhou Taizhou Airport	Yangzhou	China	CN	YTY	ZSYA	119.720278	32.563057	Asia/Shanghai	0
7392	Billy Bishop Toronto City Airport	Toronto	Canada	CA	YTZ	CYTZ	-79.396202	43.627499	America/Toronto	0
7393	Yuanmou Airport	Yuanmou	China	CN	YUA	ZPYM	101.916667	25.65	Asia/Shanghai	0
7394	James Gruben Airport	Tuktoyaktuk	Canada	CA	YUB	CYUB	-133.026001	69.433296	America/Edmonton	0
7395	Umiujaq Airport	Umiujaq	Canada	CA	YUD	CYMU	-76.518333	56.536111	America/Toronto	0
7396	Yuendumu Airport	Yuendumu	Australia	AU	YUE	YYND	131.816667	-22.266667	Australia/Darwin	0
7397	Montreal-Trudeau International Airport	Montreal	Canada	CA	YUL	CYUL	-73.749906	45.457715	America/Toronto	0
7398	Yuma International Airport	Yuma	United States	US	YUM	KNYL	-114.599263	32.668605	America/Phoenix	0
7399	Yushu Batang Airport	Yushu	China	CN	YUS	ZLYS	97.037791	32.839468	Asia/Shanghai	0
7400	Repulse Bay Airport	Repulse Bay	Canada	CA	YUT	CYUT	-86.228593	66.524844	America/Winnipeg	0
7401	Hall Beach Airport	Hall Beach	Canada	CA	YUX	CYUX	-81.25	68.783333	America/Toronto	0
7402	Rouyn-Noranda Airport	Rouyn	Canada	CA	YUY	CYUY	-78.828967	48.211769	America/Toronto	0
7403	Bonaventure Airport	Bonaventure	Canada	CA	YVB	CYVB	-65.458079	48.069083	America/Toronto	0
7404	Barber Field	La Ronge	Canada	CA	YVC	CYVC	-105.262097	55.151395	America/Regina	0
7405	Vernon Airport	Vernon	Canada	CA	YVE	CYVK	-119.333333	50.25	America/Vancouver	0
7406	Vermilion Airport	Vermilion	Canada	CA	YVG	CYVG	-110.829385	53.355538	America/Edmonton	0
7407	Qikiqtarjuaq Airport	Qikiqtarkuaq	Canada	CA	YVM	CYVM	-64.031386	67.545832	America/Toronto	0
7408	Val-d'Or Airport	Val D'Or	Canada	CA	YVO	CYVO	-77.788583	48.052603	America/Toronto	0
7409	Kuujjuaq Airport	Kuujjuaq	Canada	CA	YVP	CYVP	-68.41798	58.100237	America/Toronto	0
7410	Norman Wells Airport	Norman Wells	Canada	CA	YVQ	CYVQ	-126.793375	65.277854	America/Edmonton	0
7411	Vancouver International Airport	Vancouver	Canada	CA	YVR	CYVR	-123.179191	49.194697	America/Vancouver	0
7412	Buffalo Narrows Airport	Buffalo Narrows	Canada	CA	YVT	CYVT	-108.466667	55.866667	America/Regina	0
7413	Wiarton Airport	Wiarton	Canada	CA	YVV	CYVV	-81.166667	44.666667	America/Toronto	0
7414	Deer Lake Airport	Deer Lake	Canada	CA	YVZ	CYVZ	-94.5	52.666667	America/Winnipeg	0
7415	Petawawa Airport	Petawawa	Canada	CA	YWA	CYWA	-77.283333	45.9	America/Toronto	0
7416	Kangiqsujuaq Airport	Kangiqsujuaq	Canada	CA	YWB	CYKG	-71.95	61.6	America/Toronto	0
7417	Winnipeg James Armstrong Richardson Intl Airport	Winnipeg	Canada	CA	YWG	CYWG	-97.223716	49.905756	America/Winnipeg	0
7418	Victoria Inner Harbour Airport	Victoria	Canada	CA	YWH	CYWH	-123.370576	48.42395	America/Vancouver	0
7419	Deline Airport	Deline	Canada	CA	YWJ	CYWJ	-123.5	65.166667	America/Edmonton	0
7420	Wabush Airport	Wabush	Canada	CA	YWK	CYWK	-66.873999	52.926315	America/Halifax	0
7421	Williams Lake Airport	Williams Lake	Canada	CA	YWL	CYWL	-122.044444	52.184722	America/Vancouver	0
7422	Williams Harbour Airport	Williams Harbour	Canada	CA	YWM	CCA6	-55.784262	52.566879	America/St_Johns	0
7423	Lupin Airport	Lupin	Canada	CA	YWO	CYWO	-111.25	65.758333	America/Edmonton	0
7424	Webequie Airport	Webequie	Canada	CA	YWP	CYWP	-87.368889	52.959722	America/Toronto	0
7425	White River Sea Plane Base	White River	Canada	CA	YWR	CYWR	-85.223249	48.626896	America/Toronto	0
7426	Wrigley Airport	Wrigley	Canada	CA	YWY	CYWY	-123.438611	63.210556	America/Edmonton	0
7427	Canadian Rockies International Airport	Cranbrook	Canada	CA	YXC	CYXC	-115.787024	49.614368	America/Edmonton	0
7428	Saskatoon International Airport	Saskatoon	Canada	CA	YXE	CYXE	-106.690366	52.169703	America/Regina	0
7429	Medicine Hat Regional Airport	Medicine Hat	Canada	CA	YXH	CYXH	-110.724628	50.021131	America/Edmonton	0
7430	North Peace Regional Airport	Fort St. John	Canada	CA	YXJ	CYXJ	-120.735081	56.244836	America/Dawson_Creek	0
7431	Rimouski Airport	Rimouski	Canada	CA	YXK	CYXK	-68.50508	48.475399	America/Toronto	0
7432	Sioux Lookout Airport	Sioux Lookout	Canada	CA	YXL	CYXL	-91.902998	50.115209	America/Winnipeg	0
7433	Whale Cove Airport	Whale Cove	Canada	CA	YXN	CYXN	-92.6	62.233333	America/Winnipeg	0
7434	Pangnirtung Airport	Pangnirtung	Canada	CA	YXP	CYXP	-65.733333	66.133333	America/Toronto	0
7435	Beaver Creek Airport	Beaver Creek	Canada	CA	YXQ	CYXQ	-141	62	America/Vancouver	0
7436	Earlton Airport	Earlton	Canada	CA	YXR	CYXR	-79.851944	47.697222	America/Toronto	0
7437	Prince George Airport	Prince George	Canada	CA	YXS	CYXS	-122.673956	53.88381	America/Vancouver	0
7438	Northwest Regional Airport	Terrace	Canada	CA	YXT	CYXT	-128.576548	54.472026	America/Vancouver	0
7439	London International Airport	London	Canada	CA	YXU	CYXU	-81.149651	43.028018	America/Toronto	0
7440	Abbotsford Airport	Vancouver	Canada	CA	YXX	CYXX	-122.361944	49.025556	America/Vancouver	0
7441	Whitehorse Airport	Whitehorse	Canada	CA	YXY	CYXY	-135.066667	60.716667	America/Whitehorse	0
7442	Wawa Airport	Wawa	Canada	CA	YXZ	CYXZ	-84.785833	47.9625	America/Toronto	0
7443	Jack Garland Airport	North Bay	Canada	CA	YYB	CYYB	-79.42725	46.356824	America/Toronto	0
7444	Calgary International Airport	Calgary	Canada	CA	YYC	CYYC	-114.010551	51.131394	America/Edmonton	0
7445	Smithers Airport	Smithers	Canada	CA	YYD	CYYD	-127.180278	54.825556	America/Vancouver	0
7446	Northern Rockies Regional Airport	Fort Nelson	Canada	CA	YYE	CYYE	-122.581682	58.838433	America/Dawson_Creek	0
7447	Penticton Airport	Penticton	Canada	CA	YYF	CYYF	-119.6	49.464722	America/Vancouver	0
7448	Charlottetown Airport	Charlottetown	Canada	CA	YYG	CYYG	-63.131736	46.285898	America/Halifax	0
7449	Taloyoak Airport	Taloyoak	Canada	CA	YYH	CYYH	-93.516667	69.533333	America/Edmonton	0
7450	Victoria International Airport	Victoria	Canada	CA	YYJ	CYYJ	-123.430963	48.640267	America/Vancouver	0
7451	Lynn Lake Airport	Lynn Lake	Canada	CA	YYL	CYYL	-101.07025	56.859407	America/Winnipeg	0
7452	Cowley Airport	Cowley	Canada	CA	YYM	CYYM	-114.166667	49.866667	America/Edmonton	0
7453	Swift Current Airport	Swift Current	Canada	CA	YYN	CYYN	-107.693625	50.286404	America/Regina	0
7454	Churchill Airport	Churchill	Canada	CA	YYQ	CYYQ	-94.074497	58.748191	America/Winnipeg	0
7455	Goose Bay Airport	Goose Bay	Canada	CA	YYR	CYYR	-60.412399	53.313533	America/Halifax	0
7456	St. John's International Airport	St. John's	Canada	CA	YYT	CYYT	-52.743339	47.612818	America/St_Johns	0
7457	Kapuskasing Airport	Kapuskasing	Canada	CA	YYU	CYYU	-82.467499	49.41389	America/Toronto	0
7458	Armstrong Airport	Armstrong	Canada	CA	YYW	CYYW	-88.914238	50.295562	America/Toronto	0
7459	Mont Joli Airport	Mont Joli	Canada	CA	YYY	CYYY	-68.209342	48.609058	America/Toronto	0
7460	Toronto Pearson International Airport	Toronto	Canada	CA	YYZ	CYYZ	-79.61146	43.681585	America/Toronto	0
7461	Manitoulin Airport	Gore Bay	Canada	CA	YZE	CYZE	-82.567778	45.885278	America/Toronto	0
7462	Yellowknife Airport	Yellowknife	Canada	CA	YZF	CYZF	-114.4375	62.470869	America/Edmonton	0
7463	Salluit Airport	Salluit	Canada	CA	YZG	CYZG	-75.633333	62.2	America/Toronto	0
7464	Slave Lake Airport	Slave Lake	Canada	CA	YZH	CYZH	-114.777224	55.293229	America/Edmonton	0
7465	Sandspit Airport	Sandspit	Canada	CA	YZP	CYZP	-131.814301	53.254289	America/Vancouver	0
7466	Sarnia Airport	Sarnia	Canada	CA	YZR	CYZR	-82.311111	42.997222	America/Toronto	0
7467	Coral Harbour Airport	Coral Harbour	Canada	CA	YZS	CYZS	-83.354157	64.18834	America/Atikokan	0
7468	Port Hardy Airport	Port Hardy	Canada	CA	YZT	CYZT	-127.363889	50.680556	America/Vancouver	0
7469	Whitecourt Airport	Whitecourt	Canada	CA	YZU	CYZU	-115.784721	54.140492	America/Edmonton	0
7470	Sept-Iles Airport	Sept-Iles	Canada	CA	YZV	CYZV	-66.264036	50.21751	America/Toronto	0
7471	Teslin Airport	Teslin	Canada	CA	YZW	CYZW	-132.716667	60.166667	America/Vancouver	0
7472	Greenwood Airport	Greenwood	Canada	CA	YZX	CYZX	-64.916944	44.984444	America/Halifax	0
7473	Trail Airport	Trail	Canada	CA	YZZ	CAD4	-117.609222	49.055614	America/Vancouver	0
7474	York Landing Airport	York Landing	Canada	CA	ZAC	CZAC	-96.091921	56.089515	America/Winnipeg	0
7475	Zadar Airport	Zadar	Croatia	HR	ZAD	LDZD	15.356667	44.097778	Europe/Zagreb	0
7476	Franjo Tudman Airport	Zagreb	Croatia	HR	ZAG	LDZA	16.061519	45.733242	Europe/Zagreb	0
7477	Zahedan Airport	Zahedan	Iran	IR	ZAH	OIZH	60.900328	29.475755	Asia/Tehran	0
7478	Zaranj Airport	Zaranj	Afghanistan	AF	ZAJ	OAZJ	61.867076	30.968253	Asia/Kabul	0
7479	Pichoy Airport	Valdivia	Chile	CL	ZAL	SCVD	-73.086098	-39.650002	America/Santiago	0
7480	Zamboanga International Airport	Zamboanga	Philippines	PH	ZAM	RPMZ	122.062259	6.919294	Asia/Manila	0
7481	Laberandie Airport	Cahors	France	FR	ZAO	LFCC	1.47528	44.351398	Europe/Paris	0
7482	Zaria Airport	Zaria	Nigeria	NG	ZAR	DNZA	7.666667	11	Africa/Lagos	0
7483	Zhaotong Airport	Zhaotong	China	CN	ZAT	ZPZT	103.8	27.316667	Asia/Shanghai	0
7484	Zaragoza Airport	Zaragoza	Spain and Canary Islands	ES	ZAZ	LEZG	-1.007466	41.663862	Europe/Madrid	0
7485	Dolni Benesov Airport	Zabreh	Czech Republic	CZ	ZBE	LKZA	18.0783	49.928299	Europe/Prague	0
7486	Bathurst Airport	Bathurst	Canada	CA	ZBF	CZBF	-65.739444	47.629167	America/Halifax	0
7487	Biloela Airport	Biloela	Australia	AU	ZBL	YBLE	150.516667	-24.4	Australia/Brisbane	0
7488	Roland-Desourdy Airport	Bromont	Canada	CA	ZBM	CZBM	-72.741402	45.290798	America/Toronto	0
7489	Bowen Airport	Bowen	Australia	AU	ZBO	YBWN	148.216667	-20.016667	Australia/Brisbane	0
7490	Konarak Airport	Chah Bahar	Iran	IR	ZBR	OIZC	60.382099	25.4433	Asia/Tehran	0
7491	Sayaboury Airport	Sayaboury	Lao People's Democratic Republic	LA	ZBY	VLSB	101.7	19.25	Asia/Vientiane	0
7492	La Calera Airport	Zacatecas	Mexico	MX	ZCL	MMZC	-102.685335	22.8985	America/Mexico_City	0
7493	Temuco Airport	Temuco	Chile	CL	ZCO	SCQP	-72.651197	-38.925151	America/Santiago	0
7494	Delma Island Airport	Delma Island	United Arab Emirates	AE	ZDY	OMDL	52.335278	24.508333	Asia/Dubai	0
7495	Secunda Airport	Secunda	South Africa	ZA	ZEC	FASC	28	-27	Africa/Johannesburg	0
7496	Senggo Airport	Senggo	Indonesia	ID	ZEG	WAKQ	139.366667	-5.983333	Asia/Jayapura	0
7497	Campbell Island Airport	Bella Bella	Canada	CA	ZEL	CBBC	-128.156994	52.185001	America/Vancouver	0
7498	East Main Airport	East Main	Canada	CA	ZEM	CZEM	-78.516667	52.25	America/Toronto	0
7499	Ziro Airport	Ziro	India	IN	ZER	VEZO	93.828102	27.588301	Asia/Kolkata	0
7500	Faro Airport	Faro	Canada	CA	ZFA	CZFA	-133.375835	62.207504	America/Vancouver	0
7501	Fond Du Lac Airport	Fond Du Lac	Canada	CA	ZFD	CZFD	-107.181191	59.334211	America/Regina	0
7502	Fort Mcpherson Airport	Fort McPherson	Canada	CA	ZFM	CZFM	-134.862082	67.407527	America/Edmonton	0
7503	Tulita Airport	Tulita/Fort Norman	Canada	CA	ZFN	CZFN	-125.566667	64.916667	America/Edmonton	0
7504	Fairview Airport	Fairview	Canada	CA	ZFW	CEB5	-118.383333	56.066667	America/Edmonton	0
7505	Grand Forks Airport	Grand Forks	Canada	CA	ZGF	CZGF	-118.433333	49.016667	America/Vancouver	0
7506	Gods River Airport	Gods River	Canada	CA	ZGI	CZGI	-94.079654	54.839143	America/Winnipeg	0
7507	South Galway Airport	South Galway	Australia	AU	ZGL	YSGW	142.116667	-25.683333	Australia/Brisbane	0
7508	Ngoma Airport	Ngoma	Zambia	ZM	ZGM	FLNA	25.934444	-15.958333	Africa/Lusaka	0
7509	Little Grand Rapids Airport	Little Grand Rapids	Canada	CA	ZGR	CZGR	-95.466191	52.045012	America/Winnipeg	0
7510	Gaua Airport	Gaua	Vanuatu	VU	ZGU	NVSQ	167.588279	-14.220086	Pacific/Efate	0
7511	Zhanjiang Airport	Zhanjiang	China	CN	ZHA	ZGZJ	110.362715	21.214727	Asia/Shanghai	0
7512	Shamshernagar Airport	Shamshernagar	Bangladesh	BD	ZHM	VGSH	91.921111	24.398611	Asia/Dhaka	0
7513	High Prairie Airport	High Prairie	Canada	CA	ZHP	CZHP	-116.483333	55.4	America/Edmonton	0
7514	Xiangshan Airport	Zhongwei	China	CN	ZHY	ZLZW	105.154454	37.573125	Asia/Shanghai	0
7515	Zhukovsky International Airport	Zhukovsky	Russian Federation	RU	ZIA	UUBW	38.150407	55.55254	Europe/Moscow	0
7516	Victoria Airport	Victoria	Chile	CL	ZIC	SCTO	-72.333333	-38.216667	America/Santiago	0
7517	Ziguinchor Airport	Ziguinchor	Senegal	SN	ZIG	GOGG	-16.275833	12.556111	Africa/Dakar	0
7518	Ixtapa/Zihuatanejo Internacional Airport	Ixtapa/Zihuatanejo	Mexico	MX	ZIH	MMZH	-101.464062	17.606782	America/Mexico_City	0
7519	Zhigansk Airport	Zhigansk	Russian Federation	RU	ZIX	UEVV	123.361389	66.796667	Asia/Yakutsk	0
7520	Jenpeg Airport	Jenpeg	Canada	CA	ZJG	CZJG	-98.046111	54.519444	America/Winnipeg	0
7521	Swan River Airport	Swan River	Canada	CA	ZJN	CZJN	-101.233333	52.116667	America/Winnipeg	0
7522	Kasaba Bay Airport	Kasaba Bay	Zambia	ZM	ZKB	FLKY	30.659722	-8.522222	Africa/Lusaka	0
7523	Kashechewan Airport	Kaschechewan	Canada	CA	ZKE	CZKE	-81.333333	52.333333	America/Toronto	0
7524	Zyryanka Airport	Zyryanka	Russian Federation	RU	ZKP	UESU	150.89856	65.740446	Asia/Srednekolymsk	0
7525	Manzanillo Airport	Manzanillo	Mexico	MX	ZLO	MMZO	-104.561721	19.145585	America/Mexico_City	0
7526	Bulgan Airport, Khovd	Bulgan	Mongolia	MN	HBU	ZMBS	91.58611	46.102222	Asia/Ulaanbaatar	0
7527	South Cariboo Regional Airport	108 Mile Ranch	Canada	CA	ZMH	CZML	-121.333	51.736099	America/Vancouver	0
7528	Zamora Airport	Zamora	Mexico	MX	ZMM	MMZM	-102.266667	19.983333	America/Mexico_City	0
7529	Masset Airport	Masset	Canada	CA	ZMT	CZMT	-132.117758	54.022225	America/Vancouver	0
7530	Zinder Airport	Zinder	Niger	NE	ZND	DRZR	8.983056	13.779444	Africa/Niamey	0
7531	Newman Airport	Newman	Australia	AU	ZNE	YNWM	119.801372	-23.416517	Australia/Perth	0
7532	Abeid Amani Karume International Airport	Zanzibar	United Republic of Tanzania	TZ	ZNZ	HTZA	39.221185	-6.218466	Africa/Dar_es_Salaam	0
7533	Canal Bajo Airport	Osorno	Chile	CL	ZOS	SCJO	-73.055556	-40.607778	America/Santiago	0
7534	Sachigo Lake Airport	Sachigo Lake	Canada	CA	ZPB	CZPB	-92.195278	53.890556	America/Winnipeg	0
7535	Pucon Airport	Pucon	Chile	CL	ZPC	SCPC	-71.633333	-39.763889	America/Santiago	0
7536	Zephyrhills Airport	Zephyrhills	United States	US	ZPH	KZPH	-82.183333	28.233333	America/New_York	0
7537	Pine House Airport	Pine House	Canada	CA	ZPO	CZPO	-106.583333	55.516667	America/Winnipeg	0
7538	Queenstown Airport	Queenstown	New Zealand	NZ	ZQN	NZQN	168.739104	-45.022039	Pacific/Auckland	0
7539	Zhangjiakou Ningyuan Airport	Zhangjiakou	China	CN	ZQZ	ZBZJ	114.931455	40.739228	Asia/Shanghai	0
7540	Zurich Airport	Zurich	Switzerland	CH	ZRH	LSZH	8.561746	47.450604	Europe/Zurich	0
7541	S. Condronegoro Airport	Serui	Indonesia	ID	ZRI	WABO	136.23948	-1.873953	Asia/Jayapura	0
7542	Weagamow Airport	Round Lake	Canada	CA	ZRJ	CZRJ	-91.312798	52.9436	America/Winnipeg	0
7543	Sarmi Airport	Sarmi	Indonesia	ID	ZRM	WAJI	138.75	-1.85	Asia/Jayapura	0
7544	San Salvador Airport	San Salvador	Bahamas	BS	ZSA	MYSM	-74.533056	24.06	America/Nassau	0
7545	Pierrefonds Airport	Saint Pierre de la Reunion	Reunion	RE	ZSE	FMEP	55.426878	-21.320944	Indian/Reunion	0
7546	Sandy Lake Airport	Sandy Lake	Canada	CA	ZSJ	CZSJ	-93.233333	53.033333	America/Winnipeg	0
7547	Sassandra Airport	Sassandra	Cote d'Ivoire	CI	ZSS	DISS	-6.135556	4.924444	Africa/Abidjan	0
7548	Stewart Airport	Stewart	Canada	CA	ZST	CZST	-129.983333	55.933333	America/Vancouver	0
7549	Tureira Airport	Tureira	French Polynesia	PF	ZTA	NTGY	-138.567728	-20.78342	Pacific/Tahiti	0
7550	Zakinthos Airport	Zakinthos	Greece	GR	ZTH	LGZA	20.884711	37.753505	Europe/Athens	0
7551	Shamattawa Airport	Shamattawa	Canada	CA	ZTM	CZTM	-92.080354	55.858506	America/Winnipeg	0
7552	Zaqatala Airport	Zaqatala	Azerbaijan	AZ	ZTU	UBBY	46.664789	41.56166	Asia/Baku	0
7553	Ignace Municipal Airport	Ignace	Canada	CA	ZUC	CZUC	-91.717796	49.429699	America/Winnipeg	0
7554	Ancud Airport	Ancud	Chile	CL	ZUD	SCAC	-73.796571	-41.904251	America/Santiago	0
7555	Zhuhai Jinwan Airport	Zhuhai	China	CN	ZUH	ZGSD	113.370601	22.011788	Asia/Shanghai	0
7556	Zilfi Airport	Zilfi	Saudi Arabia	SA	ZUL	OEZL	44.833333	26.25	Asia/Riyadh	0
7557	Churchill Falls Airport	Churchill Falls	Canada	CA	ZUM	CZUM	-64.109167	53.562778	America/Halifax	0
7558	Miandrivazo Airport	Miandrivazo	Madagascar	MG	ZVA	FMMN	45.466667	-19.5	Indian/Antananarivo	0
7559	Savannakhet Airport	Savannakhet	Lao People's Democratic Republic	LA	ZVK	VLSK	104.7625	16.553611	Asia/Vientiane	0
7560	Andapa Airport	Andapa	Madagascar	MG	ZWA	FMND	49.616667	-14.65	Indian/Antananarivo	0
7561	Wollaston Lake Airport	Wollaston Lake	Canada	CA	ZWL	CZWL	-103.172471	58.106931	America/Regina	0
7562	Zabrat Airport	Baku	Azerbaijan	AZ	ZXT	UBTT	49.983611	40.485	Asia/Baku	0
7563	Zunyi Xinzhou Airport	Zunyi	China	CN	ZYI	ZUZY	106.999823	27.589673	Asia/Shanghai	0
7564	Osmani International Airport	Sylhet	Bangladesh	BD	ZYL	VGSY	91.866798	24.9632	Asia/Dhaka	0
7565	Zangilan Airport	Zangilan	Azerbaijan	AZ	ZZE	UBBZ	46.736944	39.105556	Asia/Baku	0
7566	Zonalnoye Airport	Tymovskoye	Russian Federation	RU	ZZO	UHSO	142.75	50.666668	Asia/Sakhalin	0
7567	Mzuzu Airport	Mzuzu	Malawi	MW	ZZU	FWUU	34.012778	-11.442778	Africa/Blantyre	0
7568	Zanesville Municipal Airport	Zanesville	United States	US	ZZV	KZZV	-82.890474	39.947413	America/New_York	0
\.


--
-- Data for Name: flight; Type: TABLE DATA; Schema: public; Owner: flycierge_user
--

COPY public.flight (flight_id, origin, destination, number, airline, start_date_time, landing_date_time, create_ts) FROM stdin;
\.


--
-- Data for Name: itinerary; Type: TABLE DATA; Schema: public; Owner: flycierge_user
--

COPY public.itinerary (itinerary_id, create_ts, flights_hash) FROM stdin;
\.


--
-- Data for Name: itinerary_flight; Type: TABLE DATA; Schema: public; Owner: flycierge_user
--

COPY public.itinerary_flight (itinerary_flight_id, itinerary_id, flight_id, is_return_flight) FROM stdin;
\.


--
-- Data for Name: price; Type: TABLE DATA; Schema: public; Owner: flycierge_user
--

COPY public.price (price_id, itinerary_id, value, currency, create_ts) FROM stdin;
\.


--
-- Data for Name: route_price_metric; Type: TABLE DATA; Schema: public; Owner: flycierge_user
--

COPY public.route_price_metric (route_price_metric_id, origin, destination, departure_date, currency, one_way, minimal_value, first_quartile, second_quartile, third_quartile, maximal_value, create_ts) FROM stdin;
\.


--
-- Data for Name: search; Type: TABLE DATA; Schema: public; Owner: flycierge_user
--

COPY public.search (search_id, origin, destination, departure_date, return_date, adult_number, create_ts) FROM stdin;
\.


--
-- Name: the_sequence; Type: SEQUENCE SET; Schema: public; Owner: flycierge_user
--

SELECT pg_catalog.setval('public.the_sequence', 8586, true);


--
-- Name: airline airline_iata_code_key; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.airline
    ADD CONSTRAINT airline_iata_code_key UNIQUE (iata_code);


--
-- Name: airline airline_icao_code_key; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.airline
    ADD CONSTRAINT airline_icao_code_key UNIQUE (icao_code);


--
-- Name: airline airline_pkey; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.airline
    ADD CONSTRAINT airline_pkey PRIMARY KEY (airline_id);


--
-- Name: airport airport_iata_code_key; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_iata_code_key UNIQUE (iata_code);


--
-- Name: airport airport_icao_code_key; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_icao_code_key UNIQUE (icao_code);


--
-- Name: airport airport_longitude_latitude_key; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_longitude_latitude_key UNIQUE (longitude, latitude);


--
-- Name: airport airport_pkey; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (airport_id);


--
-- Name: flight flight_origin_destination_airline_number_start_date_time_key; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_origin_destination_airline_number_start_date_time_key UNIQUE (origin, destination, airline, number, start_date_time);


--
-- Name: flight flight_pkey; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_pkey PRIMARY KEY (flight_id);


--
-- Name: itinerary_flight itinerary_flight_pkey; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.itinerary_flight
    ADD CONSTRAINT itinerary_flight_pkey PRIMARY KEY (itinerary_flight_id);


--
-- Name: itinerary itinerary_flights_hash_key; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.itinerary
    ADD CONSTRAINT itinerary_flights_hash_key UNIQUE (flights_hash);


--
-- Name: itinerary itinerary_pkey; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.itinerary
    ADD CONSTRAINT itinerary_pkey PRIMARY KEY (itinerary_id);


--
-- Name: price price_pkey; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_pkey PRIMARY KEY (price_id);


--
-- Name: route_price_metric route_price_metric_origin_destination_departure_date_one_wa_key; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.route_price_metric
    ADD CONSTRAINT route_price_metric_origin_destination_departure_date_one_wa_key UNIQUE (origin, destination, departure_date, one_way);


--
-- Name: route_price_metric route_price_metric_pkey; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.route_price_metric
    ADD CONSTRAINT route_price_metric_pkey PRIMARY KEY (route_price_metric_id);


--
-- Name: search search_pkey; Type: CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.search
    ADD CONSTRAINT search_pkey PRIMARY KEY (search_id);


--
-- Name: flight flight_airline_fkey; Type: FK CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_airline_fkey FOREIGN KEY (airline) REFERENCES public.airline(iata_code);


--
-- Name: flight flight_destination_fkey; Type: FK CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_destination_fkey FOREIGN KEY (destination) REFERENCES public.airport(iata_code);


--
-- Name: flight flight_origin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_origin_fkey FOREIGN KEY (origin) REFERENCES public.airport(iata_code);


--
-- Name: itinerary_flight itinerary_flight_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.itinerary_flight
    ADD CONSTRAINT itinerary_flight_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES public.flight(flight_id);


--
-- Name: itinerary_flight itinerary_flight_itinerary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.itinerary_flight
    ADD CONSTRAINT itinerary_flight_itinerary_id_fkey FOREIGN KEY (itinerary_id) REFERENCES public.itinerary(itinerary_id);


--
-- Name: price price_itinerary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_itinerary_id_fkey FOREIGN KEY (itinerary_id) REFERENCES public.itinerary(itinerary_id);


--
-- Name: search search_destination_fkey; Type: FK CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.search
    ADD CONSTRAINT search_destination_fkey FOREIGN KEY (destination) REFERENCES public.airport(iata_code);


--
-- Name: search search_origin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: flycierge_user
--

ALTER TABLE ONLY public.search
    ADD CONSTRAINT search_origin_fkey FOREIGN KEY (origin) REFERENCES public.airport(iata_code);


--
-- PostgreSQL database dump complete
--

