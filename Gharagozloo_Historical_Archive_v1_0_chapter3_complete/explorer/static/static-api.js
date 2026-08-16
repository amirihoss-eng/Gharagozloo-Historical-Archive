(()=>{
  if(!window.ARCHIVE_STATIC_DATA)return;
  const nativeFetch=window.fetch.bind(window),cache=new Map();
  const load=path=>{if(!cache.has(path))cache.set(path,nativeFetch(path).then(r=>{if(!r.ok)throw new Error(`Static archive data missing: ${path}`);return r.json()}));return cache.get(path)};
  const response=(data,status=200)=>new Response(JSON.stringify(data),{status,headers:{'Content-Type':'application/json; charset=utf-8'}});
  const text=v=>String(v??'').toLocaleLowerCase();
  const includes=(v,q)=>text(v).includes(q);
  window.fetch=async(input,options={})=>{
    const requestUrl=typeof input==='string'?input:input.url,url=new URL(requestUrl,location.origin);
    if(!url.pathname.startsWith('/api/'))return nativeFetch(input,options);
    if((options.method||'GET').toUpperCase()!=='GET')return response({error:'The public archive is read-only.'},405);
    try{
      const path=url.pathname;
      if(path==='/api/health')return response({ok:true,mode:'static-public-export'});
      if(path==='/api/capabilities')return response({curator_mode:false});
      if(path==='/api/dashboard')return response(await load('/data/dashboard.json'));
      if(path==='/api/graph/core')return response(await load('/data/graph_core.json'));
      if(path==='/api/gallery')return response(await load('/data/gallery.json'));
      if(path==='/api/estates')return response(await load('/data/estates.json'));
      if(path==='/api/organizations')return response(await load('/data/organizations.json'));
      if(path==='/api/titles')return response(await load('/data/titles.json'));
      if(path==='/api/research')return response(await load('/data/research.json'));
      if(path==='/api/timeline'){
        const data=await load('/data/timeline.json'),type=url.searchParams.get('type')||'',place=url.searchParams.get('place')||'';
        return response({...data,events:data.events.filter(x=>(!type||x.event_type===type)&&(!place||x.place_id===place))});
      }
      if(path==='/api/people'){
        const people=await load('/data/people.json'),q=text(url.searchParams.get('q')||''),branch=url.searchParams.get('branch')||'',limit=Math.min(Number(url.searchParams.get('limit')||200),500);
        return response(people.filter(p=>(!branch||(p.branch||'Unclassified')===branch)&&(!q||[p.preferred_name_en,p.preferred_name_fa,p.aliases,p.summary,p.branch].some(v=>includes(v,q)))).slice(0,limit));
      }
      if(path==='/api/search'){
        const q=text(url.searchParams.get('q')||'');if(!q)return response([]);
        const index=await load('/data/search_index.json');return response(index.filter(x=>includes(x.search_text,q)).slice(0,60).map(({search_text,...item})=>item));
      }
      let match=path.match(/^\/api\/person\/([^/]+)\/graph$/);if(match)return response(await load(`/data/person_graph/${encodeURIComponent(match[1])}.json`));
      match=path.match(/^\/api\/person\/([^/]+)$/);if(match)return response(await load(`/data/person/${encodeURIComponent(match[1])}.json`));
      match=path.match(/^\/api\/estate\/([^/]+)$/);if(match)return response(await load(`/data/estate/${encodeURIComponent(match[1])}.json`));
      match=path.match(/^\/api\/organization\/([^/]+)$/);if(match)return response(await load(`/data/organization/${encodeURIComponent(match[1])}.json`));
      match=path.match(/^\/api\/title\/([^/]+)$/);if(match)return response(await load(`/data/title/${encodeURIComponent(match[1])}.json`));
      return response({error:`Static API route not exported: ${path}`},404);
    }catch(error){return response({error:error.message},500)}
  };
})();
