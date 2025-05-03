CREATE
EXTENSION IF NOT EXISTS pg_trgm schema public;

create type channel_enum as enum (
    'NONE', 'INBOUND', 'OUTBOUND', 'FREE_CALL', 'CHAT',
    'EMAIL', 'AGENT_CALL', 'EMAIL_OUTBOUND',
    'SALESFORCE', 'SMS', 'WHATSAPP');

create type call_result as enum ('CONNECTED', 'ABANDON', 'ANSWERING_MACHINE', 'UNALLOCATED',
    'BUSY', 'NO_ANSWER', 'OTHER', 'HANDLED', 'ABANDON_QUEUE', 'CALENDAR_CLOSED',
    'DISSUASION_IVR', 'ABANDON_IVR', 'DISSUASION_NO_AGENT', 'DISSUASION_EFFECTIVE_TIMEOUT');

create table agent_log
(
    id                      serial
        constraint agent_log_pk primary key,
    account_id              integer                            not null,
    agent_id                integer                            not null,
    contact_session_id      uuid,
    queue_id                integer,
    campaign_id             integer,
    contact_id              integer,
    meta_status_id          integer,
    channel                 channel_enum,
    date                    timestamp with time zone           not null,
    created_at              timestamp with time zone default now(),
    call_wrapup_id          integer,
    conference_id           uuid,
    activity_id             integer,
    ref_activity_id         integer,
    agent_session_id        uuid,
    mail_id                 integer,
    mail_wrapup_id          integer,
    mail_wrapup_duration_ms bigint                   default 0 not null,
    thread_id               integer,
    abr                     boolean,
    warm_transfer           boolean,
    display_number_id       integer,
    campaign_wrapup_final   boolean,
    service_id              integer,
    user_number_type        varchar(30),
    user_phone_number       varchar(30)
);

create table contact_log
(
    id                           serial
        constraint contact_log_pk
            primary key,
    contact_session_id           uuid                     not null,
    queue_id                     integer,
    agent_id                     integer,
    date                         timestamp with time zone not null,
    created_at                   timestamp with time zone default now(),
    channel                      channel_enum             not null,
    campaign_contact_id          integer,
    campaign_id                  integer,
    conference_id                uuid,
    contact_phone                varchar,
    service_phone                varchar,
    call_result                  call_result,
    record_file_name             text,
    record_is_explicitly_started boolean,
    record_file_name_displayed   text,
    activity_id                  integer,
    agent_session_id             uuid,
    displayed_number             varchar,
    record_is_voice_message      boolean,
    external_storage_id          integer,
    displayed_number_id          integer,
    payment_result_detail        text,
    payment_id                   integer,
    abr                          boolean,
    warm_transfer                boolean,
    ref_activity_id              integer,
    ref_queue_id                 integer,
    discard_left_audio_channel   boolean,
    discard_right_audio_channel  boolean,
    call_lid                     bigint
);

create table mail_log
(
    id                      serial
        constraint mail_contact_log_pk primary key,
    account_id              integer                                not null,
    agent_id                integer,
    activity_id             integer,
    queue_id                integer,
    service_id              integer                                not null,
    thread_id               integer                                not null,
    contact_session_id      uuid                                   not null,
    mail_id                 integer                                not null,
    date                    timestamp with time zone               not null,
    created_at              timestamp with time zone default now() not null,
    channel                 channel_enum                           not null,
    ref_agent_id            integer,
    ref_queue_id            integer,
    from_address            text,
    to_address              text,
    cc_address              text,
    bcc_address             text,
    threshold_response_date timestamp with time zone,
    target_response_date    timestamp with time zone,
    abr                     boolean,
    mail_topic              varchar(255)
);


-- CUSTOM REPORT
create table custom_report
(
    report_id   integer                  not null primary key,
    report_name varchar(65)              not null,
    created_at  timestamp with time zone not null,
    created_by  integer,
    modified_at timestamp with time zone not null,
    modified_by integer,
    account_id  integer                  not null,
    report_type varchar(32)              not null,
    config      JSONB,
    deleted     boolean default false    not null
);

create table generated_report
(
    id                  serial,
    account_id          integer                  not null,
    displayed_file_name varchar(255)             not null,
    size_bytes          bigint  default 0,
    report_kind         varchar(100)             not null,
    file_id             uuid,
    extension           varchar(25),
    media_type          text,
    created_at          timestamp with time zone not null,
    updated_at          timestamp with time zone not null,
    generated_at        timestamp with time zone,
    period_start        timestamp with time zone not null,
    period_end          timestamp with time zone not null,
    status              varchar(100)             not null,
    error_reason        varchar(255),
    custom_report_id    integer                  not null references custom_report,
    deleted             boolean default false    not null
);


