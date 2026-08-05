-- 0049_import_facebook_source_captioned_photos_batch2.sql
-- Archive v2.9.6 — Facebook source-captioned historical photograph import, Batch 2.
-- Includes both canonical-person-linked and currently unresolved photographs.
-- Unresolved identities are intentionally preserved as artifact captions without forcing new P-IDs.
-- Also applies the user's curator decision that the page-77 individual portrait of
-- Mohtaj Ali Khan Amir Arfa' should be his primary Explorer portrait.
-- No genealogy changes.

PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO sources(
    source_id, short_title, full_title, author, publication_year, source_type, file_name, notes
) VALUES (
    'S0205',
    'Gharagozloo Facebook historical photograph collection',
    'Historical photographs and captions collected from the Gharagozloo Facebook page',
    'Gharagozloo Facebook page — samferdosiam',
    NULL,
    'social media historical photograph collection',
    'Gharagozloo pictures from Favebook page.pdf',
    'Source-captioned images from the supplied Facebook compilation. These identifications are preserved as statements of the source and are not elevated to family-verified status unless separately marked VERIFIED. Individual photographs are stored as artifact image files.'
);

INSERT OR IGNORE INTO artifacts(
    artifact_id, source_id, printed_page, artifact_type, title, caption_fa,
    description, transcription_status, confidence, file_reference, notes
) VALUES
('A0224','S0205','2','photograph',
 'Nosratollah Batmanghelidj, Houshang Payandehzadeh and Mohsen Khan Gharagozloo',
 'تصویری از مرحوم امیر نصرت‌الله باتمانقلیچ، مرحوم هوشنگ پاینده‌زاده و مرحوم محسن خان قراگزلو',
 'Source-captioned composite photograph. Mohsen Khan Gharagozloo is linked to canonical P0042; the other captioned people are retained as contextual names only.',
 'not_applicable','confirmed','A0224.jpg',
 'Facebook-source identification; not family-verified.'),
('A0225','S0205','3','photograph',
 'Zeyn al-Abedin Khan Gharagozloo — Amir Afkham',
 'تصویری از امیر افخم شورینی قراگزلو، حاکم همدان در دوره قاجاریه',
 'Source-captioned historical photograph of Zeyn al-Abedin Khan Gharagozloo, Amir Afkham.',
 'not_applicable','confirmed','A0225.jpg',
 'Facebook-source identification; linked to canonical P0023.'),
('A0226','S0205','4','photograph',
 'Mehri Khanom Gharagozloo on horseback',
 'مهری خانم قراگزلو (همسر مجیدخان بختیاری)',
 'Source-captioned photograph of Mehri Khanom Gharagozloo on horseback. No canonical P-ID is assigned in this migration.',
 'not_applicable','confirmed','A0226.jpg',
 'Facebook-source identification; unresolved/new-person candidate retained without forced person linkage.'),
('A0227','S0205','8','photograph',
 'Ali Qoli Khan Gharagozloo — Baha al-Molk II',
 'تصویری از علی‌قلی خان قراگزلو، بهاءالملک دوم',
 'Source-captioned portrait of Ali Qoli Khan Baha al-Molk II.',
 'not_applicable','confirmed','A0227.jpg',
 'Facebook-source identification; linked to canonical P0033.'),
('A0228','S0205','13','photograph',
 'Gholamhossein Gharagozloo — translator and writer',
 'غلامحسین قراگزلو، فرزند غلامعلی و برادرزاده شیخ محبعلی',
 'Source-captioned modern portrait of a Gholamhossein Gharagozloo described as a translator and writer. This person is intentionally not conflated with P0008.',
 'not_applicable','confirmed','A0228.jpg',
 'Facebook-source identification. Exact canonical identity unresolved.'),
('A0229','S0205','17','photograph',
 'Dr. Houshang Farmand Gharagozloo',
 'تصویری از دکتر هوشنگ فرمند قراگزلو از چهره‌های علمی ایل بزرگ قراگزلو',
 'Source-captioned portrait of Dr. Houshang Farmand Gharagozloo.',
 'not_applicable','confirmed','A0229.jpg',
 'Facebook-source identification. No current canonical P-ID found in v2.9.3 live-person reconciliation.'),
('A0230','S0205','24','photograph',
 'Hossein Ali Gharagozloo with Irandokht Teymourtash',
 'تصویری از حسینعلی قراگزلو و همسرش ایراندخت تیمورتاش',
 'Source-captioned photograph of Hossein Ali Gharagozloo with his wife Irandokht Teymourtash.',
 'not_applicable','confirmed','A0230.jpg',
 'Facebook-source identification. Hossein Ali is linked to P0093; Irandokht Teymourtash is preserved in caption only pending separate reconciliation.'),
('A0231','S0205','33','photograph',
 'Agha Mohammad Khan Gharagozloo',
 'آقای محمد خان قراگزلو، آخرین فرزند امیرتومان منصورالدوله قراگزلو',
 'Source-captioned portrait of Agha Mohammad Khan Gharagozloo, described as the last son of Amir Toman Mansur al-Dowleh.',
 'not_applicable','confirmed','A0231.jpg',
 'Facebook-source identification. Exact canonical P-ID unresolved; no forced linkage.'),
('A0232','S0205','34','photograph',
 'Hossein Khan Hesam al-Molk I',
 'امیرتومان (سرلشکر) حسین خان حسام‌الملک اول، پسر علی خان نصرت‌الملک قراگزلو',
 'Source-captioned historical portrait of Hossein Khan Hesam al-Molk I.',
 'not_applicable','confirmed','A0232.jpg',
 'Facebook-source identification; linked to canonical P0022. A separate family-verified portrait already exists and remains stronger evidence.'),
('A0233','S0205','34','photograph',
 'Zeyn al-Abedin Khan Amir Afkham — Hesam al-Molk II',
 'سرتیپ امیر افخم حسام‌الملک دوم قراگزلو',
 'Source-captioned historical portrait of Zeyn al-Abedin Khan Amir Afkham / Hesam al-Molk II.',
 'not_applicable','confirmed','A0233.jpg',
 'Facebook-source identification; linked to canonical P0023.'),
('A0234','S0205','37','photograph',
 'Gholamreza Khan Ehtesham al-Dowleh Gharagozloo',
 'غلامرضا خان احتشام‌الدوله قراگزلو، داماد مظفرالدین شاه قاجار و فرزند امیر افخم حسام‌الملک',
 'Source-captioned childhood portrait of Gholamreza Khan Ehtesham al-Dowleh.',
 'not_applicable','confirmed','A0234.jpg',
 'Facebook-source identification; linked to canonical P0024.'),
('A0235','S0205','62','photograph',
 'Fazlollah Khan Gharagozloo — Entesar al-Molk',
 'فضل‌الله خان قراگزلو (انتصارالملک)',
 'Source-captioned historical portrait of Fazlollah Khan Gharagozloo, Entesar al-Molk.',
 'not_applicable','confirmed','A0235.jpg',
 'Facebook-source identification. Exact canonical P-ID unresolved; preserved in global Gallery without forced person linkage.'),
('A0236','S0205','77','photograph',
 'Mohtaj Ali Khan Gharagozloo — Amir Arfa',
 'محتاج علی خان قراگزلو (امیر ارفع)',
 'Source-captioned individual portrait of Mohtaj Ali Khan Amir Arfa. The user explicitly selected this photograph to be the main portrait for P0005.',
 'not_applicable','confirmed','A0236.jpg',
 'Facebook-source identification; linked to canonical P0005. Curator-selected primary portrait by explicit user instruction.');

INSERT OR IGNORE INTO artifact_persons(artifact_id, person_id, role, notes) VALUES
('A0224','P0042','subject','Caption identifies Mohsen Khan Gharagozloo; other captioned people remain contextual/unlinked.'),
('A0225','P0023','subject','Source-captioned identity.'),
('A0227','P0033','subject','Source-captioned identity.'),
('A0230','P0093','subject','Source-captioned identity; spouse retained in caption only.'),
('A0232','P0022','subject','Source-captioned identity.'),
('A0233','P0023','subject','Source-captioned identity.'),
('A0234','P0024','subject','Source-captioned identity.'),
('A0236','P0005','subject','Source-captioned identity; primary portrait chosen explicitly by archive curator/user.');

INSERT OR IGNORE INTO artifact_gallery_metadata(
    artifact_id, verification_class, display_status, selection_notes
) VALUES
('A0224','source_captioned','visible','Visible globally; P0042 linked from caption, remaining identities contextual.'),
('A0225','source_captioned','visible','Visible globally and in P0023 Gallery.'),
('A0226','source_captioned','visible','Visible globally; no forced person linkage while canonical identity remains unresolved.'),
('A0227','source_captioned','visible','Visible globally and in P0033 Gallery.'),
('A0228','source_captioned','visible','Visible globally; deliberately not conflated with P0008.'),
('A0229','source_captioned','visible','Visible globally; unresolved/new-person candidate.'),
('A0230','source_captioned','visible','Visible globally and in P0093 Gallery; spouse remains caption-only.'),
('A0231','source_captioned','visible','Visible globally; unresolved exact canonical identity.'),
('A0232','source_captioned','visible','Visible globally and in P0022 Gallery; does not replace family-verified primary portrait.'),
('A0233','source_captioned','visible','Visible globally and in P0023 Gallery.'),
('A0234','source_captioned','visible','Visible globally and in P0024 Gallery.'),
('A0235','source_captioned','visible','Visible globally; unresolved exact canonical identity.'),
('A0236','source_captioned','visible','Visible globally and in P0005 Gallery; explicitly selected by user as P0005 primary portrait.');

-- Explicit curator override requested by the user:
-- use the page-77 individual portrait as Mohtaj Ali Amir Arfa's primary portrait.
-- The previous family-verified group photograph A0214 remains preserved in the Gallery.
INSERT OR REPLACE INTO person_primary_portraits(
    person_id, artifact_id, selection_basis, selected_by, notes
) VALUES (
    'P0005',
    'A0236',
    'User-curated individual portrait preferred over group photograph',
    'archive curator / explicit user selection',
    'Source-captioned individual portrait from Facebook compilation. A0214 remains family-verified and preserved in P0005 Gallery.'
);
