class Hymn {
  String title;
  String lyrics;
  Hymn({this.title = '', this.lyrics = ''});
}

List<Hymn> getHymns() {
  List<Hymn> hymns = [
    Hymn(title: 'Amazing Grace', lyrics: amazingGrace),
    Hymn(title: 'Holy Holy Holy', lyrics: holyholy),
    Hymn(title: 'Rock Of Ages', lyrics: rockOfAges),
  ];

  return hymns;
}

const amazingGrace = """
<p><b><span style="">Amazing grace! How sweet the sound<br />That saved a wretch like me!<br />I once was lost, but now am found;<br />Was blind, but now I see.<br /><br />'Twas grace that taught my heart to fear,<br />And grace my fears relieved;<br />How precious did that grace appear<br />The hour I first believed.<br /><br />Through many dangers, toils and snares,<br />I have already come;<br />'Tis grace hath brought me safe thus far,<br />And grace will lead me home.<br /><br />The Lord has promised good to me,<br />His word my hope secures;<br />He will my shield and portion be,<br />As long as life endures.<br /><br />Yea, when this flesh and heart shall fail,<br />And mortal life shall cease,<br />I shall possess, within the veil,<br />A life of joy and peace.<br /><br />The world shall soon dissolve like snow,<br />The sun refuse to shine;<br />But God, who called me here below,<br />Shall be forever mine.<br /><br />When we've been there ten thousand years,<br />Bright shining as the sun,<br />We've no less days to sing God's praise<br />Than when we'd first begun.</span></b></p>""";

const holyholy = """
<p><b><span >Holy, holy, holy! Lord God Almighty!<br />Early in the morning our song shall rise to Thee;<br />Holy, holy, holy, merciful and mighty!<br />God in three Persons, bless&egrave;d Trinity!<br /><br />Holy, holy, holy! All the saints adore Thee,<br />Casting down their golden crowns around the glassy sea;<br />Cherubim and seraphim falling down before Thee,<br />Who was, and is, and evermore shall be.<br /><br />Holy, holy, holy! though the darkness hide Thee,<br />Though the eye of sinful man Thy glory may not see;<br />Only Thou art holy; there is none beside Thee,<br />Perfect in power, in love, and purity.<br /><br />Holy, holy, holy! Lord God Almighty!<br />All Thy works shall praise Thy Name, in earth, and sky, and sea;<br />Holy, holy, holy; merciful and mighty!<br />God in three Persons, bless&egrave;d Trinity!</span></b></p>""";

const rockOfAges = """
<p><b>Rock of Ages, cleft for me,<br />Let me hide myself in Thee;<br />Let the water and the blood,<br />From Thy wounded side which flowed,<br />Be of sin the double cure;<br />Save from wrath and make me pure.<br /><br />Not the labor of my hands<br />Can fulfill Thy law&rsquo;s demands;<br />Could my zeal no respite know,<br />Could my tears forever flow,<br />All for sin could not atone;<br />Thou must save, and Thou alone.<br /><br />Nothing in my hand I bring,<br />Simply to the cross I cling;<br />Naked, come to Thee for dress;<br />Helpless look to Thee for grace;<br />Foul, I to the fountain fly;<br />Wash me, Savior, or I die.<br /><br />While I draw this fleeting breath,<br />When mine eyes shall close in death,<br />When I soar to worlds unknown,<br />See Thee on Thy judgment throne,<br />Rock of Ages, cleft for me,<br />Let me hide myself in Thee</b></p>
""";
