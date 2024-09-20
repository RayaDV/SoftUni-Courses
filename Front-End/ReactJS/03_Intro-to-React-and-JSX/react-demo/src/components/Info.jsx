export default function Info() {
    return (
        <section className="info_section ">

        <div className="container">
          <div className="contact_nav">
            <a href="">
              <i className="fa fa-phone" aria-hidden="true"></i>
              <span>
                Call : +01 123455678990
              </span>
            </a>
            <a href="">
              <i className="fa fa-envelope" aria-hidden="true"></i>
              <span>
                Email : demo@gmail.com
              </span>
            </a>
            <a href="">
              <i className="fa fa-map-marker" aria-hidden="true"></i>
              <span>
                Location
              </span>
            </a>
          </div>

          <div className="info_top ">
            <div className="row info_main_row">
              <div className="col-sm-6 col-md-4 col-lg-3">
                <div className="info_links">
                  <h4>
                    QUICK LINKS
                  </h4>
                  <div className="info_links_menu">
                    <a className="" href="index.html">Home <span className="sr-only">(current)</span></a>
                    <a className="" href="service.html">Services</a>
                    <a className="" href="about.html"> About</a>
                    <a className="" href="project.html">Project</a>
                    <a className="" href="testimonial.html">Testimonial</a>
                    <a className="" href="contact.html">Contact Us</a>
                  </div>
                </div>
              </div>
              <div className="col-sm-6 col-md-4 col-lg-3 mx-auto">
                <div className="info_post">
                  <h5>
                    INSTAGRAM FEEDS
                  </h5>
                  <div className="post_box">
                    <div className="img-box">
                      <img src="images/instagram.jpg" alt="" />
                    </div>
                    <div className="img-box">
                      <img src="images/instagram.jpg" alt="" />
                    </div>
                    <div className="img-box">
                      <img src="images/instagram.jpg" alt="" />
                    </div>
                    <div className="img-box">
                      <img src="images/instagram.jpg" alt="" />
                    </div>
                    <div className="img-box">
                      <img src="images/instagram.jpg" alt="" />
                    </div>
                    <div className="img-box">
                      <img src="images/instagram.jpg" alt="" />
                    </div>
                  </div>
                </div>
              </div>
              <div className="col-md-4">
                <div className="info_form">
                  <h4>
                    SIGN UP TO OUR NEWSLETTER
                  </h4>
                  <form action="">
                    <input type="text" placeholder="Enter Your Email" />
                    <button type="submit">
                      Subscribe
                    </button>
                  </form>
                </div>
              </div>
            </div>
          </div>
          <div className="info_bottom">
            <div className="row">
              <div className="col-md-2">
                <div className="info_logo">
                  <a href="">
                    <img src="images/logo2.png" alt="" />
                  </a>
                </div>
              </div>
              <div className="col-md-4 ml-auto">
                <div className="social_box">
                  <a href="">
                    <i className="fa fa-facebook" aria-hidden="true"></i>
                  </a>
                  <a href="">
                    <i className="fa fa-twitter" aria-hidden="true"></i>
                  </a>
                  <a href="">
                    <i className="fa fa-linkedin" aria-hidden="true"></i>
                  </a>
                  <a href="">
                    <i className="fa fa-instagram" aria-hidden="true"></i>
                  </a>
                </div>
              </div>
            </div>

          </div>
        </div>
      </section>
    );
}