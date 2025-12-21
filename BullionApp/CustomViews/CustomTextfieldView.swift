//
//  CustomTextfieldView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import SwiftUI

enum TextFieldType {
    case normal
    case secure
}

struct CustomTextfieldView<Suffix: View>: View {

    var label: String
    var description: String = ""
    @Binding var text: String

    var type: TextFieldType = .normal
    var labelWeight: String = AppFonts.RobotoRegular
    var isDisableField = false
    @ViewBuilder let suffixView: () -> Suffix

//    var action: (() -> Void)?
    
    @ViewBuilder
    private var inputField: some View {
        switch type {
        case .normal:
            TextField(label, text: $text, prompt: placeholder)
                .disabled(isDisableField)
        case .secure:
            SecureField(label, text: $text, prompt: placeholder)
                .disabled(isDisableField)
        }
    }
    
    private var placeholder: Text {
        Text("Placeholder here")
            .font(.custom(AppFonts.RobotoRegular, size: 14))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.custom(labelWeight, size: 14))
                .foregroundStyle(
                    LinearGradient(
                        stops: [
                            .init(color: AppColors.foregroundText1, location: 0),
                            .init(color: AppColors.foregroundText2, location: 0.67),
                            .init(color: AppColors.foregroundText3, location: 1)],
                        startPoint: .bottomLeading, endPoint: .topTrailing))
            
            if !description.isEmpty {
                Text(description)
                    .font(.custom(AppFonts.RobotoRegular, size: 12))
                    .foregroundStyle(AppColors.darkGray)

            }
            
            HStack {
                inputField
 
                suffixView()
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .frame(height: 48)
            .background(AppColors.white)
            .cornerRadius(100)
            .overlay {
                RoundedRectangle(cornerRadius: 100)
                    .stroke(AppColors.lightGray, lineWidth: 1)
            }
        }
    }
}

extension CustomTextfieldView {
    enum LabelWieght {
        case medium
        case regular
    }
    
    func labelWeight(_ labelWeight: LabelWieght) -> Self {
        var copy = self
        switch labelWeight {
        case .medium:
            copy.labelWeight = AppFonts.RobotoMedium
        case .regular:
            copy.labelWeight = AppFonts.RobotoRegular
        }
        return copy
    }
}

extension CustomTextfieldView where Suffix == EmptyView {
    init(
        label: String,
        description: String = "",
        text: Binding<String>,
        type: TextFieldType = .normal,
        labelWeight: String = AppFonts.RobotoRegular,
        isDisableField: Bool = false
    ) {
        self.label = label
        self.description = description
        self._text = text
        self.type = type
        self.labelWeight = labelWeight
        self.isDisableField = isDisableField
        self.suffixView = { EmptyView() }
//        self.action = nil
    }
}
