
-- Migration 0004: Chapter 3, printed pages 141-145

INSERT OR IGNORE INTO persons(person_id,preferred_name_en,preferred_name_fa,sex,birth_date_text,death_date_text,branch,summary,verification_status,created_at,updated_at) VALUES
('P0025','Aqa Jan Gharagozloo','آقاجان قراگوزلو','M',NULL,NULL,NULL,'Gharagozloo officer with the rank of yavar, involved in a diplomatic incident with the Russian embassy in 1313 AH.','confirmed','2026-07-11T05:49:59.145248+00:00','2026-07-11T05:49:59.145248+00:00'),
('P0026','Hasan Tupchi','حسن توپچی','M',NULL,NULL,NULL,'Servant of Aqa Jan Gharagozloo involved in the death of a Russian coachman.','confirmed','2026-07-11T05:49:59.145248+00:00','2026-07-11T05:49:59.145248+00:00'),
('P0027','Pavlov','پاولوف','M',NULL,'1313 AH',NULL,'Russian coachman killed during an altercation involving Hasan Tupchi.','confirmed','2026-07-11T05:49:59.145248+00:00','2026-07-11T05:49:59.145248+00:00');

INSERT OR IGNORE INTO person_names(person_id,name_text,language,name_type,is_preferred) VALUES
('P0025','Aqa Jan Gharagozloo','en','preferred',1),
('P0026','Hasan Tupchi','en','preferred',1),
('P0027','Pavlov','en','preferred',1);

INSERT OR IGNORE INTO person_titles(person_id,title_id,date_text,notes) VALUES
('P0025','T0010','1313 AH','The book identifies Aqa Jan as holding the rank of yavar.'),
('P0014','T0011','1254 AH','Mohammad Shah appointed Mahmoud Khan colonel and placed his father’s forces under him.'),
('P0014','T0009','1255 AH','Promoted to sartip before military service in Khorasan.'),
('P0014','T0012','1272 AH','Promoted to mirpanj after returning from Russia.');

INSERT OR IGNORE INTO events(event_id,event_type,title,date_text,place_id,description,verification_status) VALUES
('E0009','governorship','Hosam al-Molk appointed governor of Kermanshah','12 Rabi I 1311 AH','L0014','After extensive attempts to obtain provincial office, Zeyn al-Abedin Khan Hosam al-Molk was appointed governor of Kermanshah.','confirmed'),
('E0010','diplomatic_legal_incident','Aqa Jan Gharagozloo and the Russian embassy case','11 Shaban 1313 AH',NULL,'After Pavlov was killed in an altercation involving Aqa Jan’s servant, Aqa Jan fled, was arrested in Hamadan, imprisoned in Tehran, and handed to the Russian embassy.','confirmed'),
('E0011','military_operation','Gharagozloo regiments sent against unrest in Shiraz','21 Shawwal 1311 AH',NULL,'Gharagozloo regiments under Saed al-Saltaneh were sent to suppress unrest in Shiraz; seven or eight people were killed.','confirmed'),
('E0012','appointment','Mahmoud Khan appointed colonel and successor to Nabi Khan’s command','Shaban 1254 AH',NULL,'Mohammad Shah appointed Mahmoud Khan colonel and placed Nabi Khan’s former troops under his command.','confirmed'),
('E0013','diplomatic_mission','Mahmoud Khan mission to Russia','1269-1272 AH',NULL,'Mahmoud Khan served as Iranian envoy to Russia and returned with promotion and royal honors.','confirmed');

INSERT OR IGNORE INTO event_persons(event_id,person_id,role) VALUES
('E0009','P0023','governor'),
('E0010','P0025','officer transferred to Russian embassy'),
('E0010','P0026','servant involved in altercation'),
('E0010','P0027','deceased Russian coachman'),
('E0011','P0004','commander titled Saed al-Saltaneh'),
('E0012','P0014','appointed colonel and commander'),
('E0013','P0014','Iranian envoy to Russia');

INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X0022','S0001','141',NULL,'Hosam al-Molk offices and bribes','Hosam al-Molk offered very large payments to obtain provincial governments and was ultimately appointed governor of Kermanshah on 12 Rabi I 1311 AH.',NULL),
('X0023','S0001','141',NULL,'Aqa Jan case','Aqa Jan Gharagozloo, a yavar, fled after Pavlov was killed in an altercation with his servant Hasan Tupchi; he was arrested in Hamadan and delivered to the Russian embassy.',NULL),
('X0024','S0001','142',NULL,'Late Qajar military decline and Shiraz mission','The role of tribal regiments declined; Gharagozloo forces under Saed al-Saltaneh were sent against unrest in Shiraz in Shawwal 1311 AH, with seven or eight deaths.',NULL),
('X0025','S0001','142-143',NULL,'Mahmoud Khan succession and governorships','Mahmoud Khan, son of Nabi Khan, inherited his father’s command, served as deputy governor in Hamadan, and received several district governments.','NULL'),
('X0026','S0001','143',NULL,'Mahmoud Khan promotion','After Nabi Khan’s death, Mahmoud Khan was appointed colonel in 1254 AH and promoted to sartip in 1255 AH before service in Khorasan.',NULL),
('X0027','S0001','144-145',NULL,'Mahmoud Khan diplomatic and ministerial career','Mahmoud Khan served as envoy to Russia, returned as mirpanj, and later held senior ministries and ceremonial diplomatic assignments.','NULL');

UPDATE citations SET notes=NULL WHERE citation_id IN ('X0025','X0027');

INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C0041','person','P0023','office_purchase_attempt','Hosam al-Molk offered 100,000 tomans for the governments of Hamadan, Borujerd, and Luristan, then 80,000 tomans to the shah and 20,000 to Amin al-Soltan for Kerman.','confirmed','active',NULL),
('C0042','person','P0023','governorship','Hosam al-Molk was appointed governor of Kermanshah on 12 Rabi I 1311 AH.','confirmed','active',NULL),
('C0043','person','P0025','rank','Aqa Jan Gharagozloo held the rank of yavar.','confirmed','active',NULL),
('C0044','person','P0025','legal_diplomatic_action','Aqa Jan fled after Pavlov’s death, was captured in Hamadan, imprisoned in Tehran, and handed to the Russian embassy.','confirmed','active',NULL),
('C0045','event','E0011','casualties','Seven or eight people were killed during the confrontation between Gharagozloo forces and residents of Shiraz.','confirmed','active',NULL),
('C0046','person','P0014','parentage','Mahmoud Khan was the son of Nabi Khan and a descendant of Mohammad Hossein Khan of the Ashiqloo branch.','confirmed','active',NULL),
('C0047','person','P0014','succession','After Nabi Khan’s death in the Herat campaign, Mahmoud Khan was placed in command of his father’s troops.','confirmed','active',NULL),
('C0048','person','P0014','deputy_governorship','Mahmoud Khan served as deputy governor of Hamadan and the Gharagozloo districts during the late reign of Fath Ali Shah.','confirmed','active',NULL),
('C0049','person','P0014','district_governorships','Mahmoud Khan received authority over Darjazin, Jahraman, Tohidlu, and the districts attached to Khan Baba Khan in 1246-1247 AH.','confirmed','active',NULL),
('C0050','person','P0014','promotion','Mahmoud Khan was appointed colonel in 1254 AH and promoted to sartip in 1255 AH.','confirmed','active',NULL),
('C0051','person','P0014','diplomatic_service','Mahmoud Khan was appointed Iranian envoy to Russia in 1269 AH.','confirmed','active',NULL),
('C0052','person','P0014','promotion','After returning from Saint Petersburg in 1272 AH, Mahmoud Khan was promoted to mirpanj and received a royal robe.','confirmed','active',NULL),
('C0053','person','P0014','government_service','Mahmoud Khan later held senior posts including foreign affairs, war, state buildings, and government papers administration.','confirmed','active',NULL);

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0041','X0022','supports'),
('C0042','X0022','supports'),
('C0043','X0023','supports'),
('C0044','X0023','supports'),
('C0045','X0024','supports'),
('C0046','X0025','supports'),
('C0047','X0025','supports'),
('C0048','X0025','supports'),
('C0049','X0025','supports'),
('C0050','X0026','supports'),
('C0051','X0027','supports'),
('C0052','X0027','supports'),
('C0053','X0027','supports');
