1. LWOR expression which outputs a list of countries having islands. Output Country
name and island name.

let $doc := doc("file:///home/world.xml")
for $island in $doc//island
let $country :=
 if (empty($doc//country[@name = $island/@name])) then
 $doc//country[@id = $island/located/@country]
 else
 $doc//country[@name = $island/@name]
where not(empty($country))
return concat("country: ", string($country/@name), " : ", " island: ", string($island/@name))

2. FLWOR expression which outputs the average population for cities in Croatia.

let $cities-in-usa := doc("file:///home/world.xml")/mondial/country[@name="United States"]//city
return string(avg($cities-in-usa/population))

3. FLWOR Expression which outputs the names and population of the countries with
population less than 1 million and also has gdp_total less than 10000.

for $country in doc("world.xml")/mondial/country
where $country[@population < 1000000] and $country[@gdp_total < 10000]
return concat(normalize-space(string($country/name)), ':', normalizespace($country/@population))

4. FLWOR expression which outputs Provinces and their Capitals in United States. Output Province Name and Capital Name.

for $t in doc("file:///home/world.xml")/mondial/country[@name="United States"]/province
let $pro_name := $t/@name
let $cap_name := $t/city[@id=$t/@capital]/name[1]
return concat('Province: ',normalize-space($pro_name), " :: ", 'Capital: ', normalizespace($cap_name))

5. FLWOR expression which outputs a list of capitals of countries, where national
inflation is between including 2 and 4 and the government of these countries has the word
‘democracy’. Output Country name, Country Inflation and Country government.

for $x in doc("file:///home/world.xml")/mondial/country
let $y :=
doc("file:///home/world.xml")/mondial/country[@name=$x/@name]//city[@id=$x/@capital]/
name[1]
where $x/@inflation >= 2 and $x/@inflation <= 4 and $x[contains(@government, 'democracy')]
return concat('Country: ',normalize-space($x/@name)," , ",'capital: ', normalize-space($y),' , ',
'inflation: ', normalize-space($x/@inflation), ' , ', 'government: ', normalizespace($x/@government))

6. XPath that returns cities and its population in Sweden located nearby lakes and
having population less than 40000.

doc("file:///home/world.xml")/mondial/country[@name="Sweden"]/province/city[located_at[
@type="lake"]]/normalize-space(concat(name/text()," --- ",population[1]/text()))

7. XPath which outputs the population of city Antwerp in Belgium.

doc("file:///home/world.xml")/mondial/country[@name="Belgium"]/province/city/population[
../name/normalize-space(text())='Antwerp']/normalize-space(text())

8. FLWOR expression which averages the area of the provinces with area greater
than 1M.

let $provinces := doc("file:///home/world.xml")/mondial/country/province[@area > 1000000]
return string(avg($provinces/@area))

9. XPath which outputs cities having an area less than 300.
doc("world.xml")/mondial/country/province[number(@area) < 300]//city/data(name)

10. XPath which outputs countries having less than or equal to 3 ethnic groups and
having more than or equal to 5 religions.

doc("file:///home/world.xml")/mondial/country[count(ethnicgroups) <=3 and
count(religions)>=5]/string(@name)

11. FLWOR Expression which outputs Countries names starting with letter M.

for $country in doc("file:///home/world.xml")/mondial/country[starts-with(@name, 'M')]
return string($country/@name)

12. FLWOR Expression which outputs cities name and population of Belgium in
descending order by population with population less than 1 million

for $t in doc("file:///home/world.xml")/mondial/country[@name="Belgium"]/province/city
where $t/population < 1000000
order by number($t/population) descending
return concat(normalize-space(string($t/name)), ':', normalize-space($t/population))

13.FLWOR Expression which outputs Countries name and population with
population more than the average population of all countries.

let $countries := doc("file:///home/world.xml")/mondial/country
let $avg-population := avg($countries/@population)
for $country in $countries
where $country/@population > $avg-population
return concat(normalize-space(string( $country/@name)),':',normalizespace(string($country/@population)))

14. FLWOR Expression which outputs country names belonging to World Trade
Organization and which have population more than 100 million.

for $t in doc("file:///home/world.xml")/mondial/organization
let $z :=doc("file:///home/world.xml")/mondial/country[@id = $t/members/@country and
@population>100000000]/normalize-space(string(name[1]))
where $t/@name='World Trade Organization'
return $z



1.  FLWOR expression which outputs the country name, ethnic groups and average
population of cities in countries with more than 4 ethnic groups.

for $x in document("/home/world.xml")/mondial//country
where count($x/ethnicgroups) > 4
return <country name = "{$x/@name}" average_population = "{avg($x//city/population)}"
ethnic_groups = "{normalize-space(string-join($x/ethnicgroups,','))}"/>

2. FLWOR expression which outputs the countries that are members of the Agency
for Cultural and Technical Cooperation.

let $agency := doc("/home/world.xml")/mondial/organization[@name = "Agency for Cultural
and Technical Cooperation"]
for $country in $agency
let $coun_id := doc("/home/world.xml")/mondial/country[@id =
$country/members/@country] for $country_id in $coun_id
return $country_id/@name/normalize-space()
