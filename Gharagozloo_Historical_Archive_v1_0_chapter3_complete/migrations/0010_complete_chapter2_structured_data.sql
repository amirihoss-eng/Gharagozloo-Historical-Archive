-- Chapter 2: social, economic, landed, and military structure (printed pp. 55-85).
-- Evidence policy: narrative text first; no diagram-only genealogy is inserted.

INSERT OR IGNORE INTO citations(citation_id,source_id,page_printed,page_file,locator_text,quoted_text,notes) VALUES
('X0062','S0001','55-60',NULL,'Chapter 2, section 2-1: social structure and principal branches',NULL,'Narrative-text evidence.'),
('X0063','S0001','59-61',NULL,'Chapter 2: major landed families and their property centers',NULL,'Narrative-text evidence.'),
('X0064','S0001','61-72',NULL,'Chapter 2, section 2-2: ownership and economic structure',NULL,'Narrative-text evidence.'),
('X0065','S0001','79-80',NULL,'Chapter 2, section 2-3: military hierarchy and Gharagozloo military importance',NULL,'Narrative-text evidence.'),
('X0066','S0001','80-82',NULL,'Chapter 2, section 2-3-1: principal Gharagozloo regiments',NULL,'Narrative-text evidence.'),
('X0067','S0001','81-82',NULL,'Chapter 2: command succession among regiments',NULL,'Narrative-text evidence.'),
('X0068','S0001','82-85',NULL,'Chapter 2: infantry service, artillery, pay arrears, and military office',NULL,'Narrative-text evidence.');

INSERT OR IGNORE INTO organizations(organization_id,preferred_name_en,preferred_name_fa,organization_type,parent_organization_id,date_text,description,verification_status) VALUES
('ORG0001','Gharagozloo','قراگوزلو','tribe',NULL,NULL,'The tribal grouping studied in S0001.','confirmed'),
('ORG0002','Hajilu branch','حاجیلو','tribal_branch','ORG0001',NULL,'One of the principal Gharagozloo branches.','confirmed'),
('ORG0003','Ashiqloo branch','عاشیقلو','tribal_branch','ORG0001',NULL,'One of the principal Gharagozloo branches.','confirmed'),
('ORG0004','Uzbeklu branch','ازبکلو','tribal_branch','ORG0001',NULL,'A named Gharagozloo branch; later absorption is discussed as a possibility, not a certainty.','confirmed'),
('ORG0005','Amir Afkham Shervini family','خانواده امیر افخم شروینی','family_branch','ORG0003',NULL,'Major landed family centered on Shervin.','confirmed'),
('ORG0006','Baha al-Molk Abshini family','خانواده بهاءالملک آبشینی','family_branch','ORG0003',NULL,'Major landed family associated with Abshineh, Sorkhabad, and Zagheh.','confirmed'),
('ORG0007','Amir Nezam Letgahi family','خانواده امیرنظام لتگاهی','family_branch','ORG0002',NULL,'Major landed family centered on Letgah and Kabudarahang.','confirmed'),
('ORG0008','Naser al-Molk Bahari family','خانواده ناصرالملک بهاری','family_branch','ORG0003',NULL,'Major landed family centered on Bahar.','confirmed');

INSERT OR IGNORE INTO organization_names(organization_id,name_text,language,name_type,is_preferred) VALUES
('ORG0001','Gharagozloo','en','preferred',1),('ORG0001','قراگوزلو','fa','preferred',1),
('ORG0002','Hajilu','en','alias',0),('ORG0003','Ashiqlo','en','alias',0),('ORG0004','Uzbeklu','en','alias',0);

INSERT OR IGNORE INTO places(place_id,preferred_name_en,preferred_name_fa,place_type,parent_place_id,notes) VALUES
('L0030','Bahar','بهار','town/estate center','L0001','Center of the Naser al-Molk Bahari family.'),
('L0031','Abshineh','آبشینه','village/estate','L0001','Associated with the Baha al-Molk family.'),
('L0032','Sorkhabad','سرخ‌آباد','village/estate','L0001','Early property center of Haji Amanollah Khan Baha al-Molk.'),
('L0033','Zagheh','زاغه','village/estate','L0001','Later property center of the Baha al-Molk family.'),
('L0034','Malayer','ملایر','region/city',NULL,'Associated with a regiment commanded in 1268 AH.'),
('L0035','Tuyserkan','تویسرکان','region/city',NULL,'Associated with a regiment commanded in 1268 AH.');

INSERT OR IGNORE INTO estates(estate_id,preferred_name_en,preferred_name_fa,place_id,estate_type,description,verification_status) VALUES
('EST0001','Shervin estate','املاک شروین','L0019','family_estate','Principal estate center of the Amir Afkham Shervini family.','confirmed'),
('EST0002','Letgah estate','املاک لتگاه','L0003','family_estate','Principal estate center of the Amir Nezam Letgahi family.','confirmed'),
('EST0003','Kabudarahang holdings','املاک کبودراهنگ','L0002','regional_holdings','Important landed area of the Amir Nezam Letgahi family.','confirmed'),
('EST0004','Bahar holdings','املاک بهار','L0030','regional_holdings','Principal landed area of the Naser al-Molk Bahari family.','confirmed'),
('EST0005','Abshineh estate','املاک آبشینه','L0031','family_estate','Associated with the Baha al-Molk Abshini family.','confirmed'),
('EST0006','Sorkhabad estate','املاک سرخ‌آباد','L0032','family_estate','Early property center of Haji Amanollah Khan Baha al-Molk.','confirmed'),
('EST0007','Zagheh estate','املاک زاغه','L0033','family_estate','Later property center of the Baha al-Molk family.','confirmed');

INSERT OR IGNORE INTO estate_associations(estate_association_id,estate_id,person_id,organization_id,association_type,date_text,notes,verification_status) VALUES
('EA0001','EST0001',NULL,'ORG0005','principal_center',NULL,NULL,'confirmed'),
('EA0002','EST0002',NULL,'ORG0007','principal_center',NULL,NULL,'confirmed'),
('EA0003','EST0003',NULL,'ORG0007','major_holdings',NULL,NULL,'confirmed'),
('EA0004','EST0004',NULL,'ORG0008','principal_center',NULL,NULL,'confirmed'),
('EA0005','EST0005',NULL,'ORG0006','family_center',NULL,NULL,'confirmed'),
('EA0006','EST0006','P0031','ORG0006','property_center',NULL,'Associated with Haji Amanollah Khan Baha al-Molk.','confirmed'),
('EA0007','EST0007','P0031','ORG0006','later_property_center',NULL,'Later property center described in the narrative.','confirmed');

INSERT OR IGNORE INTO roles(role_id,preferred_name_en,preferred_name_fa,role_category,description) VALUES
('ROLE0001','Amir Tuman','امیرتومان','military_rank','Senior Qajar military rank associated with command over ten regiments in the chapter''s description.'),
('ROLE0002','Sartip','سرتیپ','military_rank','Brigadier-level rank and command role.'),
('ROLE0003','Sarhang','سرهنگ','military_rank','Colonel and regimental command rank.'),
('ROLE0004','Yavar','یاور','military_rank','Field-grade military rank.'),
('ROLE0005','Soltan','سلطان','military_rank','Company-level military rank.'),
('ROLE0006','Panjah-bashi','پنجاه‌باشی','military_rank','Commander of fifty men.'),
('ROLE0007','On-bashi','اون‌باشی','military_rank','Commander of ten men.'),
('ROLE0008','Regimental commander','سرکرده فوج','military_office','Command of a named regiment.'),
('ROLE0009','Regimental colonel','سرهنگ فوج','military_office','Colonel of a named regiment.'),
('ROLE0010','Estate manager','مباشر املاک','estate_office','Manager or agent responsible for estate administration.'),
('ROLE0011','Village headman','کدخدا','estate_office','Village headman within rural administration.'),
('ROLE0012','Tenant cultivator','رعیت','occupation','Cultivator within the landlord-tenant system.');

INSERT OR IGNORE INTO organizations(organization_id,preferred_name_en,preferred_name_fa,organization_type,parent_organization_id,date_text,description,verification_status) VALUES
('ORG0101','Sixth Gharagozloo Regiment','فوج ششم قراگوزلو','military_unit','ORG0001',NULL,'One of four principal Gharagozloo regiments named in Chapter 2.','confirmed'),
('ORG0102','Mansur Gharagozloo Regiment','فوج منصور قراگوزلو','military_unit','ORG0001',NULL,'One of four principal Gharagozloo regiments named in Chapter 2.','confirmed'),
('ORG0103','Mokhberan Gharagozloo Regiment','فوج مخبران قراگوزلو','military_unit','ORG0001',NULL,'One of four principal Gharagozloo regiments named in Chapter 2.','confirmed'),
('ORG0104','Fadavi Gharagozloo Regiment','فوج فدوی قراگوزلو','military_unit','ORG0001',NULL,'One of four principal Gharagozloo regiments named in Chapter 2.','confirmed'),
('ORG0105','Zanganeh Regiment','فوج زنگنه','military_unit',NULL,NULL,'A non-Gharagozloo regiment commanded for a time by Ahmad Khan Sartip.','confirmed'),
('ORG0106','Malayer Regiment','فوج ملایر','military_unit',NULL,'1268 AH','Commanded by Abdollah Khan Sarem al-Dowleh in 1268 AH.','confirmed'),
('ORG0107','Tuyserkan Regiment','فوج تویسرکان','military_unit',NULL,'1268 AH','Commanded by Abdollah Khan Sarem al-Dowleh in 1268 AH.','confirmed');

INSERT OR IGNORE INTO military_units(military_unit_id,organization_id,unit_kind,service_arm,affiliated_branch_id,headquarters_place_id,notes) VALUES
('MU0001','ORG0101','fowj/regiment','infantry','ORG0003',NULL,'Associated mainly with the Ashiqloo branch.'),
('MU0002','ORG0102','fowj/regiment','infantry','ORG0003',NULL,'Associated mainly with the Ashiqloo branch.'),
('MU0003','ORG0103','fowj/regiment','infantry','ORG0003',NULL,'Associated mainly with the Ashiqloo branch.'),
('MU0004','ORG0104','fowj/regiment','infantry','ORG0002',NULL,'Associated mainly with the Hajilu branch.'),
('MU0005','ORG0105','fowj/regiment','infantry',NULL,NULL,NULL),
('MU0006','ORG0106','fowj/regiment','infantry',NULL,'L0034',NULL),
('MU0007','ORG0107','fowj/regiment','infantry',NULL,'L0035',NULL);

-- New persons explicitly named in Chapter 2 narrative.
INSERT OR IGNORE INTO persons(person_id,preferred_name_en,preferred_name_fa,sex,birth_date_text,death_date_text,branch,summary,verification_status,created_at,updated_at) VALUES
('P0062','Fazlollah Khan Gharagozloo','فضل‌الله خان قراگوزلو','M',NULL,NULL,'Ashiqloo','Named as colonel of the Sixth Gharagozloo Regiment.','confirmed','2026-07-12T00:00:00Z','2026-07-12T00:00:00Z'),
('P0063','Ali Akbar Khan Gharagozloo','علی‌اکبر خان قراگوزلو','M',NULL,NULL,NULL,'Named as colonel of the Mansur Regiment.','confirmed','2026-07-12T00:00:00Z','2026-07-12T00:00:00Z'),
('P0064','Mehdi Khan Gharagozloo','مهدی خان قراگوزلو','M',NULL,NULL,'Ashiqloo / Naser al-Molk','Named as son of Naser al-Molk and commander/colonel of the Mokhberan and Sixth regiments in different contexts.','confirmed','2026-07-12T00:00:00Z','2026-07-12T00:00:00Z'),
('P0065','Abdol Ali Khan Gharagozloo','عبدالعلی خان قراگوزلو','M',NULL,NULL,'Ashiqloo / Naser al-Molk','Named as eldest son of Mehdi Khan and colonel of the Mokhberan Regiment.','confirmed','2026-07-12T00:00:00Z','2026-07-12T00:00:00Z');

INSERT OR IGNORE INTO relationships(relationship_id,person1_id,relationship_type,person2_id,notes,verification_status) VALUES
('R0039','P0040','father_of','P0064','Narrative text names Mehdi Khan as the son of Naser al-Molk in the regimental passage.','confirmed'),
('R0040','P0064','father_of','P0065','Narrative text names Abdol-Ali Khan as Mehdi Khan''s eldest son.','confirmed');

INSERT OR IGNORE INTO organization_memberships(membership_id,person_id,organization_id,membership_role,date_text,notes,verification_status) VALUES
('OM0001','P0003','ORG0007','family head / ancestor line',NULL,'Mostafa Qoli Khan is in the Amir Nezam Letgahi lineage.','confirmed'),
('OM0002','P0004','ORG0007','family head',NULL,'Abdollah Khan is identified as founder/head of the Amir Nezam Letgahi family.','confirmed'),
('OM0003','P0023','ORG0005','family head',NULL,'Zeyn al-Abedin Khan belonged to the Amir Afkham Shervini line.','confirmed'),
('OM0004','P0031','ORG0006','family founder',NULL,'Founder of the Baha al-Molk Abshini family.','confirmed'),
('OM0005','P0040','ORG0008','family member',NULL,'Naser al-Molk belonged to the Bahari line.','confirmed');

INSERT OR IGNORE INTO military_commands(command_id,person_id,military_unit_id,command_role_id,date_text,start_date_text,end_date_text,predecessor_person_id,successor_person_id,notes,verification_status) VALUES
('MC0001','P0062','MU0001','ROLE0009',NULL,NULL,NULL,NULL,NULL,'Named as colonel of the Sixth Gharagozloo Regiment.','confirmed'),
('MC0002','P0063','MU0002','ROLE0009',NULL,NULL,NULL,NULL,NULL,'Named as colonel of the Mansur Regiment.','confirmed'),
('MC0003','P0064','MU0003','ROLE0009',NULL,NULL,NULL,NULL,NULL,'Named as colonel/commander of the Mokhberan Regiment.','confirmed'),
('MC0004','P0003','MU0004','ROLE0008',NULL,NULL,NULL,NULL,'P0004','Fadavi Regiment was attached to Mostafa Qoli Khan Mirpanj.','confirmed'),
('MC0005','P0018','MU0003','ROLE0008','1272 AH',NULL,NULL,NULL,NULL,'Commanded two Mokhberan regiments during the Kerman mission.','confirmed'),
('MC0006','P0030','MU0005','ROLE0008',NULL,NULL,NULL,NULL,NULL,'Commanded the Zanganeh Regiment for a period.','confirmed'),
('MC0007','P0028','MU0006','ROLE0008','1268 AH',NULL,NULL,NULL,NULL,'Received command of the Malayer regiment.','confirmed'),
('MC0008','P0028','MU0007','ROLE0008','1268 AH',NULL,NULL,NULL,NULL,'Received command of the Tuyserkan regiment.','confirmed'),
('MC0009','P0004','MU0004','ROLE0008',NULL,NULL,NULL,'P0003','P0012','After serving as colonel during his father''s lifetime, Abdollah Khan later commanded the Fadavi Regiment.','confirmed'),
('MC0010','P0012','MU0004','ROLE0008',NULL,NULL,NULL,'P0004',NULL,'Succeeded Abdollah Khan in command of the Fadavi Regiment.','confirmed'),
('MC0011','P0014','MU0003','ROLE0008',NULL,NULL,NULL,NULL,'P0030','Command succession began with Mahmud Khan Naser al-Molk.','confirmed'),
('MC0012','P0030','MU0003','ROLE0008',NULL,NULL,NULL,'P0014','P0064','Succeeded Mahmud Khan in command of the Mokhberan Regiment.','confirmed'),
('MC0013','P0064','MU0003','ROLE0008',NULL,NULL,NULL,'P0030',NULL,'Succeeded Ahmad Khan after promotion to Sartip.','confirmed'),
('MC0014','P0065','MU0003','ROLE0009',NULL,NULL,NULL,NULL,NULL,'Served as colonel of the Mokhberan Regiment.','confirmed');

INSERT OR IGNORE INTO person_role_assignments(assignment_id,person_id,role_id,organization_id,place_id,date_text,start_date_text,end_date_text,appointing_authority_text,notes,verification_status) VALUES
('PRA0001','P0023','ROLE0002',NULL,NULL,'1304 AH',NULL,NULL,NULL,'Reportedly purchased the rank of Sartip-e Awwal.','confirmed'),
('PRA0002','P0004','ROLE0003','ORG0104',NULL,NULL,NULL,NULL,NULL,'Colonel of the Fadavi Regiment during his father''s lifetime.','confirmed'),
('PRA0003','P0004','ROLE0002','ORG0104',NULL,NULL,NULL,NULL,NULL,'Later commanded the regiment with the rank of Sartip.','confirmed'),
('PRA0004','P0012','ROLE0008','ORG0104',NULL,NULL,NULL,NULL,NULL,'Succeeded to command of the Fadavi Regiment.','confirmed'),
('PRA0005','P0064','ROLE0002','ORG0103',NULL,NULL,NULL,NULL,NULL,'Promoted to Sartip in connection with command succession.','confirmed');

-- Evidence links for the new structured entities.
INSERT OR IGNORE INTO entity_citations(entity_citation_id,entity_type,entity_id,citation_id,support_type,notes) VALUES
('EC0001','organization','ORG0002','X0062','supports',NULL),('EC0002','organization','ORG0003','X0062','supports',NULL),('EC0003','organization','ORG0004','X0062','supports',NULL),
('EC0004','organization','ORG0005','X0063','supports',NULL),('EC0005','organization','ORG0006','X0063','supports',NULL),('EC0006','organization','ORG0007','X0063','supports',NULL),('EC0007','organization','ORG0008','X0063','supports',NULL),
('EC0008','estate','EST0001','X0063','supports',NULL),('EC0009','estate','EST0002','X0063','supports',NULL),('EC0010','estate','EST0003','X0063','supports',NULL),('EC0011','estate','EST0004','X0063','supports',NULL),('EC0012','estate','EST0005','X0063','supports',NULL),('EC0013','estate','EST0006','X0063','supports',NULL),('EC0014','estate','EST0007','X0063','supports',NULL),
('EC0015','military_unit','MU0001','X0066','supports',NULL),('EC0016','military_unit','MU0002','X0066','supports',NULL),('EC0017','military_unit','MU0003','X0066','supports',NULL),('EC0018','military_unit','MU0004','X0066','supports',NULL),
('EC0019','military_command','MC0005','X0067','supports',NULL),('EC0020','military_command','MC0006','X0067','supports',NULL),('EC0021','military_command','MC0007','X0067','supports',NULL),('EC0022','military_command','MC0008','X0067','supports',NULL),
('EC0023','military_command','MC0009','X0067','supports',NULL),('EC0024','military_command','MC0010','X0067','supports',NULL),('EC0025','military_command','MC0011','X0067','supports',NULL),('EC0026','military_command','MC0012','X0067','supports',NULL),('EC0027','military_command','MC0013','X0067','supports',NULL),('EC0028','military_command','MC0014','X0067','supports',NULL),
('EC0029','person_role_assignment','PRA0001','X0065','supports','Purchase of military rank discussed in Chapter 2.');

-- Chapter-level contextual claims remain in the established claim system and are fully cited.
INSERT OR IGNORE INTO claims(claim_id,subject_type,subject_id,predicate,object_text,confidence,status,notes) VALUES
('C0111','source','S0001','chapter_2_social_structure','The chapter identifies Hajilu, Ashiqloo, and Uzbeklu as principal Gharagozloo branches, while treating claims of absorption or renaming cautiously.','confirmed','active','Narrative-text summary.'),
('C0112','source','S0001','chapter_2_economic_structure','Landed property and agricultural production formed a major economic base of Gharagozloo elite power in Hamadan.','confirmed','active','Narrative-text summary.'),
('C0113','source','S0001','chapter_2_military_structure','Military strength, alongside landed wealth, was a principal basis of Gharagozloo prominence under the Qajars.','confirmed','active','Narrative-text summary.'),
('C0114','source','S0001','chapter_2_regiments','The Sixth, Mansur, Mokhberan, and Fadavi regiments are identified as four principal Gharagozloo military formations.','confirmed','active','Narrative-text summary.'),
('C0115','source','S0001','chapter_2_branch_command_flexibility','Regimental command was not rigidly confined by tribal branch; cross-branch and external appointments occurred.','confirmed','active','Narrative-text summary.'),
('C0116','source','S0001','chapter_2_military_office_practice','Formal rules against purchasing military office diverged from practice, as illustrated by payments for rank and command.','confirmed','active','Narrative-text summary.');

INSERT OR IGNORE INTO claim_citations(claim_id,citation_id,support_type) VALUES
('C0111','X0062','supports'),('C0112','X0064','supports'),('C0113','X0065','supports'),('C0114','X0066','supports'),('C0115','X0067','supports'),('C0116','X0065','supports');

INSERT OR REPLACE INTO metadata(key,value) VALUES('archive_version','2.0.0');
INSERT OR REPLACE INTO metadata(key,value) VALUES('chapter_2_status','structured_mining_complete_v1');
INSERT OR REPLACE INTO metadata(key,value) VALUES('evidence_policy_relationships','Narrative text and explicit captions primary; diagrams corroborative only unless independently confirmed.');
