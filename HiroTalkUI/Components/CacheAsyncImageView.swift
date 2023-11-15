//
//  CacheAsyncImageView.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import SwiftUI

struct CacheAsyncImageView<Content>: View where Content: View {

    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(url: URL,
         scale: CGFloat = 1.0,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping(AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(url: url,
                       scale: scale,
                       transaction: transaction) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

struct CacheAsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        let urlStr = "http://dummyimage.com/300x200/acc/fff.gif&text=犬"
        CacheAsyncImageView(url: URL(string: urlStr)!) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
            case .failure(_):
                ProgressView()
            @unknown default:
                fatalError()
            }

        }
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

//struct ImageCacheKey: EnvironmentKey {
//    static let defaultValue: ImageCache = TemporaryImageCache()
//}
//
//extension EnvironmentValues {
//    var imageCache: ImageCache {
//        get { self[ImageCacheKey.self] }
//        set { self[ImageCacheKey.self] = newValue }
//    }
//}
//
//protocol ImageCache {
//    subscript(_ url: URL) -> UIImage? { get set }
//}
//
//struct TemporaryImageCache: ImageCache {
//    private let cache: NSCache<NSURL, UIImage> = {
//        let cache = NSCache<NSURL, UIImage>()
//        cache.countLimit = 100
//        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
//        return cache
//    }()
//
//    subscript(_ key: URL) -> UIImage? {
//        get { cache.object(forKey: key as NSURL) }
//        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
//    }
//}
