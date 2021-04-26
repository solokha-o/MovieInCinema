//
//  MovieModel.swift
//  MovieInCinema
//
//  Created by Oleksandr Solokha on 10.04.2021.

import Foundation

// MARK: - MoviePeriod
struct MoviePeriod: Codable {
    let dates: Dates?
    let page: Int?
    let results: [MovieModel]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - MovieModel
struct MovieModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var isWantWatch = false
    
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case cn = "cn"
    case ab = "ab"
    case aa = "aa"
    case af = "af"
    case ak = "ak"
    case sq = "sq"
    case am = "am"
    case ar = "ar"
    case an = "an"
    case hy = "hy"
    case av = "av"
    case ae = "ae"
    case ay = "ay"
    case az = "az"
    case bm = "bm"
    case ba = "ba"
    case eu = "eu"
    case be = "be"
    case bn = "bn"
    case bh = "bh"
    case bi = "bi"
    case bs = "bs"
    case br = "br"
    case bg = "bg"
    case my = "my"
    case ca = "ca"
    case ch = "ch"
    case ce = "ce"
    case ny = "ny"
    case zh = "zh"
    case cv = "cv"
    case kw = "kw"
    case co = "co"
    case cr = "cr"
    case hr = "hr"
    case cs = "cs"
    case da = "da"
    case dv = "dv"
    case nl = "nl"
    case dz = "dz"
    case en = "en"
    case eo = "eo"
    case et = "et"
    case ee = "ee"
    case fo = "fo"
    case fj = "fj"
    case fi = "fi"
    case fr = "fr"
    case ff = "ff"
    case gl = "gl"
    case ka = "ka"
    case de = "de"
    case el = "el"
    case gn = "gn"
    case gu = "gu"
    case ht = "ht"
    case ha = "ha"
    case he = "he"
    case hz = "hz"
    case hi = "hi"
    case ho = "ho"
    case hu = "hu"
    case ia = "ia"
    case id = "id"
    case ie = "ie"
    case ga = "ga"
    case ig = "ig"
    case ik = "ik"
    case io = "io"
    case it = "it"
    case iu = "iu"
    case ja = "ja"
    case jv = "jv"
    case kl = "kl"
    case kn = "kn"
    case kr = "kr"
    case ks = "ks"
    case kk = "kk"
    case km = "km"
    case ki = "ki"
    case rw = "rw"
    case ky = "ky"
    case kv = "kv"
    case kg = "kg"
    case ko = "ko"
    case ku = "ku"
    case kj = "kj"
    case la = "la"
    case lb = "lb"
    case lg = "lg"
    case li = "li"
    case ln = "ln"
    case lo = "lo"
    case lt = "lt"
    case lu = "lu"
    case lv = "lv"
    case gv = "gv"
    case mk = "mk"
    case mg = "mg"
    case ms = "ms"
    case ml = "ml"
    case mt = "mt"
    case mi = "mi"
    case mr = "mr"
    case mh = "mh"
    case mn = "mn"
    case na = "na"
    case nv = "nv"
    case nd = "nd"
    case ne = "ne"
    case ng = "ng"
    case nb = "nb"
    case nn = "nn"
    case no = "no"
    case ii = "ii"
    case nr = "nr"
    case oc = "oc"
    case oj = "oj"
    case cu = "cu"
    case om = "om"
    case or = "or"
    case os = "os"
    case pa = "pa"
    case pi = "pi"
    case fa = "fa"
    case pox = "pox"
    case pl = "pl"
    case ps = "ps"
    case pt = "pt"
    case qu = "qu"
    case rm = "rm"
    case rn = "rn"
    case ro = "ro"
    case ru = "ru"
    case sa = "sa"
    case sc = "sc"
    case sd = "sd"
    case se = "se"
    case sm = "sm"
    case sg = "sg"
    case sr = "sr"
    case gd = "gd"
    case sn = "sn"
    case si = "si"
    case sk = "sk"
    case sl = "sl"
    case so = "so"
    case st = "st"
    case es = "es"
    case su = "su"
    case sw = "sw"
    case ss = "ss"
    case sv = "sv"
    case ta = "ta"
    case te = "te"
    case tg = "tg"
    case th = "th"
    case ti = "ti"
    case bo = "bo"
    case tk = "tk"
    case tl = "tl"
    case tn = "tn"
    case to = "to"
    case tr = "tr"
    case ts = "ts"
    case tt = "tt"
    case tw = "tw"
    case ty = "ty"
    case ug = "ug"
    case uk = "uk"
    case ur = "ur"
    case uz = "uz"
    case ve = "ve"
    case vi = "vi"
    case vo = "vo"
    case wa = "wa"
    case cy = "cy"
    case wo = "wo"
    case fy = "fy"
    case xh = "xh"
    case yi = "yi"
    case yo = "yo"
    case za = "za"
    case zu = "zu"
}
