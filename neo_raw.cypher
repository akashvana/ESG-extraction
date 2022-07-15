LOAD CSV WITH HEADERS FROM 'file:///final_output.csv' AS row
merge(p:property {name:row.owtology_entry,amount:coalesce(row.amount,"Unknown"),quantity:coalesce(row.quantity,"Unknown"),date:coalesce(row.year,"Unknown"),relation:coalesce(row.relation, "Unknown"),company:coalesce(row.organization, "Unknown"),topic:coalesce(row.class_name, "Unknown")}
MERGE (c:Company {name: row.organization})
merge(t:topic {name: row.class_name,comp: row.organization})

match(t:topic),(c:Company)
where t.comp=c.name
create(c)-[:has_topic]->(t)

match(t:topic),(p:property)
where t.comp=p.comp and t.name=p.topic
create(t)-[:has_prop]->(p)

create(company:head {name:'Companies'})

match(h:head),(c:Company)
create(h)-[:includes]->(c)

match(c) return (c)