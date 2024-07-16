//
//  Country.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

enum Country: String, CaseIterable {
    case pol = "POL"
    case mkd = "MKD"
    case nld = "NLD"
    case mne = "MNE"
    case mco = "MCO"
    case aut = "AUT"
    case nor = "NOR"
}

extension Country {
    var name: String {
        switch self {
        case .pol: "Polen"
        case .mkd: "Mazedonien"
        case .nld: "Niederlande"
        case .mne: "Montenegro"
        case .mco: "Monaco"
        case .aut: "Österreich"
        case .nor: "Norwegen"
        }
    }

    var flag: String {
        switch self {
        case .pol: "🇵🇱"
        case .mkd: "🇲🇰"
        case .nld: "🇳🇱"
        case .mne: "🇲🇪"
        case .mco: "🇲🇨"
        case .aut: "🇦🇹"
        case .nor: "🇳🇴"
        }
    }
}
