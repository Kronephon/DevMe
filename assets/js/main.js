---

---

function createLink(parent, icon, link){
    if(parent){
        const linker = document.createElement('a');
        linker.href = link;

        linker.rel = "external";
        linker.target = "_blank";

        const image = document.createElement('img');
        image.src = icon;

        linker.appendChild(image);
        parent.appendChild(linker);
    }
}

function addLinks(input){
    const links = document.getElementById(input);
    if(links){

        //createLink(links, "{{site.instagram.icon}}", "{{site.instagram.link}}");
        //createLink(links, "{{site.twitter.icon}}", "{{site.twitter.link}}");
        createLink(links, "{{site.github.icon}}", "{{site.github.link}}");
        //createLink(links, "{{site.linkedin.icon}}", "{{site.linkedin.link}}");
        createLink(links, "{{site.email.icon}}", "{{site.email.link}}");
    }
}

addLinks('HeaderLinks');

//search query

function insertPost(post, htmldiv){
    var article = document.createElement('div');
    article.className = "article";
    article.style.order = parseInt("" + post.year + post.month + post.day);

    var title = document.createElement('a');
    title.className = "articleTitle"
    title.href = post.url;
    title.innerHTML = post.title;

    var date = document.createElement('div');
    date.className = "articleDate"
    date.innerHTML = post.year.toString() +"-"+ post.month.toString() + "-" + post.day.toString();

    var text = document.createElement('div');
    text.className = "articleText"
    text.innerHTML = post.excerpt;

    article.appendChild(title);
    article.appendChild(date);
    article.appendChild(text);

    htmldiv.appendChild(article);
}

function parsePostsAndBuild(e, parent){
    if(e.detail){
        insertPost(e.detail, parent);
    }else{
        console.log("parsePostsAndBuild: empty result");
    }
}

if(queryContent){
    const content = document.getElementById("Content");
    if(content){
        content.addEventListener('queryResult', function(e){parsePostsAndBuild(e, content)}, false);
        queryContent("",content);
    }
}

//dynamic background

const header = document.getElementById("Header");
if(header){
    var canvas = document.createElement('canvas');
    canvas.style.position = "absolute";
    canvas.width = header.offsetWidth;
    canvas.height = header.offsetHeight;
    canvas.style.backgroundColor = 'rgb( 175, 65, 29)'; //todo: make this dynamic
    canvas.style.zIndex = -1;
    header.appendChild(canvas);

    window.onresize = function(event) { //todo: doesn't go out of scope?
        canvas.width = header.offsetWidth;
        canvas.height = header.offsetHeight;
    };

    header.style.backgroundColor = '#00000000'; //make the div we wish to replace transparent, ideally a mask over
    physicsWallpaperInit(canvas, 'rgb(230, 230, 230)', 'rgb( 175, 65, 29)'); //todo change color here, they are not exactly the same
}

//loader
const loader = document.getElementById("loader");
if(loader)
{
        if(typeof(loader) !== 'undefined')
        {
        loader.style.display = "none";
        }
    var event = new CustomEvent('loadingEnded');
    loader.dispatchEvent(event);
}
console.log("Cheeky little one aren't you? :)");
