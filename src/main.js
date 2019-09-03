
import PhotoSwipe from 'photoswipe'
import PhotoSwipeUI_Default from 'photoswipe/dist/photoswipe-ui-default'

new PhotoSwipe(
    document.querySelector('main .pswp'),
    PhotoSwipeUI_Default,
    [ // items
        {
            src: '/assets/images/menu/menu-1.jpg',
            w: 2048,
            h: 1447,
        },
        {
            src: '/assets/images/menu/menu-2.jpg',
            w: 2048,
            h: 1447,
        }
    ],
    {
        // optionName: 'option value'
        // for example:
        index: 0 // start at first slide
    },
).init()

