const app=document.querySelector('#app');let state={people:[],dashboard:null,currentPerson:null,tab:'overview'};
const esc=s=>String(s??'').replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]));
async function api(url){const r=await fetch(url);if(!r.ok)throw new Error((await r.json()).error||r.statusText);return r.json()}
function route(name,arg){if(name==='graphcore')return graphCore(arg);if(name==='home')return home();if(name==='people')return people(arg||'');if(name==='person')return person(arg);if(name==='timeline')return timeline();if(name==='estates')return estates();if(name==='estate')return estate(arg);if(name==='organizations')return organizations();if(name==='organization')return organization(arg);if(name==='titles')return titles();if(name==='title')return title(arg);if(name==='research')return research();}
document.addEventListener('click',e=>{const b=e.target.closest('[data-route]');if(b)route(b.dataset.route,b.dataset.arg)});
const globalSearch=document.querySelector('#globalSearch'),searchResults=document.querySelector('#searchResults');let searchTimer;globalSearch.addEventListener('input',e=>{clearTimeout(searchTimer);const q=e.target.value.trim();if(!q){searchResults.innerHTML='';searchResults.classList.remove('open');return}searchTimer=setTimeout(async()=>{const data=await api('/api/search?q='+encodeURIComponent(q));searchResults.innerHTML=data.map(x=>`<button data-route="${x.kind}" data-arg="${x.id}"><span>${esc(x.title)}</span><small>${esc(x.kind)}${x.subtitle?' · '+esc(x.subtitle):''}</small></button>`).join('')||'<div class="search-empty">No matches</div>';searchResults.classList.add('open')},180)});globalSearch.addEventListener('keydown',e=>{if(e.key==='Enter'){searchResults.classList.remove('open');route('people',e.target.value)}});document.addEventListener('click',e=>{if(!e.target.closest('.global-search'))searchResults.classList.remove('open')});
function stats(c){return [['persons','People'],['events','Events'],['claims','Claims'],['relationships','Relationships'],['sources','Sources'],['estates','Estates']].map(([k,l])=>`<div class=stat><b>${c[k]}</b><span>${l}</span></div>`).join('')}
async function home(){
  app.innerHTML='<div class=loading>Loading archive dashboard…</div>';
  const d=state.dashboard=await api('/api/dashboard');
  app.innerHTML=`
  <section class="archive-landing">
    <section class="landing-hero">
      <div class="hero-copy">
        <div class="eyebrow">The Gharagozloo Historical Archive</div>
        <h1>A family history preserved as evidence, relationships, places and lives.</h1>
        <p class="hero-lede">Explore the Gharagozloo family across generations—from its Turkic tribal roots and settlement in western Iran to its long association with Hamadan and Kabudarahang, and the public, military and political roles held by members of the family.</p>
        <div class="hero-actions">
          <button class="btn primary" data-route="graphcore">Enter the living family graph</button>
          <button class="btn ghost" data-route="people">Browse people</button>
        </div>
      </div>
      <div class="hero-emblem" aria-hidden="true">
        <span class="hero-emblem-ring"></span>
        <span class="hero-emblem-letter">G</span>
        <small>قراگوزلو</small>
      </div>
    </section>

    <section class="dedication-banner">
      <span class="dedication-mark">✦</span>
      <div><small>DEDICATION</small><strong>Thank you, Amoo Ali Amiri Gharagozloo</strong><p>For helping preserve the family’s memory and making this archive possible.</p></div>
    </section>

    <section class="archive-intro">
      <div class="intro-kicker">About the archive</div>
      <h2>From tribal confederation to a documented family history</h2>
      <p>The Gharagozloos were a Turkic tribal and landholding family whose history became deeply connected with Hamadan and its surrounding districts. Over successive dynasties, branches of the family accumulated estates, military responsibilities, court titles and public offices. Their story intersects with the Safavid, Afsharid, Zand, Qajar and Pahlavi eras, as well as the political and social transformations of modern Iran.</p>
      <p>This Explorer brings together the people, relationships, offices, estates, events and source-backed historical claims assembled in the archive. The database remains the canonical record; every polished page is an invitation to examine the underlying evidence.</p>
    </section>

    <section class="quick-access-grid">
      <button class="access-card featured" data-route="graphcore"><span class="access-icon">⌘</span><div><small>INTERACTIVE</small><h3>Living Family Graph</h3><p>Move through generations, expand branches and open complete person dossiers.</p></div><b>→</b></button>
      <button class="access-card" data-route="people"><span class="access-icon">人</span><div><small>INDEX</small><h3>People</h3><p>Search names, branches, aliases and biographies.</p></div><b>→</b></button>
      <button class="access-card" data-route="timeline"><span class="access-icon">◷</span><div><small>CHRONOLOGY</small><h3>Timeline</h3><p>Follow events and careers across historical periods.</p></div><b>→</b></button>
      <button class="access-card" data-route="estates"><span class="access-icon">⌂</span><div><small>PLACES</small><h3>Estates</h3><p>Explore properties, localities and territorial connections.</p></div><b>→</b></button>
      <button class="access-card" data-route="titles"><span class="access-icon">♜</span><div><small>AUTHORITY</small><h3>Titles</h3><p>Inspect honorifics, ranks and offices in context.</p></div><b>→</b></button>
      <button class="access-card" data-route="research"><span class="access-icon">§</span><div><small>EVIDENCE</small><h3>Research</h3><p>Review sources, claims and unresolved questions.</p></div><b>→</b></button>
    </section>

    <section class="stats landing-stats">${stats(d.counts)}</section>

    <div class="section-head landing-section-head"><div><span class="section-overline">Selected dossiers</span><h2>Featured people</h2><p>Reconciled and richly documented records from the archive.</p></div><button class="text-link" data-route="people">View the complete people index →</button></div>
    <section class="person-grid featured-grid">${d.featured.map(card).join('')}</section>

    <div class="section-head landing-section-head"><div><span class="section-overline">Family structure</span><h2>Browse by branch</h2><p>Open the people index filtered to a family or thematic branch.</p></div></div>
    <div class="branch-list landing-branches">${d.branches.map(x=>`<button class="branch-btn" data-branch="${esc(x.branch)}"><span>${esc(x.branch)}</span><b>${x.count}</b></button>`).join('')}</div>
  </section>`;
  document.querySelectorAll('[data-branch]').forEach(b=>b.onclick=()=>people('',b.dataset.branch));
}

function card(p){return `<article class=person-card data-route=person data-arg="${p.person_id}"><h3>${esc(p.preferred_name_en)}</h3><div class=fa>${esc(p.preferred_name_fa||'')}</div><div class=chips>${p.branch?`<span class=chip>${esc(p.branch)}</span>`:''}${p.dossier_level?`<span class="chip ${p.dossier_level}">${esc(p.dossier_level)}</span>`:''}</div><p>${esc((p.summary||'No summary yet.').slice(0,180))}</p></article>`}
async function people(q='',branch=''){app.innerHTML='<div class=loading>Loading people…</div>';const data=state.people=await api(`/api/people?q=${encodeURIComponent(q)}&branch=${encodeURIComponent(branch)}`);const branches=state.dashboard?.branches||[];app.innerHTML=`<div class=section-head><div><h2>People</h2><p>${data.length} records shown</p></div></div><div class=toolbar><input id=peopleSearch value="${esc(q)}" placeholder="Name, Persian name, alias, branch or biography"><select id=branchSelect><option value="">All branches</option>${branches.map(x=>`<option ${x.branch===branch?'selected':''}>${esc(x.branch)}</option>`).join('')}</select></div><div class=people-table><div class="people-row header"><span>Person</span><span>Branch</span><span>Life</span><span>Status</span></div>${data.map(p=>`<div class=people-row data-route=person data-arg=${p.person_id}><span><strong>${esc(p.preferred_name_en)}</strong><br><span class=muted dir=rtl>${esc(p.preferred_name_fa||'')}</span></span><span>${esc(p.branch||'Unclassified')}</span><span>${esc([p.birth_date_text,p.death_date_text].filter(Boolean).join(' – ')||'—')}</span><span><span class=chip>${esc(p.dossier_level||p.verification_status)}</span></span></div>`).join('')||'<div class=empty>No matching people.</div>'}</div>`;let timer;document.querySelector('#peopleSearch').oninput=e=>{clearTimeout(timer);timer=setTimeout(()=>people(e.target.value,document.querySelector('#branchSelect').value),250)};document.querySelector('#branchSelect').onchange=e=>people(document.querySelector('#peopleSearch').value,e.target.value)}
function relLabel(r){const m={parent_of:'Parent of',father_of:'Father of',sibling_of:'Sibling of',spouse_of:'Spouse of',grandchild_of:'Grandchild of',father_in_law_of:'Father-in-law of',relative_of:'Relative of',succeeded:'Succeeded',succeeded_as_regent:'Succeeded as regent'};return m[r.relationship_type]||r.relationship_type.replaceAll('_',' ')}
async function person(id){app.innerHTML='<div class=loading>Opening person record…</div>';const p=state.currentPerson=await api('/api/person/'+id);state.tab='overview';renderPerson()}
function renderPerson(){const p=state.currentPerson;const life=[p.birth_date_text&&`Born ${p.birth_date_text}`,p.death_date_text&&`Died ${p.death_date_text}`].filter(Boolean).join(' · ')||'Dates not established';app.innerHTML=`<span class=back data-route=people>← Back to people</span><section class=profile-head><div class=identity><div class=eyebrow>${esc(p.person_id)} · ${esc(p.branch||'Branch unclassified')}</div><h1>${esc(p.preferred_name_en)}</h1><div class=fa>${esc(p.preferred_name_fa||'')}</div><p>${esc(p.summary||'No biographical summary has yet been written.')}</p><div class=chips><span class=chip>${esc(p.verification_status)}</span>${p.reconciliation?`<span class="chip silver">${esc(p.reconciliation.dossier_level)} · ${esc(p.reconciliation.reconciliation_status)}</span>`:''}</div></div><aside class=profile-meta><div class=meta-line><small>Life</small>${esc(life)}</div><div class=meta-line><small>Branch</small>${esc(p.branch||'—')}</div><div class=meta-line><small>Claims</small>${p.claims.length}</div><div class=meta-line><small>Relationships</small>${p.relationships.length}</div><div class=meta-line><small>Events</small>${p.events.length}</div>${p.reconciliation?.unresolved_summary?`<div class=meta-line><small>Open questions</small>${esc(p.reconciliation.unresolved_summary)}</div>`:''}</aside></section><div class=tabs>${[['overview','Overview'],['relationships','Family & network'],['graph','Interactive graph'],['timeline','Timeline'],['evidence','Claims & evidence']].map(([k,l])=>`<button data-tab=${k} class=${state.tab===k?'active':''}>${l}</button>`).join('')}</div><section id=tabPanel class=panel></section>`;document.querySelectorAll('[data-tab]').forEach(b=>b.onclick=()=>{state.tab=b.dataset.tab;renderPerson()});renderTab()}
function renderTab(){const p=state.currentPerson,el=document.querySelector('#tabPanel');if(state.tab==='overview'){el.innerHTML=`<div class=section-head><div><h2>Identity and career</h2><p>Names, titles and formal roles.</p></div></div><h3>Names</h3>${p.aliases.map(x=>`<div class=list-item><strong>${esc(x.name_text)}</strong> <span class=chip>${esc(x.language||'')}</span> <span class=muted>${esc(x.name_type||'')}</span></div>`).join('')||'<p class=muted>No additional names recorded.</p>'}<h3>Titles</h3>${p.titles.map(x=>`<div class=list-item><h4>${esc(x.title_en)} <span dir=rtl>${esc(x.title_fa||'')}</span></h4><p>${esc(x.date_text||'')}${x.meaning_notes?' · '+esc(x.meaning_notes):''}</p></div>`).join('')||'<p class=muted>No normalized titles recorded.</p>'}<h3>Roles and offices</h3>${p.roles.map(x=>`<div class=list-item><h4>${esc(x.role_en)}${x.organization?' · '+esc(x.organization):''}</h4><p>${esc(x.date_text||[x.start_date_text,x.end_date_text].filter(Boolean).join(' – ')||'Date not established')}${x.place?' · '+esc(x.place):''}</p><p>${esc(x.notes||'')}</p></div>`).join('')||'<p class=muted>No role assignments recorded.</p>'}`}
if(state.tab==='relationships'){el.innerHTML=`<div class=section-head><div><h2>Family and social relationships</h2><p>Every link can open the related person record.</p></div></div>${p.relationships.map(r=>`<div class=list-item person-card data-route=person data-arg=${r.related_person_id}><h4>${esc(relLabel(r))}: ${esc(r.related_name_en)}</h4><div class=fa>${esc(r.related_name_fa||'')}</div><p>${esc(r.notes||'')} <span class=chip>${esc(r.verification_status)}</span></p></div>`).join('')||'<p class=muted>No structured relationships recorded.</p>'}`}
if(state.tab==='timeline'){const items=[...p.events.map(x=>({...x,kind:'Event'})),...p.roles.map(x=>({title:x.role_en,date_text:x.date_text||x.start_date_text,description:[x.organization,x.place,x.notes].filter(Boolean).join(' · '),kind:'Role'}))].sort((a,b)=>(a.date_text||'').localeCompare(b.date_text||''));el.innerHTML=`<div class=section-head><div><h2>Timeline</h2><p>Events and offices associated with this person.</p></div></div>${items.map(x=>`<div class=list-item><span class=chip>${esc(x.kind)}</span><h4>${esc(x.date_text||'Date not established')} · ${esc(x.title)}</h4><p>${esc(x.description||'')}</p></div>`).join('')||'<p class=muted>No timeline entries recorded.</p>'}`}
if(state.tab==='evidence'){el.innerHTML=`<div class=section-head><div><h2>Claims and evidence</h2><p>Move from archive assertion to exact source citation.</p></div></div>${p.claims.map(c=>`<article class=claim><div class=predicate>${esc(c.predicate)} · ${esc(c.confidence)}</div><div class=statement>${esc(c.object_text)}</div>${c.evidence_type_code?`<div class=chips><span class=chip>${esc(c.evidence_type_code)}</span><span class=chip>${esc(c.assertion_scope)}</span><span class=chip>${esc(c.source_position)}</span></div>`:''}${c.notes?`<p class=muted>${esc(c.notes)}</p>`:''}${c.citations.map(ci=>`<div class=citation><strong>${esc(ci.short_title)}</strong>${ci.author?' · '+esc(ci.author):''}${ci.page_printed?' · printed p. '+esc(ci.page_printed):''}${ci.page_file?' · file p. '+esc(ci.page_file):''}<br>${ci.quoted_text?`<em>${esc(ci.quoted_text)}</em>`:esc(ci.locator_text||'')}</div>`).join('')}</article>`).join('')||'<p class=muted>No direct person claims recorded.</p>'}`}
if(state.tab==='graph'){el.innerHTML='<div class=loading>Building relationship graph…</div>';loadGraph(p.person_id)}}
async function loadGraph(id){const data=await api(`/api/person/${id}/graph?depth=3`),el=document.querySelector('#tabPanel');el.innerHTML=`<div class=section-head><div><h2>Interactive relationship graph</h2><p>Click a person node to open their profile.</p></div></div><div class=graph-shell><div class=graph-controls><button id=zoomIn>＋</button><button id=zoomOut>－</button><button id=resetGraph>Reset</button></div><svg id=graph viewBox="0 0 1000 650"></svg></div>`;drawGraph(data)}
function drawGraph(data){const svg=document.querySelector('#graph'),W=1000,H=650,cx=W/2,cy=H/2;let scale=1,tx=0,ty=0;const nodes=data.nodes,center=nodes.find(n=>n.person_id===data.center),others=nodes.filter(n=>n.person_id!==data.center);center.x=cx;center.y=cy;others.forEach((n,i)=>{const a=2*Math.PI*i/Math.max(others.length,1)-Math.PI/2,r=220+55*(i%2);n.x=cx+Math.cos(a)*r;n.y=cy+Math.sin(a)*r});const by=Object.fromEntries(nodes.map(n=>[n.person_id,n]));function render(){svg.innerHTML=`<g transform="translate(${tx} ${ty}) scale(${scale})">${data.edges.map(e=>{const a=by[e.person1_id],b=by[e.person2_id];if(!a||!b)return'';const mx=(a.x+b.x)/2,my=(a.y+b.y)/2;return`<line class=edge x1=${a.x} y1=${a.y} x2=${b.x} y2=${b.y}/><text class=edge-label x=${mx} y=${my}>${esc(e.relationship_type.replaceAll('_',' '))}</text>`}).join('')}${nodes.map(n=>`<g class="node ${n.person_id===data.center?'center':''}" data-node=${n.person_id} transform="translate(${n.x} ${n.y})"><circle r="48"/><text y="-4"><tspan x="0">${esc((n.preferred_name_en||'').split(' ').slice(0,3).join(' '))}</tspan><tspan x="0" dy="14">${esc((n.preferred_name_en||'').split(' ').slice(3,6).join(' '))}</tspan></text></g>`).join('')}</g>`;svg.querySelectorAll('[data-node]').forEach(n=>n.onclick=()=>person(n.dataset.node))}render();document.querySelector('#zoomIn').onclick=()=>{scale*=1.15;render()};document.querySelector('#zoomOut').onclick=()=>{scale/=1.15;render()};document.querySelector('#resetGraph').onclick=()=>{scale=1;tx=ty=0;render()};let drag=false,lx=0,ly=0;svg.onpointerdown=e=>{drag=true;lx=e.clientX;ly=e.clientY;svg.setPointerCapture(e.pointerId)};svg.onpointermove=e=>{if(!drag)return;tx+=e.clientX-lx;ty+=e.clientY-ly;lx=e.clientX;ly=e.clientY;render()};svg.onpointerup=()=>drag=false}

function timelineCard(x){return `<article class="timeline-card"><div class="timeline-date">${esc(x.date_text||'Date not established')}</div><div><span class="chip">${esc(x.event_type)}</span><h3>${esc(x.title)}</h3><p>${esc(x.description||'')}</p><div class="muted">${esc(x.place_en||'Place not recorded')} · ${x.people_count} linked people · ${esc(x.verification_status)}</div></div></article>`}
async function timeline(){app.innerHTML='<div class=loading>Loading historical timeline…</div>';const d=await api('/api/timeline');app.innerHTML=`<div class=section-head><div><h2>Historical timeline</h2><p>${d.events.length} events across the archive.</p></div></div><div class=toolbar><select id=timelineType><option value="">All event types</option>${d.types.map(x=>`<option value="${esc(x.event_type)}">${esc(x.event_type)} · ${x.count}</option>`).join('')}</select><select id=timelinePlace><option value="">All places</option>${d.places.map(x=>`<option value="${x.place_id}">${esc(x.preferred_name_en)} · ${x.count}</option>`).join('')}</select></div><section id=timelineList class=timeline-list>${d.events.map(timelineCard).join('')}</section>`;const refresh=async()=>{const t=document.querySelector('#timelineType').value,p=document.querySelector('#timelinePlace').value,x=await api(`/api/timeline?type=${encodeURIComponent(t)}&place=${encodeURIComponent(p)}`);document.querySelector('#timelineList').innerHTML=x.events.map(timelineCard).join('')||'<div class=empty>No events match these filters.</div>'};document.querySelector('#timelineType').onchange=refresh;document.querySelector('#timelinePlace').onchange=refresh}
async function estates(){app.innerHTML='<div class=loading>Loading estates…</div>';const data=await api('/api/estates');app.innerHTML=`<div class=section-head><div><h2>Estate explorer</h2><p>Land, villages and territorial associations.</p></div></div><section class=entity-grid>${data.map(x=>`<article class=entity-card data-route=estate data-arg=${x.estate_id}><span class=chip>${esc(x.estate_type)}</span><h3>${esc(x.preferred_name_en)}</h3><div class=fa>${esc(x.preferred_name_fa||'')}</div><p>${esc(x.description||'No description yet.')}</p><div class=muted>${esc(x.place_en||'Place not linked')} · ${x.association_count} associations</div></article>`).join('')}</section>`}
async function estate(id){app.innerHTML='<div class=loading>Opening estate…</div>';const x=await api('/api/estate/'+id);app.innerHTML=`<span class=back data-route=estates>← Back to estates</span><section class=profile-head><div class=identity><div class=eyebrow>${esc(x.estate_id)} · ${esc(x.estate_type)}</div><h1>${esc(x.preferred_name_en)}</h1><div class=fa>${esc(x.preferred_name_fa||'')}</div><p>${esc(x.description||'No description yet.')}</p></div><aside class=profile-meta><div class=meta-line><small>Place</small>${esc(x.place_en||'—')}</div><div class=meta-line><small>Status</small>${esc(x.verification_status)}</div><div class=meta-line><small>Associations</small>${x.associations.length}</div></aside></section><section class=panel><div class=section-head><div><h2>People and organizations</h2><p>Ownership, administration, residence and related estate links.</p></div></div>${x.associations.map(a=>`<div class="list-item ${a.person_id?'person-card':''}" ${a.person_id?`data-route=person data-arg=${a.person_id}`:''}><span class=chip>${esc(a.association_type)}</span><h4>${esc(a.person_en||a.organization_en||'Unspecified entity')}</h4><div class=fa>${esc(a.person_fa||'')}</div><p>${esc(a.date_text||'Date not established')} · ${esc(a.notes||'')}</p></div>`).join('')||'<p class=muted>No estate associations recorded.</p>'}</section>`}
async function organizations(){app.innerHTML='<div class=loading>Loading organizations…</div>';const data=await api('/api/organizations');app.innerHTML=`<div class=section-head><div><h2>Organizations</h2><p>Political, military, tribal, administrative and family institutions.</p></div></div><section class=entity-grid>${data.map(x=>`<article class=entity-card data-route=organization data-arg=${x.organization_id}><span class=chip>${esc(x.organization_type)}</span><h3>${esc(x.preferred_name_en)}</h3><div class=fa>${esc(x.preferred_name_fa||'')}</div><p>${esc(x.description||'No description yet.')}</p><div class=muted>${x.member_count} memberships · ${x.role_count} role assignments</div></article>`).join('')}</section>`}
async function organization(id){app.innerHTML='<div class=loading>Opening organization…</div>';const x=await api('/api/organization/'+id);app.innerHTML=`<span class=back data-route=organizations>← Back to organizations</span><section class=profile-head><div class=identity><div class=eyebrow>${esc(x.organization_id)} · ${esc(x.organization_type)}</div><h1>${esc(x.preferred_name_en)}</h1><div class=fa>${esc(x.preferred_name_fa||'')}</div><p>${esc(x.description||'No description yet.')}</p></div><aside class=profile-meta><div class=meta-line><small>Date</small>${esc(x.date_text||'—')}</div><div class=meta-line><small>Status</small>${esc(x.verification_status)}</div><div class=meta-line><small>Members</small>${x.members.length}</div><div class=meta-line><small>Roles</small>${x.roles.length}</div></aside></section><section class=panel><h2>Members and office holders</h2>${[...x.members.map(m=>({...m,label:m.membership_role,when:m.date_text})),...x.roles.map(r=>({...r,label:r.role_en,when:r.date_text||r.start_date_text}))].map(m=>`<div class="list-item person-card" data-route=person data-arg=${m.person_id}><h4>${esc(m.preferred_name_en)} · ${esc(m.label||'Member')}</h4><div class=fa>${esc(m.preferred_name_fa||'')}</div><p>${esc(m.when||'Date not established')} · ${esc(m.notes||'')}</p></div>`).join('')||'<p class=muted>No linked people recorded.</p>'}</section>`}
async function titles(){app.innerHTML='<div class=loading>Loading titles…</div>';const data=await api('/api/titles');app.innerHTML=`<div class=section-head><div><h2>Titles and honorifics</h2><p>Browse the archive by Qajar titles, ranks and styles.</p></div></div><section class=entity-grid>${data.map(x=>`<article class=entity-card data-route=title data-arg=${x.title_id}><h3>${esc(x.title_en)}</h3><div class=fa>${esc(x.title_fa||'')}</div><p>${esc(x.meaning_notes||'Meaning not yet documented.')}</p><div class=muted>${x.holder_count} recorded holder${x.holder_count===1?'':'s'}</div></article>`).join('')}</section>`}
async function title(id){app.innerHTML='<div class=loading>Opening title…</div>';const x=await api('/api/title/'+id);app.innerHTML=`<span class=back data-route=titles>← Back to titles</span><section class=profile-head><div class=identity><div class=eyebrow>${esc(x.title_id)} · Historical title</div><h1>${esc(x.title_en)}</h1><div class=fa>${esc(x.title_fa||'')}</div><p>${esc(x.meaning_notes||'Meaning not yet documented.')}</p></div><aside class=profile-meta><div class=meta-line><small>Recorded holders</small>${x.holders.length}</div></aside></section><section class=panel><h2>Title holders</h2>${x.holders.map(h=>`<div class="list-item person-card" data-route=person data-arg=${h.person_id}><h4>${esc(h.preferred_name_en)}</h4><div class=fa>${esc(h.preferred_name_fa||'')}</div><p>${esc(h.date_text||'Date not established')} · ${esc(h.notes||'')}</p></div>`).join('')||'<p class=muted>No title holders recorded.</p>'}</section>`}
async function research(){app.innerHTML='<div class=loading>Loading research questions…</div>';const data=await api('/api/research');app.innerHTML=`<div class=section-head><div><h2>Research questions</h2><p>Unresolved, active and completed lines of inquiry.</p></div></div><section class=research-list>${data.map(x=>`<article class=research-card><div class=chips><span class="chip ${esc(x.priority)}">${esc(x.priority)} priority</span><span class=chip>${esc(x.status)}</span></div><h3>${esc(x.question)}</h3><p>${esc(x.notes||'No notes yet.')}</p><small>${esc(x.question_id)}</small></article>`).join('')}</section>`}


// ===== Living Historical Graph: Graph Core =====
const graphState={root:'P0011',selected:null,expanded:new Set(),branches:new Set(),scale:1,tx:0,ty:0,data:null};
function familyType(t){return ['parent_of','father_of','spouse_of','sibling_of','grandchild_of'].includes(t)}
function parentChild(e){if(e.relationship_type==='parent_of'||e.relationship_type==='father_of')return [e.person1_id,e.person2_id];if(e.relationship_type==='grandchild_of')return [e.person2_id,e.person1_id];return null}
async function graphCore(root){app.innerHTML='<div class=loading>Building the living family graph…</div>';const d=graphState.data||await api('/api/graph/core');graphState.data=d;if(root)graphState.root=root;if(!graphState.expanded.size)graphState.expanded.add(graphState.root);graphState.selected=graphState.selected||graphState.root;renderGraphCore()}
function renderGraphCore(){const d=graphState.data,people=d.nodes,branches=d.branches;app.innerHTML=`<section class="living-layout"><aside class="graph-sidebar"><div class="eyebrow">Living Historical Graph</div><h2>Family tree</h2><p>Expand branches, center on any person, and open a living record without leaving the graph.</p><label class="field-label">Find and center</label><input id="graphFind" list="graphPeople" placeholder="Type a name…"><datalist id="graphPeople">${people.map(p=>`<option value="${esc(p.preferred_name_en)}" data-id="${p.person_id}"></option>`).join('')}</datalist><div class="side-actions"><button id="centerRoot" class="btn primary">Center selected</button><button id="expandAllVisible" class="btn">Expand visible</button><button id="collapseAll" class="btn">Collapse</button></div><h3>Branches</h3><label class="check-row"><input type="checkbox" id="allBranches" checked> All branches</label>${branches.map(b=>`<label class="check-row"><input type="checkbox" class="branchCheck" value="${esc(b.branch)}"> ${esc(b.branch)} <small>${b.count}</small></label>`).join('')}<h3>Relationships</h3><div class="legend"><span><i class="legend-line parent"></i>Parent / child</span><span><i class="legend-line spouse"></i>Spouse</span><span><i class="legend-line sibling"></i>Sibling</span></div></aside><section class="living-canvas"><div class="graph-toolbar"><button id="gcZoomIn">＋</button><button id="gcZoomOut">－</button><button id="gcFit">Fit</button><button id="gcHome">Original root</button><span id="visibleCount"></span></div><svg id="livingGraph" viewBox="0 0 1400 850"></svg></section><aside id="personDrawer" class="person-drawer"></aside></section>`;wireGraphControls();drawLivingGraph();renderPersonDrawer(graphState.selected)}
function wireGraphControls(){const input=document.querySelector('#graphFind');input.onchange=()=>{const p=graphState.data.nodes.find(x=>x.preferred_name_en===input.value||x.preferred_name_fa===input.value);if(p){graphState.selected=p.person_id;graphState.root=p.person_id;graphState.expanded.add(p.person_id);graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph();renderPersonDrawer(p.person_id)}};document.querySelector('#centerRoot').onclick=()=>{if(graphState.selected){graphState.root=graphState.selected;graphState.expanded.add(graphState.root);graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph()}};document.querySelector('#collapseAll').onclick=()=>{graphState.expanded=new Set([graphState.root]);drawLivingGraph()};document.querySelector('#expandAllVisible').onclick=()=>{visibleFamily().nodes.forEach(n=>graphState.expanded.add(n.person_id));drawLivingGraph()};document.querySelector('#allBranches').onchange=e=>{if(e.target.checked){graphState.branches.clear();document.querySelectorAll('.branchCheck').forEach(x=>x.checked=false)}drawLivingGraph()};document.querySelectorAll('.branchCheck').forEach(c=>c.onchange=()=>{graphState.branches=new Set([...document.querySelectorAll('.branchCheck:checked')].map(x=>x.value));document.querySelector('#allBranches').checked=!graphState.branches.size;drawLivingGraph()});document.querySelector('#gcZoomIn').onclick=()=>{graphState.scale*=1.15;drawLivingGraph()};document.querySelector('#gcZoomOut').onclick=()=>{graphState.scale/=1.15;drawLivingGraph()};document.querySelector('#gcFit').onclick=()=>{graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph()};document.querySelector('#gcHome').onclick=()=>{graphState.root=graphState.data.default_root;graphState.selected=graphState.root;graphState.expanded=new Set([graphState.root]);graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph();renderPersonDrawer(graphState.root)}}
function visibleFamily(){const d=graphState.data,by=Object.fromEntries(d.nodes.map(n=>[n.person_id,n])),children={},parents={},spouses={},siblings={};d.edges.forEach(e=>{const pc=parentChild(e);if(pc){(children[pc[0]]??=[]).push(pc[1]);(parents[pc[1]]??=[]).push(pc[0])}else if(e.relationship_type==='spouse_of'){(spouses[e.person1_id]??=[]).push(e.person2_id);(spouses[e.person2_id]??=[]).push(e.person1_id)}else if(e.relationship_type==='sibling_of'){(siblings[e.person1_id]??=[]).push(e.person2_id);(siblings[e.person2_id]??=[]).push(e.person1_id)}});const seen=new Set(),levels=new Map(),queue=[[graphState.root,0]];while(queue.length){const [id,l]=queue.shift();if(seen.has(id)||!by[id])continue;const node=by[id];if(graphState.branches.size&&!graphState.branches.has(node.branch||'Unclassified')&&id!==graphState.root)continue;seen.add(id);levels.set(id,l);if(graphState.expanded.has(id)){(children[id]||[]).forEach(x=>queue.push([x,l+1]));(parents[id]||[]).forEach(x=>queue.push([x,l-1]));(spouses[id]||[]).forEach(x=>queue.push([x,l]));(siblings[id]||[]).forEach(x=>queue.push([x,l]))}}const edges=d.edges.filter(e=>seen.has(e.person1_id)&&seen.has(e.person2_id)&&familyType(e.relationship_type));return {nodes:[...seen].map(id=>({...by[id],level:levels.get(id)||0})),edges,children,parents,spouses,siblings}}
function drawLivingGraph(){const svg=document.querySelector('#livingGraph');if(!svg)return;const family=visibleFamily(),nodes=family.nodes,edges=family.edges;document.querySelector('#visibleCount').textContent=`${nodes.length} people · ${edges.length} links`;const groups={};nodes.forEach(n=>(groups[n.level]??=[]).push(n));Object.keys(groups).forEach(k=>groups[k].sort((a,b)=>a.preferred_name_en.localeCompare(b.preferred_name_en)));const minL=Math.min(...nodes.map(n=>n.level),0),maxL=Math.max(...nodes.map(n=>n.level),0),levelGap=210;Object.entries(groups).forEach(([lv,arr])=>{const y=425+(Number(lv)-(minL+maxL)/2)*levelGap;const gap=Math.min(250,1180/Math.max(arr.length,1));arr.forEach((n,i)=>{n.x=700+(i-(arr.length-1)/2)*gap;n.y=y})});const by=Object.fromEntries(nodes.map(n=>[n.person_id,n]));const transform=`translate(${graphState.tx} ${graphState.ty}) scale(${graphState.scale})`;svg.innerHTML=`<g transform="${transform}">${edges.map(e=>{const a=by[e.person1_id],b=by[e.person2_id];if(!a||!b)return'';const cls=e.relationship_type==='spouse_of'?'spouse':e.relationship_type==='sibling_of'?'sibling':'parent';const label=e.relationship_type.replaceAll('_',' ');return `<path class="family-edge ${cls}" d="M ${a.x} ${a.y} C ${a.x} ${(a.y+b.y)/2}, ${b.x} ${(a.y+b.y)/2}, ${b.x} ${b.y}"></path><text class="family-edge-label" x="${(a.x+b.x)/2}" y="${(a.y+b.y)/2-5}">${esc(label)}</text>`}).join('')}${nodes.map(n=>{const hasKids=(family.children[n.person_id]||[]).length+(family.parents[n.person_id]||[]).length+(family.spouses[n.person_id]||[]).length+(family.siblings[n.person_id]||[]).length>0;const expanded=graphState.expanded.has(n.person_id);return `<g class="family-node ${n.person_id===graphState.selected?'selected':''}" data-person="${n.person_id}" transform="translate(${n.x} ${n.y})"><rect x="-88" y="-46" width="176" height="92" rx="14"></rect><text class="node-name" y="-12"><tspan x="0">${esc((n.preferred_name_en||'').split(' ').slice(0,3).join(' '))}</tspan><tspan x="0" dy="17">${esc((n.preferred_name_en||'').split(' ').slice(3,6).join(' '))}</tspan></text><text class="node-fa" y="27">${esc(n.preferred_name_fa||'')}</text>${hasKids?`<g class="expand-control" data-expand="${n.person_id}" transform="translate(72 35)"><circle r="13"></circle><text y="5">${expanded?'−':'+'}</text></g>`:''}</g>`}).join('')}</g>`;svg.querySelectorAll('[data-person]').forEach(g=>g.onclick=e=>{if(e.target.closest('[data-expand]'))return;graphState.selected=g.dataset.person;drawLivingGraph();renderPersonDrawer(g.dataset.person)});svg.querySelectorAll('[data-expand]').forEach(g=>g.onclick=e=>{e.stopPropagation();const id=g.dataset.expand;graphState.expanded.has(id)?graphState.expanded.delete(id):graphState.expanded.add(id);drawLivingGraph()});let drag=false,lx=0,ly=0;svg.onpointerdown=e=>{if(e.target.closest('[data-person]'))return;drag=true;lx=e.clientX;ly=e.clientY;svg.setPointerCapture(e.pointerId)};svg.onpointermove=e=>{if(!drag)return;graphState.tx+=e.clientX-lx;graphState.ty+=e.clientY-ly;lx=e.clientX;ly=e.clientY;drawLivingGraph()};svg.onpointerup=()=>drag=false;svg.onwheel=e=>{e.preventDefault();graphState.scale*=e.deltaY<0?1.08:.92;drawLivingGraph()}}
async function renderPersonDrawer(id){const drawer=document.querySelector('#personDrawer');if(!drawer)return;drawer.innerHTML='<div class=loading>Opening person…</div>';const p=await api('/api/person/'+id);const rels=p.relationships||[];const relation=(types)=>rels.filter(r=>types.includes(r.relationship_type));drawer.innerHTML=`<div class="drawer-head"><div class="eyebrow">${esc(p.person_id)} · ${esc(p.branch||'Branch unclassified')}</div><h2>${esc(p.preferred_name_en)}</h2><div class="fa">${esc(p.preferred_name_fa||'')}</div><p>${esc(p.summary||'No biographical summary yet.')}</p><div class="chips"><span class="chip">${esc(p.verification_status)}</span>${p.reconciliation?`<span class="chip silver">${esc(p.reconciliation.dossier_level)}</span>`:''}</div></div><div class="drawer-actions"><button class="btn primary" data-route="person" data-arg="${p.person_id}">Open full record</button><button class="btn" id="drawerCenter">Make graph root</button></div>${drawerRel('Parents',relation(['parent_of','father_of','grandchild_of']).filter(r=>r.direction==='incoming'||r.relationship_type==='grandchild_of'))}${drawerRel('Children',relation(['parent_of','father_of']).filter(r=>r.direction==='outgoing'))}${drawerRel('Siblings',relation(['sibling_of']))}${drawerRel('Spouses',relation(['spouse_of']))}<section class="drawer-section"><h3>Titles and roles</h3>${p.titles.slice(0,5).map(x=>`<div class="drawer-item"><strong>${esc(x.title_en)}</strong><small>${esc(x.date_text||'')}</small></div>`).join('')}${p.roles.slice(0,5).map(x=>`<div class="drawer-item"><strong>${esc(x.role_en)}</strong><small>${esc(x.date_text||x.start_date_text||'')}</small></div>`).join('')||'<p class="muted">No structured titles or roles.</p>'}</section><section class="drawer-section"><h3>Evidence snapshot</h3><div class="drawer-metrics"><span><b>${p.claims.length}</b> claims</span><span><b>${p.events.length}</b> events</span><span><b>${p.relationships.length}</b> relationships</span></div><button class="text-link" data-route="person" data-arg="${p.person_id}">Inspect claims and citations →</button></section>`;document.querySelector('#drawerCenter').onclick=()=>{graphState.root=p.person_id;graphState.expanded.add(p.person_id);graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph()}}
function drawerRel(title,items){return `<section class="drawer-section"><h3>${title}</h3>${items.length?items.map(r=>`<button class="drawer-person" data-person-jump="${r.related_person_id}"><span>${esc(r.related_name_en)}</span><small>${esc(r.related_name_fa||'')}</small></button>`).join(''):'<p class="muted">None recorded.</p>'}</section>`}
document.addEventListener('click',e=>{const x=e.target.closest('[data-person-jump]');if(x&&graphState.data){graphState.selected=x.dataset.personJump;graphState.expanded.add(graphState.selected);drawLivingGraph();renderPersonDrawer(graphState.selected)}});

route('home');

/* Living Historical Graph v2 */
const graphV2={filtersOpen:true,drawerOpen:true,history:[]};
function route(name,arg){document.body.classList.toggle('graph-mode',name==='graphcore');if(name==='graphcore')return graphCore(arg);if(name==='home')return home();if(name==='people')return people(arg||'');if(name==='person')return person(arg);if(name==='timeline')return timeline();if(name==='estates')return estates();if(name==='estate')return estate(arg);if(name==='organizations')return organizations();if(name==='organization')return organization(arg);if(name==='titles')return titles();if(name==='title')return title(arg);if(name==='research')return research();}
async function graphCore(root){document.body.classList.add('graph-mode');app.innerHTML='<div class=loading>Building the living family graph…</div>';try{const d=graphState.data||await api('/api/graph/core');graphState.data=d;if(root)graphState.root=root;if(!graphState.expanded.size)graphState.expanded.add(graphState.root);graphState.selected=graphState.selected||graphState.root;if(!graphV2.history.length)graphV2.history=[graphState.root];renderGraphCore()}catch(err){app.innerHTML=`<div class="panel"><h2>Graph could not load</h2><p>${esc(err.message)}</p><p>Open <code>/api/health</code> and confirm the server reports version 0.4.0-living-graph-v2.</p></div>`}}
function renderGraphCore(){const d=graphState.data;const selected=d.nodes.find(n=>n.person_id===graphState.selected);app.innerHTML=`<section class="graph-v2"><section class="living-canvas"><div class="canvas-help">Drag to move · Scroll to zoom · Click a person · Use + to expand</div><svg id="livingGraph" viewBox="0 0 1600 1000"></svg><div id="hoverCard" class="hover-card"></div></section><aside class="floating-panel graph-command"><h2>Living Historical Graph</h2><p>Explore the family without losing your place.</p><label class="field-label">Find and center a person</label><input id="graphFind" list="graphPeople" placeholder="Type a name…"><datalist id="graphPeople">${d.nodes.map(n=>`<option value="${esc(n.preferred_name_en)}">${esc(n.preferred_name_fa||'')}</option>`).join('')}</datalist><div class="quick-actions"><button id="centerRoot">Make selected root</button><button id="collapseAll">Collapse</button><button id="expandAllVisible">Expand visible</button><button id="gcHome">Original root</button></div></aside><aside id="filterDrawer" class="floating-panel filter-drawer ${graphV2.filtersOpen?'':'collapsed'}"><div class="filter-section"><h3>Branches</h3><label class="check-row"><input type="checkbox" id="allBranches" ${graphState.branches.size?'':'checked'}> All branches</label>${d.branches.map(b=>`<label class="check-row"><input type="checkbox" class="branchCheck" value="${esc(b.branch)}" ${graphState.branches.has(b.branch)?'checked':''}> ${esc(b.branch)} <small>${b.count}</small></label>`).join('')}</div><div class="filter-section"><h3>Relationship layers</h3><label class="check-row"><input type="checkbox" checked disabled> Parent / child</label><label class="check-row"><input type="checkbox" checked disabled> Spouse</label><label class="check-row"><input type="checkbox" checked disabled> Sibling</label></div><div class="filter-section"><h3>Legend</h3><div class="legend"><span><i class="legend-line parent"></i>Parent / child</span><span><i class="legend-line spouse"></i>Spouse</span><span><i class="legend-line sibling"></i>Sibling</span></div></div></aside><button id="filterToggle" class="floating-panel filter-toggle icon-btn">${graphV2.filtersOpen?'Hide filters':'Show filters'}</button><div id="breadcrumbs" class="breadcrumbs"></div><aside id="personDrawer" class="floating-panel person-float ${graphV2.drawerOpen?'':'hidden'}"></aside><div class="zoom-cluster"><button id="gcZoomIn" title="Zoom in">＋</button><button id="gcZoomOut" title="Zoom out">－</button><button id="gcFit" title="Fit graph">Fit</button></div><div id="visibleCount" class="graph-status"></div></section>`;wireGraphControls();drawLivingGraph();renderBreadcrumbs();renderPersonDrawer(graphState.selected)}
function renderBreadcrumbs(){const el=document.querySelector('#breadcrumbs');if(!el)return;const by=Object.fromEntries(graphState.data.nodes.map(n=>[n.person_id,n]));const ids=graphV2.history.slice(-6);el.innerHTML=ids.map((id,i)=>`${i?'<i>›</i>':''}<button data-crumb="${id}">${esc(by[id]?.preferred_name_en||id)}</button>`).join('');el.querySelectorAll('[data-crumb]').forEach(b=>b.onclick=()=>selectGraphPerson(b.dataset.crumb,false))}
function selectGraphPerson(id,push=true){if(!graphState.data.nodes.some(n=>n.person_id===id))return;graphState.selected=id;graphState.expanded.add(id);graphV2.drawerOpen=true;if(push&&graphV2.history.at(-1)!==id)graphV2.history.push(id);drawLivingGraph();renderBreadcrumbs();renderPersonDrawer(id)}
function wireGraphControls(){const input=document.querySelector('#graphFind');input.onchange=()=>{const p=graphState.data.nodes.find(x=>x.preferred_name_en===input.value||x.preferred_name_fa===input.value);if(p){graphState.root=p.person_id;graphState.scale=1;graphState.tx=graphState.ty=0;selectGraphPerson(p.person_id)}};document.querySelector('#centerRoot').onclick=()=>{if(graphState.selected){graphState.root=graphState.selected;graphState.expanded.add(graphState.root);graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph()}};document.querySelector('#collapseAll').onclick=()=>{graphState.expanded=new Set([graphState.root]);drawLivingGraph()};document.querySelector('#expandAllVisible').onclick=()=>{visibleFamily().nodes.forEach(n=>graphState.expanded.add(n.person_id));drawLivingGraph()};document.querySelector('#allBranches').onchange=e=>{if(e.target.checked){graphState.branches.clear();document.querySelectorAll('.branchCheck').forEach(x=>x.checked=false)}drawLivingGraph()};document.querySelectorAll('.branchCheck').forEach(c=>c.onchange=()=>{graphState.branches=new Set([...document.querySelectorAll('.branchCheck:checked')].map(x=>x.value));document.querySelector('#allBranches').checked=!graphState.branches.size;drawLivingGraph()});document.querySelector('#gcZoomIn').onclick=()=>{graphState.scale=Math.min(3,graphState.scale*1.18);drawLivingGraph()};document.querySelector('#gcZoomOut').onclick=()=>{graphState.scale=Math.max(.3,graphState.scale/1.18);drawLivingGraph()};document.querySelector('#gcFit').onclick=()=>{graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph()};document.querySelector('#gcHome').onclick=()=>{graphState.root=graphState.data.default_root;graphState.selected=graphState.root;graphState.expanded=new Set([graphState.root]);graphState.scale=1;graphState.tx=graphState.ty=0;graphV2.history.push(graphState.root);drawLivingGraph();renderBreadcrumbs();renderPersonDrawer(graphState.root)};document.querySelector('#filterToggle').onclick=()=>{graphV2.filtersOpen=!graphV2.filtersOpen;document.querySelector('#filterDrawer').classList.toggle('collapsed',!graphV2.filtersOpen);document.querySelector('#filterToggle').textContent=graphV2.filtersOpen?'Hide filters':'Show filters'}}
function drawLivingGraph(){const svg=document.querySelector('#livingGraph');if(!svg)return;const family=visibleFamily(),nodes=family.nodes,edges=family.edges;document.querySelector('#visibleCount').textContent=`${nodes.length} people · ${edges.length} links`;const groups={};nodes.forEach(n=>(groups[n.level]??=[]).push(n));Object.keys(groups).forEach(k=>groups[k].sort((a,b)=>a.preferred_name_en.localeCompare(b.preferred_name_en)));const minL=Math.min(...nodes.map(n=>n.level),0),maxL=Math.max(...nodes.map(n=>n.level),0),levelGap=235;Object.entries(groups).forEach(([lv,arr])=>{const y=500+(Number(lv)-(minL+maxL)/2)*levelGap;const gap=Math.min(290,1380/Math.max(arr.length,1));arr.forEach((n,i)=>{n.x=800+(i-(arr.length-1)/2)*gap;n.y=y})});const by=Object.fromEntries(nodes.map(n=>[n.person_id,n]));const transform=`translate(${graphState.tx} ${graphState.ty}) scale(${graphState.scale})`;svg.innerHTML=`<g transform="${transform}">${edges.map(e=>{const a=by[e.person1_id],b=by[e.person2_id];if(!a||!b)return'';const cls=e.relationship_type==='spouse_of'?'spouse':e.relationship_type==='sibling_of'?'sibling':'parent';return `<path class="family-edge ${cls}" d="M ${a.x} ${a.y} C ${a.x} ${(a.y+b.y)/2}, ${b.x} ${(a.y+b.y)/2}, ${b.x} ${b.y}"></path>`}).join('')}${nodes.map(n=>{const links=(family.children[n.person_id]||[]).length+(family.parents[n.person_id]||[]).length+(family.spouses[n.person_id]||[]).length+(family.siblings[n.person_id]||[]).length;const expanded=graphState.expanded.has(n.person_id);const life=[n.birth_date_text,n.death_date_text].filter(Boolean).join(' – ');return `<g class="family-node ${n.person_id===graphState.selected?'selected':''}" data-person="${n.person_id}" transform="translate(${n.x} ${n.y})"><rect x="-105" y="-58" width="210" height="116" rx="16"></rect><text class="node-branch" y="-37">${esc(n.branch||'Unclassified')}</text><text class="node-name" y="-13"><tspan x="0">${esc((n.preferred_name_en||'').split(' ').slice(0,3).join(' '))}</tspan><tspan x="0" dy="17">${esc((n.preferred_name_en||'').split(' ').slice(3,7).join(' '))}</tspan></text><text class="node-fa" y="27">${esc(n.preferred_name_fa||'')}</text><text class="node-life" y="46">${esc(life||'Dates not established')}</text>${links?`<g class="expand-control" data-expand="${n.person_id}" transform="translate(91 47)"><circle r="14"></circle><text y="5">${expanded?'−':'+'}</text></g>`:''}</g>`}).join('')}</g>`;svg.querySelectorAll('[data-person]').forEach(g=>{g.onclick=e=>{if(e.target.closest('[data-expand]'))return;selectGraphPerson(g.dataset.person)};g.onmouseenter=e=>showHover(g.dataset.person,e);g.onmousemove=e=>moveHover(e);g.onmouseleave=hideHover});svg.querySelectorAll('[data-expand]').forEach(g=>g.onclick=e=>{e.stopPropagation();const id=g.dataset.expand;graphState.expanded.has(id)?graphState.expanded.delete(id):graphState.expanded.add(id);drawLivingGraph()});let drag=false,lx=0,ly=0;svg.onpointerdown=e=>{if(e.target.closest('[data-person]'))return;drag=true;lx=e.clientX;ly=e.clientY;svg.setPointerCapture(e.pointerId)};svg.onpointermove=e=>{if(!drag)return;graphState.tx+=e.clientX-lx;graphState.ty+=e.clientY-ly;lx=e.clientX;ly=e.clientY;svg.querySelector('g').setAttribute('transform',`translate(${graphState.tx} ${graphState.ty}) scale(${graphState.scale})`)};svg.onpointerup=()=>drag=false;svg.onwheel=e=>{e.preventDefault();graphState.scale=Math.max(.3,Math.min(3,graphState.scale*(e.deltaY<0?1.08:.92)));svg.querySelector('g').setAttribute('transform',`translate(${graphState.tx} ${graphState.ty}) scale(${graphState.scale})`)}}
function showHover(id,e){const p=graphState.data.nodes.find(n=>n.person_id===id),h=document.querySelector('#hoverCard');if(!p||!h)return;h.innerHTML=`<strong>${esc(p.preferred_name_en)}</strong><small>${esc(p.preferred_name_fa||p.branch||'')}</small><div>${esc(([p.birth_date_text,p.death_date_text].filter(Boolean).join(' – ')||'Dates not established'))}</div>`;h.style.display='block';moveHover(e)}function moveHover(e){const h=document.querySelector('#hoverCard');if(h){h.style.left=(e.clientX+16)+'px';h.style.top=(e.clientY+16)+'px'}}function hideHover(){const h=document.querySelector('#hoverCard');if(h)h.style.display='none'}
function personInitials(name){return String(name||'?').split(/\s+/).filter(Boolean).slice(0,2).map(x=>x[0]).join('').toUpperCase()||'?'}
function portraitMarkup(p){return `<div class="person-portrait" data-portrait-frame><img data-person-portrait alt="Portrait of ${esc(p.preferred_name_en)}"><div class="portrait-placeholder" aria-hidden="true"><span>${esc(personInitials(p.preferred_name_en))}</span><small>Portrait not yet added</small></div></div>`}
function initPersonPortrait(img,personId){if(!img)return;const exts=['webp','jpg','jpeg','png'];let i=0;const frame=img.closest('[data-portrait-frame]');const tryNext=()=>{if(i>=exts.length){frame?.classList.add('portrait-missing');img.removeAttribute('src');return}img.src=`/static/people/${encodeURIComponent(personId)}.${exts[i++]}`};img.onload=()=>frame?.classList.add('portrait-loaded');img.onerror=tryNext;tryNext()}
async function renderPersonDrawer(id){const drawer=document.querySelector('#personDrawer');if(!drawer)return;drawer.classList.remove('hidden');drawer.innerHTML='<div class=loading>Opening person…</div>';try{const p=await api('/api/person/'+id);const rels=p.relationships||[];const relation=types=>rels.filter(r=>types.includes(r.relationship_type));drawer.innerHTML=`<button class="close-float" id="closeDrawer">×</button><div class="drawer-head">${portraitMarkup(p)}<div class="eyebrow">${esc(p.person_id)} · ${esc(p.branch||'Branch unclassified')}</div><h2>${esc(p.preferred_name_en)}</h2><div class="fa">${esc(p.preferred_name_fa||'')}</div><p>${esc(p.summary||'No biographical summary yet.')}</p><div class="chips"><span class="chip">${esc(p.verification_status)}</span>${p.reconciliation?`<span class="chip silver">${esc(p.reconciliation.dossier_level)}</span>`:''}</div></div><div class="drawer-actions"><button class="btn primary" data-route="person" data-arg="${p.person_id}">Open full record</button><button class="btn" id="drawerCenter">Make graph root</button></div><div class="drawer-rel-grid">${drawerRel('Parents',relation(['parent_of','father_of','grandchild_of']).filter(r=>r.direction==='incoming'||r.relationship_type==='grandchild_of'))}${drawerRel('Children',relation(['parent_of','father_of']).filter(r=>r.direction==='outgoing'))}${drawerRel('Siblings',relation(['sibling_of']))}${drawerRel('Spouses',relation(['spouse_of']))}</div><section class="drawer-section"><h3>Titles and roles</h3>${p.titles.slice(0,5).map(x=>`<div class="drawer-item"><strong>${esc(x.title_en)}</strong><small>${esc(x.date_text||'')}</small></div>`).join('')}${p.roles.slice(0,5).map(x=>`<div class="drawer-item"><strong>${esc(x.role_en)}</strong><small>${esc(x.date_text||x.start_date_text||'')}</small></div>`).join('')||'<p class="muted">No structured titles or roles.</p>'}</section><section class="drawer-section"><h3>Evidence snapshot</h3><div class="drawer-metrics"><span><b>${p.claims.length}</b> claims</span><span><b>${p.events.length}</b> events</span><span><b>${p.relationships.length}</b> relationships</span></div><button class="text-link" data-route="person" data-arg="${p.person_id}">Inspect claims and citations →</button></section>`;initPersonPortrait(drawer.querySelector('[data-person-portrait]'),p.person_id);document.querySelector('#closeDrawer').onclick=()=>{graphV2.drawerOpen=false;drawer.classList.add('hidden')};document.querySelector('#drawerCenter').onclick=()=>{graphState.root=p.person_id;graphState.expanded.add(p.person_id);graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph()}}catch(err){drawer.innerHTML=`<button class="close-float" id="closeDrawer">×</button><p>Could not open person: ${esc(err.message)}</p>`}}


// ===== Explorer v0.5 — generation filters and traceable parent lines =====
graphState.generationOnly = graphState.generationOnly ?? null;
graphState.colorGenerations = graphState.colorGenerations ?? true;
graphState.hoverParent = graphState.hoverParent ?? null;

const lineagePalette = [
  '#2f9e44', '#3977d6', '#8b5cc7', '#e67e22',
  '#189a9a', '#c94d73', '#7a6b35', '#667085',
  '#b05b2c', '#3f8f74', '#845ef7', '#d9480f'
];
const generationPalette = [
  '#173a3d', '#2f6f67', '#5b7f79', '#8b6b8e',
  '#a8792b', '#5577a4', '#8c7851', '#6f8f4e'
];

function stableColor(id, palette=lineagePalette){
  let h=0;
  for(const ch of String(id||'')) h=(h*31+ch.charCodeAt(0))>>>0;
  return palette[h%palette.length];
}
function parentColor(parentId){ return stableColor(parentId, lineagePalette); }
function generationColor(generation){
  return generationPalette[Math.max(0, generation-1)%generationPalette.length];
}

function buildFamilyIndex(){
  const d=graphState.data, by=Object.fromEntries(d.nodes.map(n=>[n.person_id,n]));
  const children={}, parents={}, spouses={}, siblings={}, adjacent={};
  const add=(map,a,b)=>{(map[a]??=[]).push(b)};
  d.edges.forEach(e=>{
    const pc=parentChild(e);
    if(pc){
      add(children,pc[0],pc[1]); add(parents,pc[1],pc[0]);
      add(adjacent,pc[0],pc[1]); add(adjacent,pc[1],pc[0]);
    } else if(e.relationship_type==='spouse_of'){
      add(spouses,e.person1_id,e.person2_id); add(spouses,e.person2_id,e.person1_id);
      add(adjacent,e.person1_id,e.person2_id); add(adjacent,e.person2_id,e.person1_id);
    } else if(e.relationship_type==='sibling_of'){
      add(siblings,e.person1_id,e.person2_id); add(siblings,e.person2_id,e.person1_id);
      add(adjacent,e.person1_id,e.person2_id); add(adjacent,e.person2_id,e.person1_id);
    }
  });
  return {by,children,parents,spouses,siblings,adjacent};
}

function visibleFamily(){
  const d=graphState.data;
  const index=buildFamilyIndex();
  const {by,children,parents,spouses,siblings}=index;
  const seen=new Set(), levels=new Map(), queue=[[graphState.root,0]];
  while(queue.length){
    const [id,l]=queue.shift();
    if(seen.has(id)||!by[id]) continue;
    const node=by[id];
    if(graphState.branches.size &&
       !graphState.branches.has(node.branch||'Unclassified') &&
       id!==graphState.root) continue;
    seen.add(id); levels.set(id,l);
    if(graphState.expanded.has(id)){
      (children[id]||[]).forEach(x=>queue.push([x,l+1]));
      (parents[id]||[]).forEach(x=>queue.push([x,l-1]));
      (spouses[id]||[]).forEach(x=>queue.push([x,l]));
      (siblings[id]||[]).forEach(x=>queue.push([x,l]));
    }
  }

  const allVisibleIds=[...seen];
  const nonNegative=allVisibleIds.map(id=>levels.get(id)||0).filter(x=>x>=0);
  const maxGeneration=Math.max(1, ...nonNegative.map(x=>x+1));
  const selectedGeneration=graphState.generationOnly;
  let displayIds=allVisibleIds;
  if(selectedGeneration!==null){
    displayIds=allVisibleIds.filter(id=>{
      const level=levels.get(id)||0;
      return level>=0 && level+1===selectedGeneration;
    });
  }
  const displaySet=new Set(displayIds);
  const edges=d.edges.filter(e=>
    displaySet.has(e.person1_id) &&
    displaySet.has(e.person2_id) &&
    familyType(e.relationship_type)
  );
  return {
    nodes:displayIds.map(id=>({...by[id],level:levels.get(id)||0,generation:(levels.get(id)||0)+1})),
    edges, children, parents, spouses, siblings,
    adjacent:index.adjacent, fullSeen:seen, levels, maxGeneration
  };
}

function generationOptions(max){
  let html='<button class="generation-pill active" data-generation="all">All</button>';
  for(let i=1;i<=max;i++){
    html+=`<button class="generation-pill" data-generation="${i}">${i}${i===1?'st':i===2?'nd':i===3?'rd':'th'}</button>`;
  }
  return html;
}

function renderGraphCore(){
  const d=graphState.data;
  const preview=visibleFamily();
  app.innerHTML=`<section class="graph-v2">
    <section class="living-canvas">
      <div class="canvas-help">Drag to move · Scroll to zoom · Click a person · Use + to expand</div>
      <svg id="livingGraph" viewBox="0 0 1600 1000"></svg>
      <div id="hoverCard" class="hover-card"></div>
    </section>

    <aside class="floating-panel graph-command">
      <h2>Living Historical Graph</h2>
      <p>Explore the family without losing your place.</p>
      <label class="field-label">Find and center a person</label>
      <input id="graphFind" list="graphPeople" placeholder="Type a name…">
      <datalist id="graphPeople">${d.nodes.map(n=>`<option value="${esc(n.preferred_name_en)}">${esc(n.preferred_name_fa||'')}</option>`).join('')}</datalist>
      <div class="quick-actions">
        <button id="centerRoot">Make selected root</button>
        <button id="collapseAll">Collapse</button>
        <button id="expandAllVisible">Expand visible</button>
        <button id="gcHome">Original root</button>
      </div>
    </aside>

    <aside id="filterDrawer" class="floating-panel filter-drawer ${graphV2.filtersOpen?'':'collapsed'}">
      <div class="filter-section">
        <h3>Generation</h3>
        <p class="filter-help">The current root is generation 1; its children are generation 2.</p>
        <div id="generationPills" class="generation-pills">${generationOptions(preview.maxGeneration)}</div>
        <label class="check-row generation-color-toggle">
          <input type="checkbox" id="colorGenerations" ${graphState.colorGenerations?'checked':''}>
          Subtle generation colors
        </label>
      </div>

      <div class="filter-section">
        <h3>Branches</h3>
        <label class="check-row"><input type="checkbox" id="allBranches" ${graphState.branches.size?'':'checked'}> All branches</label>
        ${d.branches.map(b=>`<label class="check-row"><input type="checkbox" class="branchCheck" value="${esc(b.branch)}" ${graphState.branches.has(b.branch)?'checked':''}> ${esc(b.branch)} <small>${b.count}</small></label>`).join('')}
      </div>

      <div class="filter-section">
        <h3>How to read parent lines</h3>
        <p class="filter-help">Each parent receives its own line color. Hover a parent card to isolate that parent's child lines.</p>
        <div id="parentLegend" class="parent-line-legend"></div>
      </div>

      <div class="filter-section">
        <h3>Other relationships</h3>
        <div class="legend">
          <span><i class="legend-line spouse"></i>Spouse</span>
          <span><i class="legend-line sibling"></i>Sibling</span>
          <span><i class="legend-line uncertain"></i>Uncertain / multiple</span>
        </div>
      </div>
    </aside>

    <button id="filterToggle" class="floating-panel filter-toggle icon-btn">${graphV2.filtersOpen?'Hide filters':'Show filters'}</button>
    <div id="breadcrumbs" class="breadcrumbs"></div>
    <aside id="personDrawer" class="floating-panel person-float ${graphV2.drawerOpen?'':'hidden'}"></aside>
    <div class="zoom-cluster">
      <button id="gcZoomIn" title="Zoom in">＋</button>
      <button id="gcZoomOut" title="Zoom out">－</button>
      <button id="gcFit" title="Fit graph">Fit</button>
    </div>
    <div id="visibleCount" class="graph-status"></div>
  </section>`;
  wireGraphControls();
  drawLivingGraph();
  renderBreadcrumbs();
  renderPersonDrawer(graphState.selected);
}

function wireGraphControls(){
  const input=document.querySelector('#graphFind');
  input.onchange=()=>{
    const p=graphState.data.nodes.find(x=>x.preferred_name_en===input.value||x.preferred_name_fa===input.value);
    if(p){
      graphState.root=p.person_id;
      graphState.generationOnly=null;
      graphState.scale=1; graphState.tx=graphState.ty=0;
      selectGraphPerson(p.person_id);
    }
  };
  document.querySelector('#centerRoot').onclick=()=>{
    if(graphState.selected){
      graphState.root=graphState.selected;
      graphState.generationOnly=null;
      graphState.expanded.add(graphState.root);
      graphState.scale=1; graphState.tx=graphState.ty=0;
      renderGraphCore();
    }
  };
  document.querySelector('#collapseAll').onclick=()=>{
    graphState.expanded=new Set([graphState.root]);
    graphState.generationOnly=null;
    renderGraphCore();
  };
  document.querySelector('#expandAllVisible').onclick=()=>{
    const before=visibleFamily();
    before.fullSeen.forEach(id=>graphState.expanded.add(id));
    renderGraphCore();
  };
  document.querySelector('#allBranches').onchange=e=>{
    if(e.target.checked){
      graphState.branches.clear();
      document.querySelectorAll('.branchCheck').forEach(x=>x.checked=false);
    }
    renderGraphCore();
  };
  document.querySelectorAll('.branchCheck').forEach(c=>c.onchange=()=>{
    graphState.branches=new Set([...document.querySelectorAll('.branchCheck:checked')].map(x=>x.value));
    renderGraphCore();
  });
  document.querySelectorAll('[data-generation]').forEach(b=>{
    const active=(b.dataset.generation==='all' && graphState.generationOnly===null) ||
                 Number(b.dataset.generation)===graphState.generationOnly;
    b.classList.toggle('active',active);
    b.onclick=()=>{
      graphState.generationOnly=b.dataset.generation==='all'?null:Number(b.dataset.generation);
      renderGraphCore();
    };
  });
  document.querySelector('#colorGenerations').onchange=e=>{
    graphState.colorGenerations=e.target.checked;
    drawLivingGraph();
  };
  document.querySelector('#gcZoomIn').onclick=()=>{
    graphState.scale=Math.min(3,graphState.scale*1.18); drawLivingGraph();
  };
  document.querySelector('#gcZoomOut').onclick=()=>{
    graphState.scale=Math.max(.3,graphState.scale/1.18); drawLivingGraph();
  };
  document.querySelector('#gcFit').onclick=()=>{
    graphState.scale=1;graphState.tx=graphState.ty=0;drawLivingGraph();
  };
  document.querySelector('#gcHome').onclick=()=>{
    graphState.root=graphState.data.default_root;
    graphState.selected=graphState.root;
    graphState.expanded=new Set([graphState.root]);
    graphState.generationOnly=null;
    graphState.scale=1;graphState.tx=graphState.ty=0;
    graphV2.history.push(graphState.root);
    renderGraphCore();
  };
  document.querySelector('#filterToggle').onclick=()=>{
    graphV2.filtersOpen=!graphV2.filtersOpen;
    document.querySelector('#filterDrawer').classList.toggle('collapsed',!graphV2.filtersOpen);
    document.querySelector('#filterToggle').textContent=graphV2.filtersOpen?'Hide filters':'Show filters';
  };
}

function edgeParentId(e){
  const pc=parentChild(e);
  return pc ? pc[0] : null;
}

function drawParentLegend(family){
  const el=document.querySelector('#parentLegend');
  if(!el) return;
  const by=Object.fromEntries(graphState.data.nodes.map(n=>[n.person_id,n]));
  const parentIds=[...new Set(family.edges.map(edgeParentId).filter(Boolean))];
  if(!parentIds.length){
    el.innerHTML='<span class="muted">No visible parent-child lines in this view.</span>';
    return;
  }
  el.innerHTML=parentIds.slice(0,12).map(id=>
    `<button class="parent-legend-item" data-parent-highlight="${id}">
       <i style="background:${parentColor(id)}"></i>
       <span>${esc(by[id]?.preferred_name_en||id)}</span>
     </button>`
  ).join('');
  el.querySelectorAll('[data-parent-highlight]').forEach(b=>{
    b.onmouseenter=()=>highlightParentLines(b.dataset.parentHighlight);
    b.onmouseleave=()=>highlightParentLines(null);
    b.onclick=()=>{
      graphState.selected=b.dataset.parentHighlight;
      selectGraphPerson(b.dataset.parentHighlight);
    };
  });
}

function highlightParentLines(parentId){
  graphState.hoverParent=parentId;
  const svg=document.querySelector('#livingGraph');
  if(!svg) return;
  svg.querySelectorAll('.family-edge.parent').forEach(path=>{
    const match=!parentId || path.dataset.parent===parentId;
    path.classList.toggle('line-muted',!match);
    path.classList.toggle('line-highlight',Boolean(parentId&&match));
  });
  svg.querySelectorAll('.family-node').forEach(node=>{
    if(!parentId){node.classList.remove('node-muted','parent-highlighted');return}
    const id=node.dataset.person;
    const family=visibleFamily();
    const belongs=id===parentId || (family.children[parentId]||[]).includes(id);
    node.classList.toggle('node-muted',!belongs);
    node.classList.toggle('parent-highlighted',id===parentId);
  });
}

function drawLivingGraph(){
  const svg=document.querySelector('#livingGraph');
  if(!svg) return;
  const family=visibleFamily(), nodes=family.nodes, edges=family.edges;
  const count=document.querySelector('#visibleCount');
  if(count){
    count.textContent=graphState.generationOnly===null
      ? `${nodes.length} people · ${edges.length} links`
      : `Generation ${graphState.generationOnly} · ${nodes.length} people`;
  }

  if(!nodes.length){
    svg.innerHTML='<text x="800" y="500" text-anchor="middle" class="empty-generation">No people are visible in this generation with the current branch filters.</text>';
    drawParentLegend(family);
    return;
  }

  const groups={};
  nodes.forEach(n=>(groups[n.level]??=[]).push(n));
  Object.keys(groups).forEach(k=>groups[k].sort((a,b)=>a.preferred_name_en.localeCompare(b.preferred_name_en)));
  const minL=Math.min(...nodes.map(n=>n.level),0), maxL=Math.max(...nodes.map(n=>n.level),0), levelGap=235;
  Object.entries(groups).forEach(([lv,arr])=>{
    const y=500+(Number(lv)-(minL+maxL)/2)*levelGap;
    const gap=Math.min(290,1380/Math.max(arr.length,1));
    arr.forEach((n,i)=>{n.x=800+(i-(arr.length-1)/2)*gap;n.y=y});
  });

  const by=Object.fromEntries(nodes.map(n=>[n.person_id,n]));
  const transform=`translate(${graphState.tx} ${graphState.ty}) scale(${graphState.scale})`;

  const edgeHtml=edges.map(e=>{
    const a=by[e.person1_id], b=by[e.person2_id];
    if(!a||!b) return '';
    const pc=parentChild(e);
    if(pc){
      const parent=by[pc[0]], child=by[pc[1]];
      if(!parent||!child) return '';
      const color=parentColor(pc[0]);
      return `<path class="family-edge parent" data-parent="${pc[0]}" data-child="${pc[1]}"
        style="--parent-line:${color}"
        d="M ${parent.x} ${parent.y+58} C ${parent.x} ${(parent.y+child.y)/2}, ${child.x} ${(parent.y+child.y)/2}, ${child.x} ${child.y-58}"></path>
        <circle class="parent-endpoint" cx="${child.x}" cy="${child.y-58}" r="5" style="--parent-line:${color}"></circle>`;
    }
    const cls=e.relationship_type==='spouse_of'?'spouse':'sibling';
    return `<path class="family-edge ${cls}" d="M ${a.x} ${a.y} C ${a.x} ${(a.y+b.y)/2}, ${b.x} ${(a.y+b.y)/2}, ${b.x} ${b.y}"></path>`;
  }).join('');

  const nodeHtml=nodes.map(n=>{
    const allAdjacent=family.adjacent[n.person_id]||[];
    const hiddenAdjacent=allAdjacent.filter(id=>!family.fullSeen.has(id));
    const expanded=graphState.expanded.has(n.person_id);
    const showControl=expanded ? allAdjacent.length>0 : hiddenAdjacent.length>0;
    const life=[n.birth_date_text,n.death_date_text].filter(Boolean).join(' – ');
    const gen=Math.max(1,n.generation);
    const genColor=generationColor(gen);
    const parentDots=(family.parents[n.person_id]||[])
      .filter(pid=>family.fullSeen.has(pid))
      .slice(0,3)
      .map((pid,i)=>`<circle class="parent-dot" cx="${-94+i*13}" cy="-48" r="4.5" style="--parent-line:${parentColor(pid)}"></circle>`)
      .join('');
    return `<g class="family-node ${n.person_id===graphState.selected?'selected':''} generation-${gen}"
      data-person="${n.person_id}" data-generation="${gen}" transform="translate(${n.x} ${n.y})"
      style="--generation-color:${genColor}">
      <rect x="-105" y="-58" width="210" height="116" rx="16"></rect>
      ${graphState.colorGenerations?`<rect class="generation-stripe" x="-105" y="-58" width="210" height="8" rx="8"></rect>`:''}
      ${parentDots}
      <text class="node-generation" x="92" y="-43">G${gen}</text>
      <text class="node-branch" y="-37">${esc(n.branch||'Unclassified')}</text>
      <text class="node-name" y="-13">
        <tspan x="0">${esc((n.preferred_name_en||'').split(' ').slice(0,3).join(' '))}</tspan>
        <tspan x="0" dy="17">${esc((n.preferred_name_en||'').split(' ').slice(3,7).join(' '))}</tspan>
      </text>
      <text class="node-fa" y="27">${esc(n.preferred_name_fa||'')}</text>
      <text class="node-life" y="46">${esc(life||'Dates not established')}</text>
      ${showControl?`<g class="expand-control" data-expand="${n.person_id}" transform="translate(91 47)">
        <circle r="14"></circle><text y="5">${expanded?'−':'+'}</text>
      </g>`:''}
    </g>`;
  }).join('');

  svg.innerHTML=`<g transform="${transform}">${edgeHtml}${nodeHtml}</g>`;
  drawParentLegend(family);

  svg.querySelectorAll('[data-person]').forEach(g=>{
    g.onclick=e=>{if(e.target.closest('[data-expand]'))return;selectGraphPerson(g.dataset.person)};
    g.onmouseenter=e=>{
      showHover(g.dataset.person,e);
      highlightParentLines(g.dataset.person);
    };
    g.onmousemove=e=>moveHover(e);
    g.onmouseleave=()=>{hideHover();highlightParentLines(null)};
  });
  svg.querySelectorAll('[data-expand]').forEach(g=>g.onclick=e=>{
    e.stopPropagation();
    const id=g.dataset.expand;
    graphState.expanded.has(id)?graphState.expanded.delete(id):graphState.expanded.add(id);
    renderGraphCore();
  });

  let drag=false,lx=0,ly=0;
  svg.onpointerdown=e=>{
    if(e.target.closest('[data-person]'))return;
    drag=true;lx=e.clientX;ly=e.clientY;svg.setPointerCapture(e.pointerId);
  };
  svg.onpointermove=e=>{
    if(!drag)return;
    graphState.tx+=e.clientX-lx;graphState.ty+=e.clientY-ly;lx=e.clientX;ly=e.clientY;
    svg.querySelector('g')?.setAttribute('transform',`translate(${graphState.tx} ${graphState.ty}) scale(${graphState.scale})`);
  };
  svg.onpointerup=()=>drag=false;
  svg.onwheel=e=>{
    e.preventDefault();
    graphState.scale=Math.max(.3,Math.min(3,graphState.scale*(e.deltaY<0?1.08:.92)));
    svg.querySelector('g')?.setAttribute('transform',`translate(${graphState.tx} ${graphState.ty}) scale(${graphState.scale})`);
  };
}

// ===== Explorer v0.6 — generation historical context =====
graphState.showGenerationContext = graphState.showGenerationContext ?? true;

function extractYear(value){
  if(!value) return null;
  const m=String(value).replace(/[–—]/g,'-').match(/(?:^|\D)(1[6-9]\d{2}|20\d{2})(?:\D|$)/);
  return m ? Number(m[1]) : null;
}

function generationProfile(g, nodes){
  const years=[];
  nodes.forEach(n=>{
    [n.birth_date_text,n.death_date_text,n.birth_date,n.death_date,n.date_text,n.notes]
      .map(extractYear).filter(Number.isFinite).forEach(y=>years.push(y));
  });
  let start,end,basis;
  if(years.length){
    start=Math.min(...years);
    end=Math.max(...years);
    if(start===end) end=start+30;
    basis='records';
  } else {
    start=1780+(g-1)*30;
    end=start+30;
    basis='estimated';
  }
  const mid=(start+end)/2;
  let regime='Undetermined';
  if(mid<1736) regime='Late Safavid';
  else if(mid<1747) regime='Afsharid';
  else if(mid<1794) regime='Zand / late Afsharid';
  else if(mid<1834) regime='Early Qajar · Fath-Ali Shah';
  else if(mid<1848) regime='Qajar · Mohammad Shah';
  else if(mid<1896) regime='Qajar · Naser al-Din Shah';
  else if(mid<1907) regime='Late Qajar · Mozaffar al-Din Shah';
  else if(mid<1925) regime='Constitutional / late Qajar';
  else if(mid<1941) regime='Pahlavi · Reza Shah';
  else if(mid<1979) regime='Pahlavi · Mohammad Reza Shah';
  else regime='Islamic Republic period';

  const labels={};
  nodes.forEach(n=>{
    const b=(n.branch||'').toLowerCase();
    let label='Hamadan region';
    if(b.includes('amiri')) label='Hamadan / Kabudarahang';
    else if(b.includes('naser')) label='Bahar / Hamadan';
    else if(b.includes('ashiq')) label='Hamadan and western Iran';
    else if(b.includes('hajilu')) label='Hamadan / Lalejin / Kabudarahang';
    else if(b.includes('shervin')) label='Shervin / Hamadan';
    labels[label]=(labels[label]||0)+1;
  });
  const area=Object.entries(labels).sort((a,b)=>b[1]-a[1])[0]?.[0]||'Hamadan region';
  return {g,start,end,regime,area,basis};
}

function generationContextHtml(family){
  const grouped={};
  family.nodes.forEach(n=>(grouped[Math.max(1,n.generation)]??=[]).push(n));
  const rows=Object.keys(grouped).map(Number).sort((a,b)=>a-b)
    .map(g=>generationProfile(g,grouped[g]));
  return `<aside id="generationContextPanel" class="floating-panel generation-context ${graphState.showGenerationContext?'':'hidden'}">
    <div class="generation-context-head">
      <div><span class="eyebrow">Historical orientation</span><h3>Generation Context</h3></div>
      <button id="closeGenerationContext" class="mini-close">×</button>
    </div>
    <p class="generation-context-note">Ranges use recorded years when available; otherwise they are marked estimates.</p>
    <div class="generation-context-list">
      ${rows.map(r=>`<button class="generation-context-row" data-generation-context="${r.g}" style="--generation-color:${generationColor(r.g)}">
        <i></i><span class="generation-context-main">
          <b>G${r.g}</b><strong>${r.start}–${r.end}</strong>
          <small>(${esc(r.regime)})</small><em>${esc(r.area)}</em>
        </span><span class="context-basis ${r.basis==='estimated'?'estimated':''}">${r.basis==='estimated'?'estimated':'from records'}</span>
      </button>`).join('')}
    </div>
  </aside>
  <button id="showGenerationContext" class="floating-panel generation-context-toggle ${graphState.showGenerationContext?'hidden':''}">Show generation context</button>`;
}

const renderGraphCoreBeforeV06 = renderGraphCore;
renderGraphCore = function(){
  renderGraphCoreBeforeV06();
  const root=document.querySelector('.graph-v2');
  if(!root) return;
  const family=visibleFamily();
  root.insertAdjacentHTML('beforeend',generationContextHtml(family));

  const filterSection=[...document.querySelectorAll('.filter-section')][0];
  if(filterSection){
    filterSection.insertAdjacentHTML('beforeend',`<label class="check-row"><input type="checkbox" id="toggleGenerationContext" ${graphState.showGenerationContext?'checked':''}> Generation date / regime panel</label>`);
  }

  const t=document.querySelector('#toggleGenerationContext');
  if(t) t.onchange=e=>{graphState.showGenerationContext=e.target.checked;renderGraphCore();};
  const c=document.querySelector('#closeGenerationContext');
  if(c) c.onclick=()=>{graphState.showGenerationContext=false;renderGraphCore();};
  const s=document.querySelector('#showGenerationContext');
  if(s) s.onclick=()=>{graphState.showGenerationContext=true;renderGraphCore();};

  document.querySelectorAll('[data-generation-context]').forEach(row=>{
    row.onclick=()=>{
      const g=Number(row.dataset.generationContext);
      graphState.generationOnly=graphState.generationOnly===g?null:g;
      renderGraphCore();
    };
  });
};

// ===== Explorer v0.6.1 — left-side generation bands =====
function generationBandHtml(family){
  const grouped={};
  family.nodes.forEach(n=>(grouped[Math.max(1,n.generation)]??=[]).push(n));
  const rows=Object.keys(grouped).map(Number).sort((a,b)=>a-b)
    .map(g=>generationProfile(g,grouped[g]));
  if(!rows.length) return '';

  const byLevel={};
  family.nodes.forEach(n=>{
    const g=Math.max(1,n.generation);
    (byLevel[g]??=[]).push(n);
  });

  return rows.map(r=>{
    const nodes=byLevel[r.g]||[];
    const avgY=nodes.length ? nodes.reduce((s,n)=>s+(n.y||0),0)/nodes.length : 120+r.g*140;
    return `<div class="generation-band-label" data-band-generation="${r.g}"
      style="--generation-color:${generationColor(r.g)}; top:${Math.max(92, Math.min(900, avgY-42))}px">
      <i></i>
      <div>
        <b>G${r.g}</b>
        <strong>${r.start}–${r.end}</strong>
        <small>(${esc(r.regime)})</small>
        <em>${esc(r.area)}</em>
      </div>
    </div>`;
  }).join('');
}

const drawLivingGraphBeforeV061 = drawLivingGraph;
drawLivingGraph = function(){
  drawLivingGraphBeforeV061();
  const family=visibleFamily();
  const root=document.querySelector('.graph-v2');
  if(!root) return;
  root.querySelectorAll('.generation-band-label').forEach(x=>x.remove());
  root.insertAdjacentHTML('beforeend',generationBandHtml(family));

  root.querySelectorAll('[data-band-generation]').forEach(label=>{
    label.onclick=()=>{
      const g=Number(label.dataset.bandGeneration);
      graphState.generationOnly=graphState.generationOnly===g?null:g;
      renderGraphCore();
    };
  });
};

// ===== Explorer v0.6.2 — SVG-aligned generation bands =====
function svgGenerationBands(){
  const svg=document.querySelector('#livingGraph');
  if(!svg) return;

  // Remove the v0.6.1 HTML overlays and any prior SVG labels.
  document.querySelectorAll('.generation-band-label').forEach(x=>x.remove());
  svg.querySelectorAll('.svg-generation-band').forEach(x=>x.remove());

  const rootGroup=svg.querySelector(':scope > g');
  if(!rootGroup) return;

  const nodeGroups=[...rootGroup.querySelectorAll('.family-node[data-generation]')];
  if(!nodeGroups.length) return;

  const grouped={};
  nodeGroups.forEach(node=>{
    const g=Number(node.dataset.generation);
    const m=(node.getAttribute('transform')||'').match(/translate\(([-\d.]+)\s+([-\d.]+)\)/);
    if(!m) return;
    (grouped[g]??=[]).push({x:Number(m[1]),y:Number(m[2])});
  });

  const family=visibleFamily();
  const dataByGeneration={};
  family.nodes.forEach(n=>(dataByGeneration[Math.max(1,n.generation)]??=[]).push(n));

  Object.keys(grouped).map(Number).sort((a,b)=>a-b).forEach(g=>{
    const positions=grouped[g];
    const avgY=positions.reduce((s,p)=>s+p.y,0)/positions.length;
    const minX=Math.min(...positions.map(p=>p.x));
    const profile=generationProfile(g,dataByGeneration[g]||[]);
    const x=minX-225;
    const y=avgY-50;
    const color=generationColor(g);

    const ns='http://www.w3.org/2000/svg';
    const label=document.createElementNS(ns,'g');
    label.setAttribute('class','svg-generation-band');
    label.setAttribute('data-svg-generation',String(g));
    label.setAttribute('transform',`translate(${x} ${y})`);
    label.style.setProperty('--generation-color',color);

    label.innerHTML=`
      <rect class="svg-generation-bg" x="0" y="0" width="190" height="100" rx="12"></rect>
      <rect class="svg-generation-rule" x="0" y="0" width="6" height="100" rx="3"></rect>
      <text class="svg-generation-g" x="18" y="24">G${g}</text>
      <text class="svg-generation-years" x="54" y="24">${profile.start}–${profile.end}</text>
      <text class="svg-generation-regime" x="18" y="45">(${esc(profile.regime)})</text>
      <text class="svg-generation-area" x="18" y="64">${esc(profile.area)}</text>
      <text class="svg-generation-basis" x="18" y="84">${profile.basis==='estimated'?'Estimated range':'Range from records'}</text>
    `;
    label.addEventListener('click',()=>{
      graphState.generationOnly=graphState.generationOnly===g?null:g;
      renderGraphCore();
    });

    rootGroup.insertBefore(label,rootGroup.firstChild);
  });
}

const drawLivingGraphBeforeV062 = drawLivingGraph;
drawLivingGraph = function(){
  drawLivingGraphBeforeV062();
  svgGenerationBands();
};

// ===== Explorer v0.6.3 — clear generation gutter + timeline toggle =====
graphState.showGenerationBands = graphState.showGenerationBands ?? true;

function svgGenerationBandsV063(){
  const svg=document.querySelector('#livingGraph');
  if(!svg) return;

  document.querySelectorAll('.generation-band-label').forEach(x=>x.remove());
  svg.querySelectorAll('.svg-generation-band').forEach(x=>x.remove());

  if(!graphState.showGenerationBands) return;

  const rootGroup=svg.querySelector(':scope > g');
  if(!rootGroup) return;

  const nodeGroups=[...rootGroup.querySelectorAll('.family-node[data-generation]')];
  if(!nodeGroups.length) return;

  const grouped={};
  nodeGroups.forEach(node=>{
    const g=Number(node.dataset.generation);
    const m=(node.getAttribute('transform')||'').match(/translate\(([-\d.]+)\s+([-\d.]+)\)/);
    if(!m) return;
    (grouped[g]??=[]).push({x:Number(m[1]),y:Number(m[2])});
  });

  const family=visibleFamily();
  const dataByGeneration={};
  family.nodes.forEach(n=>(dataByGeneration[Math.max(1,n.generation)]??=[]).push(n));

  Object.keys(grouped).map(Number).sort((a,b)=>a-b).forEach(g=>{
    const positions=grouped[g];
    const avgY=positions.reduce((s,p)=>s+p.y,0)/positions.length;
    const minX=Math.min(...positions.map(p=>p.x));
    const profile=generationProfile(g,dataByGeneration[g]||[]);

    // Keep labels in a true left gutter with a clear gap before the first person card.
    const width=172;
    const gap=46;
    const x=minX-width-gap;
    const y=avgY-48;
    const color=generationColor(g);

    const ns='http://www.w3.org/2000/svg';
    const label=document.createElementNS(ns,'g');
    label.setAttribute('class','svg-generation-band');
    label.setAttribute('data-svg-generation',String(g));
    label.setAttribute('transform',`translate(${x} ${y})`);
    label.style.setProperty('--generation-color',color);

    label.innerHTML=`
      <rect class="svg-generation-bg" x="0" y="0" width="${width}" height="96" rx="12"></rect>
      <rect class="svg-generation-rule" x="0" y="0" width="6" height="96" rx="3"></rect>
      <text class="svg-generation-g" x="17" y="23">G${g}</text>
      <text class="svg-generation-years" x="49" y="23">${profile.start}–${profile.end}</text>
      <text class="svg-generation-regime" x="17" y="43">${esc('('+profile.regime+')')}</text>
      <text class="svg-generation-area" x="17" y="62">${esc(profile.area)}</text>
      <text class="svg-generation-basis" x="17" y="82">${profile.basis==='estimated'?'Estimated range':'Range from records'}</text>
    `;
    label.addEventListener('click',()=>{
      graphState.generationOnly=graphState.generationOnly===g?null:g;
      renderGraphCore();
    });

    rootGroup.insertBefore(label,rootGroup.firstChild);
  });
}

// Replace the v0.6.2 band renderer.
svgGenerationBands = svgGenerationBandsV063;

const renderGraphCoreBeforeV063 = renderGraphCore;
renderGraphCore = function(){
  renderGraphCoreBeforeV063();

  const firstFilter=[...document.querySelectorAll('.filter-section')][0];
  if(firstFilter && !document.querySelector('#toggleGenerationBands')){
    firstFilter.insertAdjacentHTML('beforeend',`
      <label class="check-row">
        <input type="checkbox" id="toggleGenerationBands" ${graphState.showGenerationBands?'checked':''}>
        Show generation timeline at left
      </label>
    `);
  }

  const toggle=document.querySelector('#toggleGenerationBands');
  if(toggle) toggle.onchange=e=>{
    graphState.showGenerationBands=e.target.checked;
    drawLivingGraph();
  };
};

// ===== Explorer v0.6.4 — expandable generation cards =====
graphState.expandedGenerationCard = graphState.expandedGenerationCard ?? null;

function svgGenerationBandsV064(){
  const svg=document.querySelector('#livingGraph');
  if(!svg) return;

  document.querySelectorAll('.generation-band-label').forEach(x=>x.remove());
  svg.querySelectorAll('.svg-generation-band').forEach(x=>x.remove());

  if(!graphState.showGenerationBands) return;

  const rootGroup=svg.querySelector(':scope > g');
  if(!rootGroup) return;

  const nodeGroups=[...rootGroup.querySelectorAll('.family-node[data-generation]')];
  if(!nodeGroups.length) return;

  const grouped={};
  nodeGroups.forEach(node=>{
    const g=Number(node.dataset.generation);
    const m=(node.getAttribute('transform')||'').match(/translate\(([-\d.]+)\s+([-\d.]+)\)/);
    if(!m) return;
    (grouped[g]??=[]).push({x:Number(m[1]),y:Number(m[2])});
  });

  const family=visibleFamily();
  const dataByGeneration={};
  family.nodes.forEach(n=>(dataByGeneration[Math.max(1,n.generation)]??=[]).push(n));

  // Explorer v0.6.7: use one shared left edge for every generation card.
  // Reserve enough room for the widest expanded card so no card can cover a person node.
  const allPositions=Object.values(grouped).flat();
  const globalMinX=Math.min(...allPositions.map(p=>p.x));
  const expandedWidth=292;
  const nodeClearance=58;
  const alignedLeftX=globalMinX-expandedWidth-nodeClearance;

  Object.keys(grouped).map(Number).sort((a,b)=>a-b).forEach(g=>{
    const positions=grouped[g];
    const avgY=positions.reduce((s,p)=>s+p.y,0)/positions.length;
    const minX=Math.min(...positions.map(p=>p.x));
    const profile=generationProfile(g,dataByGeneration[g]||[]);
    const expanded=graphState.expandedGenerationCard===g;

    const width=expanded ? expandedWidth : 172;
    const height=expanded ? 146 : 96;
    const x=alignedLeftX;
    const y=avgY-height/2;
    const color=generationColor(g);

    const ns='http://www.w3.org/2000/svg';
    const label=document.createElementNS(ns,'g');
    label.setAttribute('class',`svg-generation-band ${expanded?'expanded':''}`);
    label.setAttribute('data-svg-generation',String(g));
    label.setAttribute('transform',`translate(${x} ${y})`);
    label.style.setProperty('--generation-color',color);

    label.innerHTML=`
      <rect class="svg-generation-bg" x="0" y="0" width="${width}" height="${height}" rx="12"></rect>
      <rect class="svg-generation-rule" x="0" y="0" width="6" height="${height}" rx="3"></rect>

      <text class="svg-generation-g" x="17" y="23">G${g}</text>
      <text class="svg-generation-years" x="49" y="23">${profile.start}–${profile.end}</text>
      <text class="svg-generation-regime" x="17" y="43">${esc('('+profile.regime+')')}</text>
      <text class="svg-generation-area" x="17" y="62">${esc(profile.area)}</text>
      <text class="svg-generation-basis" x="17" y="82">${profile.basis==='estimated'?'Estimated range':'Range from records'}</text>

      <g class="svg-generation-expand" transform="translate(${width-22} 24)">
        <circle r="13"></circle>
        <text y="5">${expanded?'‹':'›'}</text>
      </g>

      ${expanded ? `
        <line class="svg-generation-divider" x1="17" y1="96" x2="${width-17}" y2="96"></line>
        <text class="svg-generation-detail-label" x="17" y="116">Generation ${g}</text>
        <text class="svg-generation-detail" x="17" y="133">${esc(profile.regime)} · ${esc(profile.area)}</text>
      ` : ''}
    `;

    label.addEventListener('click',()=>{
      graphState.expandedGenerationCard = expanded ? null : g;
      drawLivingGraph();
    });

    rootGroup.insertBefore(label,rootGroup.firstChild);
  });
}

svgGenerationBands = svgGenerationBandsV064;
