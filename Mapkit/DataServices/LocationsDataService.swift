//
//  LocationsDataService.swift
//  MapTest
//
//  Created by Nick Sarno on 11/26/21.
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "鶴岡八幡宮",
            cityName: "雪ノ下",
            coordinates: CLLocationCoordinate2D(latitude: 35.3258, longitude: 139.5564),
            description: "鶴岡八幡宮は、神奈川県鎌倉市雪ノ下にある神社。武家源氏、鎌倉武士の守護神。鎌倉初代将軍源頼朝ゆかりの神社として知られ、鎌倉の文化の起点ともなっています。",
            imageNames: [
                "tsurugaoka-hachimangu-1",
                "tsurugaoka-hachimangu-2",
                "tsurugaoka-hachimangu-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E9%B6%B4%E5%B2%A1%E5%85%AB%E5%B9%A1%E5%AE%AE",
            category: .shrine),
        Location(
            name: "建長寺",
            cityName: "山ノ内",
            coordinates: CLLocationCoordinate2D(latitude: 35.3333, longitude: 139.5529),
            description: "建長寺は、神奈川県鎌倉市山ノ内にある禅宗の寺院で、臨済宗建長寺派の大本山。鎌倉五山の第一位。境内は国の史跡に指定されています。",
            imageNames: [
                "kenchoji-1",
                "kenchoji-2",
                "kenchoji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E5%BB%BA%E9%95%B7%E5%AF%BA",
            category: .temple),
        Location(
            name: "長谷寺",
            cityName: "長谷",
            coordinates: CLLocationCoordinate2D(latitude: 35.3129, longitude: 139.5342),
            description: "長谷寺は、神奈川県鎌倉市長谷にある浄土宗系統の単立寺院。本尊は十一面観音。坂東三十三観音霊場の第四番札所。通称「長谷観音」。",
            imageNames: [
                "hasedera-1",
                "hasedera-2",
                "hasedera-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E9%95%B7%E8%B0%B7%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
            category: .temple),
        Location(
            name: "円覚寺",
            cityName: "山ノ内",
            coordinates: CLLocationCoordinate2D(latitude: 35.3364, longitude: 139.5503),
            description: "円覚寺は、神奈川県鎌倉市山ノ内にある寺院。臨済宗円覚寺派の大本山であり、鎌倉五山第二位に列せられる。本尊は宝冠釈迦如来、開基は北条時宗、開山は無学祖元である。",
            imageNames: [
                "engakuji-1",
                "engakuji-2",
                "engakuji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E5%86%86%E8%A6%9A%E5%AF%BA",
            category: .temple),
        Location(
            name: "高徳院",
            cityName: "長谷",
            coordinates: CLLocationCoordinate2D(latitude: 35.3169, longitude: 139.5358),
            description: "高徳院は、神奈川県鎌倉市長谷にある浄土宗の寺院。本尊は国宝の阿弥陀如来坐像、通称「鎌倉大仏」。山号を大異山、詳しくは大異山高徳院清浄泉寺と号する。",
            imageNames: [
                "kotokuin-1",
                "kotokuin-2",
                "kotokuin-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E9%AB%98%E5%BE%B3%E9%99%A2",
            category: .buddha),
        Location(
            name: "明月院",
            cityName: "山ノ内",
            coordinates: CLLocationCoordinate2D(latitude: 35.3349917, longitude: 139.5514556),
            description: "明月院は、神奈川県鎌倉市山ノ内にある臨済宗建長寺派の寺院。山号を福源山と称する。あじさい寺として知られる。",
            imageNames: [
                "meigetsuin-1",
                "meigetsuin-2",
                "meigetsuin-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E6%98%8E%E6%9C%88%E9%99%A2",
            category: .temple),
        Location(
            name: "報国寺",
            cityName: "浄明寺",
            coordinates: CLLocationCoordinate2D(latitude: 35.3199722, longitude: 139.5692778),
            description: "報国寺は、神奈川県鎌倉市浄明寺にある臨済宗建長寺派の寺院。竹の庭で知られ、「竹寺」とも呼ばれる。",
            imageNames: [
                "hokokuji-1",
                "hokokuji-2",
                "hokokuji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E5%A0%B1%E5%9B%BD%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
            category: .temple),
        Location(
            name: "東慶寺",
            cityName: "山ノ内",
            coordinates: CLLocationCoordinate2D(latitude: 35.3352, longitude: 139.5457),
            description: "東慶寺は、神奈川県鎌倉市山ノ内にある臨済宗円覚寺派の寺院。かつては尼寺で、江戸時代には縁切寺として知られた。",
            imageNames: [
                "tokeiji-1",
                "tokeiji-2",
                "tokeiji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E6%9D%B1%E6%85%B6%E5%AF%BA",
            category: .temple),
        Location(
            name: "浄智寺",
            cityName: "山ノ内",
            coordinates: CLLocationCoordinate2D(latitude: 35.3323, longitude: 139.5461),
            description: "浄智寺は、神奈川県鎌倉市山ノ内にある臨済宗円覚寺派の寺院。鎌倉五山の第四位。山号を金宝山と称する。",
            imageNames: [
                "jochiji-1",
                "jochiji-2",
                "jochiji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E6%B5%84%E6%99%BA%E5%AF%BA",
            category: .temple),
        Location(
            name: "銭洗弁財天宇賀福神社",
            cityName: "佐助",
            coordinates: CLLocationCoordinate2D(latitude: 35.3228, longitude: 139.5422),
            description: "銭洗弁財天宇賀福神社は、神奈川県鎌倉市佐助にある神社。境内の洞窟にある清水で硬貨などを洗うと増えるとされることから、銭洗弁天の名で知られる。",
            imageNames: [
                "zeniarai-benzaiten-1",
                "zeniarai-benzaiten-2",
                "zeniarai-benzaiten-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E9%8A%AD%E6%B4%97%E5%BC%81%E8%B2%A1%E5%A4%A9%E5%AE%87%E8%B3%80%E7%A6%8F%E7%A5%9E%E7%A4%BE",
            category: .shrine),
        Location(
            name: "浄光明寺",
            cityName: "扇ガ谷",
            coordinates: CLLocationCoordinate2D(latitude: 35.3267, longitude: 139.5464),
            description: "浄光明寺は、神奈川県鎌倉市扇ガ谷にある真言宗泉涌寺派の寺院。山号を泉谷山と称する。本尊は阿弥陀如来。",
            imageNames: [
                "jokomyoji-1",
                "jokomyoji-2",
                "jokomyoji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E6%B5%84%E5%85%89%E6%98%8E%E5%AF%BA",
            category: .temple),
        Location(
            name: "海蔵寺",
            cityName: "扇ガ谷",
            coordinates: CLLocationCoordinate2D(latitude: 35.3256, longitude: 139.5431),
            description: "海蔵寺は、神奈川県鎌倉市扇ガ谷にある臨済宗建長寺派の寺院。山号を鷲峰山と称する。本尊は薬師如来。",
            imageNames: [
                "kaizoji-1",
                "kaizoji-2",
                "kaizoji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E6%B5%B7%E8%94%B5%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
            category: .temple),
        Location(
            name: "光明寺",
            cityName: "材木座",
            coordinates: CLLocationCoordinate2D(latitude: 35.30325, longitude: 139.5547222),
            description: "光明寺は、神奈川県鎌倉市材木座にある浄土宗の大本山。山号を天照山と称する。本尊は阿弥陀如来。",
            imageNames: [
                "komyoji-1",
                "komyoji-2",
                "komyoji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E5%85%89%E6%98%8E%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
            category: .temple),
        Location(
            name: "寿福寺",
            cityName: "扇ガ谷",
            coordinates: CLLocationCoordinate2D(latitude: 35.3241667, longitude: 139.5490278),
            description: "寿福寺は、神奈川県鎌倉市扇ガ谷にある臨済宗建長寺派の寺院。鎌倉五山第三位。開基は北条政子、開山は栄西。",
            imageNames: [
                "jufukuji-1",
                "jufukuji-2",
                "jufukuji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E5%AF%BF%E7%A6%8F%E5%AF%BA",
            category: .temple),
        Location(
            name: "安養院",
            cityName: "大町",
            coordinates: CLLocationCoordinate2D(latitude: 35.3141667, longitude: 139.5552778),
            description: "安養院は、神奈川県鎌倉市大町にある浄土宗の寺院。坂東三十三観音・鎌倉三十三観音霊場第3番札所。ツツジの名所としても知られる。",
            imageNames: [
                "anyoin-1",
                "anyoin-2",
                "anyoin-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E5%AE%89%E9%A4%8A%E9%99%A2_(%E9%8E%8C%E5%80%89%E5%B8%82)",
            category: .temple),
        Location(
            name: "荏柄天神社",
            cityName: "二階堂",
            coordinates: CLLocationCoordinate2D(latitude: 35.3269, longitude: 139.5631),
            description: "荏柄天神社は、神奈川県鎌倉市二階堂にある神社。菅原道真を祀り、学問の神として信仰を集める。日本三大天神の一つ。",
            imageNames: [
                "egaratenjinsha-1",
                "egaratenjinsha-2",
                "egaratenjinsha-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E8%8D%8F%E6%9F%84%E5%A4%A9%E7%A5%9E%E7%A4%BE",
            category: .shrine),
        Location(
            name: "本覚寺",
            cityName: "小町",
            coordinates: CLLocationCoordinate2D(latitude: 35.3173333, longitude: 139.5523889),
            description: "本覚寺は、神奈川県鎌倉市小町にある日蓮宗の本山。身延山の久遠寺にあった日蓮の遺骨を分骨したため「東身延」とも呼ばれる。",
            imageNames: [
                "hongakuji-1",
                "hongakuji-2",
                "hongakuji-3",
            ],
            link: "https://ja.wikipedia.org/wiki/%E6%9C%AC%E8%A6%9A%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
            category: .temple),
    ]
    
}
