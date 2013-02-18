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

	xml = open('http://thegamesdb.net/api/GetPlatform.php?id=' + platform_id)

	platform_data = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Data' })['Platform'].first

	platform = build_platform_from_hash(platform_data)

	platform

end

def build_platform_from_hash(platform_hash)

	@id = platform_hash["id"]

	name = platform_hash["name"]
	if (name == nil)
		name = platform_hash["Platform"]
	end

	overview = platform_hash["overview"]
	developer = platform_hash["developer"]
	rating = platform_hash["Rating"]

	if Platform.where(:external_id => @id .first).exists?
		platform = Platform.find_by_external_id(@id .first)
	else
		platform = Platform.new
		platform.external_id = @id.first;
	end

	if (name)
		platform.name = name.first
	end

	if (overview)
		platform.overview = overview.first
	end

	if (developer)
		platform.developer = developer.first
	end

	if (rating)
		platform.rating = rating.first
	end

	platform.save

  	platform
end

end
