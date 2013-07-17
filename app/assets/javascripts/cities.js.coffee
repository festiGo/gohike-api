# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#city_country_code").change (e)->
    console.log("changed", e, $(this).val())
    select_wrapper = $(this).parent().next()
    country_code = $(this).val()
    url = "/state_province_list?country_code=#{country_code}"
    select_wrapper.load(url)

jQuery ->
#call the slider and immediately set the value with setValue so that it loads default value from model
  $('#city_radius').slider('setValue', $("#city_radius").val()).on('slideStop', (ev) ->
    #create a circle with the radius value
    createCircle($("#city_latitude").val(), $("#city_longitude").val(), $("#city_radius").val()) )

jQuery ->
  $("#city_name").change (e)->
    #if city name has changed, draw a circle on map (if all the address fields are updated)
    if( $("#city_name") != "" && $("#city_state_province") != "" & $("#city_country") != "")
      setMapCenter($("#city_name").val() + ", " + $("#city_state_province").val() + ", " + $("#city_country").val() )