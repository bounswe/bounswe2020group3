--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 13.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_collaborationinvite; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_collaborationinvite (
    id integer NOT NULL,
    message character varying(200) NOT NULL,
    created timestamp with time zone,
    rejected timestamp with time zone,
    from_user_id integer NOT NULL,
    to_project_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.api_collaborationinvite OWNER to postgres;

--
-- Name: api_collaborationinvite_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_collaborationinvite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_collaborationinvite_id_seq OWNER to postgres;

--
-- Name: api_collaborationinvite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_collaborationinvite_id_seq OWNED BY public.api_collaborationinvite.id;


--
-- Name: api_collaborationrequest; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_collaborationrequest (
    id integer NOT NULL,
    message character varying(200) NOT NULL,
    created timestamp with time zone,
    rejected timestamp with time zone,
    from_user_id integer NOT NULL,
    to_project_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.api_collaborationrequest OWNER to postgres;

--
-- Name: api_collaborationrequest_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_collaborationrequest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_collaborationrequest_id_seq OWNER to postgres;

--
-- Name: api_collaborationrequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_collaborationrequest_id_seq OWNED BY public.api_collaborationrequest.id;


--
-- Name: api_comment; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_comment (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    comment character varying(1000) NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.api_comment OWNER to postgres;

--
-- Name: api_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_comment_id_seq OWNER to postgres;

--
-- Name: api_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_comment_id_seq OWNED BY public.api_comment.id;


--
-- Name: api_event; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_event (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    deadline date NOT NULL,
    date date NOT NULL,
    event_type character varying(50) NOT NULL,
    url character varying(200) NOT NULL
);


ALTER TABLE public.api_event OWNER to postgres;

--
-- Name: api_event_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_event_id_seq OWNER to postgres;

--
-- Name: api_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_event_id_seq OWNED BY public.api_event.id;


--
-- Name: api_file; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_file (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    remark character varying(100) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE public.api_file OWNER to postgres;

--
-- Name: api_file_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_file_id_seq OWNER to postgres;

--
-- Name: api_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_file_id_seq OWNED BY public.api_file.id;


--
-- Name: api_following; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_following (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.api_following OWNER to postgres;

--
-- Name: api_following_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_following_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_following_id_seq OWNER to postgres;

--
-- Name: api_following_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_following_id_seq OWNED BY public.api_following.id;


--
-- Name: api_followrequest; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_followrequest (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    req_from_user_id integer NOT NULL,
    req_to_user_id integer NOT NULL
);


ALTER TABLE public.api_followrequest OWNER to postgres;

--
-- Name: api_followrequest_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_followrequest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_followrequest_id_seq OWNER to postgres;

--
-- Name: api_followrequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_followrequest_id_seq OWNED BY public.api_followrequest.id;


--
-- Name: api_milestone; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_milestone (
    id integer NOT NULL,
    description text NOT NULL,
    date date NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE public.api_milestone OWNER to postgres;

--
-- Name: api_milestone_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_milestone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_milestone_id_seq OWNER to postgres;

--
-- Name: api_milestone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_milestone_id_seq OWNED BY public.api_milestone.id;


--
-- Name: api_notification; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_notification (
    id integer NOT NULL,
    level character varying(20) NOT NULL,
    unread boolean NOT NULL,
    actor_object_id character varying(255) NOT NULL,
    verb character varying(255) NOT NULL,
    description text,
    target_object_id character varying(255),
    action_object_object_id character varying(255),
    "timestamp" timestamp with time zone NOT NULL,
    public boolean NOT NULL,
    deleted boolean NOT NULL,
    emailed boolean NOT NULL,
    data text,
    action_object_content_type_id integer,
    actor_content_type_id integer NOT NULL,
    recipient_id integer NOT NULL,
    target_content_type_id integer
);


ALTER TABLE public.api_notification OWNER to postgres;

--
-- Name: api_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_notification_id_seq OWNER to postgres;

--
-- Name: api_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_notification_id_seq OWNED BY public.api_notification.id;


--
-- Name: api_profile; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_profile (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    middle_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    bio character varying(1000) NOT NULL,
    share_birthday boolean NOT NULL,
    expertise text NOT NULL,
    gender character varying(100) NOT NULL,
    interests text NOT NULL,
    share_bio boolean NOT NULL,
    share_gender boolean NOT NULL,
    share_affiliations boolean NOT NULL,
    owner_id integer NOT NULL,
    birthday date,
    affiliations text NOT NULL,
    profile_picture character varying(100),
    is_public boolean NOT NULL
);


ALTER TABLE public.api_profile OWNER to postgres;

--
-- Name: api_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_profile_id_seq OWNER to postgres;

--
-- Name: api_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_profile_id_seq OWNED BY public.api_profile.id;


--
-- Name: api_project; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_project (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    name character varying(500) NOT NULL,
    description text NOT NULL,
    requirements text NOT NULL,
    is_public boolean NOT NULL,
    state character varying(100) NOT NULL,
    project_type character varying(100) NOT NULL,
    due_date date NOT NULL,
    owner_id integer NOT NULL,
    event_id integer
);


ALTER TABLE public.api_project OWNER to postgres;

--
-- Name: api_project_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_project_id_seq OWNER to postgres;

--
-- Name: api_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_project_id_seq OWNED BY public.api_project.id;


--
-- Name: api_project_members; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_project_members (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.api_project_members OWNER to postgres;

--
-- Name: api_project_members_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_project_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_project_members_id_seq OWNER to postgres;

--
-- Name: api_project_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_project_members_id_seq OWNED BY public.api_project_members.id;


--
-- Name: api_project_tags; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_project_tags (
    id integer NOT NULL,
    project_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.api_project_tags OWNER to postgres;

--
-- Name: api_project_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_project_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_project_tags_id_seq OWNER to postgres;

--
-- Name: api_project_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_project_tags_id_seq OWNED BY public.api_project_tags.id;


--
-- Name: api_publication; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_publication (
    id integer NOT NULL,
    title character varying(1000) NOT NULL,
    publication_year integer NOT NULL,
    citation_number integer NOT NULL,
    owner_id integer NOT NULL,
    link text NOT NULL
);


ALTER TABLE public.api_publication OWNER to postgres;

--
-- Name: api_publication_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_publication_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_publication_id_seq OWNER to postgres;

--
-- Name: api_publication_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_publication_id_seq OWNED BY public.api_publication.id;


--
-- Name: api_rating; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_rating (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    rating integer NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.api_rating OWNER to postgres;

--
-- Name: api_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_rating_id_seq OWNER to postgres;

--
-- Name: api_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_rating_id_seq OWNED BY public.api_rating.id;


--
-- Name: api_report; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_report (
    id integer NOT NULL,
    report_type character varying(100) NOT NULL,
    description character varying(1000),
    "timestamp" timestamp with time zone NOT NULL,
    reported_user_id integer NOT NULL
);


ALTER TABLE public.api_report OWNER to postgres;

--
-- Name: api_report_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_report_id_seq OWNER to postgres;

--
-- Name: api_report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_report_id_seq OWNED BY public.api_report.id;


--
-- Name: api_tag; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.api_tag (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    color integer NOT NULL
);


ALTER TABLE public.api_tag OWNER to postgres;

--
-- Name: api_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.api_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_tag_id_seq OWNER to postgres;

--
-- Name: api_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.api_tag_id_seq OWNED BY public.api_tag.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER to postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER to postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER to postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER to postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER to postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER to postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER to postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER to postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER to postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER to postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER to postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER to postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER to postgres;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER to postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER to postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER to postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER to postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER to postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: paperlayeradmin
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER to postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paperlayeradmin
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: paperlayeradmin
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER to postgres;

--
-- Name: api_collaborationinvite id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationinvite ALTER COLUMN id SET DEFAULT nextval('public.api_collaborationinvite_id_seq'::regclass);


--
-- Name: api_collaborationrequest id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationrequest ALTER COLUMN id SET DEFAULT nextval('public.api_collaborationrequest_id_seq'::regclass);


--
-- Name: api_comment id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_comment ALTER COLUMN id SET DEFAULT nextval('public.api_comment_id_seq'::regclass);


--
-- Name: api_event id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_event ALTER COLUMN id SET DEFAULT nextval('public.api_event_id_seq'::regclass);


--
-- Name: api_file id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_file ALTER COLUMN id SET DEFAULT nextval('public.api_file_id_seq'::regclass);


--
-- Name: api_following id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_following ALTER COLUMN id SET DEFAULT nextval('public.api_following_id_seq'::regclass);


--
-- Name: api_followrequest id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_followrequest ALTER COLUMN id SET DEFAULT nextval('public.api_followrequest_id_seq'::regclass);


--
-- Name: api_milestone id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_milestone ALTER COLUMN id SET DEFAULT nextval('public.api_milestone_id_seq'::regclass);


--
-- Name: api_notification id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_notification ALTER COLUMN id SET DEFAULT nextval('public.api_notification_id_seq'::regclass);


--
-- Name: api_profile id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_profile ALTER COLUMN id SET DEFAULT nextval('public.api_profile_id_seq'::regclass);


--
-- Name: api_project id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project ALTER COLUMN id SET DEFAULT nextval('public.api_project_id_seq'::regclass);


--
-- Name: api_project_members id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_members ALTER COLUMN id SET DEFAULT nextval('public.api_project_members_id_seq'::regclass);


--
-- Name: api_project_tags id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_tags ALTER COLUMN id SET DEFAULT nextval('public.api_project_tags_id_seq'::regclass);


--
-- Name: api_publication id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_publication ALTER COLUMN id SET DEFAULT nextval('public.api_publication_id_seq'::regclass);


--
-- Name: api_rating id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_rating ALTER COLUMN id SET DEFAULT nextval('public.api_rating_id_seq'::regclass);


--
-- Name: api_report id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_report ALTER COLUMN id SET DEFAULT nextval('public.api_report_id_seq'::regclass);


--
-- Name: api_tag id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_tag ALTER COLUMN id SET DEFAULT nextval('public.api_tag_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: api_collaborationinvite; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_collaborationinvite (id, message, created, rejected, from_user_id, to_project_id, to_user_id) FROM stdin;
3	Come	2020-12-29 11:08:59.384456+00	\N	40	8	33
5	Come	2021-01-20 23:02:40.689831+00	\N	45	15	40
6	Come	2021-01-25 15:49:13.962795+00	\N	31	4	34
8	Come	2021-01-25 16:00:46.62873+00	\N	40	7	33
13	Come	2021-01-25 16:05:45.282429+00	\N	31	4	43
15	Come	2021-01-25 16:05:49.638689+00	\N	31	4	30
17	Come	2021-01-25 22:35:42.785301+00	\N	31	4	40
21	Come	2021-01-26 09:53:17.607603+00	\N	80	31	75
22	Come	2021-01-26 09:53:50.08144+00	\N	80	31	43
23	Come	2021-01-26 09:53:55.850827+00	\N	80	31	49
27		2021-01-27 11:10:18.447755+00	\N	83	35	40
28		2021-01-27 11:26:21.230758+00	\N	84	39	83
29		2021-01-27 11:27:09.953404+00	\N	84	38	83
30	string	2021-01-28 11:52:07.673195+00	2021-01-28 11:51:50.972+00	29	40	34
31	string	2021-01-28 11:52:13.391128+00	2021-01-28 11:51:50.972+00	29	40	35
32	string	2021-01-28 11:52:18.96453+00	2021-01-28 11:51:50.972+00	29	40	36
34		2021-01-30 14:34:57.119767+00	\N	92	46	74
35		2021-01-30 19:15:34.393795+00	\N	51	50	82
\.


--
-- Data for Name: api_collaborationrequest; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_collaborationrequest (id, message, created, rejected, from_user_id, to_project_id, to_user_id) FROM stdin;
11	hello	2020-12-28 23:41:41.494968+00	2020-12-28 23:42:18.120474+00	36	4	31
12	hello	2020-12-29 09:26:04.708985+00	\N	35	7	40
14	hello	2020-12-29 09:37:43.117505+00	\N	43	10	40
15	hello	2020-12-29 09:38:01.030829+00	\N	43	7	40
17	hello	2020-12-29 09:59:17.739451+00	\N	33	10	40
22	hello	2020-12-29 10:04:32.435452+00	\N	45	7	40
27	hello	2020-12-29 11:09:40.308153+00	\N	40	14	33
28	hello	2021-01-19 13:34:45.27718+00	\N	45	14	33
30	hello	2021-01-25 15:44:04.392357+00	\N	35	5	30
33		2021-01-25 17:53:15.480328+00	\N	29	4	31
34	hello	2021-01-25 20:30:02.118603+00	\N	35	4	31
35		2021-01-25 21:32:12.04003+00	\N	74	24	73
36		2021-01-25 21:50:59.698298+00	\N	76	24	73
39	hello	2021-01-26 10:14:41.031569+00	\N	80	5	30
40	hello	2021-01-26 10:16:31.089184+00	\N	80	9	40
41		2021-01-26 19:52:00.433096+00	\N	71	4	31
42		2021-01-27 11:16:24.469239+00	\N	84	34	83
43		2021-01-27 11:16:44.369915+00	\N	84	35	83
45		2021-01-28 12:51:54.828267+00	\N	85	9	40
47		2021-01-30 14:41:25.315261+00	\N	92	45	91
54		2021-01-30 22:53:53.553387+00	\N	96	49	93
55	hello	2021-01-31 16:16:10.311471+00	\N	100	51	96
56	hello	2021-01-31 16:17:06.348602+00	\N	100	2	26
57	hello	2021-01-31 16:37:28.446307+00	\N	102	26	75
\.


--
-- Data for Name: api_comment; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_comment (id, created, comment, from_user_id, to_user_id) FROM stdin;
1	2021-01-26 10:11:58.473138+00	He has stolen my article!!	75	71
2	2021-01-28 11:41:08.271664+00	I've been following his work since my first days in academy. He is one of the most influential geologists of Turkey. Thank you for your contributions Celal Hocam.	29	31
3	2021-01-28 12:46:49.165144+00	This guy should leave school and be a CS pro! He has such potential being an IGL.	85	29
4	2021-01-30 17:19:55.382529+00	he is the best supervisor I have ever seen for optimization	95	93
\.


--
-- Data for Name: api_event; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_event (id, title, description, deadline, date, event_type, url) FROM stdin;
1	ICSTR Berlin	Due to COVID 19 Pandemic, this conference will be conducted 'Online' at a reduced fee. Please visit the conference website or email us at convener@eurasiaresearch.info for more details.	2021-01-20	2020-12-28	academic conference	
2	ExCeL London	Experience four shows targeted to the foodservice and hospitality industry at HRC at ExCeL London.	2021-02-21	2021-03-03	academic conference	
3	ICSDSMT	These conferences are for those, who are interested in presenting papers in all fields of International Conference on Sustainable Development.	2021-01-05	2021-01-20	academic conference	
5	APA 2020 Virtual	APA is currently seeking proposals for APA 2021 sessions, CE workshops, and more.	2021-02-06	2021-08-12	journal submission	
4	ICAEG 2020	The International Research Conference is a federated organization dedicated to bringing together a significant number of diverse scholarly events for presentation within the conference program.	2020-12-30	2020-12-29	journal submission	
7	ICAITI 2021	15.ICAITI aims to bring together leading academic scientists and researchers to exchange and share their experiences on all aspects of Advances in Immunotherapy.	2021-02-18	2021-07-22	journal submission	https://waset.org/advances-in-immunological-techniques-and-immunotherapy-conference-in-july-2021-in-rome
6	Neuroscience Conference 2021	Neuroscience Conference 2021 will be take place in Bogazici University , Istanbul/Turkey. Experts from all over the world will give lectures about recent developments in neuroscience.	2021-05-12	2021-05-19	academic conference	
8	Conference on Computer Vision and Pattern Recognition	Annual computer vision event comprising the main conference and several co-located workshops and short courses.	2021-02-07	2021-02-11	academic conference	
9	Programming Language Design and Implementation	Premier forum for researchers, developers, practitioners, and students to present research on programming language design and implementation.	2021-04-01	2021-04-09	academic conference	
10	ICMEF 2021	The ICMEF 2021 is a leading academic event for the management science scholars and researchers.	2021-01-28	2021-02-11	academic conference	
11	CAV 2021 | 33rd International Conference on Computer-Aided Verification	CAV 2021 is the 33rd in a series dedicated to the advancement of the theory and practice of computer-aided formal analysis methods for hardware and software systems	2021-06-30	2021-07-18	academic conference	
\.


--
-- Data for Name: api_file; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_file (id, file, remark, "timestamp", project_id) FROM stdin;
1	files/abstract.txt	abstract.txt	2021-01-25 16:48:56.737601+00	4
2	files/abstract.txt	abstract	2021-01-25 16:50:21.088719+00	4
3	files/To_do	To do	2021-01-25 17:57:43.415603+00	3
4	files/a.png	response	2021-01-25 17:58:15.570499+00	3
5	files/494_public-private_key.txt	494	2021-01-25 17:59:24.216173+00	3
7	files/Duke_University	Duke University	2021-01-25 21:09:44.195804+00	26
11	files/atherosclerosis.txt	atherosclerosis	2021-01-25 21:17:11.367433+00	27
12	files/atherosclerosis.txt	atherosclerosis	2021-01-25 21:17:11.721958+00	27
13	files/atherosclerosis.txt	atherosclerosis	2021-01-25 21:17:29.193296+00	27
14	files/atherosclerosis.txt	atherosclerosis	2021-01-25 21:18:26.592082+00	27
15	files/Private_Address	Lol	2021-01-25 21:27:26.88433+00	25
16	files/queries.json	atatır	2021-01-25 21:28:05.278416+00	25
17	files/Block_Diagram_4.png	443 stuff	2021-01-25 21:30:05.014586+00	25
18	files/atherosclerosis.txt	diet	2021-01-25 21:47:10.771498+00	27
19	files/Article	article	2021-01-26 09:03:29.744587+00	26
20	files/Article_1.txt	article	2021-01-26 10:08:11.977009+00	33
21	files/program_for_those_who_dont_run.xlsx	Program - Only Cycling	2021-01-28 11:54:39.436313+00	40
22	files/Top_100_most_earning_e-sports_organizations	Top 100 Most Earning E-sports Organizations	2021-01-28 12:41:03.15809+00	41
23	files/Draft	draft v1 added	2021-01-30 19:07:27.328207+00	50
24	files/Table.png	Added table	2021-01-30 19:09:06.768076+00	50
\.


--
-- Data for Name: api_following; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_following (id, created, from_user_id, to_user_id) FROM stdin;
1	2020-12-28 20:16:42.352227+00	31	28
2	2020-12-28 20:30:38.913904+00	31	30
3	2020-12-28 20:30:51.179976+00	31	27
4	2020-12-28 20:42:53.745418+00	31	29
5	2020-12-28 23:10:34.665803+00	35	28
6	2020-12-29 09:12:55.340077+00	35	31
7	2020-12-29 09:34:47.885323+00	43	30
8	2020-12-29 09:39:29.473772+00	31	43
9	2020-12-29 09:40:52.735234+00	31	34
10	2020-12-29 09:53:57.802106+00	40	43
11	2020-12-29 09:54:06.950201+00	40	35
101	2021-01-31 16:17:38.997895+00	100	75
102	2021-01-31 16:37:34.022951+00	102	79
14	2020-12-29 10:05:51.268857+00	31	33
15	2020-12-29 10:05:53.578804+00	40	33
16	2020-12-29 11:05:39.691082+00	31	40
17	2020-12-29 11:05:43.670145+00	36	40
18	2020-12-29 11:05:54.682603+00	45	40
19	2021-01-19 18:20:33.872724+00	40	45
20	2021-01-24 13:55:52.620661+00	30	45
21	2021-01-24 18:28:59.166751+00	41	42
22	2021-01-25 16:08:01.109066+00	43	31
23	2021-01-25 16:08:07.343614+00	33	31
24	2021-01-25 16:13:36.610116+00	33	40
25	2021-01-25 16:15:18.056212+00	35	40
26	2021-01-25 18:20:58.944826+00	26	34
27	2021-01-25 20:08:23.920172+00	71	27
28	2021-01-25 20:09:04.716763+00	71	30
29	2021-01-25 20:45:55.743174+00	71	73
30	2021-01-25 20:46:25.351124+00	26	71
31	2021-01-25 20:57:35.026069+00	75	27
32	2021-01-25 21:04:02.401073+00	75	73
33	2021-01-25 21:24:49.027872+00	73	71
34	2021-01-25 21:25:27.519035+00	75	71
35	2021-01-25 21:26:41.633796+00	71	75
36	2021-01-25 21:31:28.474993+00	74	75
37	2021-01-25 21:36:59.470141+00	74	73
38	2021-01-25 21:39:18.12985+00	74	71
39	2021-01-25 21:40:39.493283+00	73	75
40	2021-01-25 21:42:46.627994+00	73	74
41	2021-01-25 21:43:19.557287+00	75	74
42	2021-01-25 22:45:56.267973+00	77	61
103	2021-01-31 16:37:43.089724+00	102	75
104	2021-01-31 18:00:25.911967+00	27	100
45	2021-01-25 23:08:48.814609+00	29	31
46	2021-01-26 09:08:05.480324+00	79	75
47	2021-01-26 09:09:07.981663+00	75	79
48	2021-01-26 09:24:54.178862+00	80	30
49	2021-01-26 09:25:32.963783+00	80	43
50	2021-01-26 09:25:34.033068+00	80	71
53	2021-01-26 09:30:47.484928+00	80	75
54	2021-01-26 09:40:39.200945+00	33	80
55	2021-01-26 09:42:54.233561+00	40	80
106	2021-01-31 18:02:04.479298+00	85	27
58	2021-01-26 09:58:20.227591+00	45	30
59	2021-01-26 10:15:36.064866+00	51	80
60	2021-01-28 12:31:47.717799+00	85	29
61	2021-01-28 12:33:41.058618+00	29	85
62	2021-01-28 13:03:44.599717+00	86	41
63	2021-01-28 13:03:49.760408+00	86	42
64	2021-01-28 13:03:54.476672+00	86	43
66	2021-01-28 13:04:07.227693+00	86	45
68	2021-01-28 13:04:17.74195+00	86	49
69	2021-01-30 08:54:14.480127+00	89	76
70	2021-01-30 12:53:50.631973+00	91	27
71	2021-01-30 12:54:29.587267+00	91	51
72	2021-01-30 12:54:48.51285+00	91	49
73	2021-01-30 12:59:43.023949+00	90	51
74	2021-01-30 13:01:21.78533+00	51	90
75	2021-01-30 13:40:12.451892+00	90	31
76	2021-01-30 16:53:46.359101+00	94	93
77	2021-01-30 16:55:30.26509+00	93	94
78	2021-01-30 17:06:02.871079+00	95	93
79	2021-01-30 17:06:32.962254+00	95	94
80	2021-01-30 17:08:02.138782+00	93	95
81	2021-01-30 17:08:02.898095+00	94	95
82	2021-01-30 17:27:43.377258+00	93	89
83	2021-01-30 17:34:32.345503+00	93	76
84	2021-01-30 23:04:49.445728+00	98	96
85	2021-01-30 23:08:00.153074+00	98	43
86	2021-01-31 11:04:36.122272+00	42	41
87	2021-01-31 11:04:56.77768+00	85	41
88	2021-01-31 11:06:06.394799+00	71	41
89	2021-01-31 16:09:22.14701+00	99	27
90	2021-01-31 16:09:34.485645+00	99	75
91	2021-01-31 16:09:35.688252+00	99	91
92	2021-01-31 16:09:52.721834+00	99	51
93	2021-01-31 16:09:53.761145+00	99	49
94	2021-01-31 16:16:30.335846+00	100	89
95	2021-01-31 16:16:40.355691+00	100	76
96	2021-01-31 16:17:10.591433+00	100	26
97	2021-01-31 16:17:17.937154+00	100	34
98	2021-01-31 16:17:21.464348+00	100	71
99	2021-01-31 16:17:31.994342+00	100	27
100	2021-01-31 16:17:33.282209+00	100	30
107	2021-01-31 18:07:25.875582+00	27	75
108	2021-01-31 18:11:47.050528+00	86	89
109	2021-01-31 18:18:51.102118+00	89	86
\.


--
-- Data for Name: api_followrequest; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_followrequest (id, created, req_from_user_id, req_to_user_id) FROM stdin;
83	2021-01-30 17:27:42.991575+00	93	89
5	2020-12-29 09:33:31.943493+00	43	40
7	2020-12-29 09:34:25.783568+00	43	36
8	2020-12-29 09:41:01.978458+00	31	36
86	2021-01-31 16:07:31.047815+00	99	74
87	2021-01-31 16:09:30.370741+00	99	31
88	2021-01-31 16:10:05.452148+00	99	90
89	2021-01-31 16:10:08.46587+00	99	80
90	2021-01-31 16:16:14.071292+00	100	96
91	2021-01-31 16:16:34.419366+00	100	93
92	2021-01-31 16:17:38.657016+00	100	73
93	2021-01-31 16:17:45.18518+00	100	41
19	2020-12-29 11:06:04.783132+00	40	36
26	2021-01-25 19:55:58.942785+00	27	40
27	2021-01-25 20:09:41.065763+00	71	45
28	2021-01-25 20:11:14.527602+00	71	33
40	2021-01-25 21:48:55.18216+00	76	73
42	2021-01-25 22:47:13.303375+00	61	77
46	2021-01-26 09:17:31.337116+00	51	74
50	2021-01-26 09:25:29.420814+00	80	31
57	2021-01-26 09:54:47.012893+00	71	80
58	2021-01-27 11:11:29.130877+00	83	40
59	2021-01-27 11:12:18.788379+00	83	80
60	2021-01-27 11:29:08.149077+00	84	83
61	2021-01-27 11:29:25.664339+00	84	80
62	2021-01-27 11:29:49.778234+00	84	40
64	2021-01-28 12:44:04.200252+00	85	31
65	2021-01-28 12:45:15.98858+00	85	30
66	2021-01-28 12:45:19.878837+00	85	35
69	2021-01-28 13:00:29.97441+00	86	31
73	2021-01-30 12:41:15.453621+00	51	90
76	2021-01-30 14:42:40.549088+00	92	84
\.


--
-- Data for Name: api_milestone; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_milestone (id, description, date, project_id) FROM stdin;
1	Finish draft	2021-02-26	5
2	Completion of member gathering	2021-01-07	4
3	Finish the experiments	2021-04-21	5
4	Create draft	2021-01-29	6
5	Arm placement on the test subject#1	2020-12-31	7
6	First Result of Tests	2021-01-18	18
7	first draft	2020-12-31	12
8	Draft	2021-01-30	29
9	End of winter trainings and start of summer trainings	2021-04-01	40
10	Completion of survey and start of second phase.	2021-05-01	41
11	End of 2020/2021 season.	2021-06-01	42
12	The draft of the project should be created to send to the committee	2021-03-03	45
\.


--
-- Data for Name: api_notification; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_notification (id, level, unread, actor_object_id, verb, description, target_object_id, action_object_object_id, "timestamp", public, deleted, emailed, data, action_object_content_type_id, actor_content_type_id, recipient_id, target_content_type_id) FROM stdin;
3	info	t	51	rated about you	Rating	3	\N	2021-01-23 13:36:47.274277+00	t	f	f	\N	\N	4	30	18
4	info	f	42	wants to follow you.	Follow Request	22	\N	2021-01-24 18:26:07.770809+00	t	f	f	\N	\N	4	41	16
190	info	t	91	followed you.	Follow	72	\N	2021-01-30 12:54:48.539405+00	t	f	f	\N	\N	4	49	17
5	info	f	41	wants to follow you.	Follow Request	23	\N	2021-01-24 18:28:40.243213+00	t	f	f	\N	\N	4	42	16
193	info	t	90	wants to follow you.	Follow Request	74	\N	2021-01-30 12:59:04.509861+00	t	f	f	\N	\N	4	31	16
7	info	t	35	wants to join your Project What is Positive Psychology	Request	30	\N	2021-01-25 15:44:04.532973+00	t	f	f	\N	\N	4	30	14
186	info	f	51	wants to follow you.	Follow Request	73	\N	2021-01-30 12:41:15.480333+00	t	f	f	\N	\N	4	90	16
9	info	t	31	invited you to the Project Tethyan evolution of Turkey: A plate tectonic approach	Invite	6	\N	2021-01-25 15:49:14.070269+00	t	f	f	\N	\N	4	34	15
197	info	t	92	invited you to the Project Review of particle physics	Invite	34	\N	2021-01-30 14:34:57.226853+00	t	f	f	\N	\N	4	74	15
201	info	t	93	created a new Project A simple effective heuristic for embedded mixed-integer quadratic programming	Project	48	\N	2021-01-30 16:50:21.685146+00	t	f	f	\N	\N	4	93	9
11	info	f	40	invited you to the Project Machine Learning Applied Prosthetics	Invite	8	\N	2021-01-25 16:00:46.732013+00	t	f	f	\N	\N	4	33	15
205	info	t	94	wants to join your Project A Certainty Equivalent Merton Problem	Request	49	\N	2021-01-30 16:59:09.968829+00	t	f	f	\N	\N	4	93	14
16	info	t	31	invited you to the Project Tethyan evolution of Turkey: A plate tectonic approach	Invite	13	\N	2021-01-25 16:05:45.386225+00	t	f	f	\N	\N	4	43	15
37	info	f	26	created a new Project 3-D Face Detection, Landmark Localization, and Registration Using a Point Distribution Model	Project	23	\N	2021-01-25 20:30:36.632278+00	t	f	f	\N	\N	4	26	9
18	info	t	31	invited you to the Project Tethyan evolution of Turkey: A plate tectonic approach	Invite	15	\N	2021-01-25 16:05:49.754969+00	t	f	f	\N	\N	4	30	15
6	info	f	35	wants to follow you.	Follow Request	24	\N	2021-01-25 15:43:20.056549+00	t	f	f	\N	\N	4	40	16
1	info	f	45	invited you to the Project Behavioural and neural bases of threat-learning during learning through adolescence	Invite	5	\N	2021-01-20 23:02:40.784724+00	t	f	f	\N	\N	4	40	15
19	info	t	40	wants to join your Project Behavioural and neural bases of threat-learning during learning through adolescence	Request	32	\N	2021-01-25 16:15:09.771091+00	t	f	f	\N	\N	4	45	14
8	info	f	35	wants to join your Project Tethyan evolution of Turkey: A plate tectonic approach	Request	31	\N	2021-01-25 15:47:19.166045+00	t	f	f	\N	\N	4	31	14
17	info	f	31	invited you to the Project Tethyan evolution of Turkey: A plate tectonic approach	Invite	14	\N	2021-01-25 16:05:47.434844+00	t	f	f	\N	\N	4	29	15
20	info	t	29	wants to follow you.	Follow Request	25	\N	2021-01-25 17:52:40.694942+00	t	f	f	\N	\N	4	31	16
21	info	t	29	wants to join your Project Tethyan evolution of Turkey: A plate tectonic approach	Request	33	\N	2021-01-25 17:53:15.59927+00	t	f	f	\N	\N	4	31	14
46	info	f	75	followed you.	Follow	31	\N	2021-01-25 20:57:35.053624+00	t	f	f	\N	\N	4	27	17
23	info	t	29	accepted your invitation to Project Tethyan evolution of Turkey: A plate tectonic approach	Project	4	\N	2021-01-25 17:56:10.809855+00	t	f	f	\N	\N	4	31	9
24	info	t	29	accepted your request for Project Effects of Covid-19 on Health Workers	Project	3	\N	2021-01-25 17:56:51.126508+00	t	f	f	\N	\N	4	45	9
15	info	f	31	invited you to the Project Tethyan evolution of Turkey: A plate tectonic approach	Invite	12	\N	2021-01-25 16:05:42.116199+00	t	f	f	\N	\N	4	26	15
22	info	f	29	created a new Project My Phd Thesis	Project	21	\N	2021-01-25 17:55:20.291508+00	t	f	f	\N	\N	4	29	9
25	info	t	26	followed you.	Follow	26	\N	2021-01-25 18:20:58.969649+00	t	f	f	\N	\N	4	34	17
26	info	t	27	wants to follow you.	Follow Request	26	\N	2021-01-25 19:55:58.970424+00	t	f	f	\N	\N	4	40	16
10	info	f	40	invited you to the Project Machine Learning Applied Prosthetics	Invite	7	\N	2021-01-25 16:00:28.879933+00	t	f	f	\N	\N	4	27	15
27	info	t	27	accepted your invitation to Project Machine Learning Applied Prosthetics	Project	7	\N	2021-01-25 19:57:04.595849+00	t	f	f	\N	\N	4	40	9
28	info	t	71	followed you.	Follow	27	\N	2021-01-25 20:08:23.947327+00	t	f	f	\N	\N	4	27	17
29	info	t	71	followed you.	Follow	28	\N	2021-01-25 20:09:04.744345+00	t	f	f	\N	\N	4	30	17
30	info	t	71	wants to follow you.	Follow Request	27	\N	2021-01-25 20:09:41.091705+00	t	f	f	\N	\N	4	45	16
31	info	t	71	wants to follow you.	Follow Request	28	\N	2021-01-25 20:11:14.554235+00	t	f	f	\N	\N	4	33	16
34	info	t	26	accepted your invitation to Project Tethyan evolution of Turkey: A plate tectonic approach	Project	4	\N	2021-01-25 20:23:40.624062+00	t	f	f	\N	\N	4	31	9
38	info	f	73	created a new Project Fly Good Feel Good	Project	24	\N	2021-01-25 20:31:12.902321+00	t	f	f	\N	\N	4	73	9
42	info	t	71	wants to follow you.	Follow Request	33	\N	2021-01-25 20:49:57.18062+00	t	f	f	\N	\N	4	41	16
44	info	t	75	wants to follow you.	Follow Request	35	\N	2021-01-25 20:56:39.934858+00	t	f	f	\N	\N	4	73	16
41	info	f	71	wants to follow you.	Follow Request	32	\N	2021-01-25 20:45:05.334393+00	t	f	f	\N	\N	4	73	16
35	info	f	26	wants to follow you.	Follow Request	30	\N	2021-01-25 20:25:00.562248+00	t	f	f	\N	\N	4	71	16
49	info	f	73	created a new Project The Reasons of Atherosclerosis	Project	27	\N	2021-01-25 21:08:26.799928+00	t	f	f	\N	\N	4	73	9
50	info	f	73	wants to follow you.	Follow Request	37	\N	2021-01-25 21:19:03.313821+00	t	f	f	\N	\N	4	71	16
48	info	f	75	invited you to the Project Research on University Rankings	Invite	16	\N	2021-01-25 21:08:17.300758+00	t	f	f	\N	\N	4	71	15
43	info	f	75	wants to follow you.	Follow Request	34	\N	2021-01-25 20:55:48.953601+00	t	f	f	\N	\N	4	71	16
45	info	f	75	wants to follow you.	Follow Request	36	\N	2021-01-25 20:57:18.409513+00	t	f	f	\N	\N	4	74	16
53	info	t	74	wants to join your Project Fly Good Feel Good	Request	35	\N	2021-01-25 21:32:12.176916+00	t	f	f	\N	\N	4	73	14
52	info	f	74	followed you.	Follow	36	\N	2021-01-25 21:31:28.504459+00	t	f	f	\N	\N	4	75	17
39	info	f	74	created a new Project Molecular signal modeling of a partially counting absorbing spherical receiver	Project	25	\N	2021-01-25 20:36:26.778023+00	t	f	f	\N	\N	4	74	9
54	info	t	74	rated about you	Rating	4	\N	2021-01-25 21:34:45.89893+00	t	f	f	\N	\N	4	75	18
40	info	f	73	wants to follow you.	Follow Request	31	\N	2021-01-25 20:41:42.955778+00	t	f	f	\N	\N	4	71	16
33	info	f	71	created a new Project Is measuring the knowledge creation of universities possible?	Project	22	\N	2021-01-25 20:14:10.34964+00	t	f	f	\N	\N	4	71	9
57	info	t	74	rated about you	Rating	5	\N	2021-01-25 21:40:04.297001+00	t	f	f	\N	\N	4	71	18
55	info	f	74	wants to follow you.	Follow Request	38	\N	2021-01-25 21:35:42.090574+00	t	f	f	\N	\N	4	73	16
47	info	f	75	created a new Project Research on University Rankings	Project	26	\N	2021-01-25 21:05:05.279494+00	t	f	f	\N	\N	4	75	9
58	info	f	73	followed you.	Follow	39	\N	2021-01-25 21:40:39.519159+00	t	f	f	\N	\N	4	75	17
51	info	f	71	followed you.	Follow	35	\N	2021-01-25 21:26:41.669417+00	t	f	f	\N	\N	4	75	17
56	info	f	74	followed you.	Follow	38	\N	2021-01-25 21:39:18.154597+00	t	f	f	\N	\N	4	71	17
59	info	f	73	wants to follow you.	Follow Request	39	\N	2021-01-25 21:41:14.895835+00	t	f	f	\N	\N	4	74	16
184	info	t	80	accepted your invitation to Project Body Area Networks	Project	35	\N	2021-01-30 12:03:04.706231+00	t	f	f	\N	\N	4	83	9
61	info	t	73	rated about you	Rating	7	\N	2021-01-25 21:43:25.564405+00	t	f	f	\N	\N	4	74	18
62	info	t	76	wants to follow you.	Follow Request	40	\N	2021-01-25 21:48:55.209724+00	t	f	f	\N	\N	4	73	16
63	info	t	76	wants to join your Project Fly Good Feel Good	Request	36	\N	2021-01-25 21:50:59.819755+00	t	f	f	\N	\N	4	73	14
187	info	t	91	created a new Project Higgs Boson	Project	45	\N	2021-01-30 12:50:47.311672+00	t	f	f	\N	\N	4	91	9
65	info	t	31	invited you to the Project Tethyan evolution of Turkey: A plate tectonic approach	Invite	17	\N	2021-01-25 22:35:42.886376+00	t	f	f	\N	\N	4	40	15
66	info	t	31	invited you to the Project Tethyan evolution of Turkey: A plate tectonic approach	Invite	18	\N	2021-01-25 22:35:43.293183+00	t	f	f	\N	\N	4	36	15
191	info	t	91	rated about you	Rating	23	\N	2021-01-30 12:55:00.625159+00	t	f	f	\N	\N	4	49	18
194	info	t	90	followed you.	Follow	73	\N	2021-01-30 12:59:43.047996+00	t	f	f	\N	\N	4	51	17
198	info	t	92	wants to join your Project Higgs Boson	Request	47	\N	2021-01-30 14:41:25.451568+00	t	f	f	\N	\N	4	91	14
70	info	t	61	wants to follow you.	Follow Request	42	\N	2021-01-25 22:47:13.333005+00	t	f	f	\N	\N	4	77	16
69	info	f	77	wants to join your Project Asymptotic formulaæ in combinatory analysis	Request	37	\N	2021-01-25 22:46:56.222221+00	t	f	f	\N	\N	4	61	14
71	info	t	61	accepted your request for Project Asymptotic formulaæ in combinatory analysis	Project	28	\N	2021-01-25 22:47:46.890218+00	t	f	f	\N	\N	4	77	9
202	info	t	94	wants to follow you.	Follow Request	77	\N	2021-01-30 16:53:05.285727+00	t	f	f	\N	\N	4	93	16
73	info	t	78	wants to follow you.	Follow Request	44	\N	2021-01-25 22:53:25.164986+00	t	f	f	\N	\N	4	77	16
207	info	t	95	wants to follow you.	Follow Request	79	\N	2021-01-30 17:04:37.483822+00	t	f	f	\N	\N	4	93	16
210	info	t	94	wants to follow you.	Follow Request	82	\N	2021-01-30 17:06:52.63587+00	t	f	f	\N	\N	4	95	16
75	info	f	78	wants to join your Project Asymptotic formulaæ in combinatory analysis	Request	38	\N	2021-01-25 22:55:47.733695+00	t	f	f	\N	\N	4	61	14
72	info	f	78	wants to follow you.	Follow Request	43	\N	2021-01-25 22:53:07.777112+00	t	f	f	\N	\N	4	61	16
68	info	f	77	wants to follow you.	Follow Request	41	\N	2021-01-25 22:45:21.901304+00	t	f	f	\N	\N	4	61	16
67	info	f	61	created a new Project Asymptotic formulaæ in combinatory analysis	Project	28	\N	2021-01-25 22:37:27.435654+00	t	f	f	\N	\N	4	61	9
77	info	t	36	accepted your invitation to Project Tethyan evolution of Turkey: A plate tectonic approach	Project	4	\N	2021-01-25 23:04:52.646527+00	t	f	f	\N	\N	4	31	9
36	info	f	35	wants to join your Project Tethyan evolution of Turkey: A plate tectonic approach	Request	34	\N	2021-01-25 20:30:02.260131+00	t	f	f	\N	\N	4	31	14
217	info	t	95	wants to join your Project A Certainty Equivalent Merton Problem	Request	53	\N	2021-01-30 17:12:55.310354+00	t	f	f	\N	\N	4	93	14
78	info	f	79	followed you.	Follow	46	\N	2021-01-26 09:08:05.509646+00	t	f	f	\N	\N	4	75	17
80	info	t	75	invited you to the Project Research on University Rankings	Invite	19	\N	2021-01-26 09:10:37.514557+00	t	f	f	\N	\N	4	79	15
81	info	t	79	accepted your invitation to Project Research on University Rankings	Project	26	\N	2021-01-26 09:14:12.595094+00	t	f	f	\N	\N	4	75	9
84	info	t	51	wants to follow you.	Follow Request	46	\N	2021-01-26 09:17:31.364755+00	t	f	f	\N	\N	4	74	16
82	info	f	51	created a new Project Attention Metaphors: How Metaphors Guide the Cognitive Psychology of Attention	Project	29	\N	2021-01-26 09:15:36.603221+00	t	f	f	\N	\N	4	51	9
79	info	f	75	followed you.	Follow	47	\N	2021-01-26 09:09:08.005554+00	t	f	f	\N	\N	4	79	17
86	info	t	79	rated about you	Rating	8	\N	2021-01-26 09:23:42.050475+00	t	f	f	\N	\N	4	75	18
87	info	t	80	followed you.	Follow	48	\N	2021-01-26 09:24:54.205301+00	t	f	f	\N	\N	4	30	17
88	info	t	80	wants to follow you.	Follow Request	50	\N	2021-01-26 09:25:29.444753+00	t	f	f	\N	\N	4	31	16
89	info	t	80	followed you.	Follow	49	\N	2021-01-26 09:25:32.98869+00	t	f	f	\N	\N	4	43	17
83	info	f	51	created a new Milestone with description Draft	Milestone	8	\N	2021-01-26 09:16:51.572309+00	t	f	f	\N	\N	4	51	12
92	info	t	80	wants to follow you.	Follow Request	51	\N	2021-01-26 09:26:26.176273+00	t	f	f	\N	\N	4	40	16
93	info	t	81	followed you.	Follow	51	\N	2021-01-26 09:26:45.531847+00	t	f	f	\N	\N	4	80	17
94	info	t	80	followed you.	Follow	53	\N	2021-01-26 09:30:47.51035+00	t	f	f	\N	\N	4	75	17
96	info	t	82	created a new Project Introduction to Educational and Psychological Measurement	Project	32	\N	2021-01-26 09:36:06.803594+00	t	f	f	\N	\N	4	82	9
98	info	t	33	followed you.	Follow	54	\N	2021-01-26 09:40:39.227081+00	t	f	f	\N	\N	4	80	17
99	info	t	33	rated about you	Rating	12	\N	2021-01-26 09:41:00.315927+00	t	f	f	\N	\N	4	80	18
100	info	f	40	wants to follow you.	Follow Request	52	\N	2021-01-26 09:42:35.215851+00	t	f	f	\N	\N	4	80	16
102	info	t	51	wants to follow you.	Follow Request	53	\N	2021-01-26 09:44:11.002575+00	t	f	f	\N	\N	4	80	16
107	info	t	56	wants to follow you.	Follow Request	56	\N	2021-01-26 09:49:46.918603+00	t	f	f	\N	\N	4	80	16
109	info	t	80	invited you to the Project Introduction to Educational and Psychological Measurement	Invite	21	\N	2021-01-26 09:53:17.713575+00	t	f	f	\N	\N	4	75	15
110	info	t	80	invited you to the Project Introduction to Educational and Psychological Measurement	Invite	22	\N	2021-01-26 09:53:50.190716+00	t	f	f	\N	\N	4	43	15
111	info	t	80	invited you to the Project Introduction to Educational and Psychological Measurement	Invite	23	\N	2021-01-26 09:53:55.949426+00	t	f	f	\N	\N	4	49	15
90	info	f	80	followed you.	Follow	50	\N	2021-01-26 09:25:34.059399+00	t	f	f	\N	\N	4	71	17
60	info	f	73	rated about you	Rating	6	\N	2021-01-25 21:42:26.603483+00	t	f	f	\N	\N	4	71	18
76	info	f	36	accepted your invitation to Project Behavioural and neural bases of threat-learning during learning through adolescence	Project	15	\N	2021-01-25 22:56:11.689413+00	t	f	f	\N	\N	4	45	9
114	info	t	45	followed you.	Follow	58	\N	2021-01-26 09:58:20.254469+00	t	f	f	\N	\N	4	30	17
115	info	t	45	rated about you	Rating	17	\N	2021-01-26 09:58:30.640153+00	t	f	f	\N	\N	4	30	18
118	info	t	71	created a new Project Factors that Affects University Rankings	Project	33	\N	2021-01-26 10:07:04.831954+00	t	f	f	\N	\N	4	71	9
116	info	f	71	accepted your invitation to Project Research on University Rankings	Project	26	\N	2021-01-26 10:04:36.921853+00	t	f	f	\N	\N	4	75	9
108	info	f	40	invited you to the Project Neurological and psychiatric consequences of SARS-CoV-2 infection	Invite	20	\N	2021-01-26 09:50:36.172397+00	t	f	f	\N	\N	4	80	15
112	info	f	71	wants to follow you.	Follow Request	57	\N	2021-01-26 09:54:47.039232+00	t	f	f	\N	\N	4	80	16
101	info	f	40	rated about you	Rating	13	\N	2021-01-26 09:43:19.818946+00	t	f	f	\N	\N	4	80	18
113	info	f	51	invited you to the Project Attention Metaphors: How Metaphors Guide the Cognitive Psychology of Attention	Invite	24	\N	2021-01-26 09:55:25.235938+00	t	f	f	\N	\N	4	80	15
64	info	f	31	accepted your invitation to Project Effects of Covid-19 on Health Workers	Project	3	\N	2021-01-25 22:34:42.580419+00	t	f	f	\N	\N	4	29	9
95	info	f	80	created a new Project Introduction to Educational and Psychological Measurement	Project	31	\N	2021-01-26 09:34:44.591003+00	t	f	f	\N	\N	4	80	9
117	info	f	81	invited you to the Project Educational Psychology in 2021	Invite	25	\N	2021-01-26 10:06:41.55364+00	t	f	f	\N	\N	4	82	15
120	info	t	75	rated about you	Rating	18	\N	2021-01-26 10:11:22.292666+00	t	f	f	\N	\N	4	71	18
121	info	t	75	commented about you	Comment	1	\N	2021-01-26 10:11:58.504782+00	t	f	f	\N	\N	4	71	19
122	info	t	80	wants to join your Project What is Positive Psychology	Request	39	\N	2021-01-26 10:14:41.173089+00	t	f	f	\N	\N	4	30	14
123	info	t	80	wants to join your Project Neurological and psychiatric consequences of SARS-CoV-2 infection	Request	40	\N	2021-01-26 10:16:31.226993+00	t	f	f	\N	\N	4	40	14
124	info	t	71	wants to join your Project Tethyan evolution of Turkey: A plate tectonic approach	Request	41	\N	2021-01-26 19:52:00.574782+00	t	f	f	\N	\N	4	31	14
125	info	t	83	created a new Project Improving Networks with Artificial Intelligence	Project	34	\N	2021-01-27 10:58:58.354281+00	t	f	f	\N	\N	4	83	9
126	info	t	83	created a new Project Body Area Networks	Project	35	\N	2021-01-27 11:01:37.954495+00	t	f	f	\N	\N	4	83	9
127	info	t	83	created a new Project Energy Harvesting in BANs	Project	36	\N	2021-01-27 11:04:25.778658+00	t	f	f	\N	\N	4	83	9
128	info	t	83	invited you to the Project Body Area Networks	Invite	26	\N	2021-01-27 11:09:54.134069+00	t	f	f	\N	\N	4	80	15
129	info	t	83	invited you to the Project Body Area Networks	Invite	27	\N	2021-01-27 11:10:18.554398+00	t	f	f	\N	\N	4	40	15
130	info	t	83	wants to follow you.	Follow Request	58	\N	2021-01-27 11:11:29.156539+00	t	f	f	\N	\N	4	40	16
188	info	t	91	followed you.	Follow	70	\N	2021-01-30 12:53:50.6569+00	t	f	f	\N	\N	4	27	17
132	info	t	84	wants to join your Project Improving Networks with Artificial Intelligence	Request	42	\N	2021-01-27 11:16:24.604687+00	t	f	f	\N	\N	4	83	14
133	info	t	84	wants to join your Project Body Area Networks	Request	43	\N	2021-01-27 11:16:44.504633+00	t	f	f	\N	\N	4	83	14
134	info	t	84	created a new Project Teaching martial arts to robots	Project	37	\N	2021-01-27 11:19:22.732263+00	t	f	f	\N	\N	4	84	9
135	info	t	84	created a new Project Artificial intelligence on martial arts	Project	38	\N	2021-01-27 11:22:11.125318+00	t	f	f	\N	\N	4	84	9
136	info	t	84	created a new Project Creating Martial Arts Animations with AI	Project	39	\N	2021-01-27 11:24:39.508444+00	t	f	f	\N	\N	4	84	9
137	info	t	84	invited you to the Project Creating Martial Arts Animations with AI	Invite	28	\N	2021-01-27 11:26:21.328982+00	t	f	f	\N	\N	4	83	15
138	info	t	84	invited you to the Project Artificial intelligence on martial arts	Invite	29	\N	2021-01-27 11:27:10.05287+00	t	f	f	\N	\N	4	83	15
139	info	t	84	wants to follow you.	Follow Request	60	\N	2021-01-27 11:29:08.175525+00	t	f	f	\N	\N	4	83	16
195	info	t	90	rated about you	Rating	24	\N	2021-01-30 13:41:56.916002+00	t	f	f	\N	\N	4	31	18
141	info	t	84	wants to follow you.	Follow Request	62	\N	2021-01-27 11:29:49.804116+00	t	f	f	\N	\N	4	40	16
142	info	t	29	commented about you	Comment	2	\N	2021-01-28 11:41:08.297085+00	t	f	f	\N	\N	4	31	19
143	info	t	29	rated about you	Rating	19	\N	2021-01-28 11:41:23.305062+00	t	f	f	\N	\N	4	31	18
199	info	t	92	wants to follow you.	Follow Request	76	\N	2021-01-30 14:42:40.575325+00	t	f	f	\N	\N	4	84	16
146	info	t	29	invited you to the Project Effects of running exercises on cycling performance	Invite	30	\N	2021-01-28 11:52:07.770443+00	t	f	f	\N	\N	4	34	15
147	info	t	29	invited you to the Project Effects of running exercises on cycling performance	Invite	31	\N	2021-01-28 11:52:13.498352+00	t	f	f	\N	\N	4	35	15
148	info	t	29	invited you to the Project Effects of running exercises on cycling performance	Invite	32	\N	2021-01-28 11:52:19.061045+00	t	f	f	\N	\N	4	36	15
144	info	f	29	created a new Project Effects of running exercises on cycling performance	Project	40	\N	2021-01-28 11:47:00.281622+00	t	f	f	\N	\N	4	29	9
203	info	t	93	wants to follow you.	Follow Request	78	\N	2021-01-30 16:54:25.740495+00	t	f	f	\N	\N	4	94	16
208	info	t	95	wants to follow you.	Follow Request	80	\N	2021-01-30 17:04:59.084574+00	t	f	f	\N	\N	4	94	16
150	info	f	85	followed you.	Follow	60	\N	2021-01-28 12:31:47.744523+00	t	f	f	\N	\N	4	29	17
221	info	t	95	rated about you	Rating	25	\N	2021-01-30 17:18:23.635134+00	t	f	f	\N	\N	4	93	18
151	info	f	85	wants to join your Project Effects of running exercises on cycling performance	Request	44	\N	2021-01-28 12:32:38.419998+00	t	f	f	\N	\N	4	29	14
223	info	t	93	wants to follow you.	Follow Request	83	\N	2021-01-30 17:27:43.020395+00	t	f	f	\N	\N	4	89	16
153	info	f	29	accepted your request for Project Effects of running exercises on cycling performance	Project	40	\N	2021-01-28 12:34:23.054362+00	t	f	f	\N	\N	4	85	9
225	info	t	93	rated about you	Rating	26	\N	2021-01-30 17:27:59.764255+00	t	f	f	\N	\N	4	89	18
154	info	f	85	created a new Project Business model of e-sports teams	Project	41	\N	2021-01-28 12:38:08.177443+00	t	f	f	\N	\N	4	85	9
155	info	t	85	wants to follow you.	Follow Request	64	\N	2021-01-28 12:44:04.227204+00	t	f	f	\N	\N	4	31	16
156	info	t	85	wants to follow you.	Follow Request	65	\N	2021-01-28 12:45:16.01351+00	t	f	f	\N	\N	4	30	16
157	info	t	85	wants to follow you.	Follow Request	66	\N	2021-01-28 12:45:19.904966+00	t	f	f	\N	\N	4	35	16
158	info	t	85	wants to follow you.	Follow Request	67	\N	2021-01-28 12:45:25.386648+00	t	f	f	\N	\N	4	27	16
159	info	t	85	wants to follow you.	Follow Request	68	\N	2021-01-28 12:45:50.216648+00	t	f	f	\N	\N	4	41	16
152	info	f	29	followed you.	Follow	61	\N	2021-01-28 12:33:41.084886+00	t	f	f	\N	\N	4	85	17
227	info	t	93	rated about you	Rating	27	\N	2021-01-30 17:34:42.681626+00	t	f	f	\N	\N	4	76	18
160	info	f	85	commented about you	Comment	3	\N	2021-01-28 12:46:49.18856+00	t	f	f	\N	\N	4	29	19
161	info	f	29	rated about you	Rating	20	\N	2021-01-28 12:47:51.349236+00	t	f	f	\N	\N	4	85	18
163	info	f	29	created a new Milestone with description End of winter trainings and start of summer trainings	Milestone	9	\N	2021-01-28 12:49:14.208659+00	t	f	f	\N	\N	4	85	12
166	info	t	85	wants to join your Project Neurological and psychiatric consequences of SARS-CoV-2 infection	Request	45	\N	2021-01-28 12:51:54.948296+00	t	f	f	\N	\N	4	40	14
165	info	f	85	created a new Milestone with description Completion of survey and start of second phase.	Milestone	10	\N	2021-01-28 12:51:29.302427+00	t	f	f	\N	\N	4	85	12
167	info	t	86	wants to follow you.	Follow Request	69	\N	2021-01-28 13:00:30.001209+00	t	f	f	\N	\N	4	31	16
170	info	t	86	followed you.	Follow	62	\N	2021-01-28 13:03:44.624928+00	t	f	f	\N	\N	4	41	17
171	info	t	86	followed you.	Follow	63	\N	2021-01-28 13:03:49.787134+00	t	f	f	\N	\N	4	42	17
172	info	t	86	followed you.	Follow	64	\N	2021-01-28 13:03:54.502627+00	t	f	f	\N	\N	4	43	17
174	info	t	86	followed you.	Follow	66	\N	2021-01-28 13:04:07.25113+00	t	f	f	\N	\N	4	45	17
176	info	t	86	followed you.	Follow	68	\N	2021-01-28 13:04:17.917422+00	t	f	f	\N	\N	4	49	17
177	info	f	86	created a new Project Referee mistakes and VAR	Project	42	\N	2021-01-28 13:19:13.315801+00	t	f	f	\N	\N	4	86	9
178	info	t	86	created a new Milestone with description End of 2020/2021 season.	Milestone	11	\N	2021-01-28 13:21:00.231455+00	t	f	f	\N	\N	4	86	12
131	info	f	83	wants to follow you.	Follow Request	59	\N	2021-01-27 11:12:18.814461+00	t	f	f	\N	\N	4	80	16
140	info	f	84	wants to follow you.	Follow Request	61	\N	2021-01-27 11:29:25.688862+00	t	f	f	\N	\N	4	80	16
185	info	t	80	accepted your invitation to Project Neurological and psychiatric consequences of SARS-CoV-2 infection	Project	9	\N	2021-01-30 12:03:10.9268+00	t	f	f	\N	\N	4	40	9
181	info	t	89	followed you.	Follow	69	\N	2021-01-30 08:54:14.507237+00	t	f	f	\N	\N	4	76	17
182	info	t	89	rated about you	Rating	22	\N	2021-01-30 08:54:22.186931+00	t	f	f	\N	\N	4	76	18
179	info	f	89	created a new Project Adversarial Attacks on Federated Learning Models	Project	43	\N	2021-01-30 08:52:58.565432+00	t	f	f	\N	\N	4	89	9
189	info	t	91	followed you.	Follow	71	\N	2021-01-30 12:54:29.61148+00	t	f	f	\N	\N	4	51	17
192	info	t	91	created a new Milestone with description The draft of the project should be created to send to the committee	Milestone	12	\N	2021-01-30 12:58:00.307964+00	t	f	f	\N	\N	4	91	12
196	info	f	92	created a new Project Review of particle physics	Project	46	\N	2021-01-30 14:33:03.650193+00	t	f	f	\N	\N	4	92	9
200	info	t	93	created a new Project A Certainty Equivalent Merton Problem	Project	47	\N	2021-01-30 16:45:33.964867+00	t	f	f	\N	\N	4	93	9
204	info	t	94	wants to join your Project A simple effective heuristic for embedded mixed-integer quadratic programming	Request	48	\N	2021-01-30 16:57:44.628154+00	t	f	f	\N	\N	4	93	14
206	info	t	93	accepted your request for Project A simple effective heuristic for embedded mixed-integer quadratic programming	Project	48	\N	2021-01-30 16:59:44.33204+00	t	f	f	\N	\N	4	94	9
209	info	t	93	wants to follow you.	Follow Request	81	\N	2021-01-30 17:06:52.360082+00	t	f	f	\N	\N	4	95	16
211	info	t	93	created a new Project Linear programming heuristics for the graph isomorphism problem	Project	49	\N	2021-01-30 17:09:23.409046+00	t	f	f	\N	\N	4	93	9
212	info	t	94	wants to join your Project Linear programming heuristics for the graph isomorphism problem	Request	50	\N	2021-01-30 17:10:16.86234+00	t	f	f	\N	\N	4	93	14
213	info	t	95	wants to join your Project Linear programming heuristics for the graph isomorphism problem	Request	51	\N	2021-01-30 17:10:30.416713+00	t	f	f	\N	\N	4	93	14
214	info	t	93	accepted your request for Project Linear programming heuristics for the graph isomorphism problem	Project	49	\N	2021-01-30 17:11:30.146682+00	t	f	f	\N	\N	4	94	9
215	info	t	93	accepted your request for Project Linear programming heuristics for the graph isomorphism problem	Project	49	\N	2021-01-30 17:11:30.950588+00	t	f	f	\N	\N	4	95	9
216	info	t	95	wants to join your Project A simple effective heuristic for embedded mixed-integer quadratic programming	Request	52	\N	2021-01-30 17:12:42.460706+00	t	f	f	\N	\N	4	93	14
218	info	t	93	accepted your request for Project A Certainty Equivalent Merton Problem	Project	47	\N	2021-01-30 17:13:38.2587+00	t	f	f	\N	\N	4	94	9
219	info	t	93	accepted your request for Project A Certainty Equivalent Merton Problem	Project	47	\N	2021-01-30 17:13:38.815507+00	t	f	f	\N	\N	4	95	9
220	info	t	93	accepted your request for Project A simple effective heuristic for embedded mixed-integer quadratic programming	Project	48	\N	2021-01-30 17:14:16.297187+00	t	f	f	\N	\N	4	95	9
222	info	t	95	commented about you	Comment	4	\N	2021-01-30 17:19:55.412728+00	t	f	f	\N	\N	4	93	19
224	info	t	93	followed you.	Follow	82	\N	2021-01-30 17:27:43.401949+00	t	f	f	\N	\N	4	89	17
226	info	t	93	followed you.	Follow	83	\N	2021-01-30 17:34:32.374979+00	t	f	f	\N	\N	4	76	17
228	info	t	51	created a new Project Effect of Covid-19 on Mental Health	Project	50	\N	2021-01-30 18:40:22.695458+00	t	f	f	\N	\N	4	51	9
229	info	t	51	invited you to the Project Effect of Covid-19 on Mental Health	Invite	35	\N	2021-01-30 19:15:34.489335+00	t	f	f	\N	\N	4	82	15
183	info	f	80	wants to join your Project Attention Metaphors: How Metaphors Guide the Cognitive Psychology of Attention	Request	46	\N	2021-01-30 12:01:39.523786+00	t	f	f	\N	\N	4	51	14
230	info	t	51	accepted your request for Project Attention Metaphors	Project	29	\N	2021-01-30 19:47:47.253402+00	t	f	f	\N	\N	4	80	9
232	info	t	96	wants to join your Project Linear programming heuristics for the graph isomorphism problem	Request	54	\N	2021-01-30 22:53:53.691429+00	t	f	f	\N	\N	4	93	14
233	info	f	98	wants to follow you.	Follow Request	84	\N	2021-01-30 22:59:42.54935+00	t	f	f	\N	\N	4	96	16
231	info	f	96	created a new Project The use of computer-aided-instructions in computer engineering curriculum	Project	51	\N	2021-01-30 22:50:01.038841+00	t	f	f	\N	\N	4	96	9
234	info	t	98	rated about you	Rating	28	\N	2021-01-30 23:05:30.481599+00	t	f	f	\N	\N	4	96	18
235	info	t	98	followed you.	Follow	85	\N	2021-01-30 23:08:00.178961+00	t	f	f	\N	\N	4	43	17
236	info	t	98	created a new Project Modelling quantum aspects of disruption of a white dwarf star by a black hole	Project	52	\N	2021-01-30 23:10:45.459041+00	t	f	f	\N	\N	4	98	9
237	info	t	42	wants to follow you.	Follow Request	85	\N	2021-01-31 11:02:02.375972+00	t	f	f	\N	\N	4	41	16
238	info	f	99	created a new Project Functional analysis in clinical psychology	Project	53	\N	2021-01-31 16:02:29.598276+00	t	f	f	\N	\N	4	99	9
239	info	t	99	wants to follow you.	Follow Request	86	\N	2021-01-31 16:07:31.073765+00	t	f	f	\N	\N	4	74	16
240	info	t	99	followed you.	Follow	89	\N	2021-01-31 16:09:22.174455+00	t	f	f	\N	\N	4	27	17
241	info	t	99	wants to follow you.	Follow Request	87	\N	2021-01-31 16:09:30.400135+00	t	f	f	\N	\N	4	31	16
242	info	t	99	followed you.	Follow	90	\N	2021-01-31 16:09:34.509072+00	t	f	f	\N	\N	4	75	17
243	info	t	99	followed you.	Follow	91	\N	2021-01-31 16:09:35.71446+00	t	f	f	\N	\N	4	91	17
244	info	t	99	followed you.	Follow	92	\N	2021-01-31 16:09:52.748958+00	t	f	f	\N	\N	4	51	17
245	info	t	99	followed you.	Follow	93	\N	2021-01-31 16:09:53.787772+00	t	f	f	\N	\N	4	49	17
246	info	t	99	wants to follow you.	Follow Request	88	\N	2021-01-31 16:10:05.481181+00	t	f	f	\N	\N	4	90	16
247	info	t	99	wants to follow you.	Follow Request	89	\N	2021-01-31 16:10:08.493157+00	t	f	f	\N	\N	4	80	16
248	info	t	100	created a new Project Research methods in human-computer interaction	Project	54	\N	2021-01-31 16:15:05.807402+00	t	f	f	\N	\N	4	100	9
249	info	t	100	wants to join your Project The use of computer-aided-instructions in computer engineering curriculum	Request	55	\N	2021-01-31 16:16:10.461535+00	t	f	f	\N	\N	4	96	14
250	info	t	100	wants to follow you.	Follow Request	90	\N	2021-01-31 16:16:14.095884+00	t	f	f	\N	\N	4	96	16
251	info	t	100	followed you.	Follow	94	\N	2021-01-31 16:16:30.365645+00	t	f	f	\N	\N	4	89	17
252	info	t	100	wants to follow you.	Follow Request	91	\N	2021-01-31 16:16:34.447412+00	t	f	f	\N	\N	4	93	16
253	info	t	100	followed you.	Follow	95	\N	2021-01-31 16:16:40.383926+00	t	f	f	\N	\N	4	76	17
254	info	t	100	wants to join your Project Cache Hit Rate Optimization using MAB in Wireless Network	Request	56	\N	2021-01-31 16:17:06.492637+00	t	f	f	\N	\N	4	26	14
255	info	t	100	followed you.	Follow	96	\N	2021-01-31 16:17:10.621787+00	t	f	f	\N	\N	4	26	17
180	info	f	89	wants to follow you.	Follow Request	72	\N	2021-01-30 08:53:32.990951+00	t	f	f	\N	\N	4	86	16
256	info	t	100	followed you.	Follow	97	\N	2021-01-31 16:17:17.964341+00	t	f	f	\N	\N	4	34	17
257	info	t	100	followed you.	Follow	98	\N	2021-01-31 16:17:21.491847+00	t	f	f	\N	\N	4	71	17
259	info	t	100	followed you.	Follow	100	\N	2021-01-31 16:17:33.327125+00	t	f	f	\N	\N	4	30	17
260	info	t	100	wants to follow you.	Follow Request	92	\N	2021-01-31 16:17:38.682344+00	t	f	f	\N	\N	4	73	16
261	info	t	100	followed you.	Follow	101	\N	2021-01-31 16:17:39.027393+00	t	f	f	\N	\N	4	75	17
262	info	t	100	wants to follow you.	Follow Request	93	\N	2021-01-31 16:17:45.214225+00	t	f	f	\N	\N	4	41	16
263	info	t	101	created a new Project Verifying autonomous systems	Project	55	\N	2021-01-31 16:25:58.773427+00	t	f	f	\N	\N	4	101	9
264	info	t	102	created a new Project Disability civil rights law and policy	Project	56	\N	2021-01-31 16:34:12.923461+00	t	f	f	\N	\N	4	102	9
265	info	t	102	wants to join your Project Research on University Rankings	Request	57	\N	2021-01-31 16:37:28.573448+00	t	f	f	\N	\N	4	75	14
266	info	t	102	followed you.	Follow	102	\N	2021-01-31 16:37:34.049466+00	t	f	f	\N	\N	4	79	17
267	info	t	102	followed you.	Follow	103	\N	2021-01-31 16:37:43.11573+00	t	f	f	\N	\N	4	75	17
258	info	f	100	followed you.	Follow	99	\N	2021-01-31 16:17:32.023781+00	t	f	f	\N	\N	4	27	17
268	info	t	27	followed you.	Follow	104	\N	2021-01-31 18:00:25.944449+00	t	f	f	\N	\N	4	100	17
269	info	t	27	created a new Project Serological identification of human tumor antigens	Project	57	\N	2021-01-31 18:05:03.729349+00	t	f	f	\N	\N	4	27	9
164	info	f	85	rated about you	Rating	21	\N	2021-01-28 12:50:28.307529+00	t	f	f	\N	\N	4	29	18
270	info	t	27	followed you.	Follow	107	\N	2021-01-31 18:07:25.9084+00	t	f	f	\N	\N	4	75	17
162	info	f	29	created a new Milestone with description End of winter trainings and start of summer trainings	Milestone	9	\N	2021-01-28 12:49:14.138081+00	t	f	f	\N	\N	4	29	12
271	info	t	86	followed you.	Follow	108	\N	2021-01-31 18:11:47.077287+00	t	f	f	\N	\N	4	89	17
\.


--
-- Data for Name: api_profile; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_profile (id, created, name, middle_name, last_name, bio, share_birthday, expertise, gender, interests, share_bio, share_gender, share_affiliations, owner_id, birthday, affiliations, profile_picture, is_public) FROM stdin;
76	2021-01-30 12:32:53.085569+00	Baran		Güzelsoy	Professor of Anthropology, University of Toronto	t	Anthropology, Paleolithic Archaeology	do not want to share	Chess, cycling	t	t	t	90	1954-02-02	University of Toronto	pp/old.jpg	f
82	2021-01-30 22:46:26.734103+00	Leyla		Amansız		t		do not want to share		t	t	t	96	\N			f
84	2021-01-30 22:58:13.927099+00	Tunç		Yılmaz		t		do not want to share		t	t	t	98	\N			f
78	2021-01-30 14:28:05.982678+00	James		Edinburg	Professor at the University of Sussex	t	Physics, Particle Physics, Pattern Recognition	male	Reading	t	t	t	92	1973-09-05	University of Sussex	pp/physicist.jpg	t
80	2021-01-30 16:51:14.921742+00	Nicholas jack		Moehle	My current research involves applying convex optimization and control theory in finance, and in particular, asset management. My PhD work, supervised by Stephen Boyd, focused on applications to energy management.	t	Applied optimization	do not want to share	Applied optimization	t	t	t	94	\N		pp/moehle.jpg	f
35	2020-12-29 09:17:43.795105+00	Matthew	george	Jackson	Matthew Jackson is Professor of Economics at Stamford University and an external faculty member of the Santa De Institute	t	Economics	do not want to share	Economics	t	t	t	42	1973-10-22	The Santa De Institute	pp/indir.jpg	t
86	2021-01-31 15:54:23.200296+00	Jade		Williams	Graduate student at The University Of Manchester	t	Human-computer interaction, Computer graphics	female	Running, Music Production	t	t	f	100	1993-04-16		pp/pexels-thisisengineering-3861445-2.jpg	t
88	2021-01-31 15:57:27.634764+00	Hugo		Anderson	Professor at University of Cambridge	t	Civil Rights, Law	do not want to share	Art, Classical Music	t	t	f	102	1975-01-31		pp/pexels-snapwire-618613.jpg	f
29	2020-12-28 23:01:56.800393+00	Hakan		Mutlu	Associate Professor at MIT. Biologist.	t	Biological network	do not want to share	Swimming	t	t	t	35	1986-12-11	MIT	pp/hakanmutlu.jpg	t
33	2020-12-29 08:45:03.630357+00	Hakan		Yılmaz	Professor at NeuroTechEU	t	Neuroscience, Machine Learning	male	Golf, Billiard, Chess	t	t	t	40	1965-12-09	NeuroTechEU	pp/hakanyilmaz2.jpg	f
30	2020-12-28 23:39:20.763631+00	İlber		Ortaylı	İlber Ortaylı (born 21 May 1947) is a Turkish historian and professor of history at the MEF University, Galatasaray University in Istanbul and at Bilkent University in Ankara. In 2005, he was appointed as the director of the Topkapı Museum in Istanbul, until he retired in 2012.	t	History of the Ottoman Empire	do not want to share	Languages	t	t	t	36	1947-05-27	Galatasaray University	pp/ilberortayli.jpg	f
25	2020-12-28 19:36:37.612535+00	Celal		Şengör	Ali Mehmet Celâl Şengör is a Turkish geologist. He is currently on the faculty at Istanbul Technical University, Department of Geological Engineering.	t	Geology	male	Wines	t	t	t	31	1955-03-24		pp/celalsengor.jpg	f
27	2020-12-28 19:53:30.91463+00	Keiichi		Tsuchiya		t	Neuroscience	male	Racing, Drift, Cars	t	t	t	33	1956-01-30		pp/pexels-bach-hanzo-3564770.png	f
24	2020-12-28 19:32:45.82444+00	Pelin		Yagiz	Clinical Psychologist. Provides expert counseling. Experienced and highly qualified.	t	Psychology	female	Reading, yoga	t	t	t	30	1983-12-03	Radboud University	pp/pexels-wictor-cardoso-5208023.jpg	t
52	2021-01-24 18:32:17.80116+00	Godfrey Harold		Hardy	I am an English mathematician, known for my achievements in number theory and mathematical analysis	t	Number theory	do not want to share	Number theory, population dynamics	t	t	t	61	1877-02-07	Trinity College, Cambridge	pp/Ghhardy72.jpg	f
36	2020-12-29 09:29:51.865313+00	Aziz		Sancar	Aziz Sancar is a Turkish molecular biologist specializing in DNA repair, cell cycle checkpoints, and circadian clock	t	Biochemistry, Molecular biology, DNA repair	do not want to share	Economy	t	t	t	43	1946-09-08	University of North Carolina School of Medicine	pp/azizsancar.jpg	t
34	2020-12-29 09:02:36.94699+00	Martin	Jack	Newman	I study using a combination of empirical methods, analysis, and computer simulation	t	Complex Networks	do not want to share	Complex Networks	t	f	t	41	1963-11-12	Technical University of Munich (TUM)		f
38	2020-12-29 09:46:43.402754+00	Mahmut		Kaya	Studied in Oxford University - Department of Experimental Psychology - Cognitive Neurosciences	t	Psychology, Cognitive Neurosciences	do not want to share	Basketball, chess	t	t	t	45	1996-12-04	Oxford University	pp/indir.png	f
40	2020-12-29 10:48:55.543214+00	Ugur		Sahin	Co-founder of Biontech	t	Immunology, Vaccine, Coronavirus	male	Cancer Research, Vaccines, Immunology	t	t	t	49	1978-12-20		pp/ugur.jpg	t
23	2020-12-28 19:29:44.297467+00	Adil Numan		Çelik	Computer Engineering Student at Boğaziçi University	f	Student	male	Django Framework, Algorithms, Backend Development, Psychology, Physiology, Cycling	t	t	t	29	1999-03-04	Bogazici University	pp/Screenshot_20201121-225413_Chrome.jpg	t
42	2021-01-17 20:36:04.797918+00	Buse		Giledereli	Psychology master student	t	Psychology, Cognitive Psychology, Evolutionary Psychology	female	Yoga	t	t	t	51	1995-04-17	Erasmus University	pp/IMG_2278_2.JPG	t
47	2021-01-24 15:16:59.842881+00	Neriman		Güler	Postdoctoral Fellow, Merad Lab, Icahn School of Medicine at Mount Sinai	t	Immunology	do not want to share	Fishing, dancing	t	t	t	56	1982-04-12	Icahn School of Medicine		f
60	2021-01-25 20:14:29.165734+00	Mehmet		Oz	Professor, Cardiolog	t	Medicine, Snowboard	male	Heart, TV Shows, Medicine, Computer Tech.	t	t	t	73	1960-06-11		pp/5adad68d7af507023058899b.jpg	f
20	2020-12-28 19:25:38.573893+00	Furkan		Cansever	Şeytanla pazarlığını iyi yapmışsın ama beni tanımamışsın...	t	ML	male	ML,Wireless Network, Image Process	t	t	t	26	1996-07-06		pp/cengelkoy1.jpg	t
22	2020-12-28 19:28:31.345987+00	Kerem		Altın	Successful anthropologist	t	Anthropology	male	History	t	t	t	28	1987-12-17	Koc University	pp/pexels-mentatdgt-937481.jpg	t
61	2021-01-25 20:22:46.200075+00	Tuna		Tugcu	King @Computer Engineering Cmpe	t	Computer Science, Technology	male	Applied Networks, Nanotechnology, Signal, Computer Science	t	t	t	74	1968-08-19	Bogazici University	pp/tugcu_0.jpg	f
63	2021-01-25 21:44:54.484759+00	Ahmet	Emir	Kocaaga	Rektör, Boğaziçi Üniversitesi	t	Software Development, Data Mining	male	Machine Learning, Software Engineering, Complex Systems, Vaccine Development	t	t	t	76	1972-01-28	Bogazici University	pp/liberbey.jpg	t
58	2021-01-25 19:59:55.59661+00	Melih		Bulu	Rektör, Boğaziçi Üniversitesi	t	Networking, Politics	male	Managemenet, Politics, More Politics	t	t	t	71	1977-01-10	Bogazici University	pp/5ff462e7ab617.jpg	t
28	2020-12-28 21:53:42.240714+00	Ceren	Tuna	Oz	Data Scientist. Likes working with Biomedical data, specialized in BioNLP.	t	NLP, BioNLP, Machine Learning, Data Science	female	Dancing, fishing	t	t	t	34	1982-08-23	ETH Zürich	pp/pexels-moose-photos-1587009.jpg	t
77	2021-01-30 12:44:05.396562+00	Büşra	Gül	Derili	A Particle Physics researcher at CERN	t	Particle Physics	female	Basketball, ballet	t	t	t	91	1980-01-13	CERN	pp/woman.jpg	t
73	2021-01-28 12:56:34.103662+00	Tursun	Turmaz	Takar	Ex-referee in Turkish Football Federation	t	Referee	do not want to share	Football, Artificial Intelligence	t	t	t	86	1959-01-15		pp/A.PNG	f
79	2021-01-30 16:41:56.184617+00	Stephen Harold		Boyd	Professor of Electrical Engineering, Computer Science, and Management Science, Stamford	t	optimization, AI, Signal processing	do not want to share	optimization, AI, Signal processing	t	t	t	93	\N		pp/citations.jpg	f
74	2021-01-30 08:32:46.024779+00	Barış		Başmak	Many things: a developer, a skier, a great husband, and a researcher	t	Web Development, Blockchain Programming	do not want to share	Machine Learning, Blockchain, Ethereum, Software Engineering, Web Development	t	t	t	89	1998-05-24		pp/7S_CC_1.png	t
21	2020-12-28 19:27:06.378374+00	Ozlem		Tureci	I am co-founder and chief medical officer of BioNTech, president of the Mainz, Germany-based non-profit Association for Cancer Immunotherapy, co-initiator and chair of the Rhine-Main region-based non-profit Cluster for Individualized Immune Intervention, and lecturer at the University of Mainz.	t	Cancer Research, Vaccines, Immunology	female	Immunology, Vaccine, Coronavirus	t	t	t	27	1975-10-11		pp/Ozlem_Tureci_v1.jpg	t
62	2021-01-25 20:51:45.266369+00	Barış		Göğebakan	Hi! I'm a enthusiastic management student at Haliç University. I am instrested in making research about University Rankings.	t	University Rankings, Management	male	University Rankings, Management	t	t	t	75	1993-11-12	Halic University	pp/happy-university-college-student-thumbs-up-15010463.jpg	t
64	2021-01-25 22:41:31.281591+00	Srinivasa Ramanujan		Aiyangar	I am an Indian mathematician	t	Number theory, mathematical analysis, infinite series, and continued fractions	do not want to share	Number theory, mathematical analysis, infinite series, and continued fractions	t	t	t	77	1887-12-22	Trinity College	pp/Srinivasa_Ramanujan_-_OPC_-_1.jpg	f
66	2021-01-26 09:05:14.571356+00	Lale		Dere	Hi! I am a Politics student.	t	Politics, IR	female	Swimming, Management	t	t	t	79	1995-10-22	Koc University	pp/42085275-university-student.jpg	t
67	2021-01-26 09:11:15.056008+00	Olivia		Wilson	PhD student at Melbourne University	t	Contemporary Educational Psychology	do not want to share	Psychology, Education	t	t	t	80	1980-02-08	Melbourne University	pp/pexels-andrea-piacquadio-774909.jpg	f
81	2021-01-30 17:02:04.991265+00	Reza ahmed		Takapoui	My Erdos_number is 3.	t	Convex Optimization	do not want to share	Convex Optimization, Statistical Learning Theory, Large-scale Data Analysis, Stochastic Control	t	t	t	95	\N		pp/citations_1.jpg	f
70	2021-01-27 10:52:33.602455+00	Ahmet		Tokgöz	AI enthusiast	t	Computer networks, Artificial intelligence	do not want to share	Mountain climbing	t	t	t	83	1978-01-11	Bilkent University	pp/pexels-italo-melo-2379004.jpg	f
71	2021-01-27 11:13:22.283384+00	Chris		Tucker	Studies in TUM	t	C++,python,computer networks, robotics	do not want to share	Martial arts	t	t	t	84	1965-01-16	TUM	pp/pexels-nitin-khajotia-1516680.jpg	f
83	2021-01-30 22:54:49.734682+00	Alican		Doymaz		t		do not want to share		t	t	t	97	\N			f
69	2021-01-26 09:31:02.102673+00	olivia		parker		t	Contemporary Educational Psychology	do not want to share	Psychology, Education	t	t	t	82	\N		pp/pexels-andrea-piacquadio-774909.jpg	t
89	2021-01-31 15:58:17.963725+00	Paul		Garcia		t		do not want to share		t	t	t	103	\N			f
72	2021-01-28 12:19:33.002153+00	Finn	karrigan	Andersen	Professional Counter Strike: Global Offensive Player for Mousesports,  Master's Degree in business administration and auditing from Copenhagen Business School.	t	Professional Counter Strike: Global Offensive Player	male	Counter-Strike: Global Offensive	t	t	t	85	1990-04-13	IGL	pp/G_XJT4zG.jpg	t
85	2021-01-31 15:47:31.620057+00	Emma		Smith	PhD Student at Stanford University	t	Psychology, Clinical Psychology	do not want to share	Photography	t	t	f	99	1990-01-17		pp/pexels-deden-dicky-ramdhani-2916324.jpg	f
87	2021-01-31 15:55:48.697944+00	Arthur		Johnson	Mechanical Engineering student at Istanbul Technical University	t	Autonomous Systems	do not want to share	Hacking, Robots	t	t	f	101	1996-01-19		pp/pexels-cottonbro-5474031.jpg	t
\.


--
-- Data for Name: api_project; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_project (id, created, name, description, requirements, is_public, state, project_type, due_date, owner_id, event_id) FROM stdin;
6	2020-12-28 22:02:37.604098+00	Application of BioBERT on Zero-Shot Settings	Transformers are an impressive improvement in NLP history. In this research, we focus on the application of transformers in the biomedical domain.	BioNLP, NLP	t	open for collaborators	journal	2021-04-16	34	\N
3	2020-12-28 19:37:11.849471+00	Effects of Covid-19 on Health Workers	A big data analysis on effects of Covid-19 on health workers.	Data Science	t	open for collaborators	conference	2021-12-28	29	\N
2	2020-12-28 19:36:04.054601+00	Cache Hit Rate Optimization using MAB in Wireless Network	With the upward movement of technology in recent years, smart devices have started to place in most of our lives. As users of smart devices, especially smartphones, are increasing rapidly, reaching content quickly that is needed to provide a satisfying quality of service and quality of experience gained a big role in network architecture. By definition of caching, it is the process of storing copies of files in a cache, or temporary storage location, so that they can be accessed more quickly. We can say that the caching mechanism in computers and wireless networks are almost the same. There are small base stations in local areas and macro base stations at higher levels. They have limited cached size and linked with each other for communication. When users have a request for any content, any request is sent to base stations and if the content is available in the cache, it returns the user, otherwise, with a backhaul link which is a link between the core network and small subnetworks, the request reaches the core network, and it returns the user. In a simple way, the main objective is to get the content with a quick response and offload the network traffic.	Wireless Network, 5G, Caching, Multi-Armed Bandit	t	open for collaborators	journal	2020-12-28	26	1
5	2020-12-28 19:56:57.025463+00	What is Positive Psychology	Positive psychology is the study of the conditions and processes that contribute to the flourishing or optimal functioning of people, groups, and institutions. In this brief introduction, the authors give examples of current work in positive psychology and try to explain why the positive psychology movement has grown so quickly in just 5 years.	Psychology	t	open for collaborators	journal	2021-03-02	30	\N
4	2020-12-28 19:56:25.985784+00	Tethyan evolution of Turkey: A plate tectonic approach	The Tethyan evolution of Turkey may be divided into two main phases, namely a Palaeo-Tethyan and a Neo-Tethyan, although they partly overlap in time. The Palaeo-Tethyan evolution was governed by the main south-dipping (present geographic orientation) subduction zone of Palaeo-Tethys beneath northern Turkey during the Permo-Liassic interval. We want people to work with us about Tethyan evolution of Turkey.	Geography	t	open for collaborators	conference	2020-12-30	31	\N
7	2020-12-29 09:01:32.44507+00	Machine Learning Applied Prosthetics	To improve limited movement of prosthetics of the users, advanced machine learning algorithms applied to prosthetics. Movements of motors in the prosthetics, smooth and improve their movements via learning from muscle contractions. Main goal is to improve the performance of prosthetics with each use of it. Designing better algorithms and movement sets to train artificial intelligence that is used in prosthetics.	Machine Learning, Neuroscience , Robotics	t	open for collaborators	instutution	2021-02-28	40	\N
10	2020-12-29 09:04:54.536525+00	Using Bayes factor hypothesis testing in neuroscience to establish evidence of absence	Through simple tutorial-style examples of Bayesian t-tests and ANOVA using the open-source project JASP, this article aims to empower neuroscientists to use this approach to provide compelling and rigorous evidence for the absence of an effect.	Bayesian mathematics, Neuroscience	t	open for collaborators	journal	2021-03-31	40	1
9	2020-12-29 09:03:53.596715+00	Neurological and psychiatric consequences of SARS-CoV-2 infection	Studying the direct effects of Covid-19 on the central nervous system and the impact of the infection on patients suffering from neurological diseases such as Alzheimer’s disease, Parkinson’s disease and multiple sclerosis.	Neuroscience, psychology, immunology	t	open for collaborators	instutution	2021-04-14	40	6
1	2020-12-28 19:31:11.377025+00	Covid-19 Vaccine	Messenger ribonucleic acid (mRNA) vaccines are a novel technology that stimulates the body’s own immune response. These vaccines contain information from messenger RNA, including the “blueprint” or code of a specific virus trait (virus antigen). The information enables the body to produce this antigen on its own: mRNA transfers the information for the production of the antigen to our cell machinery that makes proteins. Cells in our body then present the antigen on their surface and thus trigger the desired specific immune response. When the body comes into contact with the virus, the immune system recognizes the specific antigen and can fight the virus and thus the infection quickly and in a targeted manner.	Immunology	t	done	conference	2020-12-28	27	\N
8	2020-12-29 09:02:50.939849+00	Personal Mood Tracker	Small devices which are attached to different body areas, use EMG signals to track changes in the person’s body status. To understand how and which areas are affected from mood changes. Needs lots of data to construct a more precise understanding of the body. Machine learning algorithms can be also applied to data collected from different persons.	Machine Learning, Neuroscience , Robotics	t	open for collaborators	instutution	2021-03-31	40	1
56	2021-01-31 16:34:12.737779+00	Disability civil rights law and policy	There have been dramatic legal and policy developments, and strong academic and \npractical interest, in the area of American and international disability civil rights law	Law Degree, Knowledge in civil rights	f	open for collaborators	instutution	2021-03-18	102	\N
12	2020-12-29 09:12:54.367165+00	Network structure from rich but noisy data	Driven by growing interest in the sciences, industry, and among the broader public, a large number of empirical studies have been conducted in recent years of the structure of networks ranging from the internet and the world wide web to biological networks and social networks. The data produced by these experiments are often rich and multimodal, yet at the same time they may contain substantial measurement error. In practice, this means that the true network structure can differ greatly from naive estimates made from the raw data, and hence that conclusions drawn from those naive estimates may be significantly in error. In this paper we describe a technique that circumvents this problem and allows us to make optimal estimates of the true structure of networks in the presence of both richly textured data and significant measurement uncertainty. We give example applications to two different social networks, one derived from face-to-face interactions and one from self-reported friendships.	Social and Information Networks, Physics	t	done	journal	2021-02-01	41	\N
11	2020-12-29 09:05:11.170632+00	Hierarchical structure and the prediction of missing links in networks	Networks have in recent years emerged as an invaluable tool for describing and quantifying complex systems in many branches of science. Recent studies suggest that networks often exhibit hierarchical organization, where vertices divide into groups that further subdivide into groups of groups, and so forth over multiple scales. In many cases these groups are found to correspond to known functional units, such as ecological niches in food webs, modules in biochemical networks (protein interaction networks, metabolic networks, or genetic regulatory networks), or communities in social networks. Here we present a general technique for inferring hierarchical structure from network data and demonstrate that the existence of hierarchy can simultaneously explain and quantitatively reproduce many commonly observed topological properties of networks, such as right-skewed degree distributions, high clustering coefficients, and short path lengths. We further show that knowledge of hierarchical structure can be used to predict missing connections in partially known networks with high accuracy, and for more general network structures than competing techniques. Taken together, our results suggest that hierarchy is a central organizing principle of complex networks, capable of offering insight into many network phenomena.	social and information networks	t	done	journal	2020-12-29	41	\N
15	2020-12-29 09:50:27.273414+00	Behavioural and neural bases of threat-learning during learning through adolescence	Behavioural and neural bases of threat-learning during learning through adolescence	Neuroscience knowledge	t	open for collaborators	instutution	2020-12-29	45	\N
13	2020-12-29 09:20:32.777559+00	Behavioral Communities and the Atomic Structure of Networks	We develop a method of detecting the `behavioral communities' of a social network based on how people act when they choose their behaviors in coordination with their friends' behaviors. There can be multiple different `conventions' (equilibria) in which people in some parts of the network adopt a behavior while people in other parts of the network do not. We define atoms/communities to be groups of people who behave the same as each other in every convention. This provides a microfoundation for a method of detecting communities in social and economic networks. We characterize such behavioral communities in some random graphs as a function of how strongly the benefits of adopting the behavior depend on others' behaviors. We also discuss applications including: optimally seeding the diffusion of behaviors involving peer influence, detecting which demographics or nodal characteristics define a society's communities, estimating the strength of peer influence on behavior, as well as identifying missing network data by observing a series of conventions.	Game theory	t	draft	instutution	2020-12-29	42	\N
14	2020-12-29 09:50:22.068549+00	Cognitive Neuroscience	Studying the understanding of biological processes and aspects that underlie cognition, with a specific focus on the neural connections in the brain which are involved in mental processes.	Neuroscience,biology	t	open for collaborators	conference	2021-02-10	33	1
18	2020-12-29 11:02:25.786541+00	Covid-19 New Mutation Research	The effects of the new mutation found in Great Britian to the founded vaccine will be tested.	Vaccine, Immunology	t	in progress	conference	2021-02-17	27	\N
22	2021-01-25 20:14:10.177376+00	Is measuring the knowledge creation of universities possible?	University ranking indexes are considered very useful benchmarking tools in comparing the performance of universities around the world. Being placed in these prestigious indexes provides a strong advertisement for a university and helps them to attract high-quality students and academicians all over the world.	Management, University Ranking Knowledge	t	done	conference	2021-02-10	71	\N
24	2021-01-25 20:31:12.716437+00	Fly Good Feel Good	This collaboration will be a part of the project "Fly Good Feel Good" presented by the global carrier to its passengers. The project also comprises short videos and print materials with recommendations from experts that are also available on PaperLayer, social media accounts and inflight entertainment system.	Medical Equipment\nDiet Expertises	t	open for collaborators	journal	2021-01-31	73	4
23	2021-01-25 20:30:36.446942+00	3-D Face Detection, Landmark Localization, and Registration Using a Point Distribution Model	Face detection is performed by classifying the transformations between model points and candidate vertices based on the upper-bound of the deviation of the parameters from the mean model. Landmark localization is performed on the segmented face by finding the transformation that minimizes the deviation of the model from the mean shape. Face registration is obtained using prior anthropometric knowledge and the localized landmarks.	ML, ICP, 3-D, Statistics	t	open for collaborators	conference	2021-02-18	26	\N
17	2020-12-29 10:09:34.702028+00	Cancer Immunology Research	One focused on a special type of antibody that, in contrast to the normal paradigm of blocking a function, instead meant to activate immune effectors and attract them to the tumor. We called them “ideal antibodies” or IMABs.	MD, Cancer Research, Immunology	f	in progress	conference	2021-01-20	27	1
57	2021-01-31 18:05:03.538276+00	Serological identification of human tumor antigens	Using the antibody repertoire of cancer patients for the systematic search for human tumor antigens, a plenitude of new human tumor antigens has been identified demonstrating that many human tumors elicit multiple immune responses in the autologous host.	Immunology, Tumors	t	published	conference	2021-03-10	27	\N
26	2021-01-25 21:05:05.10066+00	Research on University Rankings	We will be making a research about the factors that affect university rankings.	University Rankings, Management	t	open for collaborators	conference	2021-03-18	75	10
25	2021-01-25 20:36:26.596811+00	Molecular signal modeling of a partially counting absorbing spherical receiver	To communicate at the nanoscale, researchers have proposed molecular communication as an energy-efficient solution. The drawback to this solution is that the histogram of the molecules’ hitting times, which constitute the molecular signal at the receiver, has a heavy tail. Reducing the effects of this heavy tail, inter-symbol interference (ISI), has been the focus of most prior research. In this paper, a novel way of decreasing the ISI by defining a counting region on the spherical receiver’s surface facing toward the transmitter node is proposed. The beneficial effect comes from the fact that the molecules received from the back lobe of the receiver are more likely to be coming through longer paths that contribute to ISI. In order to justify this idea, the joint distribution of the arrival molecules with respect to angle and time is derived. Using this distribution, the channel model function is approximated for the proposed system, i.e., the partially counting absorbing spherical receiver. After validating the channel model function, the characteristics of the molecular signal are investigated and improved performance is presented. Moreover, the optimal counting region in terms of bit error rate is found analytically.	Signal, Modeling, Processings	t	done	conference	2021-02-18	74	\N
27	2021-01-25 21:08:26.616996+00	The Reasons of Atherosclerosis	Atherosclerosis is a specific type of arteriosclerosis, but the terms are sometimes used interchangeably. Atherosclerosis refers to the buildup of fats, cholesterol and other substances in and on your artery walls (plaque), which can restrict blood flow.	Articles\nCollaborators	t	in progress	conference	2021-03-17	73	2
28	2021-01-25 22:37:27.242489+00	Asymptotic formulaæ in combinatory analysis	The present paper is the outcome of an attempt to apply to the principal problems of the theory of partitions the methods, depending upon the theory of analytic functions, which have proved so fruitful in the theory of the distribution of primes and allied branches of the analytic theory of numbers.	Number theory	t	open for collaborators	journal	2021-01-29	61	\N
37	2021-01-27 11:19:22.560572+00	Teaching martial arts to robots	Research on teaching robots to how to fight.	Robotics,martial arts,C++	t	open for collaborators	journal	2022-01-27	84	\N
31	2021-01-26 09:34:44.412706+00	Introduction to Educational and Psychological Measurement	Validity and test evaluation are based on both qualitative and quantitative analysis of the properties of a measure.	Education, Psychology	t	open for collaborators	conference	2022-01-26	80	\N
32	2021-01-26 09:36:06.628638+00	Introduction to Educational and Psychological Measurement	Validity and test evaluation are based on both qualitative and quantitative analysis of the properties of a measure.	Education, Psychology	t	open for collaborators	journal	2021-02-24	82	\N
34	2021-01-27 10:58:58.126541+00	Improving Networks with Artificial Intelligence	Using artificial intelligence to improve performance of computer networks.	Artificial Intelligence, Computer Networks, Python	t	open for collaborators	journal	2023-01-18	83	\N
33	2021-01-26 10:07:04.6474+00	Factors that Affects University Rankings	Reseearch on the ffactors that effects university rankings.	None	t	published	conference	2021-01-28	71	1
40	2021-01-28 11:47:00.091548+00	Effects of running exercises on cycling performance	We want to learn how a cyclist can utilize running exercises. We aim to conduct experiments. We are open for any collaboration with interest in sports and physiology.	Interest and preferably experience on sports and physiology.	t	open for collaborators	journal	2021-08-01	29	\N
35	2021-01-27 11:01:37.774134+00	Body Area Networks	Research on improving body area networks performance in long run.	Body Area Networks, Computer Networks, Algorithms	t	open for collaborators	journal	2025-01-27	83	\N
36	2021-01-27 11:04:25.598062+00	Energy Harvesting in BANs	Research on applying energy harvesting in body area networks.	Body Area Networks, Computer networks,	t	open for collaborators	journal	2022-01-27	83	\N
41	2021-01-28 12:38:07.991472+00	Business model of e-sports teams	We will create a survey on how e-sports teams operate and then try to explore new ways of increasing profits and success at the same time.	Business and management\nE-sports	t	open for collaborators	journal	2022-01-01	85	\N
42	2021-01-28 13:19:13.145157+00	Referee mistakes and VAR	We want to see that if VAR helped reducing referee mistakes in Turkish Super League compared to other European leagues.\n\nWe are going to use artificial intelligence to examine every game of Turkish Super League in 2020, 2019, 2018 and 2017 seasons. We will compare the values before and after VAR. We will also compare these values with those of other European Leagues using data sets of previous researches.	Artificial Intelligence\nMachine Learning\nImage and Video Processing\nBasic knowledge in Football	t	inviting collaborators	conference	2021-08-15	86	6
39	2021-01-27 11:24:39.337318+00	Creating Martial Arts Animations with AI	Using AI to create virtual realistic martial arts animations to use in film endustry.	Martial Arts, Artificial Intelligence, C++, Python	t	open for collaborators	journal	2023-01-27	84	\N
38	2021-01-27 11:22:10.958396+00	Artificial intelligence on martial arts	Research on teaching computer AI to use martial arts.	Artificial Intelligence, Martial Arts	t	open for collaborators	journal	2021-02-05	84	\N
29	2021-01-26 09:15:36.419182+00	Attention Metaphors	The concept of attention is defined by multiple inconsistent metaphors that scientists use to identify relevant phenomena, frame hypotheses, construct experiments, and interpret data. (1) The Filter metaphor shapes debates about partial vs. complete filtering, early vs. late selection, and information filtering vs. enhancement. (2) The Spotlight metaphor raises the issue of space‐ vs. object‐based selection, and it guides research on the size, shape, and movement of the attentional focus. (3) The Spotlight‐in‐the‐Brain metaphor is frequently used to interpret imaging studies of attention. (4) The debate between supramodal and pre‐motor theories of attention replays the dichotomy between the Spotlight and the Vision metaphors of attention. Our analysis reveals the central role of metaphor in scientific theory and research on attention, exposes hidden assumptions behind various research strategies, and shows the need for flexibility in the use of current metaphors.	Psychology, Cognitive Psychology	t	open for collaborators	instutution	2021-03-05	51	\N
43	2021-01-30 08:52:58.379235+00	Adversarial Attacks on Federated Learning Models	Adversarial Attacks on Federated Learning Models may cause many problems if they aren't addressed quickly. These models are usually built by averaging gradients coming from clients but this may cause a vulnerability against adversarial attacks	Federated Learning, Machine Learning, Networks	t	in progress	journal	2021-02-18	89	4
44	2021-01-30 12:36:53.554221+00	History of Hunting Technology	Hafting stone points to spears was an important advance in weaponry for early humans. Multiple lines of evidence indicate that ~500,000-year-old stone points from the archaeological site of Kathu Pan 1 (KP1), South Africa, functioned as spear tips. KP1 points exhibit fracture types diagnostic of impact. Modification near the base of some points is consistent with hafting. Experimental and metric data indicate that the points could function well as spear tips. Shape analysis demonstrates that the smaller retouched points are as symmetrical as larger retouched points, which fits expectations for spear tips. The distribution of edge damage is similar to that in an experimental sample of spear tips and is inconsistent with expectations for cutting or scraping tools. Thus, early humans were manufacturing hafted multicomponent tools ~200,000 years earlier than previously thought.	Paleolithic Archaeology	t	published	journal	2021-05-22	90	\N
45	2021-01-30 12:50:47.136839+00	Higgs Boson	Results are presented from searches for the standard model Higgs boson in proton–proton collisions at s= 7 and 8 TeV in the Compact Muon Solenoid experiment at the LHC, using data samples corresponding to integrated luminosities of up to 5.1 fb− 1 at 7 TeV and 5.3 fb− 1 at 8 TeV. The search is performed in five decay modes: γγ, ZZ, W+ W−, τ+ τ−, and b b¯. An excess of events is observed above the expected background, with a local significance of 5.0 standard deviations, at a mass near 125 GeV, signalling the production of a new particle. The expected significance for a standard model Higgs boson of that mass is 5.8 standard deviations. The excess is most significant in the two decay modes with the best mass resolution, γγ and ZZ; a fit to these signals gives a mass of 125.3±0.4 (stat.)±0.5 (syst.) GeV. The decay to two photons indicates that the new particle is a boson with spin different from one.	Particle Physics, Physics	t	open for collaborators	conference	2021-01-30	91	\N
47	2021-01-30 16:45:33.765188+00	A Certainty Equivalent Merton Problem	The Merton problem is the well-known stochastic control problem of choosing consumption over time, as well as an investment mix, to maximize expected constant relative risk aversion (CRRA) utility of consumption. Merton formulated the problem and provided an analytical solution in 1970; since then a number of extensions of the original formulation have been solved. In this note we identify a certainty equivalent problem, ie, a deterministic optimal control problem with the same optimal value function and optimal policy, for the base Merton problem, as well as a number of extensions. When time is discretized, the certainty equivalent problem becomes a second-order cone program (SOCP), readily formulated and solved using domain specific languages for convex optimization. This makes it a good starting point for model predictive control, a policy that can handle extensions that are either too cumbersome or impossible to handle exactly using standard dynamic programming methods.	Optimization, AI	t	open for collaborators	conference	2021-01-30	93	\N
46	2021-01-30 14:33:03.461805+00	Review of particle physics	The Review summarizes much of particle physics and cosmology. Using data from previous editions, plus 3,283 new measurements from 899 papers, we list, evaluate, and average measured properties of gauge bosons and the recently discovered Higgs boson, leptons, quarks, mesons, and baryons. We summarize searches for hypothetical particles such as heavy neutrinos, supersymmetric and technicolor particles, axions, dark photons, etc.	Particle physics, Physics	t	open for collaborators	conference	2021-01-30	92	\N
51	2021-01-30 22:50:00.850523+00	The use of computer-aided-instructions in computer engineering curriculum	a computer-aided-instruction (CAI) platform that provides a mechanism for incorporating lectures and laboratory components of an introductory computer engineering course into an interactive CAI environment. This CAI platform is a PC-based environment that strives to balance the tutorial time where students gain the theoretical skills in the subject matter with laboratory skills where students are provided with a controlled hands-on and one-on-one interaction with the CAI platform. This CAI tool is developed using Turbo C.	Computer Vision, ML, Turbo C	t	open for collaborators	conference	2021-05-19	96	8
49	2021-01-30 17:09:23.230606+00	Linear programming heuristics for the graph isomorphism problem	An isomorphism between two graphs is a bijection between their vertices that preserves the edges. We consider the problem of determining whether two finite undirected weighted graphs are isomorphic, and finding an isomorphism relating them if the answer is positive. In this paper we introduce effective probabilistic linear programming (LP) heuristics to solve the graph isomorphism problem. We motivate our heuristics by showing guarantees under some conditions, and present numerical experiments that show effectiveness of these heuristics in the general case.	Linear programming, graph theory	t	open for collaborators	conference	2021-01-30	93	\N
48	2021-01-30 16:50:21.509193+00	A simple effective heuristic for embedded mixed-integer quadratic programming	In this paper, we propose a fast optimisation algorithm for approximately minimising convex quadratic functions over the intersection of affine and separable constraints (i.e. the Cartesian product of possibly nonconvex real sets). This problem class contains many NP-hard problems such as mixed-integer quadratic programming. Our heuristic is based on a variation of the alternating direction method of multipliers (ADMM), an algorithm for solving convex optimisation problems. We discuss the favourable computational aspects of our algorithm, which allow it to run quickly even on very modest computational platforms such as embedded processors. We give several examples for which an approximate solution should be found very quickly, such as management of a hybrid-electric vehicle drivetrain and control of switched-mode power converters. Our numerical experiments suggest that our method is very effective in …	Integer Programming	t	open for collaborators	conference	2021-01-30	93	\N
50	2021-01-30 18:40:22.506289+00	Effect of Covid-19 on Mental Health	The pandemic has troubled our society not only physically but also mentally. In this paper, we will discuss how this constant state of emergency affects our psychology as a whole.	Psychology	t	open for collaborators	instutution	2021-05-12	51	\N
52	2021-01-30 23:10:45.285256+00	Modelling quantum aspects of disruption of a white dwarf star by a black hole	Final stages of the evolution of a binary system consisted of a black hole and a white dwarf star. We implement the quantum hydrodynamic equations and carry out numerical simulations. As a model of a white dwarf star we consider a zero temperature droplet of attractively interacting degenerate atomic bosons and spin-polarized atomic fermions. Such mixtures are investigated experimentally nowadays.	Astrophysics, Quantum	t	draft	conference	2021-04-02	98	\N
54	2021-01-31 16:15:05.620255+00	Research methods in human-computer interaction	Research Methods in Human-Computer Interaction is a comprehensive guide to performing \nresearch and is essential reading for both quantitative and qualitative methods.	Computer Science Degree	t	open for collaborators	instutution	2021-03-19	100	\N
53	2021-01-31 16:02:29.365024+00	Functional analysis in clinical psychology	A common task facing any therapist is the assessment of a clinical problem in order to determine the appropriate intervention to modify the problematic behavior, thoughts or feelings. A clinical problem might be related to an individual, group or organization. In any of these cases the clinician faces the same procedure: deciding what information to collect, delineating the problem, deciding what action to take, and evaluating change.	Psychology degree, Functional analysis	t	inviting collaborators	conference	2021-03-18	99	6
55	2021-01-31 16:25:58.581836+00	Verifying autonomous systems	Autonomous systems are now being deployed in safety, mission, or busi- ness critical \nscenarios, which means a thorough analysis of the choices the core software might make becomes \ncrucial.	Mechanical Engineering, Autonomous Systems	t	open for collaborators	journal	2021-04-14	101	\N
\.


--
-- Data for Name: api_project_members; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_project_members (id, project_id, user_id) FROM stdin;
1	1	27
2	2	26
3	3	29
4	4	31
5	5	30
6	6	34
7	4	28
8	4	35
9	7	40
10	8	40
11	9	40
12	10	40
13	11	41
14	12	41
15	13	42
16	14	33
17	15	45
20	17	27
21	18	27
22	10	45
23	9	45
28	4	29
29	3	45
30	7	27
31	22	71
32	4	26
33	23	26
34	24	73
35	25	74
36	26	75
37	27	73
38	3	31
39	28	61
40	28	77
41	15	36
42	4	36
43	26	79
44	29	51
46	31	80
47	32	82
48	26	71
49	33	71
51	34	83
52	35	83
53	36	83
54	37	84
55	38	84
56	39	84
57	40	29
58	40	85
59	41	85
60	42	86
61	43	89
62	35	80
63	9	80
64	44	90
65	45	91
66	46	92
67	47	93
68	48	93
69	48	94
70	49	93
71	49	94
72	49	95
73	47	94
74	47	95
75	48	95
76	50	51
77	29	80
78	51	96
79	52	98
80	53	99
81	54	100
82	55	101
83	56	102
84	57	27
\.


--
-- Data for Name: api_project_tags; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_project_tags (id, project_id, tag_id) FROM stdin;
4	2	15
6	2	17
7	4	21
8	4	22
9	4	23
10	5	24
11	2	12
12	2	13
13	2	16
14	6	25
15	6	26
16	6	27
17	6	28
18	1	9
19	11	13
20	11	27
21	11	29
22	12	27
23	12	29
24	12	13
26	13	36
27	13	37
28	10	35
30	10	38
31	7	30
32	7	31
33	7	32
44	1	39
46	18	19
48	9	31
45	18	9
47	9	19
55	22	40
56	22	41
57	22	42
58	1	43
59	1	44
60	1	45
61	18	46
62	18	43
63	17	47
64	17	48
65	17	49
67	23	50
68	23	30
69	23	38
70	23	51
71	25	52
72	25	53
73	25	54
74	24	55
75	24	56
76	24	57
77	24	39
78	24	58
79	26	59
80	26	60
81	27	39
82	27	56
83	27	58
84	27	60
85	27	55
87	28	61
88	28	38
89	29	62
90	29	33
91	31	63
92	31	33
93	32	63
94	32	33
97	34	64
98	34	65
99	34	66
100	35	64
101	35	67
102	36	67
103	36	64
104	39	68
105	39	66
106	39	65
107	39	69
108	38	65
109	38	69
110	37	32
111	37	69
112	37	68
113	40	72
114	40	73
115	40	71
116	41	40
117	41	74
118	41	75
119	42	65
120	42	73
121	42	76
122	42	51
123	42	30
124	43	30
125	43	77
126	43	64
127	44	78
128	44	79
129	45	29
130	45	80
131	46	80
132	46	29
133	47	65
134	47	81
135	48	82
136	48	81
137	49	83
138	49	84
139	50	33
140	51	27
141	51	85
142	51	86
143	51	68
144	52	87
145	52	88
146	53	33
147	53	89
148	56	90
149	56	91
150	56	92
151	57	9
152	57	93
\.


--
-- Data for Name: api_publication; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_publication (id, title, publication_year, citation_number, owner_id, link) FROM stdin;
2614	Discovery of an X-ray afterglow associated with the γ-ray burst of 28 February 1997	1997	1492	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3Au5HHmVD_uO8C
2615	Compound semiconductor radiation detectors	2004	557	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3A9yKSN-GCB0IC
2616	The X-ray afterglow of the gamma-ray burst of 1997 May 8: spectral variability and possible evidence of an iron line	1999	236	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3A7H_MAutzIkAC
2617	Evidence for a late-time outburst of the X-ray afterglow of GB970508 from BeppoSAX	1997	227	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3Au-x6o8ySG0sC
2618	BEPPOSAX observations of GRB 980425: Detection of the prompt event and monitoring of the error box	2000	185	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3A2osOgNQ5qMEC
2619	The X-ray energy response of silicon Part A. Theory	1994	169	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AqjMakFHDy7sC
2620	VLT spectroscopy of GRB 990510 and GRB 990712: Probing the faint and bright ends of the gamma-ray burst host galaxy population	2001	163	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3A1taIhTC69MYC
2621	GRB 970228	1997	149	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AQUX0mv85b1cC
2622	X-ray and gamma-ray response of a 2 ″× 2 ″LaBr3: Ce scintillation detector	2007	136	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AeQOLeE2rZwMC
726	Recombinant vaccines and use thereof	2012	29	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALkGwnXOMwfcC
727	System and method for dynamically tuning interrupt coalescing parameters	2005	29	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AM7yex6snE4oC
728	The human X chromosome is enriched for germline genes expressed in premeiotic germ cells of both sexes	2006	28	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWp0gIr-vW9MC
729	Functional TCR retrieval from single antigen-specific human T cells reveals multiple novel epitopes	2014	27	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AkuK5TVdYjLIC
730	Porous carpeting for vehicles and methods of producing same	2004	27	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A2VqYfGB8ITEC
731	Uptake of synthetic naked RNA by skin-resident dendritic cells via macropinocytosis allows antigen expression and induction of T-cell responses in mice	2016	26	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Awbdj-CoPYUoC
732	Monoclonal antibodies for treatment of cancer	2015	25	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AILKRHgRFtOwC
733	Hodgkin and Reed-Sternberg cell–associated autoantigen CLIP-170/restin is a marker for dendritic cells and is involved in the trafficking of macropinosomes to the cytoskeleton …	2002	25	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AsSrBHYA8nusC
734	Characterization of the first-in-class T-cell-engaging bispecific single-chain antibody for targeted immunotherapy of solid tumors expressing the oncofetal protein claudin 6	2016	24	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A0EnyYjriUFMC
2623	Scintillation and detection characteristics of high-sensitivity CeBr3 gamma-ray spectrometers	2013	135	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3A9pM33mqn1YgC
640	Exploiting the mutanome for tumor vaccination	2012	634	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ATyk-4Ss8FVUC
2624	The diffusion-controlled relaxation model for ionic transport in glasses	1989	126	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AIjCSPb-OGe4C
2625	Compound semiconductor radiation detectors	2016	118	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AraTqNPD5sRQC
2626	Scintillation Properties of Praseodymium Activated  Single Crystals	2008	117	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3A_FxGoFyzp5QC
2627	The X-ray, optical, and infrared counterpart to GRB 980703	1999	112	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AUeHWp8X0CEIC
735	CXorf61 is a target for T cell based immunotherapy of triple-negative breast cancer	2015	24	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AqUcmZB5y_30C
736	Selective activation of tumor growth-promoting Ca 2+ channel MS4A12 in colon cancer by caudal type homeobox transcription factor CDX2	2009	24	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Au-x6o8ySG0sC
737	An RNA vaccine drives immunity in checkpoint-inhibitor-treated melanoma	2020	22	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHhcuHIWmDEUC
738	Improvement of In Vivo Expression of Genes Delivered by Self-Amplifying RNA Using Vaccinia Virus Immune Evasion Proteins	2017	22	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AJoZmwDi-zQgC
739	Mutanome engineered RNA immunotherapy: towards patient-centered tumor vaccination	2015	22	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASdhP9T11ey4C
740	Monoclonal antibodies against claudin-18 for treatment of cancer	2019	21	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AhkOj_22Ku90C
741	NCOA3 is a selective co-activator of estrogen receptor α-mediated transactivation of PLAC1 in MCF-7 breast cancer cells	2013	21	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AW7OEmFMy1HYC
742	Autoimmunity seen through the SEREX-scope	2003	21	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmvPsJ3kp5DgC
743	Methods and compositions for diagnosis and treatment of cancer	2017	20	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ab0M2c_1WBrUC
744	Final results of the FAST study, an international, multicenter, randomized, phase II trial of epirubicin, oxaliplatin, and capecitabine (EOX) with or without the anti-CLDN18. 2 …	2016	20	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVL0QpB8kHFEC
745	Isolated nucleic acid molecule encoding cancer associated antigen, the antigen itself, and uses thereof	2001	20	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtYavs44e6CUC
746	Methods for determining breast cancer and melanoma by assaying for a plurality of antigens associated therewith	2000	20	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AvbGhcppDl1QC
747	Harnessing tumor mutations for truly individualized cancer vaccines	2019	19	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ak8Z6L05lTy4C
748	Monoclonal antibodies against claudin-18 for treatment of cancer	2016	19	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AnrtMV_XWKgEC
749	Monoclonal antibodies against claudin-18 for treatment of cancer	2015	18	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A0N-VGjzr574C
750	Genetic products differentially expressed in tumors and the use thereof	2013	18	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AwKETBy42zhYC
751	Monoclonal antibodies against claudin-18 for treatment of cancer	2013	18	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A7wO8s98CvbsC
752	rapmad: Robust analysis of peptide microarray data	2011	18	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ans9cj8rnVeAC
753	A key regulatory role of the transcription factor NFATc2 in bronchial adenocarcinoma via CD8+ T lymphocytes	2009	18	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Af2IySw72cVMC
754	CrELISA: a fast and robust enzyme-linked immunosorbent assay bypassing the need for purification of recombinant protein	2004	18	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aj8SEvjWlNXcC
755	Methods for determining breast cancer and melanoma by assaying for a plurality of antigens associated therewith	2002	18	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4fKUyHm3Qg0C
2628	Characterization of large volume 3.5 ″× 8 ″LaBr3: Ce detectors	2013	108	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3Az_wVstp3MssC
2629	Semiconductor materials and radiation detection	2006	107	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3ALkGwnXOMwfcC
2630	Spectral properties of the prompt X-ray emission and afterglow from the gamma-ray burst of 1997 February 28	1998	81	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AzYLM7Y9cAGgC
756	A multicentre, phase IIa study of zolbetuximab as a single agent in patients with recurrent or refractory advanced adenocarcinoma of the stomach or lower oesophagus: the MONO study	2019	17	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmNrWkgRL2YcC
757	A phase I dose-escalation study of IMAB362 (Zolbetuximab) in patients with advanced gastric and gastro-oesophageal junction cancer	2018	17	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AufrVoPGSRksC
758	Genetic products differentially expressed in tumors and the use thereof	2015	17	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AbEWYMUwI8FkC
759	Genetic products differentially expressed in tumors and the use thereof	2014	17	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AYOwf2qJgpHMC
760	Antitumor vaccination with synthetic mRNA: strategies for in vitro and in vivo preclinical studies	2013	17	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ANaGl4SEjCO4C
761	Genetic products differentially expressed in tumors and the use of thereof	2012	17	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AxtRiw3GOFMkC
762	Antigen-specific T cell receptors and T cell epitopes	2017	16	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aj7_hQOaDUrUC
763	Safety, tolerability, and efficacy of the first-in-class antibody IMAB362 targeting claudin 18.2 in patients with metastatic gastroesophageal adenocarcinomas.	2013	15	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AyMeIxYmEMEAC
764	Rapid molecular dissection of viral and bacterial immunomes	2006	14	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AldfaerwXgEUC
765	Method for diagnosis and treating cancers, and methods for identifying pathogenic markers in a sample of normal cells	1999	14	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A48xauSegjOkC
766	Antibodies specific for claudin 6 (CLDN6)	2016	13	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AwMgC3FpKEyYC
767	A trans-amplifying RNA Vaccine strategy for induction of potent protective immunity	2020	12	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ADUooU5lO8OsC
768	A prefusion SARS-CoV-2 spike RNA vaccine is highly immunogenic and prevents lung infection in non-human primates	2020	12	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aoi2SiIJ9l4AC
769	The European regulatory environment of RNA-based vaccines	2017	12	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmB3voiENLucC
770	Humoral immune responses of lung cancer patients against the Transmembrane Phosphatase with TEnsin homology (TPTE)	2015	12	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AbFI3QPDXJZMC
771	Efficacy and safety of multiple doses of IMAB362 in patients with advanced gastro-esophageal cancer: results of a phase II study	2014	12	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3APELIpwtuRlgC
772	Identification of tumour-associated cell surface antigens for diagnosis and therapy	2011	12	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ATFP_iSt0sucC
773	Ki-ras oncogene and p53 tumour suppressor gene mutations in colorectal carcinomas from the European Saar-Luxembourg region are less frequent than predicted by the classic …	1997	12	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZfRJV9d4-WMC
774	Comparison of Claudin 18.2 expression in primary tumors and lymph node metastases in Japanese patients with gastric adenocarcinoma	2019	11	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aanf4URPfarAC
775	Monoclonal antibodies against claudin-18 for treatment of cancer	2017	11	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AfPk4N6BV_jEC
776	Identification of surface-associated antigens for tumor diagnosis and therapy	2015	11	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AK3LRdlH-MEoC
777	Antibodies against Claudin 18.2 useful in cancer diagnosis	2016	10	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3APR6Y55bgFSsC
778	Antibodies for treatment of cancer	2016	10	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AowLR8QvbtFgC
641	Serological identification of human tumor antigens	1997	435	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A3s1wT3WcHBgC
779	First-in-human phase I/II dose-escalation study of IMAB027 in patients with recurrent advanced ovarian cancer (OVAR): Preliminary data of phase I part.	2015	10	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ar_AWSJRzSzQC
780	T-cell receptor transfer into human T cells with ecotropic retroviral vectors	2014	10	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aolpn-zPbct0C
781	HPV16 RNA-LPX vaccine mediates complete regression of aggressively growing HPV-positive mouse tumors and establishes protective T cell memory	2019	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AumqufdRvDiIC
782	Challenges towards the realization of individualized cancer vaccines	2018	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ap2g8aNsByqUC
783	Antibody to genetic products differentially expressed in tumors and the use thereof	2017	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A6yz0xqPARnAC
784	Cancer therapy using CLDN6 target-directed antibodies in vivo	2017	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZzlSgRqYykMC
785	Methods and compositions for diagnosis and treatment of cancer	2017	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A8AbLer7MMksC
786	Genetic Products Differentially Expressed In Tumors And The Use Thereof	2015	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AnRpfm8aw39MC
787	Combination therapy involving antibodies against claudin 18.2 for treatment of cancer	2015	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A5Ul4iDaHHb8C
788	Isolated peptides which bind to MHC class II molecules, and uses thereof	2004	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4xDN1ZYqzskC
789	Driving module of laser diode	2003	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A-FonjvnnhkoC
790	Method and apparatus of interface conversion for handheld device	2003	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aubry08Y2EpUC
791	Methods for determining presence of cancer in a sample by determining expression of an SSX gene	2001	9	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A35r97b3x0nAC
792	Combination therapy involving antibodies against claudin 18.2 for treatment of pancreatic adenocarcinoma	2017	8	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AzCSUwVk65WsC
793	Claudin 18.2–a novel treatment target in the multicenter, randomized, phase ii fast study, a trial of epirubicin, oxaliplatin, and capecitabine (EOX) with or without the anti …	2016	8	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Au5HHmVD_uO8C
794	Genetic Products Differentially Expressed In Tumors And The Use Thereof	2014	8	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABzfGm06jWhQC
795	Antigen identification using SEREX	2013	8	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AipzZ9siozwsC
796	Identification of surface-associated antigens for tumor diagnosis and therapy	2010	8	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ar0BpntZqJG4C
797	Genetic products differentially expressed in tumors and use thereof	2008	8	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A0CzhzZyukY4C
798	Diagnosis and therapy of cancer involving cancer stem cells	2020	7	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AEhil0879vHcC
799	Discovery and subtyping of neo-epitope specific T-cell responses for cancer immunotherapy: addressing the mutanome	2017	7	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHDshCWvjkbEC
800	Use of FLT3 ligand for enhancing immune responses in RNA immunization	2016	7	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ARGFaLdJalmkC
801	Combination therapy involving antibodies against claudin 18.2 for treatment of cancer	2016	7	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVOx2b1Wkg3QC
802	Monoclonal antibodies for treatment of cancer	2015	7	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Afbc8zXXH2BUC
1949	Antibodies for treatment of cancer	2016	10	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AowLR8QvbtFgC
803	IMAB362 plus zoledronic acid (ZA) and interleukin-2 (IL-2) in patients (pts) with advanced gastroesophageal cancer (GEC): Clinical activity and safety data from the PILOT phase …	2015	7	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AOR75R8vi5nAC
804	Monoclonal antibodies for treatment of cancer	2013	7	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABr1UauaknNIC
805	Personalized neo-epitope vaccines for cancer treatment	2020	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AsNmaIFBj_lkC
806	Intravenous delivery of the toll-like receptor 7 agonist SC1 confers tumor control by inducing a CD8+ T cell response	2019	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALO7wyVUgiFcC
807	Antibodies specific for claudin 6 (CLDN6)	2018	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4JMBOYKVnBMC
808	Cancer therapy using CLDN6 target-directed antibodies in vivo	2018	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1lhNe0rCu4AC
809	A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles encoding shared tumor antigens for potent melanoma immunotherapy	2017	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aa0OBvERweLwC
810	Abstract CT032: A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles for potent cancer immunotherapy in patients with malignant melanoma	2016	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AQYdC8u9Cj1oC
811	Abstract CT032: A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles for potent cancer immunotherapy in patients with malignant melanoma	2016	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmlAyqtXpCwEC
812	FLT3 ligand as a molecular adjuvant for naked RNA vaccines	2016	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AiH-uZ7U-co4C
813	Recognition of human tumors: SEREX expression cloning to identify tumour antigens	2001	6	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ANhqRSupF_l8C
814	A non-functional neoepitope specific CD8+ T-cell response induced by tumor derived antigen exposure in vivo	2019	5	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVaXvl8Fpj5cC
815	Enhanced stability of a chimeric hepatitis B core antigen virus-like-particle (HBcAg-VLP) by a C-terminal linker-hexahistidine-peptide	2018	5	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AcFHS6HbyZ2cC
816	Identification of tumor-associated markers for diagnosing or monitoring ovarian cancer	2015	5	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A3fE2CSJIrl8C
817	Peptide microarrays enable rapid mimotope optimization for pharmacokinetic analysis of the novel therapeutic antibody IMAB362	2014	5	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aeq2jaN3J8jMC
818	Method for identifying biologically active structures of microbial pathogens	2004	5	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ATIZ-Mc8IlK0C
819	Method for generating pure populations of mobile mebrane-associated biomolecules on supported lipid bilayers	2004	5	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A6ZxmRoH8BuwC
1374	Automated neuroanatomical relation extraction: a linguistically motivated approach with a PVT connectivity graph case study	2016	3	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ABqipwSGYUEgC
1375	Extension of the Interaction Network Ontology for literature mining of gene-gene interaction networks from sentences with multiple interaction keywords	2015	3	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AHDshCWvjkbEC
1376	Analyzing stemming approaches for turkish multi-document summarization	2014	3	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AmaZDTaKrznsC
1377	Türkçe Soru Cevaplama Sistemlerinde Kural Tabanlı Odak Çıkarımı Rule-Based Focus Extraction in Turkish Question Answering Systems	2014	3	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AmB3voiENLucC
1378	N-gram Parsing for Jointly Training a Discriminative Constituency Parser	2013	3	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AKlAtU1dfN6UC
1379	System and method for generating queries	2012	3	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AblknAaTinKkC
2631	BeppoSAX detection and follow-up of GRB 980425	1999	80	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3ATyk-4Ss8FVUC
2632	CeBr Scintillator Development for Possible Use in Space Missions	2008	74	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AHDshCWvjkbEC
2633	Evidence for dust-related X-ray emission from comet C/1995 O1 (Hale-Bopp)	1998	70	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AY0pCki6q_DkC
2634	High energy gamma-ray spectroscopy with LaBr3 scintillation detectors	2011	69	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AWp0gIr-vW9MC
2635	Hard X-ray spectroscopy using a small-format TlBr array	2003	63	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AWF5omc3nYNoC
2636	BeppoSAX follow-up search for the X-ray afterglow of GRB970111	1998	56	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AYsMSGLbcyi4C
2637	The X-ray response of CdZnTe	2002	53	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3AMXK_kJrjxJIC
2638	The X-ray energy response of silicon (B): Measurements	1996	53	92	https://scholar.google.com/citations?user=kM1-tHYAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DkM1-tHYAAAAJ%26citation_for_view%3DkM1-tHYAAAAJ%3A5nxA0vEk-isC
2639	The cognitive control of emotion	2005	4763	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AUeHWp8X0CEIC
2640	Rethinking feelings: an FMRI study of the cognitive regulation of emotion	2002	2996	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AqjMakFHDy7sC
2641	For better or for worse: neural systems supporting the cognitive down-and up-regulation of negative emotion	2004	2324	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AIjCSPb-OGe4C
2642	The experience of emotion	2007	1458	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AWF5omc3nYNoC
2643	Social effects of oxytocin in humans: context and person matter	2011	1431	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3Ak_IJM867U9cC
2644	Prefrontal-subcortical pathways mediating successful emotion regulation	2008	1392	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AroLk4NBRz8UC
2645	Functional imaging studies of emotion regulation: a synthetic review and evolving model of the cognitive control of emotion	2012	1335	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3A8AbLer7MMksC
2646	Neural systems underlying the suppression of unwanted memories	2004	1249	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3ATyk-4Ss8FVUC
2647	Cognitive reappraisal of emotion: a meta-analysis of human neuroimaging studies	2014	1226	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AdQ2og3OwTAUC
2648	Cognitive emotion regulation: Insights from social cognitive and affective neuroscience	2008	1136	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3ALkGwnXOMwfcC
2649	Reflecting upon feelings: an fMRI study of neural systems supporting the attribution of emotion to self and other	2004	963	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AY0pCki6q_DkC
2650	Implicit memory: A selective review	1993	905	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AzYLM7Y9cAGgC
2651	The neuroscience of empathy: progress, pitfalls and promise	2012	846	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3Anb7KW1ujOQ8C
2652	The emergence of social cognitive neuroscience.	2001	834	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AYsMSGLbcyi4C
2653	Are affective events richly recollected or simply familiar? The experience and process of recognizing feelings past.	2000	825	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AeQOLeE2rZwMC
2654	Gender differences in emotion regulation: An fMRI study of cognitive reappraisal	2008	770	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AULOm3_A8WrAC
2655	Amygdala responses to emotionally valenced stimuli in older and younger adults	2004	688	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AufrVoPGSRksC
2656	The neural correlates of direct and reflected self-knowledge	2005	669	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3A_FxGoFyzp5QC
2657	Prefrontal regions involved in keeping information in and out of mind	2001	644	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AW7OEmFMy1HYC
2658	A meta-analysis of functional neuroimaging studies of self-and other judgments reveals a spatial gradient for mentalizing in medial prefrontal cortex	2012	631	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3ASP6oXDckpogC
2659	Prefrontal–striatal pathway underlies cognitive regulation of craving	2010	597	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3Aj3f4tGmQtD8C
2660	The neural bases of distraction and reappraisal	2010	583	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AqxL8FJ1GzNcC
2661	The development of emotion regulation: an fMRI study of cognitive reappraisal in children, adolescents and young adults	2012	564	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3ASeFeTyx0c_EC
2662	Born to choose: The origins and value of the need for control	2010	476	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AJV2RwH3_ST0C
2663	The neural architecture of emotion regulation	2007	474	51	https://scholar.google.com/citations?user=-GHfzbUAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D-GHfzbUAAAAJ%26citation_for_view%3D-GHfzbUAAAAJ%3AMXK_kJrjxJIC
1380	Analyzing ELMo and DistilBERT on Socio-political News Classification	2020	2	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Am44aUaJR3ikC
1381	BOUN-ISIK participation: an unsupervised approach for the named entity normalization and relation extraction of bacteria biotopes	2019	2	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Afc7zyzPI2QAC
1382	Improving the annotations in the Turkish universal dependency treebank	2019	2	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Ave7iT2ZEuL4C
1383	A closed-domain question answering framework using reliable resources to assist students	2018	2	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A0iM-huCvmk0C
1384	Text classification using ontology and semantic values of terms for mining protein interactions and mutations	2017	2	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqwOXE0mbtu4C
1385	Retrieving Passages Describing Experimental Methods using Ontology and Term Relevance based Query Matching	2015	2	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ATQgYirikUcIC
1386	PREDICTING GENE INTERACTIONS OF TYROSINE KINASE INHIBITORS INDUCED CARDIOTOXICITY WITH THE ONTOLOGY OF ADVERSE EVENTS-ASSISTED BIOINFORMATICS APPROACH.: PII-021	2014	2	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ARHpTSmoSYBkC
1387	Unsupervised Machine Learning Techniques For Text Document Clustering	2004	2	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AxEMdJR0kL_sC
1388	Vapur: A Search Engine to Find Related Protein-Compound Pairs in COVID-19 Literature	2020	1	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AC-SEpTPhZ1wC
1389	Identifying Image Related Sentences in News Articles	2019	1	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Agxb_f1p9zx4C
1390	Description of the BOUN System for the Trilingual Entity Detection and Linking Tasks at TAC KBP 2017.	2017	1	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqQc65DSaYXMC
1391	Expanding Machine Translation Training Data with an Out-of-Domain Corpus using Language Modeling based Vocabulary Saturation	2014	1	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A4DMP91E08xMC
1392	Mikroblog İleti Kümelerinde Konu Algılama Yönteminin İncelenmesi	2013	1	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Al7iSsH4_Im4C
1393	The RELX Dataset and Matching the Multilingual Blanks for Cross-Lingual Relation Classification	2020	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AQ17yWvk9gpwC
1394	A Hybrid Approach to Dependency Parsing: Combining Rules and Morphology with Deep Learning	2020	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AHevVnK7dagcC
1395	Resources for Turkish Dependency Parsing: Introducing the BOUN Treebank and the BoAT Annotation Tool	2020	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Aw_ORaKkuc5QC
1396	BOUN-REX at CLEF-2020 ChEMU Task 2: Evaluating Pretrained Transformers for Event Extraction	2020	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ANObE97JSLecC
1397	An extended overview of the CLEF 2020 ChEMU Lab	2020	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AQZWLLlSfqgYC
1398	Cluster-based mention typing for named entity disambiguation	2020	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A4pF9x-cDGsoC
1399	Statistical representation models for mutation information within genomic data	2019	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A1pC5hbHeJ6IC
1400	Ignet: A centrality and INO-based web system for analyzing and visualizing literature-mined networks	2016	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ARGFaLdJalmkC
1401	A systems pharmacology approach to model tyrosine kinase inhibitor‐induced cardiotoxicity gene interaction networks (844.17)	2014	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Ae5wmG9Sq2KIC
1402	Self-training a Constituency Parser using N-gram Trees	2014	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AYOwf2qJgpHMC
1403	PHISTO: A New Web Platform for Pathogen-Human Interactions	2013	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AkNdYIx-mwKoC
1404	Identification of fever and vaccine-associated gene interaction networks using ontology-based literature mining	2012	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A6LV2YwJzdtgC
1405	Text and Network Mining for Literature-Based Scientific Discovery in Biomedicine.	2010	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AWF5omc3nYNoC
1406	Identifying Common Pathogenesis of Diseases Using Literature Mined Gene Interactions	2010	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A3wLP7v6BnpwC
1407	Team: CONDL	2010	0	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AwTekDMGr9GkC
642	Characterization of human colon cancer antigens recognized by autologous antibodies	1998	434	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A_FxGoFyzp5QC
643	Human carbonic anhydrase XII: cDNA cloning, expression, and chromosomal localization of a carbonic anhydrase gene that is overexpressed in some renal cell cancers	1998	381	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AeMMeJKvmdy0C
644	Modification of antigen-encoding RNA increases stability, translational efficacy, and T-cell stimulatory capacity of dendritic cells	2006	370	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AUeHWp8X0CEIC
2143	WideDTA: prediction of drug-target binding affinity	2019	10	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AuQdrZ3qaPmcC
2144	Sentence similarity based on dependency tree kernels for multi-document summarization	2016	10	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Amu2_AnMl8iYC
2145	Question analysis for a closed domain question answering system	2015	10	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqUcmZB5y_30C
2146	Busem at semeval-2017 task 4a sentiment analysis with word embedding and long short term memory rnn approaches	2017	9	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AKYgttONoxcsC
2147	Ontology-based categorization of bacteria and habitat entities using information retrieval techniques	2016	9	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AM3NEmzRMIkIC
2148	Automatic query generation using word embeddings for retrieving passages describing experimental methods	2017	8	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AJ_g5lzvAfSwC
2149	Detection and categorization of bacteria habitats using shallow linguistic analysis	2015	8	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AhFOr9nPyWt4C
2150	Segmenting hashtags and analyzing their grammatical structure	2018	7	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3An8FNryW2AHIC
2151	CNN-based chemical–protein interactions classification	2017	7	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AGs1AF5H0x94C
2152	The Interaction Network Ontology-supported modeling and mining of complex interactions represented with multiple keywords in biomedical literature	2016	7	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ANaGl4SEjCO4C
2153	Segmenting Hashtags using Automatically Created Training Data	2016	7	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AhMod-77fHWUC
2154	Named entity recognition on twitter for turkish using semi-supervised learning with word embeddings	2018	6	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AMtS25d97-7AC
2155	Political opinion/sentiment prediction via long short term memory recurrent neural networks on Twitter	2017	6	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AuGrg30pLAbkC
2156	Efficient indexing technique for XML-based electronic product catalogs	2006	6	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AeQOLeE2rZwMC
2157	Ontology-based literature mining and class effect analysis of adverse drug reactions associated with neuropathy-inducing drugs	2018	5	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ApeNFRSk4lDYC
2158	Towards building a political protest database to explain changes in the welfare state	2016	5	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AGnPB-g6toBAC
2159	ChemBoost: A Chemical Language Based Approach for Protein–Ligand Binding Affinity Prediction	2020	4	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AeJjLl3UG7CkC
2160	Turkish treebanking: Unifying and constructing efforts	2019	4	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A2TuIPqOg0e0C
2161	A morphology-based representation model for lstm-based dependency parsing of agglutinative languages	2018	4	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A5UUbrqTvKfUC
2162	Extracting Adverse Drug Reactions using Deep Learning and Dictionary Based Approaches.	2017	4	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AtBp-nognM3UC
2163	Literature Mining and Ontology based Analysis of Host-Brucella Gene–Gene Interaction Network	2015	4	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AR3hNpaxXUhUC
633	A testicular antigen aberrantly expressed in human cancers detected by autologous antibody screening	1997	1441	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A8k81kl-MbHgC
634	Human neoplasms elicit multiple specific immune responses in the autologous host	1995	1391	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZ5m8FVwuT1cC
635	Personalized RNA mutanome vaccines mobilize poly-specific therapeutic immunity against cancer	2017	993	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aye4kPcJQO24C
636	Generation of tissue-specific and promiscuous HLA ligand databases using DNA microarrays and virtual HLA class II matrices	1999	804	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AbKqednn6t2AC
637	Mutant MHC class II epitopes drive therapeutic immune responses to cancer	2015	701	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A35N4QoGY0k4C
638	mRNA-based therapeutics—developing a new class of drugs	2014	699	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ARYcK_YlVTxYC
639	Systemic RNA delivery to dendritic cells exploits antiviral defence for cancer immunotherapy	2016	667	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AfEOibwPWpKIC
645	Identification of a meiosis-specific protein as a member of the class of cancer/testis antigens	1998	320	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AuLbwQdceFCQC
646	The SSX-2 gene, which is involved in the t (X; 18) translocation of synovial sarcomas, codes for the human tumor antigen HOM-MEL-40	1996	299	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1sJd4Hv_s6UC
647	SSX: A multigene family with several members transcribed in normal testis and human cancer	1997	294	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AkRWSkSYxWN8C
648	Personalized vaccines for cancer immunotherapy	2018	278	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aj3f4tGmQtD8C
649	Intranodal vaccination with naked antigen-encoding RNA elicits potent prophylactic and therapeutic antitumoral immunity	2010	277	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZHo1McVdvXMC
650	Autoantibodies in lung cancer: possibilities for early detection and subsequent cure	2008	261	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtOudhMTPpwUC
651	Molecular definition of a novel human galectin which is immunogenic in patients with Hodgkin's disease	1997	245	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AD03iK_w7-QYC
652	Expression of SSX genes in human tumors	1998	226	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ArO6llkc54NcC
653	Tumor vaccination using messenger RNA: prospects of a future therapy	2011	195	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AyB1At4FlUx8C
654	Immunomic, genomic and transcriptomic characterization of CT26 colorectal carcinoma	2014	184	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AJV2RwH3_ST0C
655	Electronic mail transmission/reception system and electronic mail transmission/reception program	2006	184	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALPtt_HFRSbwC
656	Safety and efficacy of the BNT162b2 mRNA Covid-19 vaccine	2020	171	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABrOSOlqYqPUC
657	Expression of multiple cancer/testis (CT) antigens in breast cancer and melanoma: basis for polyvalent CT vaccine strategies	1998	171	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtzM49s52ZIMC
658	HLA typing from RNA-Seq sequence reads	2013	167	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AeQOLeE2rZwMC
659	Phase I/II study of COVID-19 RNA vaccine BNT162b1 in adults	2020	160	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A-nhnvRiOwuoC
660	Phosphorothioate cap analogs increase stability and translational efficiency of RNA vaccines in immature dendritic cells and induce superior immune responses in vivo	2010	155	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AblknAaTinKkC
661	Expression of cancer testis genes in human brain tumors	2000	155	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A_Qo2XoVZTnwC
662	Expression of a novel transmembrane carbonic anhydrase isozyme XII in normal human gut and colorectal tumors	2000	155	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtkaPQYYpVKoC
663	Multiple splice variants of lactate dehydrogenase C selectively expressed in human cancer	2002	136	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A9Nmd_mFXekcC
664	Characterization of DP103, a novel DEAD box protein that binds to the Epstein-Barr virus nuclear proteins EBNA2 and EBNA3C	1999	136	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ApqnbT2bcN3wC
665	mRNA as a versatile tool for exogenous protein expression	2012	124	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4MWp96NkSFoC
666	Claudin-18 splice variant 2 is a pan-cancer target suitable for therapeutic antibody development	2008	124	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AIWHjjKOFINEC
667	Selective uptake of naked vaccine RNA by dendritic cells is driven by macropinocytosis and abrogated upon DC maturation	2011	116	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AqxL8FJ1GzNcC
668	Expression of the membrane-associated carbonic anhydrase isozyme XII in the human kidney and renal tumors	2000	115	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AKlAtU1dfN6UC
669	The Human Vaccines Project: A roadmap for cancer vaccine development	2016	107	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AKxtntwgDAa4C
670	Basket catheter with improved expansion mechanism	2004	102	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ae_rmSamDkqQC
671	Increased antigen presentation efficiency by coupling antigens to MHC class I trafficking signals	2008	100	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWF5omc3nYNoC
672	Cascades of transcriptional induction during dendritic cell maturation revealed by genome‐wide expression analysis	2003	99	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ap__nRnzSRKYC
673	Safety and immunogenicity of two RNA-based Covid-19 vaccine candidates	2020	97	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AYsrPvlHIBpEC
674	A placenta-specific gene ectopically activated in many human cancers is essentially involved in malignant cell processes	2007	97	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AFu2w8maKXqMC
675	Identification of carbonic anhydrase XII as the membrane isozyme expressed in the normal human endometrial epithelium	2000	91	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWA5NYHcadZ8C
676	Humoral immune responses of lung cancer patients against tumor antigen NY-ESO-1	2006	88	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AUebtZRa9Y70C
677	Targeting the heterogeneity of cancer with individualized neoepitope vaccines	2016	87	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZuybSZzF8UAC
678	Tumor fibroblast–derived epiregulin promotes growth of colitis-associated neoplasms through ERK	2013	82	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AqjMakFHDy7sC
679	Definition of tumor-associated antigens in hepatocellular carcinoma	2000	80	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABwyfMAYsbu0C
680	Sealed sample storage element system and method	2010	79	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1yWc8FF-_SYC
681	ERBB2-mediated transcriptional up-regulation of the α5β1 integrin fibronectin receptor promotes tumor cell survival under adverse conditions	2006	78	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASeFeTyx0c_EC
682	Modification of RNA, producing an increased transcript stability and translation efficiency	2016	77	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVLnqNzywnoUC
683	Elimination of large tumors in mice by mRNA-encoded bispecific antibodies	2017	76	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A7T2F9Uy0os0C
684	Genetic products differentially expressed in tumors and the use thereof	2009	76	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AML0RJ9NH7IQC
685	Monoclonal antibodies against claudin-18 for treatment of cancer	2012	74	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AKUbvn5osdkgC
686	Lithography laser with beam delivery and beam pointing control	2004	74	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A3NQIlFlcGxIC
687	Tumor-associated CpG demethylation augments hypoxia-induced effects by positive autoregulation of HIF-1α	2011	72	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHE397vMXCloC
688	Exploitation of the antibody repertoire of cancer patients for the identification of human tumor antigens	1999	69	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AJQOojiI6XY0C
689	COVID-19 vaccine BNT162b1 elicits human antibody and TH 1 T cell responses	2020	68	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AziOE8S1-AIUC
690	Expression of multiple epigenetically regulated cancer/germline genes in nonsmall cell lung cancer	2006	67	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AOU6Ihb5iCvQC
691	FLT3 ligand enhances the cancer therapeutic potency of naked RNA vaccines	2011	66	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AhMsQuOkrut0C
692	A role for T-bet-mediated tumour immune surveillance in anti-IL-17A treatment of lung cancer	2011	64	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AGnPB-g6toBAC
693	Frequent nonrandom activation of germ-line genes in human cancer	2004	61	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A5ugPr518TE4C
694	Recombinant vaccines and use thereof	2014	60	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AgKiMpY-AVTkC
695	A novel tumour associated leucine zipper protein targeting to sites of gene transcription and splicing	2002	56	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AFAceZFleit8C
696	Highly specific auto-antibodies against claudin-18 isoform 2 induced by a chimeric HBcAg virus-like particle vaccine kill tumor cells and inhibit the growth of lung metastases	2011	55	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A2osOgNQ5qMEC
697	Aberrantly activated claudin 6 and 18.2 as potential therapy targets in non‐small‐cell lung cancer	2014	53	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABUYA1_V_uYcC
698	Targeting the tumor mutanome for personalized vaccination therapy	2012	52	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AzA6iFVUQeVQC
699	MS4A12 is a colon-selective store-operated calcium channel promoting malignant cell processes	2008	49	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AJ_g5lzvAfSwC
700	FAST: An international, multicenter, randomized, phase II trial of epirubicin, oxaliplatin, and capecitabine (EOX) with or without IMAB362, a first-in-class anti-CLDN18. 2 …	2016	45	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AEYYDruWGBe4C
701	Efficient reprogramming of human fibroblasts and blood-derived endothelial progenitor cells using nonmodified RNA for reprogramming and immune evasion	2015	45	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AvDijr-p_gm4C
702	Molecular characterization of virus-induced autoantibody responses	2004	45	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A2KloaMYe4IUC
703	Computational dissection of tissue contamination for identification of colon cancer‐specific expression profiles	2003	44	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AL7CI7m0gUJcC
704	Simultaneous ex vivo quantification of antigen-specific CD4+ and CD8+ T cell responses using in vitro transcribed RNA	2007	43	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AXiSMed-E-HIC
705	Identification of tumor-associated autoantigens with SEREX	2005	43	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtKAzc9rXhukC
706	Claudin-18 gene structure, regulation, and expression is evolutionary conserved in mammals	2011	42	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AevX43VCCuoAC
707	Expression of serologically identified tumor antigens in acute leukemias	2003	42	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHoB7MX3m0LUC
708	Selective activation of trophoblast-specific PLAC1 in breast cancer by CCAAT/enhancer-binding protein β (C/EBPβ) isoform 2	2009	41	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A5nxA0vEk-isC
709	RNA-based COVID-19 vaccine BNT162b2 selected for a pivotal efficacy study	2020	39	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aw1MjKQ0l0TYC
710	Genomic response of the rat brain to global ischemia and reperfusion	2009	39	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ANJ774b8OgUMC
711	Expression of cancer/testis antigens in cutaneous T cell lymphomas	2002	39	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ag3aElNc5_aQC
712	An RNA vaccine drives expansion and efficacy of claudin-CAR-T cells against solid tumors	2020	37	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AAXkvAH5U_nMC
713	Claudin 18.2 is a target for IMAB362 antibody in pancreatic neoplasms	2014	37	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3At6usbXjVLHcC
714	Metalized dielectric substrates for EAS tags	2004	37	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASpbeaW3--B0C
715	Translation of genomics-guided RNA-based personalised cancer vaccines: towards the bedside	2014	36	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AP5F9QuxV20EC
716	mTOR inhibition improves antitumor effects of vaccination with antigen-encoding RNA	2013	36	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A08ZZubdj9fEC
717	Confidence-based somatic mutation evaluation and prioritization	2012	35	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A7PzlFSSx8tAC
718	Mutated tumor alleles are expressed according to their DNA frequency	2014	34	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AULOm3_A8WrAC
719	Expression profiling of autoimmune regulator AIRE mRNA in a comprehensive set of human normal and neoplastic tissues	2006	34	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AeJXPG6dFmWUC
720	Determinants of intracellular RNA pharmacokinetics: Implications for RNA-based immunotherapeutics	2011	33	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Az_wVstp3MssC
721	Isolated peptides consisting of amino acid sequences found in SSX or NY-ESO-1 molecules, which bind to HLA molecules	2003	32	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABg7qf7VwUHIC
722	Concurrent human antibody and TH1 type T-cell responses elicited by a COVID-19 RNA vaccine	2020	31	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1DsIQWDZLl8C
723	Enhanced production of CCL18 by tolerogenic dendritic cells is associated with inhibition of allergic airway reactivity	2012	31	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AgeHnlv5EZngC
724	Improving mRNA-based therapeutic gene delivery by expression-augmenting 3′ UTRs identified by cellular library screening	2019	30	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALI9QrySNdTsC
725	SeroGRID: an improved method for the rapid selection of antigens with disease related immunogenicity	2003	30	30	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Adshw04ExmUIC
1315	DeepDTA: deep drug–target binding affinity prediction	2018	142	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ADrOLxFoABAwC
1314	Semi-supervised classification for extracting protein interaction sentences using dependency parsing	2007	164	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AW7OEmFMy1HYC
1312	Identifying gene-disease associations using centrality on a literature mined gene-interaction network	2008	361	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Au5HHmVD_uO8C
1313	Text categorization with class-based and corpus-based keyword selection	2005	177	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A2osOgNQ5qMEC
1316	Michigan molecular interactions r2: from interacting proteins to pathways	2009	109	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Ad1gkVwhDpl0C
1317	PHISTO: pathogen–host interaction search tool	2013	93	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AMXK_kJrjxJIC
1318	Citation summarization through keyphrase extraction	2010	93	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AIjCSPb-OGe4C
1319	A review on computational systems biology of pathogen–host interactions	2015	89	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AIWHjjKOFINEC
1320	Introducing meta-services for biomedical information extraction	2008	87	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Au-x6o8ySG0sC
1321	Detecting speculations and their scopes in scientific text	2009	77	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A9yKSN-GCB0IC
1322	Supervised and unsupervised machine learning techniques for text document categorization	2004	77	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A_FxGoFyzp5QC
1323	Classification of Beta-Lactamases and Penicillin Binding Proteins Using Ligand-Centric Network Models.	2015	61	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AZeXyd9-uunAC
1324	Improving Named Entity Recognition for Morphologically Rich Languages using Word Embeddings	2014	60	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqxL8FJ1GzNcC
1325	BIOSSES: a semantic sentence similarity estimation system for the biomedical domain	2017	59	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A_u2aKJ9e-CoC
1326	Mining of vaccine-associated IFN-g gene interaction networks using the Vaccine Ontology	2011	56	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AzYLM7Y9cAGgC
1327	GLASS: a comprehensive database for experimentally validated GPCR-ligand associations	2015	49	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AhC7cP41nSMkC
1328	A comparative study of SMILES-based compound similarity functions for drug-target interaction prediction	2016	47	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A4JMBOYKVnBMC
1329	Co-occurrence network of reuters news	2008	40	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AUebtZRa9Y70C
1330	Literature-Based Discovery of IFN-𝛾 and Vaccine-Mediated Gene Interaction Networks	2010	33	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqjMakFHDy7sC
1331	Identification of fever and vaccine-associated gene interaction networks using ontology-based literature mining	2012	32	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ALkGwnXOMwfcC
1332	BioCreative V BioC track overview: collaborative biocurator assistant task for BioGRID	2016	30	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AYFjsv_pBGBYC
1333	Identifying topics in microblogs using Wikipedia	2016	24	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Aj3f4tGmQtD8C
1334	A Graph-based Approach for Contextual Text Normalization	2014	24	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AM3ejUd6NZC8C
1335	Extracting interacting protein pairs and evidence sentences by using dependency parsing and machine learning techniques	2007	23	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AYsMSGLbcyi4C
1336	Development and application of an interaction network ontology for literature mining of vaccine-associated gene-gene interactions	2015	22	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AL8Ckcad2t8MC
1337	BOUNCE: Sentiment Classification in Twitter using Rich Feature Sets	2013	21	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AZph67rFs4hoC
1338	U-Compare bio-event meta-service: compatible BioNLP event extraction services	2011	21	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ASe3iqnhoufwC
1339	Turkish tweet sentiment analysis with word embedding and machine learning	2017	19	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ApZ2CosqRuhkC
1340	Bayesian pathway analysis of cancer microarray data	2014	18	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A_kc_bZDykSQC
1341	Word polarity detection using a multilingual approach	2013	17	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A0EnyYjriUFMC
1342	Supervised classification for extracting biomedical events	2009	17	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AUeHWp8X0CEIC
1343	Classification of skewed and homogenous document corpora with class-based and corpus-based keywords	2006	16	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ATyk-4Ss8FVUC
1344	Overview of the BioCreative VI Precision Medicine Track: mining protein interactions and mutations for precision medicine	2019	15	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Aqt-6tCTBDsQC
1345	Bacteria biotope detection, ontology-based normalization, and relation extraction using syntactic rules	2013	15	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A8k81kl-MbHgC
1346	A novel methodology on distributed representations of proteins using their interacting ligands	2018	14	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AwE8AsS3ykUMC
1347	Social network of co-occurrence in news articles	2004	14	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AY0pCki6q_DkC
1348	Linking entities through an ontology using word embeddings and syntactic re-ranking	2019	12	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AnnITTVbzT6kC
1349	Ontology-based literature mining of E. coli vaccine-associated gene interaction networks	2017	12	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A4WewbtJKmRkC
1350	Exploring chemical space using natural language processing methodologies for drug discovery	2020	10	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AlL5f5cZgq8MC
1351	WideDTA: prediction of drug-target binding affinity	2019	10	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AuQdrZ3qaPmcC
1352	Sentence similarity based on dependency tree kernels for multi-document summarization	2016	10	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Amu2_AnMl8iYC
1353	Question analysis for a closed domain question answering system	2015	10	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqUcmZB5y_30C
1354	Busem at semeval-2017 task 4a sentiment analysis with word embedding and long short term memory rnn approaches	2017	9	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AKYgttONoxcsC
1355	Ontology-based categorization of bacteria and habitat entities using information retrieval techniques	2016	9	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AM3NEmzRMIkIC
1356	Automatic query generation using word embeddings for retrieving passages describing experimental methods	2017	8	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AJ_g5lzvAfSwC
1357	Detection and categorization of bacteria habitats using shallow linguistic analysis	2015	8	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AhFOr9nPyWt4C
1358	Segmenting hashtags and analyzing their grammatical structure	2018	7	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3An8FNryW2AHIC
1359	CNN-based chemical–protein interactions classification	2017	7	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AGs1AF5H0x94C
1360	The Interaction Network Ontology-supported modeling and mining of complex interactions represented with multiple keywords in biomedical literature	2016	7	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ANaGl4SEjCO4C
1361	Segmenting Hashtags using Automatically Created Training Data	2016	7	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AhMod-77fHWUC
1362	Named entity recognition on twitter for turkish using semi-supervised learning with word embeddings	2018	6	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AMtS25d97-7AC
1363	Political opinion/sentiment prediction via long short term memory recurrent neural networks on Twitter	2017	6	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AuGrg30pLAbkC
1364	Efficient indexing technique for XML-based electronic product catalogs	2006	6	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AeQOLeE2rZwMC
1365	Ontology-based literature mining and class effect analysis of adverse drug reactions associated with neuropathy-inducing drugs	2018	5	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ApeNFRSk4lDYC
1366	Towards building a political protest database to explain changes in the welfare state	2016	5	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AGnPB-g6toBAC
1367	ChemBoost: A Chemical Language Based Approach for Protein–Ligand Binding Affinity Prediction	2020	4	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AeJjLl3UG7CkC
1368	Turkish treebanking: Unifying and constructing efforts	2019	4	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A2TuIPqOg0e0C
1369	A morphology-based representation model for lstm-based dependency parsing of agglutinative languages	2018	4	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A5UUbrqTvKfUC
1370	Extracting Adverse Drug Reactions using Deep Learning and Dictionary Based Approaches.	2017	4	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AtBp-nognM3UC
1371	Literature Mining and Ontology based Analysis of Host-Brucella Gene–Gene Interaction Network	2015	4	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AR3hNpaxXUhUC
1372	Machine learning-based identification and rule-based normalization of adverse drug reactions in drug labels	2019	3	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A5N-NJrZHaHcC
1373	Turkish tweet classification with transformer encoder	2019	3	34	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AMDQ-9Oe3GGUC
2588	Convolutional Soft Decision Trees	2018	0	33	https://scholar.google.com/citations?user=B23iqYwAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DB23iqYwAAAAJ%26citation_for_view%3DB23iqYwAAAAJ%3Au5HHmVD_uO8C
1804	A testicular antigen aberrantly expressed in human cancers detected by autologous antibody screening	1997	1441	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A8k81kl-MbHgC
1805	Human neoplasms elicit multiple specific immune responses in the autologous host	1995	1391	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZ5m8FVwuT1cC
1806	Personalized RNA mutanome vaccines mobilize poly-specific therapeutic immunity against cancer	2017	993	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aye4kPcJQO24C
1807	Generation of tissue-specific and promiscuous HLA ligand databases using DNA microarrays and virtual HLA class II matrices	1999	804	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AbKqednn6t2AC
1808	Mutant MHC class II epitopes drive therapeutic immune responses to cancer	2015	701	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A35N4QoGY0k4C
1809	mRNA-based therapeutics—developing a new class of drugs	2014	699	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ARYcK_YlVTxYC
1810	Systemic RNA delivery to dendritic cells exploits antiviral defence for cancer immunotherapy	2016	667	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AfEOibwPWpKIC
1811	Exploiting the mutanome for tumor vaccination	2012	634	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ATyk-4Ss8FVUC
1812	Serological identification of human tumor antigens	1997	435	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A3s1wT3WcHBgC
1813	Characterization of human colon cancer antigens recognized by autologous antibodies	1998	434	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A_FxGoFyzp5QC
1814	Human carbonic anhydrase XII: cDNA cloning, expression, and chromosomal localization of a carbonic anhydrase gene that is overexpressed in some renal cell cancers	1998	381	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AeMMeJKvmdy0C
1815	Modification of antigen-encoding RNA increases stability, translational efficacy, and T-cell stimulatory capacity of dendritic cells	2006	370	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AUeHWp8X0CEIC
1816	Identification of a meiosis-specific protein as a member of the class of cancer/testis antigens	1998	320	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AuLbwQdceFCQC
1817	The SSX-2 gene, which is involved in the t (X; 18) translocation of synovial sarcomas, codes for the human tumor antigen HOM-MEL-40	1996	299	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1sJd4Hv_s6UC
1818	SSX: A multigene family with several members transcribed in normal testis and human cancer	1997	294	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AkRWSkSYxWN8C
1819	Personalized vaccines for cancer immunotherapy	2018	278	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aj3f4tGmQtD8C
1820	Intranodal vaccination with naked antigen-encoding RNA elicits potent prophylactic and therapeutic antitumoral immunity	2010	277	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZHo1McVdvXMC
1821	Autoantibodies in lung cancer: possibilities for early detection and subsequent cure	2008	261	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtOudhMTPpwUC
1822	Molecular definition of a novel human galectin which is immunogenic in patients with Hodgkin's disease	1997	245	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AD03iK_w7-QYC
1823	Expression of SSX genes in human tumors	1998	226	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ArO6llkc54NcC
1824	Tumor vaccination using messenger RNA: prospects of a future therapy	2011	195	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AyB1At4FlUx8C
1825	Immunomic, genomic and transcriptomic characterization of CT26 colorectal carcinoma	2014	184	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AJV2RwH3_ST0C
1826	Electronic mail transmission/reception system and electronic mail transmission/reception program	2006	184	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALPtt_HFRSbwC
1827	Safety and efficacy of the BNT162b2 mRNA Covid-19 vaccine	2020	171	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABrOSOlqYqPUC
1828	Expression of multiple cancer/testis (CT) antigens in breast cancer and melanoma: basis for polyvalent CT vaccine strategies	1998	171	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtzM49s52ZIMC
1829	HLA typing from RNA-Seq sequence reads	2013	167	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AeQOLeE2rZwMC
1830	Phase I/II study of COVID-19 RNA vaccine BNT162b1 in adults	2020	160	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A-nhnvRiOwuoC
1831	Phosphorothioate cap analogs increase stability and translational efficiency of RNA vaccines in immature dendritic cells and induce superior immune responses in vivo	2010	155	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AblknAaTinKkC
1832	Expression of cancer testis genes in human brain tumors	2000	155	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A_Qo2XoVZTnwC
1833	Expression of a novel transmembrane carbonic anhydrase isozyme XII in normal human gut and colorectal tumors	2000	155	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtkaPQYYpVKoC
1834	Multiple splice variants of lactate dehydrogenase C selectively expressed in human cancer	2002	136	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A9Nmd_mFXekcC
1835	Characterization of DP103, a novel DEAD box protein that binds to the Epstein-Barr virus nuclear proteins EBNA2 and EBNA3C	1999	136	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ApqnbT2bcN3wC
1836	mRNA as a versatile tool for exogenous protein expression	2012	124	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4MWp96NkSFoC
1837	Claudin-18 splice variant 2 is a pan-cancer target suitable for therapeutic antibody development	2008	124	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AIWHjjKOFINEC
1838	Selective uptake of naked vaccine RNA by dendritic cells is driven by macropinocytosis and abrogated upon DC maturation	2011	116	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AqxL8FJ1GzNcC
1839	Expression of the membrane-associated carbonic anhydrase isozyme XII in the human kidney and renal tumors	2000	115	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AKlAtU1dfN6UC
1840	The Human Vaccines Project: A roadmap for cancer vaccine development	2016	107	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AKxtntwgDAa4C
1841	Basket catheter with improved expansion mechanism	2004	102	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ae_rmSamDkqQC
1842	Increased antigen presentation efficiency by coupling antigens to MHC class I trafficking signals	2008	100	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWF5omc3nYNoC
1843	Cascades of transcriptional induction during dendritic cell maturation revealed by genome‐wide expression analysis	2003	99	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ap__nRnzSRKYC
1844	Safety and immunogenicity of two RNA-based Covid-19 vaccine candidates	2020	97	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AYsrPvlHIBpEC
1845	A placenta-specific gene ectopically activated in many human cancers is essentially involved in malignant cell processes	2007	97	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AFu2w8maKXqMC
1846	Identification of carbonic anhydrase XII as the membrane isozyme expressed in the normal human endometrial epithelium	2000	91	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWA5NYHcadZ8C
1847	Humoral immune responses of lung cancer patients against tumor antigen NY-ESO-1	2006	88	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AUebtZRa9Y70C
1848	Targeting the heterogeneity of cancer with individualized neoepitope vaccines	2016	87	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZuybSZzF8UAC
1849	Tumor fibroblast–derived epiregulin promotes growth of colitis-associated neoplasms through ERK	2013	82	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AqjMakFHDy7sC
1850	Definition of tumor-associated antigens in hepatocellular carcinoma	2000	80	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABwyfMAYsbu0C
1851	Sealed sample storage element system and method	2010	79	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1yWc8FF-_SYC
1852	ERBB2-mediated transcriptional up-regulation of the α5β1 integrin fibronectin receptor promotes tumor cell survival under adverse conditions	2006	78	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASeFeTyx0c_EC
1853	Modification of RNA, producing an increased transcript stability and translation efficiency	2016	77	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVLnqNzywnoUC
1854	Elimination of large tumors in mice by mRNA-encoded bispecific antibodies	2017	76	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A7T2F9Uy0os0C
1855	Genetic products differentially expressed in tumors and the use thereof	2009	76	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AML0RJ9NH7IQC
1856	Monoclonal antibodies against claudin-18 for treatment of cancer	2012	74	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AKUbvn5osdkgC
1857	Lithography laser with beam delivery and beam pointing control	2004	74	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A3NQIlFlcGxIC
1858	Tumor-associated CpG demethylation augments hypoxia-induced effects by positive autoregulation of HIF-1α	2011	72	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHE397vMXCloC
1859	Exploitation of the antibody repertoire of cancer patients for the identification of human tumor antigens	1999	69	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AJQOojiI6XY0C
1860	COVID-19 vaccine BNT162b1 elicits human antibody and TH 1 T cell responses	2020	68	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AziOE8S1-AIUC
1861	Expression of multiple epigenetically regulated cancer/germline genes in nonsmall cell lung cancer	2006	67	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AOU6Ihb5iCvQC
1862	FLT3 ligand enhances the cancer therapeutic potency of naked RNA vaccines	2011	66	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AhMsQuOkrut0C
1863	A role for T-bet-mediated tumour immune surveillance in anti-IL-17A treatment of lung cancer	2011	64	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AGnPB-g6toBAC
1864	Frequent nonrandom activation of germ-line genes in human cancer	2004	61	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A5ugPr518TE4C
1865	Recombinant vaccines and use thereof	2014	60	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AgKiMpY-AVTkC
1866	A novel tumour associated leucine zipper protein targeting to sites of gene transcription and splicing	2002	56	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AFAceZFleit8C
1867	Highly specific auto-antibodies against claudin-18 isoform 2 induced by a chimeric HBcAg virus-like particle vaccine kill tumor cells and inhibit the growth of lung metastases	2011	55	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A2osOgNQ5qMEC
1868	Aberrantly activated claudin 6 and 18.2 as potential therapy targets in non‐small‐cell lung cancer	2014	53	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABUYA1_V_uYcC
1869	Targeting the tumor mutanome for personalized vaccination therapy	2012	52	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AzA6iFVUQeVQC
1870	MS4A12 is a colon-selective store-operated calcium channel promoting malignant cell processes	2008	49	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AJ_g5lzvAfSwC
1871	FAST: An international, multicenter, randomized, phase II trial of epirubicin, oxaliplatin, and capecitabine (EOX) with or without IMAB362, a first-in-class anti-CLDN18. 2 …	2016	45	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AEYYDruWGBe4C
1872	Efficient reprogramming of human fibroblasts and blood-derived endothelial progenitor cells using nonmodified RNA for reprogramming and immune evasion	2015	45	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AvDijr-p_gm4C
1873	Molecular characterization of virus-induced autoantibody responses	2004	45	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A2KloaMYe4IUC
1874	Computational dissection of tissue contamination for identification of colon cancer‐specific expression profiles	2003	44	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AL7CI7m0gUJcC
1875	Simultaneous ex vivo quantification of antigen-specific CD4+ and CD8+ T cell responses using in vitro transcribed RNA	2007	43	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AXiSMed-E-HIC
1876	Identification of tumor-associated autoantigens with SEREX	2005	43	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtKAzc9rXhukC
1877	Claudin-18 gene structure, regulation, and expression is evolutionary conserved in mammals	2011	42	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AevX43VCCuoAC
1878	Expression of serologically identified tumor antigens in acute leukemias	2003	42	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHoB7MX3m0LUC
1879	Selective activation of trophoblast-specific PLAC1 in breast cancer by CCAAT/enhancer-binding protein β (C/EBPβ) isoform 2	2009	41	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A5nxA0vEk-isC
1880	RNA-based COVID-19 vaccine BNT162b2 selected for a pivotal efficacy study	2020	39	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aw1MjKQ0l0TYC
1881	Genomic response of the rat brain to global ischemia and reperfusion	2009	39	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ANJ774b8OgUMC
1882	Expression of cancer/testis antigens in cutaneous T cell lymphomas	2002	39	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ag3aElNc5_aQC
1883	An RNA vaccine drives expansion and efficacy of claudin-CAR-T cells against solid tumors	2020	37	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AAXkvAH5U_nMC
1884	Claudin 18.2 is a target for IMAB362 antibody in pancreatic neoplasms	2014	37	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3At6usbXjVLHcC
1885	Metalized dielectric substrates for EAS tags	2004	37	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASpbeaW3--B0C
1886	Translation of genomics-guided RNA-based personalised cancer vaccines: towards the bedside	2014	36	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AP5F9QuxV20EC
1887	mTOR inhibition improves antitumor effects of vaccination with antigen-encoding RNA	2013	36	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A08ZZubdj9fEC
1888	Confidence-based somatic mutation evaluation and prioritization	2012	35	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A7PzlFSSx8tAC
1889	Mutated tumor alleles are expressed according to their DNA frequency	2014	34	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AULOm3_A8WrAC
1890	Expression profiling of autoimmune regulator AIRE mRNA in a comprehensive set of human normal and neoplastic tissues	2006	34	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AeJXPG6dFmWUC
1891	Determinants of intracellular RNA pharmacokinetics: Implications for RNA-based immunotherapeutics	2011	33	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Az_wVstp3MssC
1892	Isolated peptides consisting of amino acid sequences found in SSX or NY-ESO-1 molecules, which bind to HLA molecules	2003	32	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABg7qf7VwUHIC
1893	Concurrent human antibody and TH1 type T-cell responses elicited by a COVID-19 RNA vaccine	2020	31	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1DsIQWDZLl8C
1894	Enhanced production of CCL18 by tolerogenic dendritic cells is associated with inhibition of allergic airway reactivity	2012	31	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AgeHnlv5EZngC
1895	Improving mRNA-based therapeutic gene delivery by expression-augmenting 3′ UTRs identified by cellular library screening	2019	30	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALI9QrySNdTsC
1896	SeroGRID: an improved method for the rapid selection of antigens with disease related immunogenicity	2003	30	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Adshw04ExmUIC
1897	Recombinant vaccines and use thereof	2012	29	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALkGwnXOMwfcC
1898	System and method for dynamically tuning interrupt coalescing parameters	2005	29	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AM7yex6snE4oC
1899	The human X chromosome is enriched for germline genes expressed in premeiotic germ cells of both sexes	2006	28	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWp0gIr-vW9MC
1900	Functional TCR retrieval from single antigen-specific human T cells reveals multiple novel epitopes	2014	27	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AkuK5TVdYjLIC
1901	Porous carpeting for vehicles and methods of producing same	2004	27	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A2VqYfGB8ITEC
1902	Uptake of synthetic naked RNA by skin-resident dendritic cells via macropinocytosis allows antigen expression and induction of T-cell responses in mice	2016	26	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Awbdj-CoPYUoC
1903	Monoclonal antibodies for treatment of cancer	2015	25	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AILKRHgRFtOwC
1904	Hodgkin and Reed-Sternberg cell–associated autoantigen CLIP-170/restin is a marker for dendritic cells and is involved in the trafficking of macropinosomes to the cytoskeleton …	2002	25	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AsSrBHYA8nusC
1905	Characterization of the first-in-class T-cell-engaging bispecific single-chain antibody for targeted immunotherapy of solid tumors expressing the oncofetal protein claudin 6	2016	24	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A0EnyYjriUFMC
1906	CXorf61 is a target for T cell based immunotherapy of triple-negative breast cancer	2015	24	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AqUcmZB5y_30C
1907	Selective activation of tumor growth-promoting Ca 2+ channel MS4A12 in colon cancer by caudal type homeobox transcription factor CDX2	2009	24	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Au-x6o8ySG0sC
1908	An RNA vaccine drives immunity in checkpoint-inhibitor-treated melanoma	2020	22	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHhcuHIWmDEUC
1909	Improvement of In Vivo Expression of Genes Delivered by Self-Amplifying RNA Using Vaccinia Virus Immune Evasion Proteins	2017	22	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AJoZmwDi-zQgC
1910	Mutanome engineered RNA immunotherapy: towards patient-centered tumor vaccination	2015	22	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASdhP9T11ey4C
1911	Monoclonal antibodies against claudin-18 for treatment of cancer	2019	21	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AhkOj_22Ku90C
1912	NCOA3 is a selective co-activator of estrogen receptor α-mediated transactivation of PLAC1 in MCF-7 breast cancer cells	2013	21	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AW7OEmFMy1HYC
1913	Autoimmunity seen through the SEREX-scope	2003	21	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmvPsJ3kp5DgC
1914	Methods and compositions for diagnosis and treatment of cancer	2017	20	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ab0M2c_1WBrUC
1915	Final results of the FAST study, an international, multicenter, randomized, phase II trial of epirubicin, oxaliplatin, and capecitabine (EOX) with or without the anti-CLDN18. 2 …	2016	20	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVL0QpB8kHFEC
1916	Isolated nucleic acid molecule encoding cancer associated antigen, the antigen itself, and uses thereof	2001	20	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtYavs44e6CUC
1917	Methods for determining breast cancer and melanoma by assaying for a plurality of antigens associated therewith	2000	20	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AvbGhcppDl1QC
1918	Harnessing tumor mutations for truly individualized cancer vaccines	2019	19	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ak8Z6L05lTy4C
1919	Monoclonal antibodies against claudin-18 for treatment of cancer	2016	19	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AnrtMV_XWKgEC
1920	Monoclonal antibodies against claudin-18 for treatment of cancer	2015	18	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A0N-VGjzr574C
1921	Genetic products differentially expressed in tumors and the use thereof	2013	18	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AwKETBy42zhYC
1922	Monoclonal antibodies against claudin-18 for treatment of cancer	2013	18	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A7wO8s98CvbsC
1923	rapmad: Robust analysis of peptide microarray data	2011	18	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ans9cj8rnVeAC
1924	A key regulatory role of the transcription factor NFATc2 in bronchial adenocarcinoma via CD8+ T lymphocytes	2009	18	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Af2IySw72cVMC
1948	Antibodies against Claudin 18.2 useful in cancer diagnosis	2016	10	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3APR6Y55bgFSsC
1925	CrELISA: a fast and robust enzyme-linked immunosorbent assay bypassing the need for purification of recombinant protein	2004	18	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aj8SEvjWlNXcC
1926	Methods for determining breast cancer and melanoma by assaying for a plurality of antigens associated therewith	2002	18	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4fKUyHm3Qg0C
1927	A multicentre, phase IIa study of zolbetuximab as a single agent in patients with recurrent or refractory advanced adenocarcinoma of the stomach or lower oesophagus: the MONO study	2019	17	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmNrWkgRL2YcC
1928	A phase I dose-escalation study of IMAB362 (Zolbetuximab) in patients with advanced gastric and gastro-oesophageal junction cancer	2018	17	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AufrVoPGSRksC
1929	Genetic products differentially expressed in tumors and the use thereof	2015	17	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AbEWYMUwI8FkC
1930	Genetic products differentially expressed in tumors and the use thereof	2014	17	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AYOwf2qJgpHMC
1931	Antitumor vaccination with synthetic mRNA: strategies for in vitro and in vivo preclinical studies	2013	17	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ANaGl4SEjCO4C
1932	Genetic products differentially expressed in tumors and the use of thereof	2012	17	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AxtRiw3GOFMkC
1933	Antigen-specific T cell receptors and T cell epitopes	2017	16	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aj7_hQOaDUrUC
1934	Safety, tolerability, and efficacy of the first-in-class antibody IMAB362 targeting claudin 18.2 in patients with metastatic gastroesophageal adenocarcinomas.	2013	15	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AyMeIxYmEMEAC
1935	Rapid molecular dissection of viral and bacterial immunomes	2006	14	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AldfaerwXgEUC
1936	Method for diagnosis and treating cancers, and methods for identifying pathogenic markers in a sample of normal cells	1999	14	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A48xauSegjOkC
1937	Antibodies specific for claudin 6 (CLDN6)	2016	13	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AwMgC3FpKEyYC
1938	A trans-amplifying RNA Vaccine strategy for induction of potent protective immunity	2020	12	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ADUooU5lO8OsC
1939	A prefusion SARS-CoV-2 spike RNA vaccine is highly immunogenic and prevents lung infection in non-human primates	2020	12	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aoi2SiIJ9l4AC
1940	The European regulatory environment of RNA-based vaccines	2017	12	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmB3voiENLucC
1941	Humoral immune responses of lung cancer patients against the Transmembrane Phosphatase with TEnsin homology (TPTE)	2015	12	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AbFI3QPDXJZMC
1942	Efficacy and safety of multiple doses of IMAB362 in patients with advanced gastro-esophageal cancer: results of a phase II study	2014	12	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3APELIpwtuRlgC
1943	Identification of tumour-associated cell surface antigens for diagnosis and therapy	2011	12	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ATFP_iSt0sucC
1944	Ki-ras oncogene and p53 tumour suppressor gene mutations in colorectal carcinomas from the European Saar-Luxembourg region are less frequent than predicted by the classic …	1997	12	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZfRJV9d4-WMC
1945	Comparison of Claudin 18.2 expression in primary tumors and lymph node metastases in Japanese patients with gastric adenocarcinoma	2019	11	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aanf4URPfarAC
1946	Monoclonal antibodies against claudin-18 for treatment of cancer	2017	11	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AfPk4N6BV_jEC
1947	Identification of surface-associated antigens for tumor diagnosis and therapy	2015	11	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AK3LRdlH-MEoC
1950	First-in-human phase I/II dose-escalation study of IMAB027 in patients with recurrent advanced ovarian cancer (OVAR): Preliminary data of phase I part.	2015	10	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ar_AWSJRzSzQC
1951	T-cell receptor transfer into human T cells with ecotropic retroviral vectors	2014	10	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aolpn-zPbct0C
1952	HPV16 RNA-LPX vaccine mediates complete regression of aggressively growing HPV-positive mouse tumors and establishes protective T cell memory	2019	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AumqufdRvDiIC
1953	Challenges towards the realization of individualized cancer vaccines	2018	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ap2g8aNsByqUC
1954	Antibody to genetic products differentially expressed in tumors and the use thereof	2017	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A6yz0xqPARnAC
1955	Cancer therapy using CLDN6 target-directed antibodies in vivo	2017	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZzlSgRqYykMC
1956	Methods and compositions for diagnosis and treatment of cancer	2017	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A8AbLer7MMksC
1957	Genetic Products Differentially Expressed In Tumors And The Use Thereof	2015	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AnRpfm8aw39MC
1958	Combination therapy involving antibodies against claudin 18.2 for treatment of cancer	2015	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A5Ul4iDaHHb8C
1959	Isolated peptides which bind to MHC class II molecules, and uses thereof	2004	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4xDN1ZYqzskC
1960	Driving module of laser diode	2003	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A-FonjvnnhkoC
1961	Method and apparatus of interface conversion for handheld device	2003	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aubry08Y2EpUC
1962	Methods for determining presence of cancer in a sample by determining expression of an SSX gene	2001	9	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A35r97b3x0nAC
1963	Combination therapy involving antibodies against claudin 18.2 for treatment of pancreatic adenocarcinoma	2017	8	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AzCSUwVk65WsC
1964	Claudin 18.2–a novel treatment target in the multicenter, randomized, phase ii fast study, a trial of epirubicin, oxaliplatin, and capecitabine (EOX) with or without the anti …	2016	8	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Au5HHmVD_uO8C
1965	Genetic Products Differentially Expressed In Tumors And The Use Thereof	2014	8	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABzfGm06jWhQC
1966	Antigen identification using SEREX	2013	8	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AipzZ9siozwsC
1967	Identification of surface-associated antigens for tumor diagnosis and therapy	2010	8	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ar0BpntZqJG4C
1968	Genetic products differentially expressed in tumors and use thereof	2008	8	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A0CzhzZyukY4C
1969	Diagnosis and therapy of cancer involving cancer stem cells	2020	7	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AEhil0879vHcC
1970	Discovery and subtyping of neo-epitope specific T-cell responses for cancer immunotherapy: addressing the mutanome	2017	7	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHDshCWvjkbEC
1971	Use of FLT3 ligand for enhancing immune responses in RNA immunization	2016	7	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ARGFaLdJalmkC
1972	Combination therapy involving antibodies against claudin 18.2 for treatment of cancer	2016	7	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVOx2b1Wkg3QC
1973	Monoclonal antibodies for treatment of cancer	2015	7	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Afbc8zXXH2BUC
1974	IMAB362 plus zoledronic acid (ZA) and interleukin-2 (IL-2) in patients (pts) with advanced gastroesophageal cancer (GEC): Clinical activity and safety data from the PILOT phase …	2015	7	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AOR75R8vi5nAC
1975	Monoclonal antibodies for treatment of cancer	2013	7	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABr1UauaknNIC
1976	Personalized neo-epitope vaccines for cancer treatment	2020	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AsNmaIFBj_lkC
1977	Intravenous delivery of the toll-like receptor 7 agonist SC1 confers tumor control by inducing a CD8+ T cell response	2019	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALO7wyVUgiFcC
1978	Antibodies specific for claudin 6 (CLDN6)	2018	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4JMBOYKVnBMC
1979	Cancer therapy using CLDN6 target-directed antibodies in vivo	2018	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1lhNe0rCu4AC
1980	A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles encoding shared tumor antigens for potent melanoma immunotherapy	2017	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aa0OBvERweLwC
1981	Abstract CT032: A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles for potent cancer immunotherapy in patients with malignant melanoma	2016	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AQYdC8u9Cj1oC
1982	Abstract CT032: A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles for potent cancer immunotherapy in patients with malignant melanoma	2016	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmlAyqtXpCwEC
1983	FLT3 ligand as a molecular adjuvant for naked RNA vaccines	2016	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AiH-uZ7U-co4C
1984	Recognition of human tumors: SEREX expression cloning to identify tumour antigens	2001	6	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ANhqRSupF_l8C
1985	A non-functional neoepitope specific CD8+ T-cell response induced by tumor derived antigen exposure in vivo	2019	5	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVaXvl8Fpj5cC
1986	Enhanced stability of a chimeric hepatitis B core antigen virus-like-particle (HBcAg-VLP) by a C-terminal linker-hexahistidine-peptide	2018	5	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AcFHS6HbyZ2cC
1987	Identification of tumor-associated markers for diagnosing or monitoring ovarian cancer	2015	5	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A3fE2CSJIrl8C
1988	Peptide microarrays enable rapid mimotope optimization for pharmacokinetic analysis of the novel therapeutic antibody IMAB362	2014	5	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aeq2jaN3J8jMC
1989	Method for identifying biologically active structures of microbial pathogens	2004	5	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ATIZ-Mc8IlK0C
1990	Method for generating pure populations of mobile mebrane-associated biomolecules on supported lipid bilayers	2004	5	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A6ZxmRoH8BuwC
1991	Isolated nucleic acid molecule encoding an esophageal cancer associated antigen, the antigen itself, and uses thereof	2000	5	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABJbdYPG6LGMC
1992	Vom Immunsystem erkennbare Antigene auf menschlichen Malignomen	1999	5	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AdQ2og3OwTAUC
1993	Abstract CT156: A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles encoding shared tumor antigens for immunotherapy of malignant melanoma	2018	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AD_sINldO8mEC
1994	Preclinical characterization of IMAB362 for the treatment of gastric carcinoma	2017	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWbkHhVStYXYC
1995	Preclinical evaluation of the anti-CLDN18. 2 antibody, IMAB362, in pancreatic carcinoma	2017	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ae5wmG9Sq2KIC
1996	Identification of surface-associated antigens for tumor diagnosis and therapy	2017	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ACHSYGLWDkRkC
1997	Identification of Tumor-Associated Markers for Diagnosis and Therapy	2016	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWC23djZS0W4C
1998	Chromatin immunoprecipitation assay to identify genomic binding sites of regulatory factors	2016	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABqipwSGYUEgC
1999	Identification of tumor-associated cell surface antigens for diagnosis and therapy	2015	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AbnK-pcrLprsC
2000	Retrieval of functional TCRs from single antigen-specific T cells: toward individualized TCR-engineered therapies	2015	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AyD5IFk8b50cC
2001	Identification of tumor-associated antigens for diagnosis and therapy	2015	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AeflP2zaiRacC
2002	Monoclonal antibodies for treatment of cancer	2015	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A1taIhTC69MYC
2003	In silico strategy for detection of target candidates for antibody therapy of solid tumors	2008	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASe3iqnhoufwC
2004	Isolated nucleic acid molecules encoding isolated peptides which correspond to contiguous amino acids of an SSX molecule or NY-ESO-1 and uses thereof	2007	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AyxmsSjX2EkcC
2005	SSX family proteins	2002	4	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AMpfHP-DdYjUC
2006	BNT162b2 induces SARS-CoV-2-neutralising antibodies and T cells in humans	2020	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A5bg8sr1QxYwC
2007	A liposomal RNA vaccine inducing neoantigen-specific CD4+ T cells augments the antitumor activity of local radiotherapy in mice	2020	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ARoXSNcbkSzsC
2008	Combination therapy involving antibodies against claudin 18.2 for treatment of pancreatic cancer	2019	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A7H_MAutzIkAC
2009	A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles encoding shared tumor antigens for immunotherapy of malignant melanoma	2018	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AMLfJN-KU85MC
2010	Identification of tumor-associated cell surface antigens for diagnosis and therapy	2018	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AR3hNpaxXUhUC
2011	Preclinical characterization of IMAB362-vcMMAE, an anti-CLDN18. 2 antibody–drug conjugate	2017	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AYsMSGLbcyi4C
2012	Monoclonal antibodies for treatment of cancer	2016	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AtS2w5q8j5-wC
2013	LBA-06 IMAB362: a novel immunotherapeutic antibody targeting the tight-junction protein component CLAUDIN18. 2 in gastric cancer	2016	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AOcBU2YAGkTUC
2014	Identification of tumor-associated cell surface antigens for diagnosis and therapy	2016	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmaZDTaKrznsC
2015	Identification of surface-associated antigens for tumor diagnosis and therapy	2016	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AYFjsv_pBGBYC
2016	Genetic products differentially expressed in tumors and use thereof	2016	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AUxriW0iASnsC
2017	Luciferase mRNA transfection of antigen presenting cells permits sensitive nonradioactive measurement of cellular and humoral cytotoxicity	2016	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AV3AGJWp-ZtQC
2018	Abstract B041: A novel nanoparticular formulated tetravalent RNA cancer vaccine for treatment of patients with malignant melanoma	2016	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AdBIO0h50nwkC
2019	The human vaccines project: a roadmap for cancer vaccine development. Sci Transl Med 8: 334ps9	2016	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A_FM0Bhl9EiAC
2020	Identification of surface-associated antigens for tumor diagnosis and therapy	2015	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AL1USKYWJimsC
2021	Abstract CT202: IVAC MUTANOME: Individualized vaccines for the treatment of cancer	2015	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AHIFyuExEbWQC
2022	Antigen-specific clonal expansion of B cells	2015	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A2tRrZ1ZAMYUC
2023	Phenotyping of peripheral blood mononuclear cells of patients with advanced heavily pre-treated adenocarcinoma of the stomach and gastro-esophageal junction	2014	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AfQNAKQ3IYiAC
2024	Isolated peptides which bind to MHC Class II molecules, and uses thereof	2008	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A4X0JR2_MtJMC
2025	Sensor for measuring a substrate temperature	2002	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALdasjJ6CEcoC
2026	Isolated nucleic acid molecules encoding SSX family members and thereof	2001	3	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AprdVHNxh-e8C
2027	Cancer therapy using CLDN6 target-directed antibodies in vivo	2020	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AjL-93Qbq4QoC
2028	Antibodies specific for claudin 6 (CLDN6)	2020	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A_xSYboBqXhAC
2029	Monoclonal antibodies against claudin-18 for treatment of cancer	2020	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AuWiczbcajpAC
2030	A shared tumor-antigen RNA-lipoplex vaccine with/without anti-PD1 in patients with checkpoint-inhibition experienced melanoma.	2020	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AU_HPUtbDl20C
2031	Abstract OT2-06-01: Highly innovative personalized RNA-immunotherapy for patients with triple negative breast cancer	2019	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A9c2xU6iGI7YC
2032	Methods and compositions for diagnosis and treatment of cancer	2018	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AZph67rFs4hoC
2033	Abstract CT034: a first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles for potent melanoma immunotherapy	2017	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AyFnVuubrUp4C
2034	Antibody therapy in oncology	2014	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AIjCSPb-OGe4C
2035	Identification of tumour-associated cell surface antigens for diagnosis and therapy	2011	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AURolC5Kub84C
2036	The role of NFATc1 in tumor T cell responses to lung cancer (101.6)	2010	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A9yKSN-GCB0IC
2037	Liposome-Encapsulated Adjuvants are Potent Inducers of Antigen-Specific T-Cells in Vivo	2008	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AW5xh706n7nkC
2038	Bioelectric telemetering system and method	2004	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AgVv57TyPmFsC
2039	System and method for rapid alignment and accurate placement of electronic components on a printed circuit board	2003	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AuDGL6kOW6j0C
2040	448 PCR-SSCP a sensitive and rapid method to detect mutations in the P53 tumor suppressor gene of patients with advanced colorectal cancer	1995	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AB3FOqHPlNUQC
2041	Characterization of human glioblastoma cell lines in vitro and their xenografts in nude mice by DNA fingerprinting	1990	2	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ABrmTIyaxlBUC
2042	A noninflammatory mRNA vaccine for treatment of experimental autoimmune encephalomyelitis	2021	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ApS0ncopqnHgC
2043	Abstract CT301: A phase Ib study to evaluate RO7198457, an individualized Neoantigen Specific immunoTherapy (iNeST), in combination with atezolizumab in patients with locally …	2020	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AF2UWTTQJPOcC
2044	Agents for treatment of claudin expressing cancer diseases	2020	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A9pM33mqn1YgC
2045	Targeting the tumor vasculature with engineered cystine-knot miniproteins	2020	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AjFemdcug13IC
2046	A Phase Ia Study to Evaluate RO7198457, an Individualized Neoantigen-Specific Immunotherapy (iNeST), in Patients With Locally Advanced or Metastatic Solid Tumors	2020	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Ace2CqMG-AY4C
2047	Claudin-6-specific immunoreceptors and T cell epitopes	2019	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AisC4tDSrTZIC
2048	Abstract CT221: Mutanome engineered RNA immuno-therapy (MERIT) for patients with triple negative breast cancer (TNBC)	2019	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AXvxMoLDsR5gC
2049	Antigen-specific T cell receptors and T cell epitopes	2018	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AkVjdVfd2voEC
2050	Mutanome engineered RNA immuno-therapy (MERIT) for patients with triple negative breast cancer (TNBC)	2018	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Almc2jWPfTJgC
2051	Antibodies against claudin 18.2 useful in cancer diagnosis	2018	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AGFxP56DSvIMC
2052	Combination therapy involving antibodies against Claudin 18.2 for treatment of cancer	2018	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ACaZNVDsoPx4C
2053	The anti-claudin 6 antibody, IMAB027, induces antibody-dependent cellular and complement-dependent cytotoxicity in claudin 6-expressing cancer cells	2018	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AdTyEYWd-f8wC
2054	Drug conjugates comprising antibodies against claudin 18.2	2018	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AU4n9YNQMCAIC
2055	IVAC MUTANOME: A first-in-human phase I clinical trial targeting individual mutant neoantigens for the treatment of melanoma	2017	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AdhFuZR0502QC
2056	Mutanome engineered RNA immuno-therapy (MERIT) for patients with triple negative breast cancer	2017	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AY0pCki6q_DkC
2057	Erratum: Elimination of large tumors in mice by mRNA-encoded bispecific antibodies	2017	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALjlpjdlvIbIC
2058	Genetic products differentially expressed in tumors and the use thereof	2017	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AFiytvqdAVhgC
2059	A first-in-human phase I/II clinical trial assessing novel mRNA-lipoplex nanoparticles for potent melanoma immunotherapy	2017	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASnGPuo6Feq8C
2060	Tumor vaccination involving a humoral immune response against self-proteins	2017	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A7BrZ7Jt4UNcC
2061	Abstract CT201: The Mutanome Engineered RNA Immuno-Therapy (MERIT) project	2015	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AIUKN3-7HHlwC
2062	IMAB362, a novel first-in-class monoclonal antibody for treatment of pancreatic cancer	2014	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AIRz6iEL74y4C
2063	Chemotherapy combined with IMAB362 synergistically improves anti-tumor immune response in vitro	2014	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ANXb4pA-qfm4C
2064	A first-in-human dose escalation and dose-finding phase I/II trial of IMAB027 in patients with recurrent advanced ovarian cancer (GM-IMAB-002-01).	2014	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ALhH-TYMQEocC
2065	Identification of Tumor-Associated Markers for Diagnosis and Therapy	2014	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AlgwcVrK6X84C
2066	Abstract A37: Ectopic claudin 6 and 18.2 expression as potential treatment target in non-small cell lung cancer.	2014	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3At7zJ5fGR-2UC
2067	Genetic products differentially expressed in tumors and use thereof	2013	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A_B80troHkn4C
2068	Autoantigenes for improved diagnosis, prognosis and treatment of inflammatory neurological diseases	2013	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Al7t_Zn2s7bgC
2069	Compositions and Methods for Therapy and Diagnosis of Cancer	2012	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ApyW8ca7W8N0C
2070	Compositions and methods for therapy and diagnosis of cancer	2012	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Au_35RYKgDlwC
2071	Antibodies specific for claudin 6 (cldn6)	2011	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ApAkWuXOU-OoC
2072	Identification of Tumor-Associated Antigens for Diagnosis and Therapy	2009	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AaqlVkmm33-oC
2073	Tumor associated peptide and uses thereof	2004	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AcK4Rrx0J3m0C
2074	Antibodies specific for SSX proteins	2003	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AQD3KBmkZPeQC
2075	New Methods, Abstract 253–261, Posters	2003	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AKaMxkj08jr0C
2076	Isolated muteins of proteins SCP-1, and compositions containing the mutein	2001	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AepqYDVWIO7EC
2077	Epidemiological study of p53 tumor suppressor gene mutations in patients from Luxembourg and the German Saar region with an advanced colorectal cancer using PCR-SSCP analysis	1998	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aq3oQSFYPqjQC
2078	Identification of Human Tumor Antigens Using the B-Cell Repertoire	1998	1	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AM05iB0D1s5AC
2079	Agents for Treatment of Claudin Expressing Cancer Diseases	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AeO3_k5sD8BwC
2080	Combination therapy involving antibodies against claudin 18.2 for treatment of cancer	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A2l5NCbZemmgC
2081	Monoclonal antibodies against claudin-18 for treatment of cancer	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ADkZNVXde3BIC
2082	Diagnosis and therapy of cancer involving cancer stem cells	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ASGW5VrABaM0C
2083	561 DuoBody®-PD-L1× 4–1BB (GEN1046) induces superior immune-cell activation, cytokine production and cytotoxicity by combining PD-L1 blockade with conditional 4–1BB co-stimulation	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AkzcSZmkxUKAC
2084	412 First-in-human phase I/IIa trial to evaluate the safety and initial clinical activity of DuoBody®-PD-L1× 4–1BB (GEN1046) in patients with advanced solid tumors	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AkF1pexMAQbMC
2085	Antibodies specific for claudin 6 (cldn6)	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AWAzi4Gm8nLoC
2086	Combination therapy involving antibodies against Claudin 18.2 for treatment of cancer	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A5MTHONV0fEkC
2087	T-cell responses induced by an individualized neoantigen specific immune therapy in post (neo) adjuvant patients with triple negative breast cancer	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AmUJArPsKIAAC
2088	Abstract LB-383: An RNA vaccine drives expansion and efficacy of claudin-CAR-T cells against solid tumors	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3A3bvyWxjaHKcC
2089	Abstract CT169: A phase Ia study to evaluate RO7198457, an individualized Neoantigen Specific immunoTherapy (iNeST), in patients with locally advanced or metastatic solid tumors	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aw0F2JDEymm0C
2090	Identification of surface associated antigen FLJ31461 for tumor diagnosis and therapy	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3APYBJJbyH-FwC
2091	Antibodies useful in cancer diagnosis	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AkWvqk_afx_IC
2092	Antibodies specific for claudin 6 (cldn6)	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AVN7nJs4JPk0C
2093	PLAC1 is essential for FGF7/FGFRIIIb-induced Akt-mediated cancer cell proliferation	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AsszUF3NjhM4C
2094	Antikūnai, specifiški claudin 6 (cldn6)	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AO0nohqN1r9EC
2095	Evaluation of systemic RNA-based cancer vaccine induced T-cell responses via mouse T-cell receptor (TCR) profiling.	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3APyEswDtIyv0C
2096	Imaging Immune activation by FDG PET/CT after systemic cancer vaccination therapy	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AQyXJ3EUuO1IC
2097	Abstract B62: Evaluation of systemic RNA-based cancer vaccine induced T-cell responses via mouse T-cell receptor (TCR) profiling	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AOBSaB-F7qqsC
2098	Monoclonal anti-GT 468 antibodies for treatment of cancer	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AjgBuDB5drN8C
2099	Tumor vaccination involving a humoral immune response against self-proteins	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AvDZJ-YLwNdEC
2100	CT301-A phase Ib study to evaluate RO7198457, an individualized Neoantigen Specific immunoTherapy (iNeST), in combination with atezolizumab in patients with locally advanced or …	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AAn6A6Jpfc1oC
2101	BNT162b vaccines are immunogenic and protect non-human primates against SARS-CoV-2	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3AEPG8bYD4jVwC
2102	Dexamethasone premedication suppresses vaccine-induced immune responses against cancer	2020	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3ANDuN12AVoxsC
2103	Claudin-6-specific immunoreceptors and t cell epitopes	2019	0	56	https://scholar.google.com/citations?user=sUY3B2sAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DsUY3B2sAAAAJ%26citation_for_view%3DsUY3B2sAAAAJ%3Aq-HalDI95KYC
2104	Identifying gene-disease associations using centrality on a literature mined gene-interaction network	2008	361	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Au5HHmVD_uO8C
2105	Text categorization with class-based and corpus-based keyword selection	2005	177	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A2osOgNQ5qMEC
2106	Semi-supervised classification for extracting protein interaction sentences using dependency parsing	2007	164	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AW7OEmFMy1HYC
2107	DeepDTA: deep drug–target binding affinity prediction	2018	142	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ADrOLxFoABAwC
2108	Michigan molecular interactions r2: from interacting proteins to pathways	2009	109	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Ad1gkVwhDpl0C
2109	PHISTO: pathogen–host interaction search tool	2013	93	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AMXK_kJrjxJIC
2110	Citation summarization through keyphrase extraction	2010	93	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AIjCSPb-OGe4C
2111	A review on computational systems biology of pathogen–host interactions	2015	89	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AIWHjjKOFINEC
2112	Introducing meta-services for biomedical information extraction	2008	87	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Au-x6o8ySG0sC
2113	Detecting speculations and their scopes in scientific text	2009	77	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A9yKSN-GCB0IC
2114	Supervised and unsupervised machine learning techniques for text document categorization	2004	77	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A_FxGoFyzp5QC
2115	Classification of Beta-Lactamases and Penicillin Binding Proteins Using Ligand-Centric Network Models.	2015	61	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AZeXyd9-uunAC
2116	Improving Named Entity Recognition for Morphologically Rich Languages using Word Embeddings	2014	60	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqxL8FJ1GzNcC
2117	BIOSSES: a semantic sentence similarity estimation system for the biomedical domain	2017	59	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A_u2aKJ9e-CoC
2118	Mining of vaccine-associated IFN-g gene interaction networks using the Vaccine Ontology	2011	56	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AzYLM7Y9cAGgC
2119	GLASS: a comprehensive database for experimentally validated GPCR-ligand associations	2015	49	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AhC7cP41nSMkC
2120	A comparative study of SMILES-based compound similarity functions for drug-target interaction prediction	2016	47	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A4JMBOYKVnBMC
2121	Co-occurrence network of reuters news	2008	40	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AUebtZRa9Y70C
2122	Literature-Based Discovery of IFN-𝛾 and Vaccine-Mediated Gene Interaction Networks	2010	33	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqjMakFHDy7sC
2123	Identification of fever and vaccine-associated gene interaction networks using ontology-based literature mining	2012	32	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ALkGwnXOMwfcC
2124	BioCreative V BioC track overview: collaborative biocurator assistant task for BioGRID	2016	30	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AYFjsv_pBGBYC
2125	Identifying topics in microblogs using Wikipedia	2016	24	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Aj3f4tGmQtD8C
2126	A Graph-based Approach for Contextual Text Normalization	2014	24	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AM3ejUd6NZC8C
2127	Extracting interacting protein pairs and evidence sentences by using dependency parsing and machine learning techniques	2007	23	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AYsMSGLbcyi4C
2128	Development and application of an interaction network ontology for literature mining of vaccine-associated gene-gene interactions	2015	22	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AL8Ckcad2t8MC
2129	BOUNCE: Sentiment Classification in Twitter using Rich Feature Sets	2013	21	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AZph67rFs4hoC
2130	U-Compare bio-event meta-service: compatible BioNLP event extraction services	2011	21	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ASe3iqnhoufwC
2131	Turkish tweet sentiment analysis with word embedding and machine learning	2017	19	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ApZ2CosqRuhkC
2132	Bayesian pathway analysis of cancer microarray data	2014	18	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A_kc_bZDykSQC
2133	Word polarity detection using a multilingual approach	2013	17	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A0EnyYjriUFMC
2134	Supervised classification for extracting biomedical events	2009	17	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AUeHWp8X0CEIC
2135	Classification of skewed and homogenous document corpora with class-based and corpus-based keywords	2006	16	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ATyk-4Ss8FVUC
2136	Overview of the BioCreative VI Precision Medicine Track: mining protein interactions and mutations for precision medicine	2019	15	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Aqt-6tCTBDsQC
2137	Bacteria biotope detection, ontology-based normalization, and relation extraction using syntactic rules	2013	15	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A8k81kl-MbHgC
2138	A novel methodology on distributed representations of proteins using their interacting ligands	2018	14	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AwE8AsS3ykUMC
2139	Social network of co-occurrence in news articles	2004	14	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AY0pCki6q_DkC
2140	Linking entities through an ontology using word embeddings and syntactic re-ranking	2019	12	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AnnITTVbzT6kC
2141	Ontology-based literature mining of E. coli vaccine-associated gene interaction networks	2017	12	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A4WewbtJKmRkC
2142	Exploring chemical space using natural language processing methodologies for drug discovery	2020	10	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AlL5f5cZgq8MC
2164	Machine learning-based identification and rule-based normalization of adverse drug reactions in drug labels	2019	3	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A5N-NJrZHaHcC
2165	Turkish tweet classification with transformer encoder	2019	3	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AMDQ-9Oe3GGUC
2166	Automated neuroanatomical relation extraction: a linguistically motivated approach with a PVT connectivity graph case study	2016	3	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ABqipwSGYUEgC
2167	Extension of the Interaction Network Ontology for literature mining of gene-gene interaction networks from sentences with multiple interaction keywords	2015	3	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AHDshCWvjkbEC
2168	Analyzing stemming approaches for turkish multi-document summarization	2014	3	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AmaZDTaKrznsC
2169	Türkçe Soru Cevaplama Sistemlerinde Kural Tabanlı Odak Çıkarımı Rule-Based Focus Extraction in Turkish Question Answering Systems	2014	3	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AmB3voiENLucC
2170	N-gram Parsing for Jointly Training a Discriminative Constituency Parser	2013	3	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AKlAtU1dfN6UC
2171	System and method for generating queries	2012	3	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AblknAaTinKkC
2172	Analyzing ELMo and DistilBERT on Socio-political News Classification	2020	2	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Am44aUaJR3ikC
2173	BOUN-ISIK participation: an unsupervised approach for the named entity normalization and relation extraction of bacteria biotopes	2019	2	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Afc7zyzPI2QAC
2174	Improving the annotations in the Turkish universal dependency treebank	2019	2	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Ave7iT2ZEuL4C
2175	A closed-domain question answering framework using reliable resources to assist students	2018	2	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A0iM-huCvmk0C
2176	Text classification using ontology and semantic values of terms for mining protein interactions and mutations	2017	2	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqwOXE0mbtu4C
2177	Retrieving Passages Describing Experimental Methods using Ontology and Term Relevance based Query Matching	2015	2	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ATQgYirikUcIC
2178	PREDICTING GENE INTERACTIONS OF TYROSINE KINASE INHIBITORS INDUCED CARDIOTOXICITY WITH THE ONTOLOGY OF ADVERSE EVENTS-ASSISTED BIOINFORMATICS APPROACH.: PII-021	2014	2	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ARHpTSmoSYBkC
2179	Unsupervised Machine Learning Techniques For Text Document Clustering	2004	2	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AxEMdJR0kL_sC
2180	Vapur: A Search Engine to Find Related Protein-Compound Pairs in COVID-19 Literature	2020	1	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AC-SEpTPhZ1wC
2181	Identifying Image Related Sentences in News Articles	2019	1	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Agxb_f1p9zx4C
2182	Description of the BOUN System for the Trilingual Entity Detection and Linking Tasks at TAC KBP 2017.	2017	1	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AqQc65DSaYXMC
2183	Expanding Machine Translation Training Data with an Out-of-Domain Corpus using Language Modeling based Vocabulary Saturation	2014	1	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A4DMP91E08xMC
2184	Mikroblog İleti Kümelerinde Konu Algılama Yönteminin İncelenmesi	2013	1	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Al7iSsH4_Im4C
2185	The RELX Dataset and Matching the Multilingual Blanks for Cross-Lingual Relation Classification	2020	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AQ17yWvk9gpwC
2186	A Hybrid Approach to Dependency Parsing: Combining Rules and Morphology with Deep Learning	2020	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AHevVnK7dagcC
2187	Resources for Turkish Dependency Parsing: Introducing the BOUN Treebank and the BoAT Annotation Tool	2020	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Aw_ORaKkuc5QC
2188	BOUN-REX at CLEF-2020 ChEMU Task 2: Evaluating Pretrained Transformers for Event Extraction	2020	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ANObE97JSLecC
2189	An extended overview of the CLEF 2020 ChEMU Lab	2020	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AQZWLLlSfqgYC
2190	Cluster-based mention typing for named entity disambiguation	2020	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A4pF9x-cDGsoC
2191	Statistical representation models for mutation information within genomic data	2019	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A1pC5hbHeJ6IC
2192	Ignet: A centrality and INO-based web system for analyzing and visualizing literature-mined networks	2016	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3ARGFaLdJalmkC
2193	A systems pharmacology approach to model tyrosine kinase inhibitor‐induced cardiotoxicity gene interaction networks (844.17)	2014	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3Ae5wmG9Sq2KIC
2194	Self-training a Constituency Parser using N-gram Trees	2014	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AYOwf2qJgpHMC
2195	PHISTO: A New Web Platform for Pathogen-Human Interactions	2013	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AkNdYIx-mwKoC
2196	Identification of fever and vaccine-associated gene interaction networks using ontology-based literature mining	2012	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A6LV2YwJzdtgC
2197	Text and Network Mining for Literature-Based Scientific Discovery in Biomedicine.	2010	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AWF5omc3nYNoC
2198	Identifying Common Pathogenesis of Diseases Using Literature Mined Gene Interactions	2010	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3A3wLP7v6BnpwC
2199	Team: CONDL	2010	0	40	https://scholar.google.com/citations?user=8Kn4-EsAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3D8Kn4-EsAAAAJ%26citation_for_view%3D8Kn4-EsAAAAJ%3AwTekDMGr9GkC
2585	Hierarchical mixtures of generators for adversarial learning	2019	3	33	https://scholar.google.com/citations?user=B23iqYwAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DB23iqYwAAAAJ%26citation_for_view%3DB23iqYwAAAAJ%3Au-x6o8ySG0sC
2586	DeepSym: Deep Symbol Generation and Rule Learning from Unsupervised Continuous Robot Interaction for Planning	2020	0	33	https://scholar.google.com/citations?user=B23iqYwAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DB23iqYwAAAAJ%26citation_for_view%3DB23iqYwAAAAJ%3A9yKSN-GCB0IC
2587	Hierarchical Multitask Learning Approach for BERT	2020	0	33	https://scholar.google.com/citations?user=B23iqYwAAAAJ#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26user%3DB23iqYwAAAAJ%26citation_for_view%3DB23iqYwAAAAJ%3Ad1gkVwhDpl0C
\.


--
-- Data for Name: api_rating; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_rating (id, created, rating, from_user_id, to_user_id) FROM stdin;
1	2020-12-29 10:54:39.540005+00	6	27	49
2	2020-12-29 12:11:47.689028+00	8	26	49
3	2021-01-23 13:36:47.24726+00	8	51	30
4	2021-01-25 21:34:45.873043+00	10	74	75
5	2021-01-25 21:40:04.271565+00	4	74	71
6	2021-01-25 21:42:26.578117+00	2	73	71
7	2021-01-25 21:43:25.531784+00	10	73	74
8	2021-01-26 09:23:42.027174+00	8	79	75
12	2021-01-26 09:41:00.289956+00	10	33	80
13	2021-01-26 09:43:19.705999+00	8	40	80
17	2021-01-26 09:58:30.612098+00	10	45	30
18	2021-01-26 10:11:22.268641+00	2	75	71
19	2021-01-28 11:41:23.280807+00	10	29	31
20	2021-01-28 12:47:51.324618+00	10	29	85
21	2021-01-28 12:50:28.284281+00	10	85	29
22	2021-01-30 08:54:22.160943+00	10	89	76
23	2021-01-30 12:55:00.600325+00	8	91	49
24	2021-01-30 13:41:56.891284+00	8	90	31
26	2021-01-30 17:27:59.731786+00	2	93	89
27	2021-01-30 17:34:42.656291+00	6	93	76
28	2021-01-30 23:05:30.455962+00	10	98	96
25	2021-01-30 17:18:23.609635+00	10	95	93
\.


--
-- Data for Name: api_report; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_report (id, report_type, description, "timestamp", reported_user_id) FROM stdin;
1	Spam	Hileeeeee	2021-01-25 21:39:29.307256+00	71
2	Spam	Hileeeeee	2021-01-25 21:39:30.157146+00	71
3	Spam	He stole my article!!!	2021-01-26 10:11:41.600729+00	71
4	Spam	He has stolen my project	2021-01-26 10:44:15.75908+00	71
\.


--
-- Data for Name: api_tag; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.api_tag (id, name, color) FROM stdin;
9	immunology	2
12	wireless	0
13	network	4
15	5g	7
16	multi-armed bandit	5
17	4g	4
19	covid-19	3
21	geography	1
22	turkey	0
23	tethyan evolution	5
24	positive psychology	6
25	nlp	6
26	text mining	5
27	ml	5
28	ai	9
29	physics	2
30	Machine Learning	1
31	Neuroscience	2
32	Robotics	3
33	Psychology	4
35	Bayesian Mathematics	6
36	game theory	3
37	peer effects	4
38	mathematics	3
39	medical	9
40	management	4
41	university	4
42	ranking	9
43	vaccine	9
44	mrna	3
45	corona	2
46	mutation	5
47	cancer	7
48	antibody	0
49	imabs	3
50	3-d	6
51	statistics	1
52	signal	0
53	computer science	3
54	nanoscale	1
55	diet	0
56	health	3
57	flying experience	0
58	cardio	9
59	university rankings	4
60	research	8
61	number theory	0
62	cognitive psychology	1
63	education	2
64	computer networks	5
65	artificial intelligence	3
66	python	7
67	body area networks	4
68	c++	9
69	martial arts	0
70	data science	6
71	cycling	9
72	running	7
73	sports	5
74	e-sports	4
75	business	5
76	football	2
77	federated learning	0
78	Paleolithic Archaeology	3
79	Archeology	8
80	particle physics	8
81	optimization	8
82	integer programming	2
83	linear programming	3
84	graph theory	0
85	computer vision	8
86	c	8
87	astrophysics	3
88	quantum	9
89	clinical psychology	9
90	law	1
91	civil rights	9
92	politics	1
93	tumor	0
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add event	7	add_event
26	Can change event	7	change_event
27	Can delete event	7	delete_event
28	Can view event	7	view_event
29	Can add example	8	add_example
30	Can change example	8	change_example
31	Can delete example	8	delete_example
32	Can view example	8	view_example
33	Can add project	9	add_project
34	Can change project	9	change_project
35	Can delete project	9	delete_project
36	Can view project	9	view_project
37	Can add tag	10	add_tag
38	Can change tag	10	change_tag
39	Can delete tag	10	delete_tag
40	Can view tag	10	view_tag
41	Can add profile	11	add_profile
42	Can change profile	11	change_profile
43	Can delete profile	11	delete_profile
44	Can view profile	11	view_profile
45	Can add milestone	12	add_milestone
46	Can change milestone	12	change_milestone
47	Can delete milestone	12	delete_milestone
48	Can view milestone	12	view_milestone
49	Can add file	13	add_file
50	Can change file	13	change_file
51	Can delete file	13	delete_file
52	Can view file	13	view_file
53	Can add collaboration request	14	add_collaborationrequest
54	Can change collaboration request	14	change_collaborationrequest
55	Can delete collaboration request	14	delete_collaborationrequest
56	Can view collaboration request	14	view_collaborationrequest
57	Can add collaboration invite	15	add_collaborationinvite
58	Can change collaboration invite	15	change_collaborationinvite
59	Can delete collaboration invite	15	delete_collaborationinvite
60	Can view collaboration invite	15	view_collaborationinvite
61	Can add follow request	16	add_followrequest
62	Can change follow request	16	change_followrequest
63	Can delete follow request	16	delete_followrequest
64	Can view follow request	16	view_followrequest
65	Can add following	17	add_following
66	Can change following	17	change_following
67	Can delete following	17	delete_following
68	Can view following	17	view_following
69	Can add rating	18	add_rating
70	Can change rating	18	change_rating
71	Can delete rating	18	delete_rating
72	Can view rating	18	view_rating
73	Can add comment	19	add_comment
74	Can change comment	19	change_comment
75	Can delete comment	19	delete_comment
76	Can view comment	19	view_comment
77	Can add Token	20	add_token
78	Can change Token	20	change_token
79	Can delete Token	20	delete_token
80	Can view Token	20	view_token
81	Can add token	21	add_tokenproxy
82	Can change token	21	change_tokenproxy
83	Can delete token	21	delete_tokenproxy
84	Can view token	21	view_tokenproxy
85	Can add notification	22	add_notification
86	Can change notification	22	change_notification
87	Can delete notification	22	delete_notification
88	Can view notification	22	view_notification
89	Can add publication	23	add_publication
90	Can change publication	23	change_publication
91	Can delete publication	23	delete_publication
92	Can view publication	23	view_publication
93	Can add report	24	add_report
94	Can change report	24	change_report
95	Can delete report	24	delete_report
96	Can view report	24	view_report
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
91	pbkdf2_sha256$216000$iatvqWldIAjI$G3wf1QqkrOTaqsanQBrDpxPsVTmO0Xl1oPyJ8U+fzDQ=	2021-01-30 12:45:13.875859+00	f	busragul			bsgldrl@hotmail.com	f	t	2021-01-30 12:44:04.630572+00
93	pbkdf2_sha256$216000$hzlyoY352FPK$t/9Tq0TZ+pzgplCsVuQl1oxp5O6gDttsdYyOM6FjgSQ=	2021-01-30 16:42:13.089152+00	f	Sboyd			xiwiv43142@lovomon.com	f	t	2021-01-30 16:41:55.383636+00
33	pbkdf2_sha256$216000$ICtuHeA8KMmh$Vsfi5exsMlOU8P71asjtyw3X6PqHnchebCacKO6+CLQ=	\N	f	keiichiT			tsuchiya@gmail.com	f	t	2020-12-28 19:53:30.14027+00
101	pbkdf2_sha256$216000$NCaWJkoakNI1$aEkp3pPnbLSZG91WLlVBMUJMMIM/4ICCEuCX2tuMQuc=	2021-01-31 15:56:13.602393+00	f	arthurjohnson			mehese1466@jentrix.com	f	t	2021-01-31 15:55:47.810801+00
95	pbkdf2_sha256$216000$RXhwNeIf5TUQ$WHnoJkvFYXWTxVWCM/6kDoaSco11k0wTwExGaYBW4aE=	2021-01-30 17:02:40.63668+00	f	Rez			lorajo2531@alicdh.com	f	t	2021-01-30 17:02:04.28972+00
34	pbkdf2_sha256$216000$jHQREuwS1JDR$Q1OxMejckdaw/h2RFrb6ycScvQ8iMS//V1pISXmFRxE=	\N	f	cerenoz			cerenoz@example.com	f	t	2020-12-28 21:53:41.288702+00
97	pbkdf2_sha256$216000$p3JW6JSUqvGV$brRaNxoEdpuxT8eb+Y9UUz+7cVzZp+IOwkfFtjdE7cg=	\N	f	alicandoymaz			vakoto4926@botfed.com	f	f	2021-01-30 22:54:49.044793+00
35	pbkdf2_sha256$216000$oorHDJTZRKHE$BRbAUTnI7+I/PaBsgeeaAfdgyL+tLRPIXTfo3Fltclo=	\N	f	hakanmutlu			hakanmutlu@mail.com	f	t	2020-12-28 23:01:55.806289+00
99	pbkdf2_sha256$216000$pc1t9bATY2wy$/ZJlxyblxZQUPxvio7fC4piDysDjua//s7DooKqK5W8=	2021-01-31 15:52:55.512249+00	f	emmasmith			lepalew373@poetred.com	f	t	2021-01-31 15:47:30.541594+00
36	pbkdf2_sha256$216000$vNHZ824cAcsd$eVsFMNcy5mqXPzj5VE7UusGaWnrxvgWEvbnq+Bl4+MY=	\N	f	ilberortayli			ilberortayli@mail.com	f	t	2020-12-28 23:39:19.983472+00
103	pbkdf2_sha256$216000$OEwkwgwTMm3x$jnHZkJVwRDyOYNLMsVtok32hs6PKYYOySZnckXvyEsA=	2021-01-31 15:58:35.122453+00	f	paulgarcia			tajanak695@poetred.com	f	t	2021-01-31 15:58:17.142365+00
1	pbkdf2_sha256$216000$1DrSwCCuqjmH$zYR6HsSHLqYw30+uDRWXlhQ9NLH9K2vQyxVxrwQiX/c=	2021-01-31 16:32:24.464566+00	t	admin			bounswe2020group3@gmail.com	t	t	2020-12-26 11:26:39.536288+00
40	pbkdf2_sha256$216000$4OgACw8d0LrD$2tT1T0xYnHSpu0547TfPcrnnqhGQr7ThdlhH64xXHC4=	\N	f	hakanyilmaz			hakan@demo.com	f	t	2020-12-29 08:45:02.759891+00
26	pbkdf2_sha256$216000$C6nQmnK8ukW7$gO9Y/yVb+IHAAjLtDb7At2ofoDt9wnxhcXMyqSscIF4=	\N	f	furkancan			f.cansever67@gmail.com	f	t	2020-12-28 19:25:37.795325+00
27	pbkdf2_sha256$216000$NRNyygRUPv3E$sfGjYwxKJiW6RMQ/Bx94gFnYh8kHzqN2h0+WOLXezQw=	\N	f	ozlemtureci_biontech			ozlem@gmail.com	f	t	2020-12-28 19:27:05.579169+00
28	pbkdf2_sha256$216000$FqyhUGece83w$wybr7ok42tcpcxdVSGfPUasX7k89JbxbwTSwhhRzcV0=	\N	f	keremaltin			keremaltin@mail.com	f	t	2020-12-28 19:28:30.58654+00
29	pbkdf2_sha256$216000$NipPMj2GQt0S$chYtfYmdyvTdFIQatvIuHkIU0WXIREz6rnGM2opjFBo=	\N	f	adil			an_celik4444@windowslive.com	f	t	2020-12-28 19:29:43.593412+00
30	pbkdf2_sha256$216000$uWDONBIv5v4n$fGfwglZPYCWMX8fC+szCKLs2cdxTI6my+kts81ns1cc=	\N	f	pelinyagiz			pelin@example.com	f	t	2020-12-28 19:32:45.076784+00
31	pbkdf2_sha256$216000$101aewDsbDZG$rcmHs44SozQSUgI0ocfL6D8nAWXYlBBjuY5lcGFvoSM=	\N	f	celalsengor			celalsengor@mail.com	f	t	2020-12-28 19:36:36.402282+00
51	pbkdf2_sha256$216000$9MGXuvcSN2vR$SlP2WIx7UBziKFN3yjGLmLxJfscMX5afnYhozOhXCfk=	\N	f	bsgldrl			bsgldrl@example.com	f	t	2021-01-17 20:36:03.95875+00
41	pbkdf2_sha256$216000$s9HiMFiv0ywp$yrLgZLs9C02Mm00ovlUyNRZag2QhkiKlKaMeP0AlNoQ=	\N	f	mnewman			vasiw79567@j24blog.com	f	t	2020-12-29 09:02:36.1464+00
42	pbkdf2_sha256$216000$VEQOe7z7Fq5N$0ABl1uNACBKqf+OVZsGLmo/ai+dTjBsmEAokJ50jdF8=	\N	f	mjackson			vasiw79567@j24blog.com	f	t	2020-12-29 09:17:43.054732+00
43	pbkdf2_sha256$216000$5F3Qp8egH5Ho$iFlwL5wwx/x923pqMiAqN1Brw0KYnvk99kXBCEnOLFg=	\N	f	azizsancar			azizsancar@gmail.com	f	t	2020-12-29 09:29:51.113857+00
45	pbkdf2_sha256$216000$7Rj6yaZkDqhM$3+Miz1aSSpqA/WHq4bhibcVmEQUA5yKsBiv1a1cZn70=	\N	f	mhrfky			mhrfky@gmail.com	f	t	2020-12-29 09:46:42.638849+00
49	pbkdf2_sha256$216000$2uZ5dbDNXH1U$BfIEV2QZ2nCQsiYEjL+1roebAMBNt9N4HdHN5FBkREg=	\N	f	ugursahin			ugursahin@gmail.com	f	t	2020-12-29 10:48:54.765241+00
56	pbkdf2_sha256$216000$ECdsNfrcLKh9$VPdsXzLahUdA1Kr5Q+hciB5zD/6Y/TFryHyZSXv8sWQ=	\N	f	neriman				f	t	2021-01-24 15:16:26.087007+00
61	pbkdf2_sha256$216000$hZ1tivVLKqky$nSNa84DpUTPgLHixEzEu0rkmDbZ+FuE0G+2ilR/on+Q=	\N	f	hardy			ghardy@gmail.com	f	t	2021-01-24 18:32:16.779929+00
71	pbkdf2_sha256$216000$ommCMACG8Jpc$nFRZ7BTV6eVFYAvrTrg5II1yTdd2JXtkOy1x6qNbnoY=	2021-01-25 20:04:51.974961+00	f	blue			drkocaaga@gmail.com	f	t	2021-01-25 19:59:54.779812+00
74	pbkdf2_sha256$216000$M5700F8oay4H$KlrlPb91vSeOWMsiwQBPJRSDM2i76vbc8OV8Uu2GNRA=	2021-01-25 20:23:26.533779+00	f	ttugcu			catlab753@gmail.com	f	t	2021-01-25 20:22:45.391749+00
73	pbkdf2_sha256$216000$Wmo1TAqtKt7e$sK/YQpDvLqzQ7aVrmCnL+aw5LdntMyWDO9iPFMlUgDQ=	2021-01-25 20:16:10.293347+00	f	drmehmetoz			zdgficxyfzmcwngwsl@wqcefp.com	f	t	2021-01-25 20:14:28.102196+00
76	pbkdf2_sha256$216000$yMLSB5mbWF7S$FQavXYS2mSdizeywae8bgtWC5jmqVqP2CiDiniufqOk=	2021-01-25 21:45:30.739335+00	f	liberbey			bbasmakpotm@gmail.com	f	t	2021-01-25 21:44:53.534328+00
75	pbkdf2_sha256$216000$KxQSlROnQUFu$QeXhPBL7eWUsr0cKco6WG7gTE+8xAcb9c2kvKpCA9/s=	2021-01-25 20:51:58.005466+00	f	baris_gok			wniebbkhylwbkxtkjd@twzhhq.com	f	t	2021-01-25 20:51:44.424679+00
77	pbkdf2_sha256$216000$ygEdWniMSZz0$D+8xDAoXKH1MjG2t1UF3uDHO7QT+fagqaQ8f5gem7gA=	2021-01-25 22:41:53.34023+00	f	Ramanujan			tiloh66700@1adir.com	f	t	2021-01-25 22:41:30.418484+00
79	pbkdf2_sha256$216000$FAYj2aZbgmnR$vSPLeZGfgSCt/gXQWsgNT8I/BYDrAdobNMdA0O3JapA=	2021-01-26 09:05:26.103924+00	f	lale_dere			pygiwbzszdwvdvcgcu@twzhhq.com	f	t	2021-01-26 09:05:13.586216+00
80	pbkdf2_sha256$216000$fXfw9o8esMQ5$Z7QPQgzwl38OYk/8/K1uW5UrMKXpeC6CRY883dcDLh4=	2021-01-26 09:11:34.114328+00	f	oliviawilson			tivamek945@eamarian.com	f	t	2021-01-26 09:11:14.276157+00
82	pbkdf2_sha256$216000$fMOD6zvibmqP$7hKX9baDF1Lt0Kbnsesja68SWypCOB05nFv6cJyZfL0=	2021-01-26 09:31:27.896864+00	f	oliviavilson			surdopurka@nedoz.com	f	t	2021-01-26 09:31:01.354296+00
90	pbkdf2_sha256$216000$kRjgSz1Ll0FL$Iyl9ckmM3gq5/wVSxoQGNxrxw3aBGZ5DLgeL9KOYN0U=	\N	f	baransoy			brnsy@example.com	f	t	2021-01-30 12:19:30+00
83	pbkdf2_sha256$216000$8Wet7xJP9wuD$ffVkkrZqgBnVQ5908eNueV7eGqPjdLzkbzohbAsM1ZE=	2021-01-27 10:53:03.848849+00	f	ahmet451			fibay82706@aiclbd.com	f	t	2021-01-27 10:52:32.712746+00
84	pbkdf2_sha256$216000$Qf6OON134oYj$JrkNULejsURTtOmYMJPE3wREeRpzfnCKH3OHYgwxeYI=	2021-01-27 11:13:50.856965+00	f	chris451			dertimarka@nedoz.com	f	t	2021-01-27 11:13:21.583619+00
85	pbkdf2_sha256$216000$q1P4SU9HV5h1$JoA5Q0jUw1ZXqy33+fMf7SMF5ePZQ7I6rSlpPCLzWC8=	2021-01-28 12:28:33.759986+00	f	karrigancs			an_celik4444@windowslive.com	f	t	2021-01-28 12:19:32.190539+00
92	pbkdf2_sha256$216000$EHW0FamB1Zse$hpXLhZPXn7MAT0OfValHja4enc0WG3xRAOaQ+Pgk1L8=	\N	f	jamesedin			jamesedin@example.com	f	t	2021-01-30 14:28:04+00
86	pbkdf2_sha256$216000$XGogCqHo696k$2oTwSuT3YFQFiXfooRgBe/nr9mDqs7FIuNNc/lwrFxk=	2021-01-28 12:56:57.6453+00	f	tursun			an_celik4444@windowslive.com	f	t	2021-01-28 12:56:33.381801+00
94	pbkdf2_sha256$216000$WsauTVZYTmD4$CwvHTSrL7GLZTjOGVCzltFs3jUGTO/ARJwXwM+x0uj4=	2021-01-30 16:51:55.179341+00	f	Nicholas			kawov98309@poetred.com	f	t	2021-01-30 16:51:14.156275+00
89	pbkdf2_sha256$216000$VfHN0exeQNoV$7QHdxyRTmc6O+wXTkcRLiRrccrSiiAgvl/MzM/+ebdE=	2021-01-30 08:46:10.094485+00	f	bariss			barisbasmak@gmail.com	f	t	2021-01-30 08:32:45.238269+00
96	pbkdf2_sha256$216000$DMIeQoyIqm8T$rsxJIH3EFYipVLZBBCJMG1YbvLcO1HCdofyJGnFD5h0=	2021-01-30 22:47:02.572178+00	f	leylaleyla			vakoto4926@botfed.com	f	t	2021-01-30 22:46:25.864496+00
98	pbkdf2_sha256$216000$3l1wFICOQvNu$nmx2JmvQc2s+P/HWY5eaWhAPLyRNybFodlxRqkOt8H0=	2021-01-30 22:58:44.175399+00	f	tuncyılmaz			vakoto4926@botfed.com	f	t	2021-01-30 22:58:12.903582+00
100	pbkdf2_sha256$216000$6DtkGrH5aHwM$PL8ZHSoMaUBkyUIOpHSRVBp01kVPwEaGIPeK5wvWn0o=	2021-01-31 15:55:01.976849+00	f	jadewilliams			peyiho3631@laklica.com	f	t	2021-01-31 15:54:22.410675+00
102	pbkdf2_sha256$216000$5SVim1tzvxYe$WA8VmFSNA0+pkwTRV3nFlbhziMYGbQFmDawygoWbfts=	\N	f	hugoanderson			pekejo9865@lovomon.com	f	t	2021-01-31 15:57:26+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
cbe91313577bd77c7786e5d968b8d467aea90afb	2020-12-28 18:38:02.060878+00	1
794b225f2ef27b02bde28538111abce5f60d2e1e	2020-12-28 19:25:53.942062+00	26
47fd782587f5bbe785e82f689a81cf87fefd5b1c	2020-12-28 19:27:30.042676+00	27
2b8828dffabfb091ac6cf522b01454f1f4e73a53	2020-12-28 19:28:41.174484+00	28
4d9f6b94838b712b67da3745fa2e624dbdde71e4	2020-12-28 19:30:07.532047+00	29
aa35e6ea33c4d6ddc3fb1fa21bd636392238ef4c	2020-12-28 19:33:24.694672+00	30
4220e2e34070928556406749d3fd8a3520b515d1	2020-12-28 19:36:43.67492+00	31
720fd1f380f31ccb6ff73b97d81fdf4e85e71da5	2020-12-28 19:53:55.89163+00	33
3949104338430668a7ccc0af7bb526fb2f59e802	2020-12-28 21:54:00.200901+00	34
76f0d0f4dcc598cc3e88777dabc2c5273c5bd918	2020-12-28 23:02:45.520814+00	35
8ebce9ce1e4d310315fba0cce887f4a72811ed96	2020-12-28 23:39:28.897759+00	36
8c5c6d818030ea7fc5b4abbef3cdca33175b2705	2020-12-29 08:59:23.387187+00	40
877b86bdd7476d3612bea727e5ab09e6fba36887	2020-12-29 09:02:52.630322+00	41
0b88c4aed8ea384a15f185c5abd345b5c6506d2b	2020-12-29 09:18:00.496624+00	42
470cb42573748bd0ebde667f53ce0eb62cd71acb	2020-12-29 09:30:14.440085+00	43
b4bf273a3853e2cc192a1872f968cece33f96f42	2020-12-29 09:46:54.628504+00	45
d6405b109b284059e7773304990488f8e3458e3e	2020-12-29 10:49:22.761207+00	49
2c953e672736dc2f686b7bda52f58156166f842e	2021-01-17 20:36:19.950567+00	51
356da06b92aafff36d99a74cb18fdc4a7c4b166a	2021-01-24 15:18:24.184836+00	56
03e7d057ee3e76a9f651a8ebad747e97fc158486	2021-01-24 18:35:51.71543+00	61
1f8faf7f534cfe4aef928f48cc6f12c8d03006ee	2021-01-25 20:00:10.211487+00	71
d021a947d8a53c5b45819d50689c6c100b353d00	2021-01-25 20:16:21.920861+00	73
bc45c226e046eb9e48b242cbbf7599fa855fffc2	2021-01-25 20:23:56.439267+00	74
f9729ac28bd9dd6ab8ad417883fe4e84d763064f	2021-01-25 20:52:14.561451+00	75
ad2b6f6728c31bdbeda31e1d953a15b0a0b8b7e1	2021-01-25 21:45:51.774745+00	76
7f54faea564b29c7e2a814575b2eb0a0faebd2fc	2021-01-25 22:41:57.989972+00	77
ee8f2d3a831b39d9cb021104e3d51d99b2acb3ec	2021-01-26 09:05:41.250523+00	79
ee0ea87c3b8a23a27a7e4fe604238018ee6e207b	2021-01-26 09:11:46.282155+00	80
bb1e9cbffe0580aefef109cf86d84ed7633532ae	2021-01-26 09:32:02.811465+00	82
38cc67a4e92e58ee4cb216bf10105325f5b001eb	2021-01-27 10:53:12.400679+00	83
7139b9607c9b70261ea281c66994887213fe81dd	2021-01-27 11:14:00.935942+00	84
03db4ba9101f4f8aa9655ebe873ba540c379bfc1	2021-01-28 12:21:18.846293+00	85
a5aad2a9e66f078396e62108f5bdb89f3bf2b491	2021-01-28 12:57:07.495495+00	86
c3bb0f358d882dd19d6b6fb9c25620e16cbc0c10	2021-01-30 08:32:58.455978+00	89
df11698211a09b6dc0b6c7e4a82653316c31e5d8	2021-01-30 12:21:50.504644+00	90
2ed814fa8163e7cd8e9d2c725cd1281cbe754c7c	2021-01-30 12:45:19.695099+00	91
456ce054b8d9894da47a209af000c648767b95b2	2021-01-30 14:28:15.577715+00	92
28c7ef622a6ea003945a63ee6bbc9e19ccfb53a4	2021-01-30 16:42:06.247057+00	93
dac368ebd2569998719efd0093c153669b303295	2021-01-30 16:52:07.139613+00	94
488a49780a543f0d60b2aa7058cca349271324e4	2021-01-30 17:02:18.844181+00	95
96adfa7a9ecf68bcca2561c022063bc1afcbf1c4	2021-01-30 22:46:44.239406+00	96
2c6f4869fc3e2e27fd126563904528b6eea1155c	2021-01-30 22:55:13.975918+00	97
06dd431a2de22101fbbd7bd8102a5b245e9b3cb2	2021-01-30 22:58:55.300202+00	98
25b41f531bbb4c8912b67340967a2383efc23f25	2021-01-31 15:47:42.006749+00	99
4acc104169a94197a05c286a6b8d0ad5da582b7b	2021-01-31 16:10:42.920299+00	100
da846aa416da5a99bbfc90d5f006469454a50155	2021-01-31 16:18:27.582093+00	101
4427c46a120d4bfa3af1f2d40ced3299c72f01bb	2021-01-31 16:28:23.45256+00	102
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-12-28 13:09:59.790645+00	7	alifurkanbudak	3		4	1
2	2020-12-28 13:15:02.758768+00	9	alifurkanbudak	3		4	1
3	2020-12-28 13:18:10.976739+00	2	yusuf6	3		4	1
4	2020-12-28 13:18:43.075348+00	10	ali.budak1	3		4	1
5	2020-12-28 13:26:12.132104+00	11	ali.budak1	3		4	1
6	2020-12-28 13:26:12.157699+00	6	cansever	3		4	1
7	2020-12-28 13:26:12.182345+00	5	furkan	3		4	1
8	2020-12-28 13:26:12.207851+00	4	furkancan	3		4	1
9	2020-12-28 13:26:12.232656+00	12	yusuf	3		4	1
10	2020-12-28 18:18:00.587499+00	20	alifurkan	3		4	1
11	2020-12-28 19:18:10.509411+00	21	alifurkan	3		4	1
12	2020-12-28 19:18:10.538508+00	22	alifurkanbudak	3		4	1
13	2020-12-28 19:18:10.566263+00	19	f.cansever	3		4	1
14	2020-12-28 19:18:10.593744+00	14	furkancansever	3		4	1
15	2020-12-28 19:18:10.621372+00	17	liberbey	3		4	1
16	2020-12-28 19:18:10.648897+00	18	liberbey1	3		4	1
17	2020-12-28 19:18:10.676298+00	16	ozlem_tureci	3		4	1
18	2020-12-28 19:18:10.703622+00	15	yusuf	3		4	1
19	2020-12-28 19:18:37.072041+00	25	liberbey11	3		4	1
20	2020-12-28 19:46:04.648909+00	32	han123	3		4	1
21	2020-12-28 19:52:48.638631+00	4	Event object (4)	2	[{"changed": {"fields": ["Title"]}}]	7	1
22	2020-12-29 10:42:42.553996+00	6	Event object (6)	2	[{"changed": {"fields": ["Deadline", "Date"]}}]	7	1
23	2021-01-23 13:31:43.687612+00	34	Tag object (34)	3		10	1
24	2021-01-24 13:55:52.646553+00	20	Following object (20)	1	[{"added": {}}]	17	1
25	2021-01-24 15:16:26.638535+00	56	neriman	1	[{"added": {}}]	4	1
26	2021-01-24 15:16:59.868733+00	47	Profile object (47)	1	[{"added": {}}]	11	1
27	2021-01-24 17:09:57.045636+00	58	alifurkanbudak	3		4	1
28	2021-01-24 17:09:57.078384+00	57	Ali Furkan Budak	3		4	1
29	2021-01-25 19:03:07.585907+00	60	alifurkanbudak	3		4	1
30	2021-01-25 19:43:42.868459+00	68	alifurkanbudak	3		4	1
31	2021-01-30 11:38:32.826033+00	21	Profile object (21)	2	[{"changed": {"fields": ["Birthday"]}}]	11	1
32	2021-01-30 11:41:22.494536+00	24	Profile object (24)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
33	2021-01-30 11:42:01.887839+00	27	Profile object (27)	2	[{"changed": {"fields": ["Interests"]}}]	11	1
34	2021-01-30 11:43:38.592786+00	28	Profile object (28)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
35	2021-01-30 11:44:56.59364+00	29	Profile object (29)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
36	2021-01-30 11:45:31.912034+00	30	Profile object (30)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
37	2021-01-30 11:45:53.432991+00	30	Profile object (30)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
38	2021-01-30 11:46:58.640691+00	33	Profile object (33)	2	[{"changed": {"fields": ["Expertise", "Interests", "Affiliations"]}}]	11	1
39	2021-01-30 11:47:39.41658+00	34	Profile object (34)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
40	2021-01-30 11:48:05.363901+00	35	Profile object (35)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
41	2021-01-30 11:49:26.076747+00	34	Profile object (34)	2	[{"changed": {"fields": ["Name", "Middle name", "Birthday"]}}]	11	1
42	2021-01-30 11:49:51.586852+00	35	Profile object (35)	2	[{"changed": {"fields": ["Birthday"]}}]	11	1
43	2021-01-30 11:51:50.648986+00	36	Profile object (36)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
44	2021-01-30 11:53:26.770067+00	38	Profile object (38)	2	[{"changed": {"fields": ["Name", "Last name", "Bio", "Expertise", "Interests", "Affiliations"]}}]	11	1
45	2021-01-30 11:54:48.042411+00	42	Profile object (42)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
46	2021-01-30 11:59:30.528257+00	47	Profile object (47)	2	[{"changed": {"fields": ["Bio", "Birthday", "Interests", "Affiliations"]}}]	11	1
47	2021-01-30 12:01:16.819124+00	52	Profile object (52)	2	[{"changed": {"fields": ["Birthday", "Affiliations"]}}]	11	1
48	2021-01-30 12:03:15.828427+00	58	Profile object (58)	2	[{"changed": {"fields": ["Birthday", "Affiliations"]}}]	11	1
49	2021-01-30 12:04:37.305202+00	61	Profile object (61)	2	[{"changed": {"fields": ["Birthday", "Affiliations"]}}]	11	1
50	2021-01-30 12:05:13.144938+00	62	Profile object (62)	2	[{"changed": {"fields": ["Birthday", "Affiliations"]}}]	11	1
51	2021-01-30 12:05:34.039127+00	63	Profile object (63)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
52	2021-01-30 12:06:48.115985+00	64	Profile object (64)	2	[{"changed": {"fields": ["Birthday", "Affiliations"]}}]	11	1
53	2021-01-30 12:08:05.848799+00	66	Profile object (66)	2	[{"changed": {"fields": ["Birthday", "Affiliations"]}}]	11	1
54	2021-01-30 12:08:23.009853+00	67	Profile object (67)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
55	2021-01-30 12:09:56.607623+00	70	Profile object (70)	2	[{"changed": {"fields": ["Name", "Last name", "Bio", "Affiliations"]}}]	11	1
56	2021-01-30 12:10:51.174218+00	71	Profile object (71)	2	[{"changed": {"fields": ["Name", "Last name", "Bio", "Affiliations"]}}]	11	1
57	2021-01-30 12:15:11.015798+00	28	Profile object (28)	2	[{"changed": {"fields": ["Birthday"]}}]	11	1
58	2021-01-30 12:16:05.365698+00	23	Profile object (23)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
59	2021-01-30 12:16:23.106383+00	22	Profile object (22)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
60	2021-01-30 12:26:01.649941+00	70	alifurkanbudak	3		4	1
61	2021-01-30 12:26:01.677459+00	72	alifurkanbudak1	3		4	1
62	2021-01-30 12:26:01.701573+00	44	anderson	3		4	1
63	2021-01-30 12:26:01.728242+00	39	barisbasmak	3		4	1
64	2021-01-30 12:26:01.760117+00	37	Barisbasmak	3		4	1
65	2021-01-30 12:26:01.795703+00	62	emirhan	3		4	1
66	2021-01-30 12:26:01.820086+00	59	furkansahin	3		4	1
67	2021-01-30 12:26:01.843931+00	67	hakansabancı	3		4	1
68	2021-01-30 12:26:01.878322+00	81	jack	3		4	1
69	2021-01-30 12:26:01.90322+00	53	KocayarAgam	3		4	1
70	2021-01-30 12:26:01.930837+00	78	Littlewood	3		4	1
71	2021-01-30 12:26:01.958287+00	52	logintest123	3		4	1
72	2021-01-30 12:26:01.982523+00	48	ruveni	3		4	1
73	2021-01-30 12:26:02.006146+00	55	testpublications	3		4	1
74	2021-01-30 12:26:02.033808+00	69	yigit123	3		4	1
75	2021-01-30 12:26:02.062228+00	50	yscaliskan	3		4	1
76	2021-01-30 12:26:02.089531+00	54	yusuf6	3		4	1
77	2021-01-30 12:32:53.378843+00	76	Profile object (76)	1	[{"added": {}}]	11	1
78	2021-01-30 12:36:04.292424+00	78	Tag object (78)	1	[{"added": {}}]	10	1
79	2021-01-30 12:36:46.235167+00	79	Tag object (79)	1	[{"added": {}}]	10	1
80	2021-01-30 12:36:53.673119+00	44	Project object (44)	1	[{"added": {}}]	9	1
81	2021-01-30 12:40:01.269994+00	75	Profile object (75)	3		11	1
82	2021-01-30 12:49:27.756334+00	77	Profile object (77)	2	[{"changed": {"fields": ["Affiliations"]}}]	11	1
83	2021-01-30 12:51:38.015583+00	90	baransoy	2	[{"changed": {"fields": ["Active"]}}]	4	1
84	2021-01-30 13:01:21.808033+00	74	Following object (74)	1	[{"added": {}}]	17	1
85	2021-01-30 14:28:35.885344+00	92	jamesedin	2	[{"changed": {"fields": ["Active"]}}]	4	1
86	2021-01-30 14:31:15.654095+00	78	Profile object (78)	2	[{"changed": {"fields": ["Birthday", "Affiliations"]}}]	11	1
87	2021-01-31 16:33:00.202103+00	102	hugoanderson	2	[{"changed": {"fields": ["Active"]}}]	4	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	api	event
8	api	example
9	api	project
10	api	tag
11	api	profile
12	api	milestone
13	api	file
14	api	collaborationrequest
15	api	collaborationinvite
16	api	followrequest
17	api	following
18	api	rating
19	api	comment
20	authtoken	token
21	authtoken	tokenproxy
22	api	notification
23	api	publication
24	api	report
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-12-26 11:14:33.130482+00
2	auth	0001_initial	2020-12-26 11:14:33.833738+00
3	admin	0001_initial	2020-12-26 11:14:35.631565+00
4	admin	0002_logentry_remove_auto_add	2020-12-26 11:14:36.18786+00
5	admin	0003_logentry_add_action_flag_choices	2020-12-26 11:14:36.469584+00
6	api	0001_initial	2020-12-26 11:14:37.551033+00
7	api	0002_collaborationrequest	2020-12-26 11:14:39.601463+00
8	api	0003_auto_20201206_1712	2020-12-26 11:14:40.620104+00
9	api	0002_auto_20201204_1708	2020-12-26 11:14:41.301732+00
10	api	0004_merge_20201206_1815	2020-12-26 11:14:41.983362+00
11	api	0005_auto_20201206_2024	2020-12-26 11:14:42.800751+00
12	api	0006_auto_20201206_2025	2020-12-26 11:14:43.643666+00
13	api	0007_auto_20201206_2026	2020-12-26 11:14:44.472154+00
14	api	0008_auto_20201206_2028	2020-12-26 11:14:45.313291+00
15	api	0009_auto_20201209_1436	2020-12-26 11:14:45.97732+00
16	api	0009_auto_20201208_2042	2020-12-26 11:14:46.357184+00
17	api	0010_merge_20201214_2048	2020-12-26 11:14:47.034951+00
18	api	0011_auto_20201214_2048	2020-12-26 11:14:47.625051+00
19	api	0012_auto_20201215_1844	2020-12-26 11:14:48.077815+00
20	api	0009_auto_20201212_1633	2020-12-26 11:14:48.714968+00
21	api	0010_auto_20201212_1717	2020-12-26 11:14:49.705922+00
22	api	0013_merge_20201215_2314	2020-12-26 11:14:49.978577+00
23	api	0014_auto_20201217_1125	2020-12-26 11:14:50.550477+00
24	api	0015_auto_20201219_1124	2020-12-26 11:14:51.116659+00
25	api	0016_auto_20201221_2047	2020-12-26 11:14:51.678821+00
26	contenttypes	0002_remove_content_type_name	2020-12-26 11:14:52.671916+00
27	auth	0002_alter_permission_name_max_length	2020-12-26 11:14:53.039164+00
28	auth	0003_alter_user_email_max_length	2020-12-26 11:14:53.404348+00
29	auth	0004_alter_user_username_opts	2020-12-26 11:14:53.699833+00
30	auth	0005_alter_user_last_login_null	2020-12-26 11:14:54.057154+00
31	auth	0006_require_contenttypes_0002	2020-12-26 11:14:54.324375+00
32	auth	0007_alter_validators_add_error_messages	2020-12-26 11:14:54.628233+00
33	auth	0008_alter_user_username_max_length	2020-12-26 11:14:54.998963+00
34	auth	0009_alter_user_last_name_max_length	2020-12-26 11:14:55.360687+00
35	auth	0010_alter_group_name_max_length	2020-12-26 11:14:55.782164+00
36	auth	0011_update_proxy_permissions	2020-12-26 11:14:56.076562+00
37	auth	0012_alter_user_first_name_max_length	2020-12-26 11:14:56.441312+00
38	authtoken	0001_initial	2020-12-26 11:14:56.811916+00
39	authtoken	0002_auto_20160226_1747	2020-12-26 11:14:57.576726+00
40	authtoken	0003_tokenproxy	2020-12-26 11:14:57.860016+00
41	sessions	0001_initial	2020-12-26 11:14:58.215225+00
42	api	0017_auto_20201228_1217	2020-12-28 12:35:57.304855+00
43	api	0016_auto_20201221_2147	2021-01-20 22:09:32.25045+00
44	api	0018_merge_20210107_2115	2021-01-20 22:09:32.779579+00
45	api	0019_auto_20210117_1056	2021-01-20 22:09:32.930834+00
46	api	0015_publication	2021-01-20 22:09:33.110911+00
47	api	0016_auto_20210117_1657	2021-01-20 22:09:33.612921+00
48	api	0020_merge_20210117_1732	2021-01-20 22:09:33.731819+00
49	api	0020_auto_20210117_1512	2021-01-20 22:43:33.855589+00
50	api	0021_merge_20210117_2302	2021-01-20 22:43:34.105096+00
51	notifications	0001_initial	2021-01-20 22:43:34.388926+00
52	notifications	0002_auto_20150224_1134	2021-01-20 22:43:34.68734+00
53	notifications	0003_notification_data	2021-01-20 22:43:34.965416+00
54	notifications	0004_auto_20150826_1508	2021-01-20 22:43:35.244928+00
55	notifications	0005_auto_20160504_1520	2021-01-20 22:43:35.519473+00
56	notifications	0006_indexes	2021-01-20 22:43:35.861369+00
57	notifications	0007_add_timestamp_index	2021-01-20 22:43:36.162812+00
58	notifications	0008_index_together_recipient_unread	2021-01-20 22:43:36.441599+00
59	api	0022_report	2021-01-24 13:35:37.559251+00
60	api	0022_auto_20210124_1320	2021-01-24 13:35:38.050216+00
61	api	0023_merge_20210124_1237	2021-01-24 13:35:38.166767+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: paperlayeradmin
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
77d4lthziimm6ryrvcetquhx0858c6q8	.eJxVjDsKwzAQRO-iOgh2tdYnZfqcQeizipwEGSy7Mrl7bHCRwFTz3swmfFiX6tfOsx-zuAoQl98uhvTidoD8DO0xyTS1ZR6jPBR50i7vU-b37XT_DmrodV-7CIqtAoM6o0ajnIHCSCkBFc6aVNGRgSw6HSwqtIN1tAco4ZCM-HwBt6Q2bg:1kt7ig:HpzfDnmcU9AIEPbseYUOFmd-EViL2AQQamSltqG4hdg	2021-01-09 11:26:46.891373+00
av0849ro3szkdvhuugi32d766kk0l10i	.eJxVjDsKwzAQRO-iOgh2tdYnZfqcQeizipwEGSy7Mrl7bHCRwFTz3swmfFiX6tfOsx-zuAoQl98uhvTidoD8DO0xyTS1ZR6jPBR50i7vU-b37XT_DmrodV-7CIqtAoM6o0ajnIHCSCkBFc6aVNGRgSw6HSwqtIN1tAco4ZCM-HwBt6Q2bg:1ktsHG:itATriTZZWEV53TSbXjuMtxDLbXNYmcHH3hqGDkV4Qo	2021-01-11 13:09:34.880829+00
gootki7930ih9y8ly8p3fdvuf1tp5xmx	.eJxVjDsKwzAQRO-iOgh2tdYnZfqcQeizipwEGSy7Mrl7bHCRwFTz3swmfFiX6tfOsx-zuAoQl98uhvTidoD8DO0xyTS1ZR6jPBR50i7vU-b37XT_DmrodV-7CIqtAoM6o0ajnIHCSCkBFc6aVNGRgSw6HSwqtIN1tAco4ZCM-HwBt6Q2bg:1ktyYe:qj5uk3KG0nHbbCWcL6DxLcGOnuJ4HnIdLhdX6-0zbQU	2021-01-11 19:51:56.428186+00
72zzlxs0rtuxa1vf2fis6xft5c8r8yw7	.eJxVjDsKwzAQRO-iOgh2tdYnZfqcQeizipwEGSy7Mrl7bHCRwFTz3swmfFiX6tfOsx-zuAoQl98uhvTidoD8DO0xyTS1ZR6jPBR50i7vU-b37XT_DmrodV-7CIqtAoM6o0ajnIHCSCkBFc6aVNGRgSw6HSwqtIN1tAco4ZCM-HwBt6Q2bg:1ku0fL:rmaJ-gGFsusqVEoaqW7gMEZzG2ysvCZOr3Uk38_-h6A	2021-01-11 22:06:59.140116+00
hquw0508h3lzpcipmio5lhq0u1d6rb36	.eJxVjDsKwzAQRO-iOgh2tdYnZfqcQeizipwEGSy7Mrl7bHCRwFTz3swmfFiX6tfOsx-zuAoQl98uhvTidoD8DO0xyTS1ZR6jPBR50i7vU-b37XT_DmrodV-7CIqtAoM6o0ajnIHCSCkBFc6aVNGRgSw6HSwqtIN1tAco4ZCM-HwBt6Q2bg:1l1Dku:OlPF4QIE4i-fZ9KK222VhYdzKWaZwaOXY-r1oSmFCD0	2021-01-31 19:30:32.362548+00
sfakxzsjbop2pd5qth1fbaktghrp96vk	.eJxVjDsKwzAQRO-iOgh2tdYnZfqcQeizipwEGSy7Mrl7bHCRwFTz3swmfFiX6tfOsx-zuAoQl98uhvTidoD8DO0xyTS1ZR6jPBR50i7vU-b37XT_DmrodV-7CIqtAoM6o0ajnIHCSCkBFc6aVNGRgSw6HSwqtIN1tAco4ZCM-HwBt6Q2bg:1l2MKV:n05YN6D1z6Mmha4s41Wa6zL8YMEB_jgJrp9OLbbN_u4	2021-02-03 22:51:59.506151+00
ybw6kf0lkv5phd798lf3ptrrccvbf906	.eJxVjDsKwzAQRO-iOgh2tdYnZfqcQeizipwEGSy7Mrl7bHCRwFTz3swmfFiX6tfOsx-zuAoQl98uhvTidoD8DO0xyTS1ZR6jPBR50i7vU-b37XT_DmrodV-7CIqtAoM6o0ajnIHCSCkBFc6aVNGRgSw6HSwqtIN1tAco4ZCM-HwBt6Q2bg:1l3itR:SinRXSQzQew4wvWIwOyD3txlJIEPiKBppYsmzmkd6HM	2021-02-07 17:09:41.877663+00
8dfyqw277zb4uol8pcf54m4jgda779eg	.eJxVjDsKwzAQRO-iOgh2tdYnZfqcQeizipwEGSy7Mrl7bHCRwFTz3swmfFiX6tfOsx-zuAoQl98uhvTidoD8DO0xyTS1ZR6jPBR50i7vU-b37XT_DmrodV-7CIqtAoM6o0ajnIHCSCkBFc6aVNGRgSw6HSwqtIN1tAco4ZCM-HwBt6Q2bg:1l6FeC:bKs_94IbVn8EbH7Kvo3MS7OXw2YbGcpC-dmoWS5dNgc	2021-02-14 16:32:24.493379+00
\.


--
-- Name: api_collaborationinvite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_collaborationinvite_id_seq', 35, true);


--
-- Name: api_collaborationrequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_collaborationrequest_id_seq', 57, true);


--
-- Name: api_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_comment_id_seq', 4, true);


--
-- Name: api_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_event_id_seq', 11, true);


--
-- Name: api_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_file_id_seq', 24, true);


--
-- Name: api_following_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_following_id_seq', 109, true);


--
-- Name: api_followrequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_followrequest_id_seq', 93, true);


--
-- Name: api_milestone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_milestone_id_seq', 12, true);


--
-- Name: api_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_notification_id_seq', 271, true);


--
-- Name: api_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_profile_id_seq', 89, true);


--
-- Name: api_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_project_id_seq', 57, true);


--
-- Name: api_project_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_project_members_id_seq', 84, true);


--
-- Name: api_project_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_project_tags_id_seq', 152, true);


--
-- Name: api_publication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_publication_id_seq', 2663, true);


--
-- Name: api_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_rating_id_seq', 28, true);


--
-- Name: api_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_report_id_seq', 5, true);


--
-- Name: api_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.api_tag_id_seq', 93, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 103, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 87, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paperlayeradmin
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 61, true);


--
-- Name: api_collaborationinvite api_collaborationinvite_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationinvite
    ADD CONSTRAINT api_collaborationinvite_pkey PRIMARY KEY (id);


--
-- Name: api_collaborationrequest api_collaborationrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationrequest
    ADD CONSTRAINT api_collaborationrequest_pkey PRIMARY KEY (id);


--
-- Name: api_comment api_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_comment
    ADD CONSTRAINT api_comment_pkey PRIMARY KEY (id);


--
-- Name: api_event api_event_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_event
    ADD CONSTRAINT api_event_pkey PRIMARY KEY (id);


--
-- Name: api_file api_file_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_file
    ADD CONSTRAINT api_file_pkey PRIMARY KEY (id);


--
-- Name: api_following api_following_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_following
    ADD CONSTRAINT api_following_pkey PRIMARY KEY (id);


--
-- Name: api_followrequest api_followrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_followrequest
    ADD CONSTRAINT api_followrequest_pkey PRIMARY KEY (id);


--
-- Name: api_milestone api_milestone_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_milestone
    ADD CONSTRAINT api_milestone_pkey PRIMARY KEY (id);


--
-- Name: api_notification api_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_notification
    ADD CONSTRAINT api_notification_pkey PRIMARY KEY (id);


--
-- Name: api_profile api_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_profile
    ADD CONSTRAINT api_profile_pkey PRIMARY KEY (id);


--
-- Name: api_project_members api_project_members_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_members
    ADD CONSTRAINT api_project_members_pkey PRIMARY KEY (id);


--
-- Name: api_project_members api_project_members_project_id_user_id_c3944911_uniq; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_members
    ADD CONSTRAINT api_project_members_project_id_user_id_c3944911_uniq UNIQUE (project_id, user_id);


--
-- Name: api_project api_project_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project
    ADD CONSTRAINT api_project_pkey PRIMARY KEY (id);


--
-- Name: api_project_tags api_project_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_tags
    ADD CONSTRAINT api_project_tags_pkey PRIMARY KEY (id);


--
-- Name: api_project_tags api_project_tags_project_id_tag_id_4989e062_uniq; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_tags
    ADD CONSTRAINT api_project_tags_project_id_tag_id_4989e062_uniq UNIQUE (project_id, tag_id);


--
-- Name: api_publication api_publication_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_publication
    ADD CONSTRAINT api_publication_pkey PRIMARY KEY (id);


--
-- Name: api_rating api_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_rating
    ADD CONSTRAINT api_rating_pkey PRIMARY KEY (id);


--
-- Name: api_report api_report_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_report
    ADD CONSTRAINT api_report_pkey PRIMARY KEY (id);


--
-- Name: api_tag api_tag_name_e0f7a95d_uniq; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_tag
    ADD CONSTRAINT api_tag_name_e0f7a95d_uniq UNIQUE (name);


--
-- Name: api_tag api_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_tag
    ADD CONSTRAINT api_tag_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: api_following unique_followers; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_following
    ADD CONSTRAINT unique_followers UNIQUE (from_user_id, to_user_id);


--
-- Name: api_rating unique_rating; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_rating
    ADD CONSTRAINT unique_rating UNIQUE (from_user_id, to_user_id);


--
-- Name: api_followrequest unique_request; Type: CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_followrequest
    ADD CONSTRAINT unique_request UNIQUE (req_from_user_id, req_to_user_id);


--
-- Name: api_collaborationinvite_from_user_id_75f18318; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_collaborationinvite_from_user_id_75f18318 ON public.api_collaborationinvite USING btree (from_user_id);


--
-- Name: api_collaborationinvite_to_project_id_cc74fe48; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_collaborationinvite_to_project_id_cc74fe48 ON public.api_collaborationinvite USING btree (to_project_id);


--
-- Name: api_collaborationinvite_to_user_id_4b2f9b27; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_collaborationinvite_to_user_id_4b2f9b27 ON public.api_collaborationinvite USING btree (to_user_id);


--
-- Name: api_collaborationrequest_from_user_id_01969013; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_collaborationrequest_from_user_id_01969013 ON public.api_collaborationrequest USING btree (from_user_id);


--
-- Name: api_collaborationrequest_to_project_id_17c0421e; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_collaborationrequest_to_project_id_17c0421e ON public.api_collaborationrequest USING btree (to_project_id);


--
-- Name: api_collaborationrequest_to_user_id_0d50d29a; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_collaborationrequest_to_user_id_0d50d29a ON public.api_collaborationrequest USING btree (to_user_id);


--
-- Name: api_comment_from_user_id_3b7da9bd; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_comment_from_user_id_3b7da9bd ON public.api_comment USING btree (from_user_id);


--
-- Name: api_comment_to_user_id_d7fe0d05; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_comment_to_user_id_d7fe0d05 ON public.api_comment USING btree (to_user_id);


--
-- Name: api_file_project_id_45607e71; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_file_project_id_45607e71 ON public.api_file USING btree (project_id);


--
-- Name: api_following_from_user_id_997629bd; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_following_from_user_id_997629bd ON public.api_following USING btree (from_user_id);


--
-- Name: api_following_to_user_id_4de3e2c4; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_following_to_user_id_4de3e2c4 ON public.api_following USING btree (to_user_id);


--
-- Name: api_followrequest_req_from_user_id_4437ba79; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_followrequest_req_from_user_id_4437ba79 ON public.api_followrequest USING btree (req_from_user_id);


--
-- Name: api_followrequest_req_to_user_id_9c55e158; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_followrequest_req_to_user_id_9c55e158 ON public.api_followrequest USING btree (req_to_user_id);


--
-- Name: api_milestone_project_id_55239a7d; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_milestone_project_id_55239a7d ON public.api_milestone USING btree (project_id);


--
-- Name: api_notification_action_object_content_type_id_40c1d5e7; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_action_object_content_type_id_40c1d5e7 ON public.api_notification USING btree (action_object_content_type_id);


--
-- Name: api_notification_actor_content_type_id_2a815f01; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_actor_content_type_id_2a815f01 ON public.api_notification USING btree (actor_content_type_id);


--
-- Name: api_notification_deleted_c32c0cac; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_deleted_c32c0cac ON public.api_notification USING btree (deleted);


--
-- Name: api_notification_emailed_732e97fe; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_emailed_732e97fe ON public.api_notification USING btree (emailed);


--
-- Name: api_notification_public_c9edc784; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_public_c9edc784 ON public.api_notification USING btree (public);


--
-- Name: api_notification_recipient_id_ad4ce955; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_recipient_id_ad4ce955 ON public.api_notification USING btree (recipient_id);


--
-- Name: api_notification_recipient_id_unread_bdcbeb91_idx; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_recipient_id_unread_bdcbeb91_idx ON public.api_notification USING btree (recipient_id, unread);


--
-- Name: api_notification_target_content_type_id_38771683; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_target_content_type_id_38771683 ON public.api_notification USING btree (target_content_type_id);


--
-- Name: api_notification_timestamp_17e1b10d; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_timestamp_17e1b10d ON public.api_notification USING btree ("timestamp");


--
-- Name: api_notification_unread_ae26bfff; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_notification_unread_ae26bfff ON public.api_notification USING btree (unread);


--
-- Name: api_profile_owner_id_bb82c117; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_profile_owner_id_bb82c117 ON public.api_profile USING btree (owner_id);


--
-- Name: api_project_event_id_d6d00d50; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_project_event_id_d6d00d50 ON public.api_project USING btree (event_id);


--
-- Name: api_project_members_project_id_f528a993; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_project_members_project_id_f528a993 ON public.api_project_members USING btree (project_id);


--
-- Name: api_project_members_user_id_9024675e; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_project_members_user_id_9024675e ON public.api_project_members USING btree (user_id);


--
-- Name: api_project_owner_id_54c92f4c; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_project_owner_id_54c92f4c ON public.api_project USING btree (owner_id);


--
-- Name: api_project_tags_project_id_1cc13fd3; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_project_tags_project_id_1cc13fd3 ON public.api_project_tags USING btree (project_id);


--
-- Name: api_project_tags_tag_id_31ef3681; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_project_tags_tag_id_31ef3681 ON public.api_project_tags USING btree (tag_id);


--
-- Name: api_publication_owner_id_d199443d; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_publication_owner_id_d199443d ON public.api_publication USING btree (owner_id);


--
-- Name: api_rating_from_user_id_b512949e; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_rating_from_user_id_b512949e ON public.api_rating USING btree (from_user_id);


--
-- Name: api_rating_to_user_id_f0e2f814; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_rating_to_user_id_f0e2f814 ON public.api_rating USING btree (to_user_id);


--
-- Name: api_report_reported_user_id_8e970d74; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_report_reported_user_id_8e970d74 ON public.api_report USING btree (reported_user_id);


--
-- Name: api_tag_name_e0f7a95d_like; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX api_tag_name_e0f7a95d_like ON public.api_tag USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: paperlayeradmin
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: api_collaborationinvite api_collaborationinv_to_project_id_cc74fe48_fk_api_proje; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationinvite
    ADD CONSTRAINT api_collaborationinv_to_project_id_cc74fe48_fk_api_proje FOREIGN KEY (to_project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_collaborationinvite api_collaborationinvite_from_user_id_75f18318_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationinvite
    ADD CONSTRAINT api_collaborationinvite_from_user_id_75f18318_fk_auth_user_id FOREIGN KEY (from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_collaborationinvite api_collaborationinvite_to_user_id_4b2f9b27_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationinvite
    ADD CONSTRAINT api_collaborationinvite_to_user_id_4b2f9b27_fk_auth_user_id FOREIGN KEY (to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_collaborationrequest api_collaborationreq_to_project_id_17c0421e_fk_api_proje; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationrequest
    ADD CONSTRAINT api_collaborationreq_to_project_id_17c0421e_fk_api_proje FOREIGN KEY (to_project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_collaborationrequest api_collaborationrequest_from_user_id_01969013_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationrequest
    ADD CONSTRAINT api_collaborationrequest_from_user_id_01969013_fk_auth_user_id FOREIGN KEY (from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_collaborationrequest api_collaborationrequest_to_user_id_0d50d29a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_collaborationrequest
    ADD CONSTRAINT api_collaborationrequest_to_user_id_0d50d29a_fk_auth_user_id FOREIGN KEY (to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_comment api_comment_from_user_id_3b7da9bd_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_comment
    ADD CONSTRAINT api_comment_from_user_id_3b7da9bd_fk_auth_user_id FOREIGN KEY (from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_comment api_comment_to_user_id_d7fe0d05_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_comment
    ADD CONSTRAINT api_comment_to_user_id_d7fe0d05_fk_auth_user_id FOREIGN KEY (to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_file api_file_project_id_45607e71_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_file
    ADD CONSTRAINT api_file_project_id_45607e71_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_following api_following_from_user_id_997629bd_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_following
    ADD CONSTRAINT api_following_from_user_id_997629bd_fk_auth_user_id FOREIGN KEY (from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_following api_following_to_user_id_4de3e2c4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_following
    ADD CONSTRAINT api_following_to_user_id_4de3e2c4_fk_auth_user_id FOREIGN KEY (to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_followrequest api_followrequest_req_from_user_id_4437ba79_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_followrequest
    ADD CONSTRAINT api_followrequest_req_from_user_id_4437ba79_fk_auth_user_id FOREIGN KEY (req_from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_followrequest api_followrequest_req_to_user_id_9c55e158_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_followrequest
    ADD CONSTRAINT api_followrequest_req_to_user_id_9c55e158_fk_auth_user_id FOREIGN KEY (req_to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_milestone api_milestone_project_id_55239a7d_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_milestone
    ADD CONSTRAINT api_milestone_project_id_55239a7d_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_notification api_notification_action_object_conten_40c1d5e7_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_notification
    ADD CONSTRAINT api_notification_action_object_conten_40c1d5e7_fk_django_co FOREIGN KEY (action_object_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_notification api_notification_actor_content_type_i_2a815f01_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_notification
    ADD CONSTRAINT api_notification_actor_content_type_i_2a815f01_fk_django_co FOREIGN KEY (actor_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_notification api_notification_recipient_id_ad4ce955_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_notification
    ADD CONSTRAINT api_notification_recipient_id_ad4ce955_fk_auth_user_id FOREIGN KEY (recipient_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_notification api_notification_target_content_type__38771683_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_notification
    ADD CONSTRAINT api_notification_target_content_type__38771683_fk_django_co FOREIGN KEY (target_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_profile api_profile_owner_id_bb82c117_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_profile
    ADD CONSTRAINT api_profile_owner_id_bb82c117_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_project api_project_event_id_d6d00d50_fk_api_event_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project
    ADD CONSTRAINT api_project_event_id_d6d00d50_fk_api_event_id FOREIGN KEY (event_id) REFERENCES public.api_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_project_members api_project_members_project_id_f528a993_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_members
    ADD CONSTRAINT api_project_members_project_id_f528a993_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_project_members api_project_members_user_id_9024675e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_members
    ADD CONSTRAINT api_project_members_user_id_9024675e_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_project api_project_owner_id_54c92f4c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project
    ADD CONSTRAINT api_project_owner_id_54c92f4c_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_project_tags api_project_tags_project_id_1cc13fd3_fk_api_project_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_tags
    ADD CONSTRAINT api_project_tags_project_id_1cc13fd3_fk_api_project_id FOREIGN KEY (project_id) REFERENCES public.api_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_project_tags api_project_tags_tag_id_31ef3681_fk_api_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_project_tags
    ADD CONSTRAINT api_project_tags_tag_id_31ef3681_fk_api_tag_id FOREIGN KEY (tag_id) REFERENCES public.api_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_publication api_publication_owner_id_d199443d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_publication
    ADD CONSTRAINT api_publication_owner_id_d199443d_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_rating api_rating_from_user_id_b512949e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_rating
    ADD CONSTRAINT api_rating_from_user_id_b512949e_fk_auth_user_id FOREIGN KEY (from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_rating api_rating_to_user_id_f0e2f814_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_rating
    ADD CONSTRAINT api_rating_to_user_id_f0e2f814_fk_auth_user_id FOREIGN KEY (to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_report api_report_reported_user_id_8e970d74_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.api_report
    ADD CONSTRAINT api_report_reported_user_id_8e970d74_fk_auth_user_id FOREIGN KEY (reported_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: paperlayeradmin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

