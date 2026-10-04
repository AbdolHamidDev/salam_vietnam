-- Salam Vietnam Row Level Security (RLS) Policies
-- Migration 002_security_rls.sql

-- Enable RLS on all tables
ALTER TABLE public.places ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.place_translations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.place_category_links ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.halal_verifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.place_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cultural_articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.article_translations ENABLE ROW LEVEL SECURITY;

-- 1. Public Read Policy for Published Places & Translations
CREATE POLICY "Public places are viewable by everyone" ON public.places
    FOR SELECT USING (publication_status = 'published');

CREATE POLICY "Place translations viewable by everyone" ON public.place_translations
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.places
            WHERE places.id = place_translations.place_id
            AND places.publication_status = 'published'
        )
    );

CREATE POLICY "Categories viewable by everyone" ON public.categories
    FOR SELECT USING (true);

CREATE POLICY "Halal verifications viewable by everyone" ON public.halal_verifications
    FOR SELECT USING (true);

CREATE POLICY "Cultural articles viewable by everyone" ON public.cultural_articles
    FOR SELECT USING (true);

CREATE POLICY "Article translations viewable by everyone" ON public.article_translations
    FOR SELECT USING (true);

-- 2. Public Submission Policy (Only INSERT, status forced to 'pending')
CREATE POLICY "Anyone can submit a place contribution" ON public.place_submissions
    FOR INSERT WITH CHECK (status = 'pending');

-- Public users CANNOT update or delete submissions or places directly
