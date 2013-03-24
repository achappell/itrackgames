require 'xmlsimple'

module PlatformsHelper

def fetch_all_platforms
	xml = open('http://thegamesdb.net/api/GetPlatformsList.php')

    platform_data = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Platforms' })["Platforms"].first["Platform"]

    platforms = []

    platform_data.each do |platform|
    	puts platform
    	platforms << build_platform_from_hash(platform)
    end

    platforms
end

def fetch_platform(platform_id)

	updated_platform_id = platform_id

	if Platform.exists?(platform_id)
		updated_platform_id = Platform.find(platform_id).external_id
	end

	xml = open('http://thegamesdb.net/api/GetPlatform.php?id=' + updated_platform_id.to_s)

	platform_data = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Data' })['Platform'].first

	platform = build_platform_from_hash(platform_data)

	platform

end

def build_platform_from_hash(platform_hash)

	id = platform_hash["id"].first

	puts id

	name = platform_hash["name"]

	overview = platform_hash["overview"]
	developer = platform_hash["developer"]
	rating = platform_hash["Rating"]

	if Platform.where(:external_id => id).exists?
		platform = Platform.find_by_external_id(id)
	else
		platform = Platform.create(:external_id => id)
	end

	if name
		platform.name = name.first
	end

	if overview
		platform.overview = overview.first
	end

	if developer
		platform.developer = developer.first
	end

	if rating
		platform.rating = rating.first
	end

  	platform.save

  	platform
end

end
