
-- Migration 0005: Complete remaining Chapter 3, printed pages 146-166.
-- Chapter 4 begins immediately after printed page 166.



INSERT OR IGNORE INTO titles(title_id,title_en,title_fa,meaning_notes) VALUES
('T0016','Naser al-Molk','ناصرالملک',NULL),
('T0017','Sarem al-Saltaneh','صارم‌السلطنه',NULL),
('T0018','Sardar Akram','سردار اکرم',NULL),
('T0019','Ejlal al-Mamalek','اجلال‌الممالک',NULL),
('T0020','Zia al-Molk','ضیاءالملک',NULL),
('T0021','Baha al-Molk','بهاءالملک',NULL),
('T0022','Amir Afkham','امیر افخم',NULL),
('T0023','Ehtesham al-Dowleh','احتشام‌الدوله',NULL);

INSERT OR IGNORE INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes) VALUES
('L0015','Gilan','گیلان','province',NULL,NULL),
('L0016','Kurdistan','کردستان','province',NULL,NULL),
('L0017','Khuzestan','خوزستان','province',NULL,NULL),
('L0018','Borujerd','بروجرد','city',NULL,NULL),
('L0019','Shervin','شروین','village/estate','L0001','Major Gharagozloo residence and estate near Hamadan.'),
('L0020','Tabriz','تبریز','city',NULL,NULL),
('L0021','Shiraz','شیراز','city',NULL,NULL);

INSERT OR IGNORE INTO persons(person_id,preferred_name_en,preferred_name_fa,sex,birth_date_text,death_date_text,branch,summary,verification_status,created_at,updated_at) VALUES
('P0028','Abdollah Khan Sarem al-Saltaneh Gharagozloo','عبدالله خان صارم‌السلطنه قراگوزلو','M',NULL,'Dhu al-Qada 1278 AH','Ashiqloo','Son of Mohammad Hossein Khan; husband of a daughter of Mohammad Shah and father of Negar Khanom.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0029','Negar Khanom Gharagozloo','نگار خانم قراگوزلو','F',NULL,NULL,'Ashiqloo','Daughter of Abdollah Khan Sarem al-Saltaneh; wife of Ahmad Khan Sartip and later Abd al-Samad Mirza.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0030','Ahmad Khan Sartip Gharagozloo','احمد خان سرتیپ قراگوزلو','M',NULL,NULL,'Ashiqloo','Son of Mahmoud Khan Naser al-Molk; father of Mehdi Khan, Abd al-Ali Khan, and Abu al-Qasem Khan Naser al-Molk.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0031','Amanollah Khan Baha al-Molk Gharagozloo','امان‌الله خان بهاءالملک قراگوزلو','M',NULL,'1296 AH','Ashiqloo','Son of Nabi Khan; founder of the Baha al-Molk Abshini family.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0032','Hossein Qoli Khan Zia al-Molk Gharagozloo','حسینقلی خان ضیاءالملک قراگوزلو','M',NULL,NULL,'Ashiqloo','Son of Amanollah Khan and progenitor of the Zia al-Molk Hamadani line.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0033','Ali Qoli Khan Baha al-Molk Gharagozloo','علیقلی خان بهاءالملک قراگوزلو','M',NULL,NULL,'Ashiqloo','Son of Amanollah Khan and progenitor of the Baha al-Molk Hamadani line.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0034','Morteza Qoli Khan Gharagozloo','مرتضی‌قلی خان قراگوزلو','M',NULL,NULL,'Ashiqloo','Son of Amanollah Khan and progenitor of the Sangestani line.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0035','Seyyed Jamal al-Din Vaez Esfahani','سید جمال‌الدین واعظ اصفهانی','M',NULL,'25 Shawwal 1326 AH',NULL,'Constitutionalist preacher killed in Borujerd by order of Amir Afkham.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0036','Qamar al-Saltaneh Qajar','قمرالسلطنه قاجار','F',NULL,NULL,NULL,'Daughter of Mozaffar al-Din Shah and wife of Gholamreza Khan Ehtesham al-Dowleh.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0037','Alireza Khan Baha al-Molk Gharagozloo','علیرضا خان بهاءالملک قراگوزلو','M',NULL,NULL,'Ashiqloo','Educated Gharagozloo notable elected from Hamadan to the Third Majles and later finance minister.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0038','Mohammad Ebrahim Khan Gharagozloo','محمدابراهیم خان قراگوزلو','M',NULL,NULL,NULL,'Son of Mehdi Khan Amir Tuman; third secretary at the Iranian legation in London, 1299-1303 SH.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0039','Zia al-Molk Farmand Gharagozloo','ضیاءالملک فرمند قراگوزلو','M',NULL,NULL,'Zia al-Molk','Representative of Hamadan in the Constituent Assembly of 1304 SH.','confirmed','2026-07-11T06:01:08.791373+00:00','2026-07-11T06:01:08.791373+00:00'),
('P0040','Abu al-Qasem Khan Naser al-Molk Gharagozloo','ابوالقاسم خان ناصرالملک قراگوزلو','M','14 Dhu al-Qada 1272 AH',NULL,'Ashiqloo','Oxford-educated statesman, minister, and regent for Ahmad Shah.','confirmed','2026-07-11T06:02:17.287873+00:00','2026-07-11T06:02:17.287873+00:00');

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0028','Abdollah Khan Sarem al-Saltaneh Gharagozloo','en','preferred',1),
('P0029','Negar Khanom Gharagozloo','en','preferred',1),
('P0030','Ahmad Khan Sartip Gharagozloo','en','preferred',1),
('P0031','Amanollah Khan Baha al-Molk Gharagozloo','en','preferred',1),
('P0032','Hossein Qoli Khan Zia al-Molk Gharagozloo','en','preferred',1),
('P0033','Ali Qoli Khan Baha al-Molk Gharagozloo','en','preferred',1),
('P0034','Morteza Qoli Khan Gharagozloo','en','preferred',1),
('P0035','Seyyed Jamal al-Din Vaez Esfahani','en','preferred',1),
('P0036','Qamar al-Saltaneh Qajar','en','preferred',1),
('P0037','Alireza Khan Baha al-Molk Gharagozloo','en','preferred',1),
('P0038','Mohammad Ebrahim Khan Gharagozloo','en','preferred',1),
('P0039','Zia al-Molk Farmand Gharagozloo','en','preferred',1),
('P0040','Abu al-Qasem Khan Naser al-Molk Gharagozloo','en','preferred',1);

INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes) VALUES
('P0014','T0016','1275 AH','Mahmoud Khan received the title Naser al-Molk.'),
('P0028','T0017',NULL,NULL),
('P0031','T0021',NULL,NULL),
('P0032','T0020',NULL,NULL),
('P0033','T0021',NULL,NULL),
('P0023','T0022',NULL,'Also called Amir Afkham in the Constitutional-period narrative.'),
('P0024','T0023',NULL,NULL),
('P0037','T0021',NULL,NULL),
('P0040','T0016','1305 AH','Inherited the title Naser al-Molk after the death of Mahmoud Khan.');

INSERT OR IGNORE INTO relationships(relationship_id,person1_id,relationship_type,person2_id,notes,verification_status) VALUES
('R0018','P0011','parent_of','P0028','Book identifies Abdollah Khan Sarem al-Saltaneh as a son of Mohammad Hossein Khan.','confirmed'),
('R0019','P0028','parent_of','P0029','Negar Khanom was his daughter.','confirmed'),
('R0020','P0014','parent_of','P0030','Ahmad Khan Sartip was a son of Mahmoud Khan Naser al-Molk.','confirmed'),
('R0021','P0030','spouse_of','P0029','Marriage produced Mehdi Khan and Abd al-Ali Khan.','confirmed'),
('R0022','P0013','parent_of','P0031','Amanollah Khan was a son of Nabi Khan.','confirmed'),
('R0023','P0031','parent_of','P0032',NULL,'confirmed'),
('R0024','P0031','parent_of','P0033',NULL,'confirmed'),
('R0025','P0031','parent_of','P0034',NULL,'confirmed'),
('R0026','P0024','spouse_of','P0036','Qamar al-Saltaneh was wife of Gholamreza Khan Ehtesham al-Dowleh.','confirmed');

INSERT OR IGNORE INTO events(event_id,event_type,title,date_text,place_id,description,verification_status) VALUES
('E0014','industrial_project','Mahmoud Khan steam spinning factory project','1275 AH',NULL,'Mahmoud Khan imported machinery from Moscow for a modern steam-powered spinning factory; the project failed for lack of trained operators.','confirmed'),
('E0015','ministerial_appointment','Mahmoud Khan appointed first minister of commerce','1277 AH',NULL,'Mahmoud Khan Naser al-Molk became the first holder of the newly established ministry of commerce.','confirmed'),
('E0016','death','Deaths of major Gharagozloo khans','1278-1307 AH',NULL,'The book records the deaths of Abdollah Khan Sarem al-Saltaneh, Ali Naqi Khan, Ali Khan Nosrat al-Molk, Amanollah Khan, Mostafa Qoli Khan, Mahmoud Khan, and Mohammad Hossein Khan Hosam al-Molk.','confirmed'),
('E0017','governorship','Abdollah Khan appointed governor of Khuzestan','1314 AH','L0017','Abdollah Khan Saed al-Saltaneh was appointed governor and received the title Sardar Akram.','confirmed'),
('E0018','education','Foundation of the Islamiyyeh School at Shervin','1322 AH','L0019','Hosam al-Molk and Zia al-Molk established the Islamiyyeh School.','confirmed'),
('E0019','economic_conflict','Gharagozloo grain blockade and Hamadan bread crisis','1324 AH','L0001','Gharagozloo landowners restricted grain deliveries during conflict with the Majles-e Favaed-e Ammeh and Constitutionalists.','confirmed'),
('E0020','political_assassination','Killing of Seyyed Jamal al-Din Vaez Esfahani','25 Shawwal 1326 AH','L0018','The preacher was delivered to Amir Afkham’s circle and killed in Borujerd.','confirmed'),
('E0021','military_campaign','Gharagozloo regiments against Tabriz Constitutionalists','1326 AH','L0020','Regiments commanded by Sardar Akram, Mansur al-Dowleh, and Amir Afkham supported Mohammad Ali Shah against Tabriz.','confirmed'),
('E0022','rebellion','Gharagozloo participation in the Salar al-Dowleh crisis','1329-1330 AH',NULL,'Amir Nezam and other khans shifted positions during Salar al-Dowleh’s rebellion; Amir Afkham later joined government forces.','confirmed'),
('E0023','parliamentary_action','Naser al-Molk dissolves the Second Majles','1330 AH',NULL,'As regent, Naser al-Molk ordered Yeprem Khan to close the Second Majles during the Russian ultimatum crisis.','confirmed'),
('E0024','world_war','Russian occupation of Hamadan and appointment of Amir Afkham','1334 AH','L0001','Russian forces occupied Hamadan with assistance from Amir Afkham, who was installed as governor.','confirmed'),
('E0025','coup_aftermath','Arrest and release of Amir Nezam after the 1921 coup','1299 SH',NULL,'Amir Nezam was arrested by Seyyed Zia’s government and reportedly paid 25,000 tomans to secure release.','confirmed'),
('E0026','constitutional_assembly','Gharagozloo participation in the 1304 SH Constituent Assembly','1304 SH',NULL,'Zia al-Molk Farmand represented Hamadan in the assembly that confirmed Reza Shah.','confirmed');

INSERT OR IGNORE INTO event_persons(event_id,person_id,role) VALUES
('E0014','P0014','industrial sponsor'),
('E0015','P0014','minister of commerce'),
('E0016','P0028','deceased khan'),
('E0016','P0020','deceased khan'),
('E0016','P0019','deceased khan'),
('E0016','P0031','deceased khan'),
('E0016','P0003','deceased khan'),
('E0016','P0014','deceased khan'),
('E0016','P0022','deceased khan'),
('E0017','P0004','governor titled Sardar Akram'),
('E0018','P0023','co-founder'),
('E0018','P0032','co-founder'),
('E0019','P0023','major landowning khan'),
('E0019','P0024','participant in resistance'),
('E0020','P0035','victim'),
('E0020','P0023','ordering authority identified by the book'),
('E0020','P0024','custodian before killing'),
('E0020','P0036','advocated clemency'),
('E0021','P0004','regimental commander'),
('E0021','P0006','regimental commander'),
('E0021','P0023','Qajar commander'),
('E0022','P0004','commander whose conduct was disputed'),
('E0022','P0023','later joined government forces'),
('E0023','P0040','regent ordering closure'),
('E0024','P0023','pro-Russian intermediary and governor'),
('E0025','P0004','arrested former war minister'),
('E0026','P0039','Hamadan representative');

INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X0028','S0001','146-147',NULL,'Mahmoud Khan industry and offices','Mahmoud Khan imported machinery for a steam spinning mill, became first minister of commerce, and held posts in Gilan, Khorasan, Kurdistan, and London diplomacy.',NULL),
('X0029','S0001','147-150',NULL,'Deaths and family relations','The book records deaths, marriages, succession, and offspring among Sarem al-Saltaneh, Ali Naqi Khan, Ali Khan, Amanollah Khan, Mostafa Qoli Khan, Mahmoud Khan, and Hosam al-Molk.',NULL),
('X0030','S0001','151-153',NULL,'Mozaffar al-Din Shah period appointments','Hosam al-Molk, Abdollah Khan Sardar Akram, and their sons received governorships, titles, and honors; Islamiyyeh School was founded at Shervin.',NULL),
('X0031','S0001','154-158',NULL,'Hamadan grain crisis','Gharagozloo khans restricted grain, resisted official orders, and attempted to remove Vakil al-Roaya after the bread crisis.','NULL'),
('X0032','S0001','159-161',NULL,'Mohammad Ali Shah and Jamal al-Din Vaez','Gharagozloo regiments fought Tabriz Constitutionalists and Amir Afkham ordered the killing of Seyyed Jamal al-Din Vaez in Borujerd.',NULL),
('X0033','S0001','161-163',NULL,'Regency and Salar al-Dowleh','Naser al-Molk became regent; Gharagozloo khans participated ambiguously in the Salar al-Dowleh crisis; the Second Majles was dissolved.','NULL'),
('X0034','S0001','164-166',NULL,'World War I to fall of Qajars','Alireza Baha al-Molk entered the Third Majles; Russian forces occupied Hamadan with Amir Afkham’s support; Amir Nezam served as war minister and was arrested after the 1921 coup; Zia al-Molk Farmand joined the Constituent Assembly.','NULL');

UPDATE citations SET notes=NULL WHERE citation_id IN ('X0031','X0033','X0034');

INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C0054','person','P0014','industrial_project','Mahmoud Khan imported approximately 90,000 tomans of machinery from Moscow for a steam-powered spinning factory, but the project failed because trained personnel were unavailable.','confirmed','active',NULL),
('C0055','person','P0014','ministerial_office','Mahmoud Khan became the first minister of commerce when that ministry was established in 1277 AH.','confirmed','active',NULL),
('C0056','person','P0028','death','Abdollah Khan Sarem al-Saltaneh died in Dhu al-Qada 1278 AH.','confirmed','active',NULL),
('C0057','person','P0028','marriage','His wife was a granddaughter of Abbas Mirza and daughter of Mohammad Shah.','confirmed','active',NULL),
('C0058','person','P0029','marriages','Negar Khanom married Ahmad Khan Sartip and later Abd al-Samad Mirza, governor of Hamadan.','confirmed','active',NULL),
('C0059','person','P0031','lineage','Amanollah Khan Baha al-Molk was a son of Nabi Khan and founder of the Baha al-Molk Abshini family.','confirmed','active',NULL),
('C0060','person','P0031','children','His sons were Hossein Qoli Khan, Ali Qoli Khan, and Morteza Qoli Khan, founders of three later family lines.','confirmed','active',NULL),
('C0061','person','P0004','governorship','Abdollah Khan was appointed governor of Khuzestan in 1314 AH and received the title Sardar Akram.','confirmed','active',NULL),
('C0062','person','P0005','title_grant','Mohtaj Ali Khan received the title Ejlal al-Mamalek at his father’s request in 1314 AH.','confirmed','active',NULL),
('C0063','event','E0018','foundation','Hosam al-Molk and Zia al-Molk founded the Islamiyyeh School at Shervin in 1322 AH.','confirmed','active',NULL),
('C0064','event','E0019','grain_quantities','Hamadan representatives demanded 25,000 kharvars of grain at 10 tomans per kharvar from an alleged stock of 200,000 kharvars.','confirmed','active',NULL),
('C0065','event','E0019','estate_scale','Opponents claimed Gharagozloo khans held nearly 700 properties across several Hamadan districts.','confirmed','active',NULL),
('C0066','person','P0023','political_alignment','Amir Afkham was a leading royalist Qajar commander against Constitutionalists.','confirmed','active',NULL),
('C0067','person','P0023','assassination_order','The book attributes the killing of Seyyed Jamal al-Din Vaez Esfahani to Amir Afkham’s order.','confirmed','active',NULL),
('C0068','person','P0036','clemency_attempt','Qamar al-Saltaneh asked Amir Afkham and her husband Ehtesham al-Dowleh to spare Seyyed Jamal al-Din.','confirmed','active',NULL),
('C0069','person','P0040','regency','Abu al-Qasem Naser al-Molk became regent for Ahmad Shah and swore the regency oath in 1329 AH.','confirmed','active',NULL),
('C0070','event','E0023','closure','The Second Majles was closed on Naser al-Molk’s order during the Russian ultimatum crisis.','confirmed','active',NULL),
('C0071','person','P0037','parliamentary_service','Alireza Khan Baha al-Molk represented Hamadan in the Third Majles.','confirmed','active',NULL),
('C0072','person','P0037','ministerial_office','Alireza Baha al-Molk served as finance minister in Mostowfi al-Mamalek’s cabinet in 1301 SH.','confirmed','active',NULL),
('C0073','person','P0023','wartime_governorship','Amir Afkham assisted Russian forces in occupying Hamadan and became governor under Russian protection.','confirmed','active',NULL),
('C0074','person','P0004','war_ministry','Amir Nezam Gharagozloo served as minister of war in Sepahdar Azam’s cabinet shortly before the 1921 coup.','confirmed','active',NULL),
('C0075','person','P0004','release_payment','After the 1921 coup, Amir Nezam reportedly paid 25,000 tomans to obtain release from detention.','confirmed','active',NULL),
('C0076','person','P0038','diplomatic_service','Mohammad Ebrahim Khan served as third secretary of the Iranian legation in London from 1299 to 1303 SH.','confirmed','active',NULL),
('C0077','person','P0039','assembly_service','Zia al-Molk Farmand represented Hamadan in the Constituent Assembly of 1304 SH.','confirmed','active',NULL);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0054','X0028','supports'),
('C0055','X0028','supports'),
('C0056','X0029','supports'),
('C0057','X0029','supports'),
('C0058','X0029','supports'),
('C0059','X0029','supports'),
('C0060','X0029','supports'),
('C0061','X0030','supports'),
('C0062','X0030','supports'),
('C0063','X0030','supports'),
('C0064','X0031','supports'),
('C0065','X0031','supports'),
('C0066','X0032','supports'),
('C0067','X0032','supports'),
('C0068','X0032','supports'),
('C0069','X0033','supports'),
('C0070','X0033','supports'),
('C0071','X0034','supports'),
('C0072','X0034','supports'),
('C0073','X0034','supports'),
('C0074','X0034','supports'),
('C0075','X0034','supports'),
('C0076','X0034','supports'),
('C0077','X0034','supports');

INSERT OR IGNORE INTO research_questions(question_id,question,status,priority,notes) VALUES
('Q0006','Review all claims and citations for the two different holders of the title Naser al-Molk: Mahmoud Khan and Abu al-Qasem Khan.','open','high','The canonical persons are now separated as P0014 and P0040.');