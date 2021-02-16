
function loadScript (href) {
    const $script = document.createElement('script')
    $script.src = href
    $script.async = true

    document.head.appendChild($script)
}

function loadGA () {
    loadScript('https://www.googletagmanager.com/gtag/js?id=UA-126764064-1')

    window.dataLayer = window.dataLayer || []
    function gtag(){dataLayer.push(arguments)}

    gtag('js', new Date())

    gtag('config', 'UA-126764064-1')
}

function showCookiesBanner () {
    console.log('🍪 missing!')

    const $banner = document.createElement('div')
    const $banner_snippet = document.querySelector('script[type="text/html"][data-snippet="cookies_banner"]')
    $banner.className = 'cookies_banner show'
    document.body.appendChild($banner)

    $banner.innerHTML = $banner_snippet.textContent

    $banner
        .querySelector('button')
        .addEventListener('click', _e => {
            $banner.className = 'cookies_banner'
            loadGA()
        })
}

if (!/\b_ga=/.test(document.cookie)) showCookiesBanner()
else loadGA()

// import PhotoSwipe from 'photoswipe'
// import PhotoSwipeUI_Default from 'photoswipe/dist/photoswipe-ui-default'

// new PhotoSwipe(
//     document.querySelector('main .pswp'),
//     PhotoSwipeUI_Default,
//     [ // items
//         {
//             src: '/assets/images/menu/menu-1.jpg',
//             w: 2048,
//             h: 1447,
//         },
//         {
//             src: '/assets/images/menu/menu-2.jpg',
//             w: 2048,
//             h: 1447,
//         }
//     ],
//     {
//         // optionName: 'option value'
//         // for example:
//         index: 0 // start at first slide
//     },
// ).init()

