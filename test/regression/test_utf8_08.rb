# -*- coding: utf-8 -*-
require 'helper'

class TestRegressionUtf8_08 < Test::Unit::TestCase
  def setup
    setup_dir_var
  end

  def teardown
    File.delete(@xlsx) if File.exist?(@xlsx)
  end

  def test_utf8_08
    @xlsx = 'utf8_08.xlsx'
    workbook  = WriteXLSX.new(@xlsx)
    worksheet = workbook.add_worksheet

    worksheet.write('A1', 'Foo')

    worksheet.set_header('&LCafé')
    worksheet.set_footer('&Rclé')

    worksheet.paper = 9

    workbook.close
    compare_xlsx_for_regression(File.join(@regression_output, @xlsx), @xlsx,
                                [
                                 'xl/printerSettings/printerSettings1.bin',
                                 'xl/worksheets/_rels/sheet1.xml.rels'
                                ],
                                {
                                  '[Content_Types].xml'      => ['<Default Extension="bin"'],
                                  'xl/workbook.xml' => ['<workbookView'],
                                  #    'xl/worksheets/sheet1.xml' => ['<pageMargins', '<pageSetup'],
                                }
                                )
  end
end
