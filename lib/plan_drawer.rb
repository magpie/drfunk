class PlanDrawer
  def self.draw(plan)
    pdf = PDF::TechBook.new
    pdf.techbook_parse ".title " + plan.name
    #pdf.techbook_parse ".toc Table of Contents"
    pdf.select_font "Times-Roman"
    pdf.text(plan.name, :font_size => 24, :justification => :center)
    pdf.techbook_parse ".newpage"

    pnx = pdf.absolute_right_margin
    pdf.start_page_numbering(pnx, 36, 6, :right, "<PAGENUM>", 1)

    plan.use_cases.each do |use_case|
      pdf.techbook_text " "
      pdf.techbook_parse "1<" + use_case.name + ">FOO"
      pdf.techbook_text " "
      table = PDF::SimpleTable.new
      table.data = []

      use_case.steps.each_with_index do |step, id|
        table.data << {"Step" => id, "Action" => step.description, "Verify" => step.verify}
      end

      table.column_order = ["Step","Action", "Verify"]
      table.bold_headings = true
      table.columns["Step"] = PDF::SimpleTable::Column.new("") { |col|
        col.width = 30
        col.heading = PDF::SimpleTable::Column::Heading.new("")
        col.heading.justification = :left
      }

      table.columns["Action"] = PDF::SimpleTable::Column.new("Action") { |col|
        col.width = 260 
        col.heading = PDF::SimpleTable::Column::Heading.new("Action")
        col.heading.justification = :left
      }

      table.columns["Verify"] = PDF::SimpleTable::Column.new("Verify") { |col|
        col.width = 260
        col.heading = PDF::SimpleTable::Column::Heading.new("Verify")
        col.heading.justification = :left
      }

      table.font_size = 8
      table.heading_font_size = 10 
      table.width = 550
      table.show_lines = :all
      if table.data.length != 0
        table.render_on(pdf)
      end
    end

    pdf.render
  end
end
