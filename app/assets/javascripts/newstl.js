window.addEventListener("load", function () {
    "use strict";
  $("#post_volume").hide();
    //-------------------------------- VOLUME parte 1 ---------------------------------------------------------
        function volumeOfT(p1, p2, p3){
            var v321 = p3.x*p2.y*p1.z;
            var v231 = p2.x*p3.y*p1.z;
            var v312 = p3.x*p1.y*p2.z;
            var v132 = p1.x*p3.y*p2.z;
            var v213 = p2.x*p1.y*p3.z;
            var v123 = p1.x*p2.y*p3.z;
            return (-v321 + v231 + v312 - v132 - v213 + v123)/6.0;
        }

    //-------------------------------------------------------------------------------------------------------
    var w = 640, h = 550;
    
    var renderer = new THREE.WebGLRenderer();
    renderer.setSize(w, h);
    var view = document.getElementById("view_teste");
    view.appendChild(renderer.domElement);
    
    var camera = new THREE.PerspectiveCamera(45, w / h, 0.1, 20000);
    camera.position.set(0, 0, 150);
    var controls = new THREE.OrbitControls(camera, view);
    
    var scene = new THREE.Scene();
    scene.add(new THREE.AmbientLight(0x666666));
    scene.background = new THREE.Color( 0xffffff);
    
    
    var light1 = new THREE.DirectionalLight(0xffffff);
    light1.position.set(0, 100, 100);
    scene.add(light1);
    
    var light2 = new THREE.DirectionalLight(0xffffff);
    light2.position.set(0, -100, -100);
    scene.add(light2);
    
    var mat = new THREE.MeshPhongMaterial({
        color: 0xbfbfbf, ambient: 0xbfbfbf, specular: 0x030303,
    });
    var obj = new THREE.Mesh(new THREE.Geometry(), mat);
    scene.add(obj);
    
    var pivot = new THREE.Mesh(new THREE.Geometry(), mat);
    var maior;
    var alpha;
    var degrees;
    var cameraAng;


    var loop = function loop() {
        requestAnimationFrame(loop);
        pivot.rotation.y += 0.002;
        controls.update();
        renderer.clear();
        renderer.render(scene, camera);
    };
    loop();
    
    // file load
    var openFile = function (file) {
        var reader = new FileReader();
        reader.addEventListener("load", function (ev) {
            var buffer = ev.target.result;
            var geom = loadStl(buffer);
            scene.remove(pivot);
            obj = new THREE.Mesh(geom, mat);
            obj.rotation.x = -90 * Math.PI/180;

            var box = new THREE.Box3().setFromObject( obj );
            console.log( box.min, box.max, box.size(),obj.rotation );
            obj.position.y = -(box.max.y - (box.size().y/2));
            obj.position.x = -(box.max.x - (box.size().x/2));
            obj.position.z = -(box.max.z - (box.size().z/2));

            pivot = new THREE.Object3D();
            
            pivot.position.set(0, 0, 0);
            pivot.rotation.set(0, 0, 0);

            pivot.add(obj);

        //----------------------------------- VOLUME parte2 --------------------------------------------------------
        console.log("pqplsl");


        var volumes = 0.0;
        
        for(var i = 0; i < obj.geometry.faces.length; i++){
            console.log("blablabla");
            var Pi = obj.geometry.faces[i].a;
            var Qi = obj.geometry.faces[i].b;
            var Ri = obj.geometry.faces[i].c;

            var P = new THREE.Vector3(obj.geometry.vertices[Pi].x, obj.geometry.vertices[Pi].y, obj.geometry.vertices[Pi].z);
            var Q = new THREE.Vector3(obj.geometry.vertices[Qi].x, obj.geometry.vertices[Qi].y, obj.geometry.vertices[Qi].z);
            var R = new THREE.Vector3(obj.geometry.vertices[Ri].x, obj.geometry.vertices[Ri].y, obj.geometry.vertices[Ri].z);
            volumes += volumeOfT(P, Q, R);
            //console.log("pqpLSL");
        }
 
        var loadedObjectVolume = Math.abs(volumes);
        var boundingboxVolume = box.size().x*box.size().y*box.size().z;

        console.log(boundingboxVolume, loadedObjectVolume);

        $("#post_volume").val(loadedObjectVolume);
        //---------------------------------------------------------------------------------------------------

            if ((box.size().x>box.size().y)||(box.size().z>box.size().y)) {
                if (box.size().z>box.size().y) {
                    maior = box.size().z;
                }else{
                    maior = box.size().x;
                }
            }else{
                maior = box.size().y;
            };

            alpha = 2*Math.atan(maior/400);
            console.log(alpha);

            degrees = alpha * (180/Math.PI);
            camera = new THREE.PerspectiveCamera(degrees, w / h, 1, 800);
            camera.position.set(0, 63.767, 300);
            cameraAng = 12 * (Math.PI/180);
            camera.rotation.set(-cameraAng, 0, 0);
            controls = new THREE.OrbitControls(camera, view);

            scene.add(pivot);

            /*
            obj.rotation.x = -105 * Math.PI/180;
            obj.position.y = 0;
            obj.position.x = 0;
             var box = new THREE.Box3().setFromObject( obj );
            console.log( box.min, box.max, box.size(),obj.rotation );
            camera.position.y = box.size().y/2;
            obj.position.y = -box.size().y/2;
            scene.add(obj);
            */
        }, false);
        reader.readAsArrayBuffer(file);
    };
    
    // file input button
    var input = document.getElementById("post_attachment");
    input.addEventListener("change", function (ev) {
        var file = ev.target.files[0];
        openFile(file);
    }, false);
    
    // dnd
    view.addEventListener("dragover", function (ev) {
        ev.stopPropagation();
        ev.preventDefault();
        ev.dataTransfer.dropEffect = "copy";
    }, false);
    view.addEventListener("drop", function (ev) {
        ev.stopPropagation();
        ev.preventDefault();
        var file = ev.dataTransfer.files[0];
        openFile(file);
    }, false);
}, false);