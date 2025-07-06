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
            name: LocalizedString(
                japanese: "鶴岡八幡宮",
                english: "Tsurugaoka Hachimangū"
            ),
            cityName: LocalizedString(
                japanese: "雪ノ下",
                english: "Yukinoshita"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3258, longitude: 139.5564),
            description: LocalizedString(
                japanese: "鶴岡八幡宮は、神奈川県鎌倉市雪ノ下にある神社。武家源氏、鎌倉武士の守護神。鎌倉初代将軍源頼朝ゆかりの神社として知られ、鎌倉の文化の起点ともなっています。",
                english: "Tsurugaoka Hachimangū is a Shinto shrine located in Yukinoshita, Kamakura, Kanagawa Prefecture. It is the guardian deity of the Minamoto samurai clan and Kamakura warriors. Known as a shrine associated with Minamoto no Yoritomo, the first shogun of Kamakura, it is considered the starting point of Kamakura culture."
            ),
            imageNames: [
                "tsurugaoka-hachimangu-1",
                "tsurugaoka-hachimangu-2",
                "tsurugaoka-hachimangu-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E9%B6%B4%E5%B2%A1%E5%85%AB%E5%B9%A1%E5%AE%AE",
                english: "https://en.wikipedia.org/wiki/Tsurugaoka_Hachimang%C5%AB"
            ),
            category: .shrine),
        Location(
            name: LocalizedString(
                japanese: "建長寺",
                english: "Kenchō-ji"
            ),
            cityName: LocalizedString(
                japanese: "山ノ内",
                english: "Yamanouchi"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3333, longitude: 139.5529),
            description: LocalizedString(
                japanese: "建長寺は、神奈川県鎌倉市山ノ内にある禅宗の寺院で、臨済宗建長寺派の大本山。鎌倉五山の第一位。境内は国の史跡に指定されています。",
                english: "Kenchō-ji is a Zen Buddhist temple located in Yamanouchi, Kamakura, Kanagawa Prefecture. It is the head temple of the Kenchō-ji school of Rinzai Zen Buddhism and ranks first among the Five Great Zen Temples of Kamakura. The temple grounds are designated as a National Historic Site."
            ),
            imageNames: [
                "kenchoji-1",
                "kenchoji-2",
                "kenchoji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E5%BB%BA%E9%95%B7%E5%AF%BA",
                english: "https://en.wikipedia.org/wiki/Kench%C5%8D-ji"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "長谷寺",
                english: "Hase-dera"
            ),
            cityName: LocalizedString(
                japanese: "長谷",
                english: "Hase"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3129, longitude: 139.5342),
            description: LocalizedString(
                japanese: "長谷寺は、神奈川県鎌倉市長谷にある浄土宗系統の単立寺院。本尊は十一面観音。坂東三十三観音霊場の第四番札所。通称「長谷観音」。",
                english: "Hase-dera is an independent temple of the Pure Land Buddhism tradition located in Hase, Kamakura, Kanagawa Prefecture. The main deity is the Eleven-faced Kannon. It is the fourth temple of the Bandō Sanjūsankasho pilgrimage route and is commonly known as 'Hase Kannon'."
            ),
            imageNames: [
                "hasedera-1",
                "hasedera-2",
                "hasedera-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E9%95%B7%E8%B0%B7%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
                english: "https://en.wikipedia.org/wiki/Hase-dera_(Kamakura)"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "円覚寺",
                english: "Engaku-ji"
            ),
            cityName: LocalizedString(
                japanese: "山ノ内",
                english: "Yamanouchi"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3364, longitude: 139.5503),
            description: LocalizedString(
                japanese: "円覚寺は、神奈川県鎌倉市山ノ内にある寺院。臨済宗円覚寺派の大本山であり、鎌倉五山第二位に列せられる。本尊は宝冠釈迦如来、開基は北条時宗、開山は無学祖元である。",
                english: "Engaku-ji is a temple located in Yamanouchi, Kamakura, Kanagawa Prefecture. It is the head temple of the Engaku-ji school of Rinzai Zen Buddhism and ranks second among the Five Great Zen Temples of Kamakura. The main deity is the Crowned Shakyamuni Buddha, founded by Hōjō Tokimune and established by Mugaku Sogen."
            ),
            imageNames: [
                "engakuji-1",
                "engakuji-2",
                "engakuji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E5%86%86%E8%A6%9A%E5%AF%BA",
                english: "https://en.wikipedia.org/wiki/Engaku-ji"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "高徳院",
                english: "Kōtoku-in"
            ),
            cityName: LocalizedString(
                japanese: "長谷",
                english: "Hase"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3169, longitude: 139.5358),
            description: LocalizedString(
                japanese: "高徳院は、神奈川県鎌倉市長谷にある浄土宗の寺院。本尊は国宝の阿弥陀如来坐像、通称「鎌倉大仏」。山号を大異山、詳しくは大異山高徳院清浄泉寺と号する。",
                english: "Kōtoku-in is a Pure Land Buddhist temple located in Hase, Kamakura, Kanagawa Prefecture. The main deity is the National Treasure Amida Buddha seated statue, commonly known as the 'Great Buddha of Kamakura'. The mountain name is Daibutsu-san, and the full name is Daibutsu-san Kōtoku-in Shōjōsen-ji."
            ),
            imageNames: [
                "kotokuin-1",
                "kotokuin-2",
                "kotokuin-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E9%AB%98%E5%BE%B3%E9%99%A2",
                english: "https://en.wikipedia.org/wiki/K%C5%8Dtoku-in"
            ),
            category: .buddha),
        Location(
            name: LocalizedString(
                japanese: "明月院",
                english: "Meigetsu-in"
            ),
            cityName: LocalizedString(
                japanese: "山ノ内",
                english: "Yamanouchi"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3349917, longitude: 139.5514556),
            description: LocalizedString(
                japanese: "明月院は、神奈川県鎌倉市山ノ内にある臨済宗建長寺派の寺院。山号を福源山と称する。あじさい寺として知られる。",
                english: "Meigetsu-in is a temple of the Kenchō-ji school of Rinzai Zen Buddhism located in Yamanouchi, Kamakura, Kanagawa Prefecture. The mountain name is Fukugen-san. It is known as the 'Hydrangea Temple'."
            ),
            imageNames: [
                "meigetsuin-1",
                "meigetsuin-2",
                "meigetsuin-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E6%98%8E%E6%9C%88%E9%99%A2",
                english: "https://en.wikipedia.org/wiki/Meigetsu-in"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "報国寺",
                english: "Hōkoku-ji"
            ),
            cityName: LocalizedString(
                japanese: "浄明寺",
                english: "Jōmyō-ji"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3199722, longitude: 139.5692778),
            description: LocalizedString(
                japanese: "報国寺は、神奈川県鎌倉市浄明寺にある臨済宗建長寺派の寺院。竹の庭で知られ、「竹寺」とも呼ばれる。",
                english: "Hōkoku-ji is a temple of the Kenchō-ji school of Rinzai Zen Buddhism located in Jōmyō-ji, Kamakura, Kanagawa Prefecture. It is known for its bamboo garden and is also called the 'Bamboo Temple'."
            ),
            imageNames: [
                "hokokuji-1",
                "hokokuji-2",
                "hokokuji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E5%A0%B1%E5%9B%BD%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
                english: "https://en.wikipedia.org/wiki/H%C5%8Dkoku-ji"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "東慶寺",
                english: "Tōkei-ji"
            ),
            cityName: LocalizedString(
                japanese: "山ノ内",
                english: "Yamanouchi"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3352, longitude: 139.5457),
            description: LocalizedString(
                japanese: "東慶寺は、神奈川県鎌倉市山ノ内にある臨済宗円覚寺派の寺院。かつては尼寺で、江戸時代には縁切寺として知られた。",
                english: "Tōkei-ji is a temple of the Engaku-ji school of Rinzai Zen Buddhism located in Yamanouchi, Kamakura, Kanagawa Prefecture. It was once a nunnery and was known as a 'divorce temple' during the Edo period."
            ),
            imageNames: [
                "tokeiji-1",
                "tokeiji-2",
                "tokeiji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E6%9D%B1%E6%85%B6%E5%AF%BA",
                english: "https://en.wikipedia.org/wiki/T%C5%8Dkei-ji"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "浄智寺",
                english: "Jōchi-ji"
            ),
            cityName: LocalizedString(
                japanese: "山ノ内",
                english: "Yamanouchi"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3323, longitude: 139.5461),
            description: LocalizedString(
                japanese: "浄智寺は、神奈川県鎌倉市山ノ内にある臨済宗円覚寺派の寺院。鎌倉五山の第四位。山号を金宝山と称する。",
                english: "Jōchi-ji is a temple of the Engaku-ji school of Rinzai Zen Buddhism located in Yamanouchi, Kamakura, Kanagawa Prefecture. It ranks fourth among the Five Great Zen Temples of Kamakura. The mountain name is Kinpō-san."
            ),
            imageNames: [
                "jochiji-1",
                "jochiji-2",
                "jochiji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E6%B5%84%E6%99%BA%E5%AF%BA",
                english: "https://en.wikipedia.org/wiki/J%C5%8Dchi-ji"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "銭洗弁財天宇賀福神社",
                english: "Zeniarai Benzaiten Ugafuku Shrine"
            ),
            cityName: LocalizedString(
                japanese: "佐助",
                english: "Sasuke"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3228, longitude: 139.5422),
            description: LocalizedString(
                japanese: "銭洗弁財天宇賀福神社は、神奈川県鎌倉市佐助にある神社。境内の洞窟にある清水で硬貨などを洗うと増えるとされることから、銭洗弁天の名で知られる。",
                english: "Zeniarai Benzaiten Ugafuku Shrine is a shrine located in Sasuke, Kamakura, Kanagawa Prefecture. It is known as 'Zeniarai Benten' because it is believed that washing coins and other items in the clear water of the cave within the shrine grounds will make them multiply."
            ),
            imageNames: [
                "zeniarai-benzaiten-1",
                "zeniarai-benzaiten-2",
                "zeniarai-benzaiten-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E9%8A%AD%E6%B4%97%E5%BC%81%E8%B2%A1%E5%A4%A9%E5%AE%87%E8%B3%80%E7%A6%8F%E7%A5%9E%E7%A4%BE",
                english: "https://en.wikipedia.org/wiki/Zeniarai_Benzaiten_Ugafuku_Shrine"
            ),
            category: .shrine),
        Location(
            name: LocalizedString(
                japanese: "浄光明寺",
                english: "Jōkōmyō-ji"
            ),
            cityName: LocalizedString(
                japanese: "扇ガ谷",
                english: "Ōgigayatsu"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3267, longitude: 139.5464),
            description: LocalizedString(
                japanese: "浄光明寺は、神奈川県鎌倉市扇ガ谷にある真言宗泉涌寺派の寺院。山号を泉谷山と称する。本尊は阿弥陀如来。",
                english: "Jōkōmyō-ji is a temple of the Shingon Buddhism Sennyū-ji school located in Ōgigayatsu, Kamakura, Kanagawa Prefecture. The mountain name is Sen'yoku-san. The main deity is Amida Buddha."
            ),
            imageNames: [
                "jokomyoji-1",
                "jokomyoji-2",
                "jokomyoji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E6%B5%84%E5%85%89%E6%98%8E%E5%AF%BA",
                english: "https://ja.wikipedia.org/wiki/%E6%B5%84%E5%85%89%E6%98%8E%E5%AF%BA"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "海蔵寺",
                english: "Kaizō-ji"
            ),
            cityName: LocalizedString(
                japanese: "扇ガ谷",
                english: "Ōgigayatsu"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3256, longitude: 139.5431),
            description: LocalizedString(
                japanese: "海蔵寺は、神奈川県鎌倉市扇ガ谷にある臨済宗建長寺派の寺院。山号を鷲峰山と称する。本尊は薬師如来。",
                english: "Kaizō-ji is a temple of the Kenchō-ji school of Rinzai Zen Buddhism located in Ōgigayatsu, Kamakura, Kanagawa Prefecture. The mountain name is Juhō-san. The main deity is Yakushi Buddha."
            ),
            imageNames: [
                "kaizoji-1",
                "kaizoji-2",
                "kaizoji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E6%B5%B7%E8%94%B5%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
                english: "https://ja.wikipedia.org/wiki/%E6%B5%B7%E8%94%B5%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "光明寺",
                english: "Kōmyō-ji"
            ),
            cityName: LocalizedString(
                japanese: "材木座",
                english: "Zaimokuza"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.30325, longitude: 139.5547222),
            description: LocalizedString(
                japanese: "光明寺は、神奈川県鎌倉市材木座にある浄土宗の大本山。山号を天照山と称する。本尊は阿弥陀如来。",
                english: "Kōmyō-ji is the head temple of Pure Land Buddhism located in Zaimokuza, Kamakura, Kanagawa Prefecture. The mountain name is Tenshō-san. The main deity is Amida Buddha."
            ),
            imageNames: [
                "komyoji-1",
                "komyoji-2",
                "komyoji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E5%85%89%E6%98%8E%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
                english: "https://en.wikipedia.org/wiki/K%C5%8Dmy%C5%8D-ji"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "寿福寺",
                english: "Jufuku-ji"
            ),
            cityName: LocalizedString(
                japanese: "扇ガ谷",
                english: "Ōgigayatsu"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3241667, longitude: 139.5490278),
            description: LocalizedString(
                japanese: "寿福寺は、神奈川県鎌倉市扇ガ谷にある臨済宗建長寺派の寺院。鎌倉五山第三位。開基は北条政子、開山は栄西。",
                english: "Jufuku-ji is a temple of the Kenchō-ji school of Rinzai Zen Buddhism located in Ōgigayatsu, Kamakura, Kanagawa Prefecture. It ranks third among the Five Great Zen Temples of Kamakura. Founded by Hōjō Masako and established by Eisai."
            ),
            imageNames: [
                "jufukuji-1",
                "jufukuji-2",
                "jufukuji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E5%AF%BF%E7%A6%8F%E5%AF%BA",
                english: "https://en.wikipedia.org/wiki/Jufuku-ji"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "安養院",
                english: "Anyō-in"
            ),
            cityName: LocalizedString(
                japanese: "大町",
                english: "Ōmachi"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3141667, longitude: 139.5552778),
            description: LocalizedString(
                japanese: "安養院は、神奈川県鎌倉市大町にある浄土宗の寺院。坂東三十三観音・鎌倉三十三観音霊場第3番札所。ツツジの名所としても知られる。",
                english: "Anyō-in is a Pure Land Buddhist temple located in Ōmachi, Kamakura, Kanagawa Prefecture. It is the third temple of the Bandō Sanjūsankasho and Kamakura Sanjūsankasho pilgrimage routes. It is also known as a famous spot for azaleas."
            ),
            imageNames: [
                "anyoin-1",
                "anyoin-2",
                "anyoin-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E5%AE%89%E9%A4%8A%E9%99%A2_(%E9%8E%8C%E5%80%89%E5%B8%82)",
                english: "https://ja.wikipedia.org/wiki/%E5%AE%89%E9%A4%8A%E9%99%A2_(%E9%8E%8C%E5%80%89%E5%B8%82)"
            ),
            category: .temple),
        Location(
            name: LocalizedString(
                japanese: "荏柄天神社",
                english: "Egara Tenjin Shrine"
            ),
            cityName: LocalizedString(
                japanese: "二階堂",
                english: "Nikaidō"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3269, longitude: 139.5631),
            description: LocalizedString(
                japanese: "荏柄天神社は、神奈川県鎌倉市二階堂にある神社。菅原道真を祀り、学問の神として信仰を集める。日本三大天神の一つ。",
                english: "Egara Tenjin Shrine is a shrine located in Nikaidō, Kamakura, Kanagawa Prefecture. It enshrines Sugawara no Michizane and is worshipped as the god of learning. It is one of the Three Great Tenjin Shrines of Japan."
            ),
            imageNames: [
                "egaratenjinsha-1",
                "egaratenjinsha-2",
                "egaratenjinsha-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E8%8D%8F%E6%9F%84%E5%A4%A9%E7%A5%9E%E7%A4%BE",
                english: "https://en.wikipedia.org/wiki/Egara_Tenjin_Shrine"
            ),
            category: .shrine),
        Location(
            name: LocalizedString(
                japanese: "本覚寺",
                english: "Hongaku-ji"
            ),
            cityName: LocalizedString(
                japanese: "小町",
                english: "Komachi"
            ),
            coordinates: CLLocationCoordinate2D(latitude: 35.3173333, longitude: 139.5523889),
            description: LocalizedString(
                japanese: "本覚寺は、神奈川県鎌倉市小町にある日蓮宗の本山。身延山の久遠寺にあった日蓮の遺骨を分骨したため「東身延」とも呼ばれる。",
                english: "Hongaku-ji is the head temple of Nichiren Buddhism located in Komachi, Kamakura, Kanagawa Prefecture. It is also called 'East Minobu' because it contains a portion of Nichiren's remains that were divided from Kuon-ji on Mount Minobu."
            ),
            imageNames: [
                "hongakuji-1",
                "hongakuji-2",
                "hongakuji-3",
            ],
            link: LocalizedLinks(
                japanese: "https://ja.wikipedia.org/wiki/%E6%9C%AC%E8%A6%9A%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)",
                english: "https://ja.wikipedia.org/wiki/%E6%9C%AC%E8%A6%9A%E5%AF%BA_(%E9%8E%8C%E5%80%89%E5%B8%82)"
            ),
            category: .temple),
    ]
    
}
