-- Normalize the Persian spelling of Gharagozloo throughout canonical text data.
-- Old: قراگوزلو
-- New: قراگزلو

UPDATE metadata SET value = replace(value, 'قراگوزلو', 'قراگزلو') WHERE instr(value, 'قراگوزلو') > 0;
UPDATE sources SET short_title = replace(short_title, 'قراگوزلو', 'قراگزلو') WHERE instr(short_title, 'قراگوزلو') > 0;
UPDATE sources SET full_title = replace(full_title, 'قراگوزلو', 'قراگزلو') WHERE instr(full_title, 'قراگوزلو') > 0;
UPDATE sources SET notes = replace(notes, 'قراگوزلو', 'قراگزلو') WHERE instr(notes, 'قراگوزلو') > 0;
UPDATE persons SET preferred_name_fa = replace(preferred_name_fa, 'قراگوزلو', 'قراگزلو') WHERE instr(preferred_name_fa, 'قراگوزلو') > 0;
UPDATE person_names SET name_text = replace(name_text, 'قراگوزلو', 'قراگزلو') WHERE instr(name_text, 'قراگوزلو') > 0;
UPDATE research_questions SET notes = replace(notes, 'قراگوزلو', 'قراگزلو') WHERE instr(notes, 'قراگوزلو') > 0;
UPDATE bibliography_entries SET raw_entry_fa = replace(raw_entry_fa, 'قراگوزلو', 'قراگزلو') WHERE instr(raw_entry_fa, 'قراگوزلو') > 0;
UPDATE artifacts SET caption_fa = replace(caption_fa, 'قراگوزلو', 'قراگزلو') WHERE instr(caption_fa, 'قراگوزلو') > 0;
UPDATE organizations SET preferred_name_fa = replace(preferred_name_fa, 'قراگوزلو', 'قراگزلو') WHERE instr(preferred_name_fa, 'قراگوزلو') > 0;
UPDATE organization_names SET name_text = replace(name_text, 'قراگوزلو', 'قراگزلو') WHERE instr(name_text, 'قراگوزلو') > 0;
UPDATE roles SET preferred_name_fa = replace(preferred_name_fa, 'قراگوزلو', 'قراگزلو') WHERE instr(preferred_name_fa, 'قراگوزلو') > 0;
