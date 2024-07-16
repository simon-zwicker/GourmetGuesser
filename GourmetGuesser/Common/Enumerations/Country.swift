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
    case hun = "HUN"
    case ukr = "UKR"
    case cze = "CZE"
    case esp = "ESP"
    case svn = "SVN"
    case svk = "SVK"
    case srb = "SRB"
    case che = "CHE"
    case swe = "SWE"
    case smr = "SMR"
    case rus = "RUS"
    case rou = "ROU"
    case por = "POR"
    case and = "AND"
    case alb = "ALB"
    case cyp = "CYP"
    case blr = "BLR"
    case gbr = "GBR"
    case mda = "MDA"
    case mlt = "MLT"
    case lux = "LUX"
    case ltu = "LTU"
    case lie = "LIE"
    case lva = "LVA"
    case cro = "CRO"
    case xk = "XK"
    case ita = "ITA"
    case isl = "ISL"
    case ire = "IRE"
    case gre = "GRE"
    case fra = "FRA"
    case fin = "FIN"
    case est = "EST"
    case deu = "DEU"
    case dnk = "DNK"
    case bgr = "BGR"
    case bih = "BIH"
    case bel = "BEL"
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
        case .hun: "Ungarn"
        case .ukr: "Ukraine"
        case .cze: "Tschechien"
        case .esp: "Spanien"
        case .svn: "Slowenien"
        case .svk: "Slowakei"
        case .srb: "Serbien"
        case .che: "Schweiz"
        case .swe: "Schweden"
        case .smr: "San Marino"
        case .rus: "Russland"
        case .rou: "Rumänien"
        case .por: "Portugal"
        case .and: "Andorra"
        case .alb: "Albanien"
        case .cyp: "Zypern"
        case .blr: "Belarus"
        case .gbr: "Großbritannien (UK)"
        case .mda: "Moldau"
        case .mlt: "Malta"
        case .lux: "Luxemburg"
        case .ltu: "Litauen"
        case .lie: "Liechtenstein"
        case .lva: "Lettland"
        case .cro: "Kroatien"
        case .xk: "Kosovo"
        case .ita: "Italien"
        case .isl: "Island"
        case .ire: "Irland"
        case .gre: "Griechenland"
        case .fra: "Frankreich"
        case .fin: "Finnland"
        case .est: "Estland"
        case .deu: "Deutschland"
        case .dnk: "Dänemark"
        case .bgr: "Bulgarien"
        case .bih: "Bosnien und Herzegowina"
        case .bel: "Belgien"
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
        case .hun: "🇭🇺"
        case .ukr: "🇺🇦"
        case .cze: "🇨🇿"
        case .esp: "🇪🇸"
        case .svn: "🇸🇮"
        case .svk: "🇸🇰"
        case .srb: "🇷🇸"
        case .che: "🇨🇭"
        case .swe: "🇸🇪"
        case .smr: "🇸🇲"
        case .rus: "🇷🇺"
        case .rou: "🇷🇴"
        case .por: "🇵🇹"
        case .and: "🇦🇩"
        case .alb: "🇦🇱"
        case .cyp: "🇨🇾"
        case .blr: "🇧🇾"
        case .gbr: "🇬🇧"
        case .mda: "🇲🇩"
        case .mlt: "🇲🇹"
        case .lux: "🇱🇺"
        case .ltu: "🇱🇹"
        case .lie: "🇱🇮"
        case .lva: "🇱🇻"
        case .cro: "🇭🇷"
        case .xk: "🇽🇰"
        case .ita: "🇮🇹"
        case .isl: "🇦🇽"
        case .ire: "🇮🇪"
        case .gre: "🇬🇷"
        case .fra: "🇫🇷"
        case .fin: "🇫🇮"
        case .est: "🇪🇪"
        case .deu: "🇩🇪"
        case .dnk: "🇩🇰"
        case .bgr: "🇧🇬"
        case .bih: "🇧🇦"
        case .bel: "🇧🇪"
        }
    }
}
