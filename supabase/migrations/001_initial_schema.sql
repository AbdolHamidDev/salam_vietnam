-- Salam Vietnam Initial Database Schema Migration
-- Migration 001_initial_schema.sql

-- Enable UUID extension if not enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Places Table
CREATE TABLE IF NOT EXISTS public.places (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT UNIQUE NOT NULL,
    place_type TEXT NOT NULL DEFAULT 'halal_food',
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    address TEXT NOT NULL,
    province TEXT NOT NULL,
    phone TEXT,
    website_url TEXT,
    publication_status TEXT NOT NULL DEFAULT 'published',
    verification_status TEXT NOT NULL DEFAULT 'source_confirmed',
    image_url TEXT,
    rating DOUBLE PRECISION DEFAULT 4.5,
    review_count INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_verified_at TIMESTAMPTZ
);

-- Place Translations Table
CREATE TABLE IF NOT EXISTS public.place_translations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID NOT NULL REFERENCES public.places(id) ON DELETE CASCADE,
    language_code TEXT NOT NULL,
    name TEXT NOT NULL,
    short_description TEXT,
    description TEXT,
    address_display TEXT,
    CONSTRAINT unique_place_lang UNIQUE (place_id, language_code)
);

-- Categories Table
CREATE TABLE IF NOT EXISTS public.categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT UNIQUE NOT NULL,
    icon_key TEXT,
    sort_order INT DEFAULT 0
);

-- Place Category Links Table
CREATE TABLE IF NOT EXISTS public.place_category_links (
    place_id UUID NOT NULL REFERENCES public.places(id) ON DELETE CASCADE,
    category_id UUID NOT NULL REFERENCES public.categories(id) ON DELETE CASCADE,
    PRIMARY KEY (place_id, category_id)
);

-- Halal Verifications Table
CREATE TABLE IF NOT EXISTS public.halal_verifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID NOT NULL REFERENCES public.places(id) ON DELETE CASCADE,
    status TEXT NOT NULL DEFAULT 'unverified',
    claim_type TEXT,
    evidence_summary TEXT,
    issuing_body TEXT,
    certificate_reference TEXT,
    valid_from DATE,
    valid_until DATE,
    public_note TEXT,
    verified_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sources Table
CREATE TABLE IF NOT EXISTS public.sources (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_type TEXT NOT NULL,
    name TEXT NOT NULL,
    url TEXT,
    attribution_text TEXT,
    accessed_at TIMESTAMPTZ DEFAULT NOW()
);

-- Place Submissions Table (Pending Queue)
CREATE TABLE IF NOT EXISTS public.place_submissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    submission_type TEXT NOT NULL DEFAULT 'new_place',
    payload JSONB NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    moderator_note TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    reviewed_at TIMESTAMPTZ
);

-- Cultural Articles Table
CREATE TABLE IF NOT EXISTS public.cultural_articles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT UNIQUE NOT NULL,
    category TEXT NOT NULL,
    image_url TEXT,
    author_name TEXT,
    source_attribution TEXT,
    published_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Article Translations Table
CREATE TABLE IF NOT EXISTS public.article_translations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    article_id UUID NOT NULL REFERENCES public.cultural_articles(id) ON DELETE CASCADE,
    language_code TEXT NOT NULL,
    title TEXT NOT NULL,
    summary TEXT,
    body_markdown TEXT NOT NULL,
    CONSTRAINT unique_article_lang UNIQUE (article_id, language_code)
);
