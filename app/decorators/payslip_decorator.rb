class PayslipDecorator < Draper::Decorator
  delegate_all

  def additional_allowance_1_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_allowance_1
    else
      "additional_allowance_1".titleize
    end
  end

  def additional_allowance_2_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_allowance_2
    else
      "additional_allowance_2".titleize
    end
  end

  def additional_allowance_3_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_allowance_3
    else
      "additional_allowance_3".titleize
    end
  end

  def additional_deduction_1_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_deduction_1
    else
      "additional_deduction_1".titleize
    end
  end

  def additional_deduction_2_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_deduction_1
    else
      "additional_deduction_1".titleize
    end
  end

  def additional_deduction_3_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_deduction_3
    else
      "additional_deduction_3".titleize
    end
  end
end
