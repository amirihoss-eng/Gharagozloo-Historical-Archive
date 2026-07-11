
-- Migration 0003: Chapter 3, printed pages 135-140
-- Anglo-Persian War, Laristan, Kerman service, western Iran, and Hamadan unrest.

INSERT OR IGNORE INTO titles(title_id,title_en,title_fa,meaning_notes) VALUES
('T0012','Mirpanj','میرپنج','Qajar military rank'),
('T0013','Nosrat al-Molk','نصرت‌الملک',NULL),
('T0014','Hosam al-Molk','حسام‌الملک',NULL),
('T0015','Ehtesham al-Saltaneh','احتشام‌السلطنه',NULL);

INSERT OR IGNORE INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes) VALUES
('L0009','Bandar Lengeh','بندر لنگه','port/city',NULL,NULL),
('L0010','Dalaki','دالکی','town/river area',NULL,NULL),
('L0011','Kerman','کرمان','province/city',NULL,NULL),
('L0012','Laristan','لارستان','region',NULL,NULL),
('L0013','Bikhuh district','محال بیخو','district',NULL,NULL),
('L0014','Kermanshah','کرمانشاه','province/city',NULL,NULL);

INSERT OR IGNORE INTO persons(person_id,preferred_name_en,preferred_name_fa,sex,birth_date_text,death_date_text,branch,summary,verification_status,created_at,updated_at) VALUES
('P0018','Rustam Khan Gharagozloo','رستم خان قراگوزلو','M',NULL,NULL,'Ashiqloo','Gharagozloo brigadier active in the southern campaigns against British forces.','confirmed','2026-07-11T03:59:46.139916+00:00','2026-07-11T03:59:46.139916+00:00'),
('P0019','Ali Khan Nosrat al-Molk Gharagozloo','علی خان نصرت‌الملک قراگوزلو','M',NULL,NULL,'Ashiqloo','Son of Rustam Khan; senior Gharagozloo officer active in southern Iran and Kerman.','confirmed','2026-07-11T03:59:46.139916+00:00','2026-07-11T03:59:46.139916+00:00'),
('P0020','Ali Naqi Khan Gharagozloo','علینقی خان قراگوزلو','M',NULL,NULL,NULL,'Commander of the Dargazin infantry regiment in the Laristan campaign.','confirmed','2026-07-11T03:59:46.139916+00:00','2026-07-11T03:59:46.139916+00:00'),
('P0021','Lotf Ali Khan Sartip Gharagozloo','لطفعلی خان سرتیپ قراگوزلو','M',NULL,NULL,NULL,'Commander associated with the sixth Gharagozloo regiment in Kerman.','confirmed','2026-07-11T03:59:46.139916+00:00','2026-07-11T03:59:46.139916+00:00'),
('P0022','Mohammad Hossein Khan Hosam al-Molk Gharagozloo','محمدحسین خان حسام‌الملک قراگوزلو','M',NULL,NULL,'Ashiqloo','Son of Ali Khan; Gharagozloo officer rewarded for service in Kerman.','confirmed','2026-07-11T03:59:46.139916+00:00','2026-07-11T03:59:46.139916+00:00'),
('P0023','Zeyn al-Abedin Khan Hosam al-Molk Gharagozloo','زین‌العابدین خان حسام‌الملک قراگوزلو','M',NULL,NULL,'Ashiqloo','Prominent Gharagozloo khan active in Kermanshah and Hamadan politics.','confirmed','2026-07-11T03:59:46.139916+00:00','2026-07-11T03:59:46.139916+00:00'),
('P0024','Gholamreza Khan Ehtesham al-Saltaneh Gharagozloo','غلامرضا خان احتشام‌السلطنه قراگوزلو','M',NULL,NULL,'Ashiqloo','Son of Zeyn al-Abedin Khan; married Qamar al-Saltaneh in 1309 AH.','confirmed','2026-07-11T03:59:46.139916+00:00','2026-07-11T03:59:46.139916+00:00');

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0018','Rustam Khan Gharagozloo','en','preferred',1),
('P0019','Ali Khan Nosrat al-Molk Gharagozloo','en','preferred',1),
('P0020','Ali Naqi Khan Gharagozloo','en','preferred',1),
('P0021','Lotf Ali Khan Sartip Gharagozloo','en','preferred',1),
('P0022','Mohammad Hossein Khan Hosam al-Molk Gharagozloo','en','preferred',1),
('P0023','Zeyn al-Abedin Khan Hosam al-Molk Gharagozloo','en','preferred',1),
('P0024','Gholamreza Khan Ehtesham al-Saltaneh Gharagozloo','en','preferred',1);

INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes) VALUES
('P0003','T0012','1273 AH','Described as mirpanj during the Bandar Lengeh operations.'),
('P0019','T0013',NULL,'Known as Nosrat al-Molk.'),
('P0022','T0014','1287 AH','Granted for service in Kerman.'),
('P0024','T0015',NULL,NULL);

INSERT OR IGNORE INTO relationships(relationship_id,person1_id,relationship_type,person2_id,notes,verification_status) VALUES
('R0015','P0018','parent_of','P0019','Printed page 135 identifies Ali Khan as Rustam Khan’s son.','confirmed'),
('R0016','P0019','parent_of','P0022','Printed page 137 identifies Mohammad Hossein Khan as Ali Khan’s son.','confirmed'),
('R0017','P0023','parent_of','P0024','Printed page 139 identifies Gholamreza Khan as Zeyn al-Abedin Khan’s son.','confirmed');

INSERT OR IGNORE INTO events(event_id,event_type,title,date_text,place_id,description,verification_status) VALUES
('E0004','military_campaign','Gharagozloo participation in the Anglo-Persian War in southern Iran','1273 AH','L0007','Mostafa Qoli Khan, Rustam Khan, and Ali Khan served against British forces around Bandar Lengeh, Bushehr, Dalaki, and Borazjan.','confirmed'),
('E0005','military_operation','Defeat of Nasrallah Khan of Laristan','1274 AH','L0012','Ali Naqi Khan led the Dargazin regiment and defeated Nasrallah Khan in Bikhuh district.','confirmed'),
('E0006','military_service','Gharagozloo military service in Kerman','1277-1287 AH','L0011','Ali Khan Nosrat al-Molk and other Gharagozloo officers served in Kerman; Mohammad Hossein Khan later received the title Hosam al-Molk.','confirmed'),
('E0007','political_social_event','Marriage of Gholamreza Khan and Qamar al-Saltaneh','1309 AH','L0014','A lavish dynastic marriage arranged by Zeyn al-Abedin Khan Hosam al-Molk.','confirmed'),
('E0008','political_repression','Arrest of Hamadan Gharagozloo amir-tumans','1310 AH','L0001','Following unrest in Hamadan, Hosam al-Molk, Saed al-Saltaneh, and Zia al-Molk were dismissed and detained.','confirmed');

INSERT OR IGNORE INTO event_persons(event_id,person_id,role) VALUES
('E0004','P0003','commander at Bandar Lengeh'),
('E0004','P0018','brigadier with artillery'),
('E0004','P0019','officer and son of Rustam Khan'),
('E0005','P0020','commander of Dargazin regiment'),
('E0006','P0019','senior officer in Kerman'),
('E0006','P0021','commander of sixth Gharagozloo regiment'),
('E0006','P0022','garrison officer rewarded for service'),
('E0007','P0023','father and organizer'),
('E0007','P0024','groom'),
('E0008','P0023','detained khan');

INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X0016','S0001','135',NULL,'Chapter 3, Anglo-Persian War','Mahmoud Khan advocated peace; Mostafa Qoli Khan Mirpanj attempted to stop the British ship at Bandar Lengeh and exchanged fire before withdrawing inland.',NULL),
('X0017','S0001','135-136',NULL,'Southern campaign','Rustam Khan and his son Ali Khan joined Iranian forces against the British; Ali Khan suffered a superficial arm wound and three Gharagozloo soldiers were captured.',NULL),
('X0018','S0001','137',NULL,'Laristan and Kerman operations','Ali Naqi Khan defeated Nasrallah Khan in Bikhuh; Ali Khan Nosrat al-Molk and Lotf Ali Khan served with Gharagozloo troops in Kerman.',NULL),
('X0019','S0001','137',NULL,'Kerman rewards','Mohammad Hossein Khan, son of Ali Khan, was granted the title Hosam al-Molk in 1287 AH for service in Kerman.',NULL),
('X0020','S0001','139',NULL,'Hosam al-Molk family marriage','Zeyn al-Abedin Khan married his son Gholamreza Khan Ehtesham al-Saltaneh to Qamar al-Saltaneh in 1309 AH in a costly month-long celebration.',NULL),
('X0021','S0001','140',NULL,'Hamadan arrests','Hosam al-Molk, Saed al-Saltaneh, and Zia al-Molk were blamed for unrest, dismissed, and detained in 1310 AH.',NULL);

INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C0029','person','P0014','political_position','Mahmoud Khan Gharagozloo argued for peace in a state consultation during the Anglo-Persian crisis.','probable','active','Identity with P0014 is contextually likely but should be rechecked.'),
('C0030','person','P0003','military_action','At Bandar Lengeh, Mostafa Qoli Khan Mirpanj tried to prevent a British ship carrying prisoners from departing; he exchanged fire with two guns and withdrew inland.','confirmed','active',NULL),
('C0031','person','P0018','military_action','Rustam Khan joined the southern Iranian forces with artillery during the Anglo-Persian War.','confirmed','active',NULL),
('C0032','person','P0019','wounding','Ali Khan received a superficial wound to the arm during fighting against British forces.','confirmed','active',NULL),
('C0033','event','E0004','captives','Two soldiers of the Gharagozloo special regiment and one of the fourth regiment were captured and later released in Bushehr.','confirmed','active',NULL),
('C0034','person','P0020','military_action','Ali Naqi Khan led the Dargazin infantry regiment and defeated Nasrallah Khan of Laristan in Bikhuh district.','confirmed','active',NULL),
('C0035','person','P0019','office','Ali Khan Nosrat al-Molk served as first-rank sartip responsible for order in Kerman in 1277 AH.','confirmed','active',NULL),
('C0036','person','P0019','military_activity','Ali Khan and his troops drilled daily in the Kerman citadel square and joined the expedition against Azad Khan Kharani.','confirmed','active',NULL),
('C0037','person','P0022','title_grant','Mohammad Hossein Khan, son of Ali Khan, received the title Hosam al-Molk in 1287 AH for service in Kerman.','confirmed','active',NULL),
('C0038','person','P0023','marriage_arrangement','Zeyn al-Abedin Khan arranged the marriage of his son Gholamreza Khan to Qamar al-Saltaneh in 1309 AH.','confirmed','active',NULL),
('C0039','event','E0007','scale','The wedding celebrations lasted about one month and reportedly cost more than one hundred thousand tomans.','confirmed','active',NULL),
('C0040','event','E0008','outcome','Hosam al-Molk, Saed al-Saltaneh, and Zia al-Molk were dismissed and detained after being blamed for the Hamadan unrest.','confirmed','active',NULL);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0029','X0016','supports'),
('C0030','X0016','supports'),
('C0031','X0017','supports'),
('C0032','X0017','supports'),
('C0033','X0017','supports'),
('C0034','X0018','supports'),
('C0035','X0018','supports'),
('C0036','X0018','supports'),
('C0037','X0019','supports'),
('C0038','X0020','supports'),
('C0039','X0020','supports'),
('C0040','X0021','supports');
