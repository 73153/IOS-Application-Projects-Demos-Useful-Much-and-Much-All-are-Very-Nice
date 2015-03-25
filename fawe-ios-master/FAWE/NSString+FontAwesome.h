//
//  NSString+FontAwesome.h
//
//  Copyright (c) 2012 Alex Usbergo. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//

#import <Foundation/Foundation.h>

static NSString *const kFontAwesomeFamilyName = @"FontAwesome";


typedef NS_ENUM(NSInteger, FAWEIcon) {
    FAWEIconGlass = 0,
    FAWEIconMusic,
    FAWEIconSearch,
    FAWEIconEnvelope,
    FAWEIconHeart,
    FAWEIconStar,
    FAWEIconStarEmpty,
    FAWEIconUser,
    FAWEIconFilm,
    FAWEIconThLarge,
    FAWEIconTh,
    FAWEIconThList,
    FAWEIconOk,
    FAWEIconRemove,
    FAWEIconZoomIn,
    FAWEIconZoomOut,
    FAWEIconOff,
    FAWEIconSignal,
    FAWEIconCog,
    FAWEIconTrash,
    FAWEIconHome,
    FAWEIconFile,
    FAWEIconTime,
    FAWEIconRoad,
    FAWEIconDownloadAlt,
    FAWEIconDownload,
    FAWEIconUpload,
    FAWEIconInbox,
    FAWEIconPlayCircle,
    FAWEIconRepeat,
    FAWEIconRefresh,
    FAWEIconListAlt,
    FAWEIconLock,
    FAWEIconFlag,
    FAWEIconHeadphones,
    FAWEIconVolumeOff,
    FAWEIconVolumeDown,
    FAWEIconVolumeUp,
    FAWEIconQrcode,
    FAWEIconBarcode,
    FAWEIconTag,
    FAWEIconTags,
    FAWEIconBook,
    FAWEIconBookmark,
    FAWEIconPrint,
    FAWEIconCamera,
    FAWEIconFont,
    FAWEIconBold,
    FAWEIconItalic,
    FAWEIconTextHeight,
    FAWEIconTextWidth,
    FAWEIconAlignLeft,
    FAWEIconAlignCenter,
    FAWEIconAlignRight,
    FAWEIconAlignJustify,
    FAWEIconList,
    FAWEIconIndentLeft,
    FAWEIconIndentRight,
    FAWEIconFacetimeVideo,
    FAWEIconPicture,
    FAWEIconPencil,
    FAWEIconMapMarker,
    FAWEIconAdjust,
    FAWEIconTint,
    FAWEIconEdit,
    FAWEIconShare,
    FAWEIconCheck,
    FAWEIconMove,
    FAWEIconStepBackward,
    FAWEIconFastBackward,
    FAWEIconBackward,
    FAWEIconPlay,
    FAWEIconPause,
    FAWEIconStop,
    FAWEIconForward,
    FAWEIconFastForward,
    FAWEIconStepForward,
    FAWEIconEject,
    FAWEIconChevronLeft,
    FAWEIconChevronRight,
    FAWEIconPlusSign,
    FAWEIconMinusSign,
    FAWEIconRemoveSign,
    FAWEIconOkSign,
    FAWEIconQuestionSign,
    FAWEIconInfoSign,
    FAWEIconScreenshot,
    FAWEIconRemoveCircle,
    FAWEIconOkCircle,
    FAWEIconBanCircle,
    FAWEIconArrowLeft,
    FAWEIconArrowRight,
    FAWEIconArrowUp,
    FAWEIconArrowDown,
    FAWEIconShareAlt,
    FAWEIconResizeFull,
    FAWEIconResizeSmall,
    FAWEIconPlus,
    FAWEIconMinus,
    FAWEIconAsterisk,
    FAWEIconExclamationSign,
    FAWEIconGift,
    FAWEIconLeaf,
    FAWEIconFire,
    FAWEIconEyeOpen,
    FAWEIconEyeClose,
    FAWEIconWarningSign,
    FAWEIconPlane,
    FAWEIconCalendar,
    FAWEIconRandom,
    FAWEIconComment,
    FAWEIconMagnet,
    FAWEIconChevronUp,
    FAWEIconChevronDown,
    FAWEIconRetweet,
    FAWEIconShoppingCart,
    FAWEIconFolderClose,
    FAWEIconFolderOpen,
    FAWEIconResizeVertical,
    FAWEIconResizeHorizontal,
    FAWEIconBarChart,
    FAWEIconTwitterSign,
    FAWEIconFacebookSign,
    FAWEIconCameraRetro,
    FAWEIconKey,
    FAWEIconCogs,
    FAWEIconComments,
    FAWEIconThumbsUp,
    FAWEIconThumbsDown,
    FAWEIconStarHalf,
    FAWEIconHeartEmpty,
    FAWEIconSignout,
    FAWEIconLinkedinSign,
    FAWEIconPushpin,
    FAWEIconExternalLink,
    FAWEIconSignin,
    FAWEIconTrophy,
    FAWEIconGithubSign,
    FAWEIconUploadAlt,
    FAWEIconLemon,
    FAWEIconPhone,
    FAWEIconCheckEmpty,
    FAWEIconBookmarkEmpty,
    FAWEIconPhoneSign,
    FAWEIconTwitter,
    FAWEIconFacebook,
    FAWEIconGithub,
    FAWEIconUnlock,
    FAWEIconCreditCard,
    FAWEIconRss,
    FAWEIconHdd,
    FAWEIconBullhorn,
    FAWEIconBell,
    FAWEIconCertificate,
    FAWEIconHandRight,
    FAWEIconHandLeft,
    FAWEIconHandUp,
    FAWEIconHandDown,
    FAWEIconCircleArrowLeft,
    FAWEIconCircleArrowRight,
    FAWEIconCircleArrowUp,
    FAWEIconCircleArrowDown,
    FAWEIconGlobe,
    FAWEIconWrench,
    FAWEIconTasks,
    FAWEIconFilter,
    FAWEIconBriefcase,
    FAWEIconFullscreen,
    FAWEIconGroup,
    FAWEIconLink,
    FAWEIconCloud,
    FAWEIconBeaker,
    FAWEIconCut,
    FAWEIconCopy,
    FAWEIconPaperClip,
    FAWEIconSave,
    FAWEIconSignBlank,
    FAWEIconReorder,
    FAWEIconListUl,
    FAWEIconListOl,
    FAWEIconStrikethrough,
    FAWEIconUnderline,
    FAWEIconTable,
    FAWEIconMagic,
    FAWEIconTruck,
    FAWEIconPinterest,
    FAWEIconPinterestSign,
    FAWEIconGooglePlusSign,
    FAWEIconGooglePlus,
    FAWEIconMoney,
    FAWEIconCaretDown,
    FAWEIconCaretUp,
    FAWEIconCaretLeft,
    FAWEIconCaretRight,
    FAWEIconColumns,
    FAWEIconSort,
    FAWEIconSortDown,
    FAWEIconSortUp,
    FAWEIconEnvelopeAlt,
    FAWEIconLinkedin,
    FAWEIconUndo,
    FAWEIconLegal,
    FAWEIconDashboard,
    FAWEIconCommentAlt,
    FAWEIconCommentsAlt,
    FAWEIconBolt,
    FAWEIconSitemap,
    FAWEIconUmbrella,
    FAWEIconPaste,
    FAWEIconUserMd,
	FAWEIconStethoscope,
	FAWEIconBuilding,
	FAWEIconHospital,
	FAWEIconAmbulance,
	FAWEIconMedkit,
	FAWEIconHSign,
	FAWEIconPlusSignAlt,
	FAWEIconSpinner,
	FAWEIconCloudDownload,
	FAWEIconCloudUpload,
	FAWEIconLightbulb,
	FAWEIconExchange,
	FAWEIconBellAlt,
	FAWEIconFileAlt,
	FAWEIconBeer,
	FAWEIconCoffee,
	FAWEIconFood,
	FAWEIconFighterJet,
	FAWEIconAngleLeft,
	FAWEIconAngleRight,
	FAWEIconAngleUp,
	FAWEIconAngleDown,
	FAWEIconDoubleAngleLeft,
	FAWEIconDoubleAngleRight,
	FAWEIconDoubleAngleUp,
	FAWEIconDoubleAngleDown,
	FAWEIconCircleBlank,
	FAWEIconCircle,
	FAWEIconDesktop,
	FAWEIconLaptop,
	FAWEIconTablet,
	FAWEIconMobilePhone,
	FAWEIconQuoteLeft,
	FAWEIconQuoteRight,
	FAWEIconReply,
	FAWEIconGithubAlt,
	FAWEIconFolderCloseAlt,
	FAWEIconFolderOpenAlt,
    FAWEIconSuitcase,
};

@interface NSString (FontAwesome)

/* Returns the correct enum for a font-awesome icon.
 * The list of identifiers can be found here:
 * http://fortawesome.github.com/Font-Awesome/#all-icons */
+ (FAWEIcon)fontAwesomeEnumForIconIdentifier:(NSString*)string;

/* Returns the font-awesome character associated to the
 * icon enum passed as argument */
+ (NSString*)fontAwesomeIconStringForEnum:(FAWEIcon)value;

/* Returns the font-awesome character associated to the font-awesome
 * identifier.
 * http://fortawesome.github.com/Font-Awesome/#all-icons */
+ (NSString*)fontAwesomeIconStringForIconIdentifier:(NSString*)identifier;

@end