-- 0048_import_family_verified_facebook_photos_batch1.sql
-- Archive v2.9.5 — First family-verified historical photograph import.
-- Source identities are based on captions/labels in the supplied Facebook compilation
-- and the user's explicit instruction that items marked VERIFIED are trusted personal-family photographs
-- from Mohtaj Ali Amiri Gharagozloo.
-- No genealogy changes.

PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO sources(
    source_id, short_title, full_title, author, publication_year, source_type, file_name, notes
) VALUES (
    'S0204',
    'Mohtaj Ali Amiri Gharagozloo — verified family photographs',
    'Family-verified Gharagozloo historical photograph collection supplied by Mohtaj Ali Amiri Gharagozloo',
    'Mohtaj Ali Amiri Gharagozloo',
    NULL,
    'family archive photographs',
    'Gharagozloo pictures from Favebook page.pdf',
    'Items in the supplied compilation explicitly marked VERIFIED. The archive treats the identification as family-verified testimony from Mohtaj Ali Amiri Gharagozloo. The PDF is the intake carrier; individual photographs are stored as separate artifact image files.'
);

INSERT OR IGNORE INTO artifacts(
    artifact_id, source_id, printed_page, artifact_type, title, caption_fa,
    description, transcription_status, confidence, file_reference, notes
) VALUES
('A0213','S0204','56','photograph',
 'Hossein Khan Hesam al-Molk I',
 'حسین خان قراگزلو امیر نویان (حسام الملک اول)، فرزند علی خان نصرت الملک قراگزلو',
 'Family-verified individual portrait of Hossein Khan Hesam al-Molk I.',
 'not_applicable','confirmed','A0213.jpg',
 'VERIFIED in supplied family compilation. Linked to canonical P0022.'),
('A0214','S0204','57','photograph',
 'Mohtaj Ali Khan Amir Arfa and Mansur Ali Khan Sardar Akram at private school',
 'محتاجعلی خان قراگزلو (امیر ارفع) و منصورعلی خان قراگزلو (سردار اکرم)، فرزندان عبدالله خان حاج امیر نظام همدانی، در مکتب‌خانه خصوصی',
 'Family-verified group photograph of brothers Mohtaj Ali Khan and Mansur Ali Khan with teachers and attendants.',
 'not_applicable','confirmed','A0214.jpg',
 'VERIFIED in supplied family compilation. Multi-person artifact linked to P0005 and P0006.'),
('A0215','S0204','68','photograph',
 'Gholam Ali Khan Gharagozloo — Hesam al-Molk III',
 'غلامعلی خان قراگزلو - حسام الملک سوم',
 'Family-verified individual portrait of Gholam Ali Khan Hesam al-Molk III.',
 'not_applicable','confirmed','A0215.jpg',
 'VERIFIED in supplied family compilation. Linked to canonical P0170.'),
('A0216','S0204','79','photograph',
 'Ali Khan Gharagozloo — Nosrat al-Molk',
 'عکس قدیمی از علی خان قراگزلو (نصرت الملک)',
 'Family-verified historical portrait of Ali Khan Nosrat al-Molk.',
 'not_applicable','confirmed','A0216.jpg',
 'VERIFIED in supplied family compilation. Linked to canonical P0019.'),
('A0217','S0204','81','photograph',
 'Funeral of Mohsen Gharagozloo at Sepahsalar Mosque',
 'مسجد سپهسالار طهران (مدرسه شهید مطهری) - تشییع پیکر مرحوم محسن قراگزلو',
 'Family-verified funeral photograph associated with Mohsen Gharagozloo.',
 'not_applicable','confirmed','A0217.jpg',
 'VERIFIED in supplied family compilation. This is an event/context image; it is not used as Mohsen Gharagozloo''s primary portrait.'),
('A0218','S0204','82','photograph',
 'Funeral of Mohsen Gharagozloo — attendees including Hossein Ali Gharagozloo',
 'مسجد سپهسالار طهران - تشییع پیکر مرحوم محسن قراگزلو؛ حسینعلی قراگزلو در سمت چپ',
 'Family-verified funeral photograph; caption identifies Hossein Ali Gharagozloo among the attendees.',
 'not_applicable','confirmed','A0218.jpg',
 'VERIFIED in supplied family compilation. Linked to P0042 as the funeral subject and P0041 as a captioned attendee.'),
('A0219','S0204','83','photograph',
 'Gholamhossein Khan Amiri Gharagozloo with Ali Amiri Gharagozloo',
 'عکس یادگاری از غلامحسین خان امیری قراگزلو و علی امیری قراگزلو',
 'Family-verified photograph of Gholamhossein Khan Amiri Gharagozloo with Ali Amiri Gharagozloo.',
 'not_applicable','confirmed','A0219.jpg',
 'VERIFIED in supplied family compilation. P0008 is linked now; Ali Amiri remains unresolved/not yet canonical and is therefore preserved in the caption rather than assigned a P-ID.'),
('A0220','S0204','86','photograph',
 'Mansur Ali Khan Gharagozloo — Sardar Akram',
 'منصور علی قراگزلو - سردار اکرم',
 'Family-verified individual portrait of Mansur Ali Khan Sardar Akram.',
 'not_applicable','confirmed','A0220.jpg',
 'VERIFIED in supplied family compilation. Linked to canonical P0006.'),
('A0221','S0204','94','photograph',
 'Abdollah Khan Gharagozloo — Haji Amir Nezam',
 'عبدالله خان قراگزلو حاج امیر نظام',
 'Family-verified individual portrait of Abdollah Khan Haji Amir Nezam.',
 'not_applicable','confirmed','A0221.jpg',
 'VERIFIED in supplied family compilation. Linked to canonical P0004.'),
('A0222','S0204','96','photograph',
 'Sardar Akram and Amir Arfa as children of Haji Amir Nezam',
 'سردار اکرم و امیر ارفع، فرزندان حاج امیر نظام',
 'Family-verified childhood photograph of Mansur Ali Khan Sardar Akram and Mohtaj Ali Khan Amir Arfa.',
 'not_applicable','confirmed','A0222.jpg',
 'VERIFIED in supplied family compilation. Multi-person artifact linked to P0006 and P0005.'),
('A0223','S0204','98','photograph',
 'Hossein Ali Gharagozloo — son of Naser al-Molk',
 'حسینعلی قراگزلو فرزند ناصرالملک',
 'Family-verified individual portrait of Hossein Ali Gharagozloo, son of Naser al-Molk.',
 'not_applicable','confirmed','A0223.jpg',
 'VERIFIED in supplied family compilation. Linked to canonical P0041.');

INSERT OR IGNORE INTO artifact_persons(artifact_id, person_id, role, notes) VALUES
('A0213','P0022','subject','Captioned and family-verified identity.'),
('A0214','P0005','subject','Captioned and family-verified identity.'),
('A0214','P0006','subject','Captioned and family-verified identity.'),
('A0215','P0170','subject','Captioned and family-verified identity.'),
('A0216','P0019','subject','Captioned and family-verified identity.'),
('A0217','P0042','historical_subject','Funeral/context photograph for Mohsen Gharagozloo; not a portrait likeness.'),
('A0218','P0042','historical_subject','Funeral/context photograph for Mohsen Gharagozloo; not a portrait likeness.'),
('A0218','P0041','attendee','Caption explicitly identifies Hossein Ali Gharagozloo among attendees.'),
('A0219','P0008','subject','Captioned and family-verified identity; second named person Ali Amiri is unresolved.'),
('A0220','P0006','subject','Captioned and family-verified identity.'),
('A0221','P0004','subject','Captioned and family-verified identity.'),
('A0222','P0005','subject','Captioned and family-verified identity.'),
('A0222','P0006','subject','Captioned and family-verified identity.'),
('A0223','P0041','subject','Captioned and family-verified identity.');

INSERT OR IGNORE INTO artifact_gallery_metadata(
    artifact_id, verification_class, display_status, selection_notes
) VALUES
('A0213','family_verified','visible','Family-verified individual portrait; selected as primary portrait for P0022.'),
('A0214','family_verified','visible','Family-verified group photograph; may serve as P0005 primary until a verified individual portrait is available.'),
('A0215','family_verified','visible','Family-verified individual portrait; selected as primary portrait for P0170.'),
('A0216','family_verified','visible','Family-verified individual portrait; selected as primary portrait for P0019.'),
('A0217','family_verified','visible','Family-verified historical/event image; intentionally not a primary portrait.'),
('A0218','family_verified','visible','Family-verified historical/event image; intentionally not a primary portrait.'),
('A0219','family_verified','visible','Family-verified two-person photograph; retained in P0008 gallery but legacy individual portrait remains primary.'),
('A0220','family_verified','visible','Family-verified individual portrait; selected as primary portrait for P0006.'),
('A0221','family_verified','visible','Family-verified individual portrait; selected as primary portrait for P0004.'),
('A0222','family_verified','visible','Family-verified childhood group photograph; gallery image for P0005 and P0006.'),
('A0223','family_verified','visible','Family-verified individual portrait; selected as primary portrait for P0041.');

-- Curated primary-portrait decisions. A previous portrait is never deleted; only the primary designation changes.
INSERT OR REPLACE INTO person_primary_portraits(
    person_id, artifact_id, selection_basis, selected_by, notes
) VALUES
('P0022','A0213','Family-verified clear individual portrait','archive migration 0048','Preferred over no/less-certain portrait.'),
('P0005','A0214','Family-verified photograph; best currently available verified likeness','archive migration 0048','Group photograph used provisionally as primary until a verified individual portrait is available.'),
('P0170','A0215','Family-verified clear individual portrait','archive migration 0048','Selected under archive primary-portrait policy.'),
('P0019','A0216','Family-verified clear individual portrait','archive migration 0048','Selected under archive primary-portrait policy.'),
('P0006','A0220','Family-verified clear individual portrait','archive migration 0048','Preferred over childhood/group images.'),
('P0004','A0221','Family-verified clear individual portrait','archive migration 0048','Selected under archive primary-portrait policy.'),
('P0041','A0223','Family-verified clear individual portrait','archive migration 0048','Selected under archive primary-portrait policy.');

-- Deliberately retain P0008's existing legacy individual portrait as primary.
-- A0219 is verified but is a two-person photograph and therefore stays in the gallery only.
