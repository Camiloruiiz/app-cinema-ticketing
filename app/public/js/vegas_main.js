var $body       = $('body'),
    $characters = $('.characters'),
    $posters    = $('.characters-poster'),
    $names      = $('.characters-list a'),
    $label      = $('.characters-label');

var backgrounds = [
    { src: 'img/2.jpg', delay: 6500, video: [
        'img/intro.mp4',
        'img/intro.ogv',
        'img/intro.webm'
    ] },
    { src: 'img/1.jpg', valign: 'top' },
    { src: 'img/2.jpg', valign: 'top' },
    { src: 'img/3.jpg', valign: 'top' }
];

$body.vegas({
    preload: true,
    overlay: '/vendor/bower_components/vegas/dist/overlays/01.png',
    transitionDuration: 4000,
    delay: 10000,
    slides: backgrounds,
    walk: function (nb, settings) {
        if (settings.video) {
            $('.logo').addClass('collapsed');
        } else {
            $('.logo').removeClass('collapsed');
        }
    }
});
