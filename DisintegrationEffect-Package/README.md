# DisintegrationEffect

A SwiftUI view modifier that adds a Thanos-snap disintegration effect to any view. Pixels scatter into dust particles that drift away with rotation and fade — perfect for delete animations.

Inspired by [potato04/ThanosSnap](https://github.com/potato04/ThanosSnap).

## Requirements

- iOS 17.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/YOUR_USERNAME/DisintegrationEffect.git", from: "1.0.0")
]
```

Or in Xcode: **File → Add Package Dependencies** → paste the repo URL.

## Usage

### Basic

```swift
import DisintegrationEffect

struct ContentView: View {
    @State private var isDeleting = false

    var body: some View {
        MyRowView()
            .disintegrate(isActive: $isDeleting) {
                // Called after animation completes
                print("Gone!")
            }
    }
}
```

### With Custom Parameters

```swift
.disintegrate(
    isActive: $isDeleting,
    particleLayers: 20,   // fewer = chunkier particles
    duration: 0.8          // seconds
) {
    items.remove(item)
}
```

### With Config Presets

```swift
// Fine dust
.disintegrate(isActive: $isDeleting, config: .fine)

// Chunky & fast
.disintegrate(isActive: $isDeleting, config: .chunky)

// Custom config
let config = DisintegrationConfig(
    particleLayers: 24,
    duration: 1.0,
    spreadX: 100,    // horizontal scatter distance
    spreadY: 50,     // vertical scatter distance
    renderScale: 3.0
)
.disintegrate(isActive: $isDeleting, config: config)
```

### List Swipe-to-Delete Example

```swift
List {
    ForEach(items) { item in
        ItemRow(item: item)
            .disintegrate(
                isActive: /* binding for this item */,
                particleLayers: 20,
                duration: 0.8
            ) {
                withAnimation { items.removeAll { $0.id == item.id } }
            }
            .swipeActions(edge: .trailing) {
                Button {
                    // trigger disintegration
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .tint(.red)
            }
            .listRowBackground(Color.clear)
    }
}
```

> **Tip:** Put the view's background _inside_ the content (not via `.listRowBackground`) so the snapshot captures the full visual appearance.

## How It Works

1. **Snapshot** — `ImageRenderer` captures the view as a `UIImage`
2. **Pixel splitting** — pixels are randomly distributed across N layers, weighted left-to-right so the effect sweeps across
3. **Animation** — each layer gets a `CAAnimationGroup` with Bézier curve movement, rotation, and fade-out, staggered in time

## Config Reference

| Parameter | Default | Description |
|-----------|---------|-------------|
| `particleLayers` | 20 | Number of dust layers (fewer = larger chunks) |
| `duration` | 1.4 | Total animation duration in seconds |
| `spreadX` | 80 | Horizontal scatter distance (points) |
| `spreadY` | 40 | Vertical scatter distance (points) |
| `renderScale` | 3.0 | Snapshot resolution scale |

## License

MIT
