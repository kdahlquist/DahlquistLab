$(function() {

	var enableImageChangeOnHover = function (imageID, imageName) {
		$( imageID ).on('mouseenter', function () {
			changeImage(imageID, imageName, 'Color');
		}).on('mouseleave', function () {
			changeImage(imageID, imageName, 'BW');
		});
	}

	var changeImage = function (imageID, imageName, type) {
		$( imageID ).attr('src', 'assets/images/LabArt/' + imageName + type + '.gif');
	}

	var homepageMenuImages = [ 	[ '#XMLPipeDBImage',    'XMLpipeDB'    ],
						       	[ '#researchImage',     'Research'     ],
		                   		[ '#coursesImage',      'Courses'      ],
		                   		[ '#peopleImage',       'People'       ],
		                		[ '#publicationsImage', 'Publications' ],
		                		[ '#womenImage',        'Women'        ],
		               		    [ '#linksImage',        'Links'        ],
		                   		[ '#contactImage',      'Contact'      ] ]

	homepageMenuImages.forEach(function (clickableItem) {
		enableImageChangeOnHover.apply(null, clickableItem);
	});
	

});