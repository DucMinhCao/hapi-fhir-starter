CREATE TABLE identifier
(
    id                bigint NOT NULL,
    system            character varying(255),
    value             character varying(255),
    patient_entity_id bigint
);

CREATE TABLE name
(
    id                bigint NOT NULL,
    family_name       character varying(255),
    given_name        character varying(255),
    prefix            character varying(255),
    use               character varying(255),
    patient_entity_id bigint
);

CREATE TABLE patient
(
    id            bigint NOT NULL,
    created_time  timestamp without time zone NOT NULL,
    date_of_birth timestamp without time zone,
    gender        integer,
    updated_time  timestamp without time zone NOT NULL
);

CREATE TABLE telecom
(
    id                bigint NOT NULL,
    system            integer,
    use               integer,
    value             character varying(255),
    patient_entity_id bigint
);

CREATE TABLE address
(
    id                bigint NOT NULL,
    city              character varying(255),
    country           character varying(255),
    line              character varying(255),
    postal_code       character varying(255),
    state             character varying(255),
    patient_entity_id bigint
);

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);

ALTER TABLE ONLY identifier
    ADD CONSTRAINT identifier_pkey PRIMARY KEY (id);

ALTER TABLE ONLY name
    ADD CONSTRAINT name_pkey PRIMARY KEY (id);

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);

ALTER TABLE ONLY telecom
    ADD CONSTRAINT telecom_pkey PRIMARY KEY (id);

ALTER TABLE ONLY telecom
    ADD CONSTRAINT fk2g05s8un27iaml7yog6hd20ng FOREIGN KEY (patient_entity_id) REFERENCES public.patient(id);

ALTER TABLE ONLY address
    ADD CONSTRAINT fknhupix26ayqfu6nusvj4wg0ca FOREIGN KEY (patient_entity_id) REFERENCES public.patient(id);

ALTER TABLE ONLY identifier
    ADD CONSTRAINT fkpdu5yqh9165dc8g2fapbhf16d FOREIGN KEY (patient_entity_id) REFERENCES public.patient(id);

ALTER TABLE ONLY name
    ADD CONSTRAINT fktib9ylw1xma55d234lacmju37 FOREIGN KEY (patient_entity_id) REFERENCES public.patient(id);


