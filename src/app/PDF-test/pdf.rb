require "prawn"
require "prawn/measurement_extensions"


Prawn::Document.generate("hello.pdf") do

  
  project_name = "2023 Winter Ball"
  donor_organization = "Han Dynasty"
  address = "123 Chestnut Street, Philadelphia, PA 19106"
  date_of_service = "September 15, 2022"
  approvee_name = "Gregory  Johnson"
  approvee_title = "Director of Operations"
  date_approved = "1/6/2023"
  services_rendered = [['Bob', '34', '7227'], ['Albert', '65', '4333'], ['Spear', '57', '6555']]
  total_services = 0
  goods_donated = [["Event Food (100 pp)", 1000], ["Event Drinks (100 pp)", 1000]]
  total_goods = 0
  total_fascilities = 0
  total_value = 0


  image "FillablePDF-1.png", at: [0, 730],  width: 530

  font 'Times-Roman'

  draw_text "Atlantic Center for Capital Representation", at: [198, 635]
  draw_text project_name, at: [50, 608]
  draw_text donor_organization, at: [110, 595]
  draw_text address, at: [57, 582]
  draw_text date_of_service, at: [150, 503]

  y_position = 467
  services_rendered.each do |name, hours, cost|
    [["#{name}", 70], ["#{hours}", 305], ["#{cost}", 400]].each do |text, x_position|
      text_box text, at: [x_position, y_position], align: :left
    end
    total_services += cost.to_i
    y_position -= 13
  end
  draw_text total_services, at: [396, 381]

  y_position = 350
  goods_donated.each do |name, cost|
    [["#{name}", 70], ["#{cost}", 400]].each do |text, x_position|
      text_box text, at: [x_position, y_position], align: :left
    end
    total_goods += cost.to_i
    y_position -= 13
  end
  draw_text total_goods, at: [396, 287]

  

  draw_text approvee_name, at: [150, 130]
  draw_text approvee_title, at: [150, 117]
  draw_text date_approved, at: [150, 104]  
  
end