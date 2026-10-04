-- Salam Vietnam Seed Pilot Data
-- Migration 003_seed_data.sql

-- Seed Categories
INSERT INTO public.categories (slug, icon_key, sort_order) VALUES
('halal_food', 'restaurant', 1),
('mosque', 'account_balance', 2),
('cham_culture', 'museum', 3),
('accommodation', 'hotel', 4)
ON CONFLICT (slug) DO NOTHING;

-- Seed Sample Place 1: Nhà hàng Halal Saigon Saigon
INSERT INTO public.places (id, slug, place_type, latitude, longitude, address, province, phone, publication_status, verification_status, image_url, rating, review_count, last_verified_at)
VALUES (
    'a1b2c3d4-0001-4000-8000-000000000001',
    'nha-hang-halal-saigon-saigon',
    'halal_food',
    10.7769,
    106.7051,
    '86 Đông Du, Phường Bến Nghé, Quận 1',
    'TP. Hồ Chí Minh',
    '+84 28 3824 6161',
    'published',
    'field_verified',
    'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=600',
    4.8,
    124,
    NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO public.place_translations (place_id, language_code, name, short_description, description)
VALUES (
    'a1b2c3d4-0001-4000-8000-000000000001',
    'vi',
    'Nhà hàng Halal Saigon Saigon',
    'Chuyên ẩm thực Halal Việt Nam và Đông Nam Á',
    'Chuyên phục vụ các món ăn Việt Nam đạt chuẩn Halal và ẩm thực Đông Nam Á.'
) ON CONFLICT (place_id, language_code) DO NOTHING;

INSERT INTO public.halal_verifications (place_id, status, claim_type, evidence_summary)
VALUES (
    'a1b2c3d4-0001-4000-8000-000000000001',
    'verified',
    'certified',
    'Giấy chứng nhận Halal hợp lệ do Ban Đại diện Cộng đồng Hồi giáo cấp.'
);

-- Seed Sample Place 2: Thánh đường Al-Nur Hanoi
INSERT INTO public.places (id, slug, place_type, latitude, longitude, address, province, phone, publication_status, verification_status, image_url, rating, review_count, last_verified_at)
VALUES (
    'a1b2c3d4-0002-4000-8000-000000000002',
    'thanh-duong-al-nur-hanoi',
    'mosque',
    21.0368,
    105.8491,
    '12 Hàng Lược, Phường Hàng Ma, Quận Hoàn Kiếm',
    'Hà Nội',
    '+84 24 3828 2026',
    'published',
    'source_confirmed',
    'https://images.unsplash.com/photo-1542662565-7e4b66bae529?w=600',
    4.9,
    89,
    NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO public.place_translations (place_id, language_code, name, short_description, description)
VALUES (
    'a1b2c3d4-0002-4000-8000-000000000002',
    'vi',
    'Thánh đường Al-Nur (Mosque Hanoi)',
    'Thánh đường Hồi giáo duy nhất tại miền Bắc Việt Nam',
    'Thánh đường cổ kính được xây dựng từ năm 1885, điểm hành lễ chính cho cộng đồng Hồi giáo Hà Nội.'
) ON CONFLICT (place_id, language_code) DO NOTHING;

INSERT INTO public.halal_verifications (place_id, status, claim_type, evidence_summary)
VALUES (
    'a1b2c3d4-0002-4000-8000-000000000002',
    'verified',
    'official_mosque',
    'Thánh đường Hồi giáo chính thức duy nhất tại miền Bắc Việt Nam.'
);
